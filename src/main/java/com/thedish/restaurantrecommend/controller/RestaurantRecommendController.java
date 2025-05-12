package com.thedish.restaurantrecommend.controller;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.comment.model.service.CommentService;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.Paging;
import com.thedish.image.model.service.ImageService;
import com.thedish.restaurantrecommend.model.service.RestaurantRecommendService;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RestaurantRecommendController {

	 @Autowired
	    private RestaurantRecommendService restaurantRecommendService;
	 
		// 클래스 내 변수로 선언
		@Value("${kakao.map.key}")
		private String kakaoMapKey;
		
		private static final Logger logger = LoggerFactory.getLogger(RestaurantRecommendController.class);

		
		@Autowired
		private ImageService imageService;
		
		@Autowired
		private CommentService commentService;
	 
	 
	 
	 @RequestMapping("restaurantRecommendList.do") // 요청 URL 매핑
	  public ModelAndView showRecommendationList(ModelAndView mv,
              @RequestParam(name = "page", required = false) String page,
              @RequestParam(name = "limit", required = false) String slimit) {
		 
		 

	        // 페이징 처리
	        int currentPage = 1;
	        if (page != null) {
	            try {
	                currentPage = Integer.parseInt(page);
	            } catch (NumberFormatException e) {
	                // 숫자로 변환할 수 없는 경우 기본값 1 사용 또는 에러 처리
	                currentPage = 1;
	                // 필요시 로그 기록
	            }
	        }

	        // 한 페이지에 출력할 목록 갯수 기본 10개로 지정 (필요에 따라 변경)
	        int limit = 10;
	        if (slimit != null) {
	             try {
	                limit = Integer.parseInt(slimit);
	            } catch (NumberFormatException e) {
	                // 숫자로 변환할 수 없는 경우 기본값 10 사용 또는 에러 처리
	                limit = 10;
	                // 필요시 로그 기록
	            }
	        }

	        // 총 목록 갯수 조회해서, 총 페이지 수 계산함
	        int listCount = restaurantRecommendService.selectRecommendationCount(); // Service 메소드 호출

	        // 페이지 관련 항목들 계산 처리
	        // Paging 객체 생성 시, urlMapping에 이 목록을 보여주는 컨트롤러 URL을 지정
	        Paging paging = new Paging(listCount, limit, currentPage, "restaurantRecommendList.do");
	        paging.calculate(); // Paging 객체 내부에서 필요한 값들 계산 (startPage, endPage, maxPage, startRow, endRow 등)

	        // 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
	        // DAO/Service 메소드는 Paging 객체에서 startRow, endRow 값을 활용하여 DB에서 해당 범위의 데이터만 가져옴
	        List<RestaurantRecommend> recommendList = restaurantRecommendService.selectRecommendationList(paging); // Service 메소드 호출

	        // ModelAndView : Model + View 정보를 함께 담는 객체
	        if (recommendList != null) { // 목록 조회 성공시 (빈 리스트일 수 있음)
	            mv.addObject("recommendList", recommendList); // 모델에 추천 목록 추가
	            mv.addObject("paging", paging); // 모델에 페이징 정보 추가 (pagingView.jsp에서 사용)

	            mv.setViewName("restaurantrecommend/restaurantRecommendList"); // 뷰 이름 설정 (WEB-INF/views/restaurantRecommendList.jsp)
	        } else { // 조회 실패시 (예: DB 연결 문제 등)
	             // 실제 애플리케이션에서는 에러 처리가 더 상세해야 함
	             mv.addObject("message", "맛집 추천 목록 조회 중 오류가 발생했습니다.");
	             mv.setViewName("common/error"); // 에러 페이지로 이동
	        }

	        return mv;
	    }
	 
	 @RequestMapping("restaurantRecommendDetail.do")
	 public ModelAndView restaurantRecommendDetailMethod(
	            @RequestParam("no") int recommendId, // 맛집 추천 ID를 'no' 파라미터로 받음
	            ModelAndView mv,
	            HttpSession session,
	            HttpServletRequest request,
	            @RequestParam(value = "page", required = false, defaultValue = "1") int page) { // 댓글 페이징을 위한 현재 페이지

	        logger.info("restaurantRecommendDetail.do 호출 - recommendId: {}", recommendId); // 로깅 메시지 수정

	        try {
	            // 1. 맛집 추천 상세 정보 조회
	        	RestaurantRecommend recommend = restaurantRecommendService.selectRestaurantRecommend(recommendId);

	            if (recommend != null) {
	            	// 2. 조회수 증가 로직 (상세 정보 조회 성공 시에만)
	            	restaurantRecommendService.updateAddReadCount(recommendId);

	                mv.addObject("recommend", recommend); // 맛집 추천 상세 정보 모델에 추가

	                // 3. 카카오 지도 API 키 JSP에 전달 (필요하다면)
	                mv.addObject("kakaoMapKey", kakaoMapKey);

	                // 4. 사용자 정보 가져오는 로직 (필요하다면 댓글 작성 권한 등 확인용)
	                String userId = null;
	                // 세션에서 로그인된 사용자 정보를 가져오는 로직 (예시)
	                Object userObj = session.getAttribute("loginUser"); // 예: 세션에 "loginUser"라는 이름으로 저장됨
	                if (userObj != null) {
	                     try {
	                        
	                         Method getLoginIdMethod = userObj.getClass().getMethod("getLoginId"); // 또는 getUserId 등 실제 VO 메소드명
	                         userId = (String) getLoginIdMethod.invoke(userObj);
	                     } catch (Exception e) {
	                         logger.error("세션에서 사용자 ID를 가져오는 중 오류 발생", e);
	                         // 오류 발생 시 비로그인 처리 또는 다른 로직 수행
	                         userId = request.getRemoteAddr(); // 비로그인 사용자로 처리 (IP 주소 사용)
	                     }
	                     logger.info("로그인된 사용자 ID 확인: {}", userId);
	                } else {
	                    // 로그인하지 않은 사용자의 경우 IP 주소 사용 (로그인 여부 확인 시 필요)
	                    userId = request.getRemoteAddr();
	                    logger.info("비로그인 사용자 (IP): {}", userId);
	                }
	                mv.addObject("currentUserId", userId); // JSP에서 사용자 ID가 필요하다면 모델에 추가

	                // 5. 댓글 관련 로직
	                int commentsPerPage = 10; // 한 페이지에 보여줄 댓글 수
	                String targetType = "restaurant"; // **맛집 추천 댓글 타입 지정** (MyBatis 이미지 쿼리와 동일하게 사용)

	                // 댓글 총 개수 조회 (targetId: recommendId, targetType: "restaurant_recommend")
	                // commentService에 selectCommentCount(int targetId, String targetType) 메소드가 있다고 가정
	                int totalComments = commentService.selectCommentCount(recommendId, targetType);
	                logger.info("조회된 댓글 총 개수 ({}): {}", targetType, totalComments);

	                // 댓글 페이징 계산
	                int totalPages = (int) Math.ceil((double) totalComments / commentsPerPage);
	                if (totalPages == 0) totalPages = 1; // 댓글이 없어도 최소 1페이지

	                // 현재 페이지 유효성 검사
	                if (page < 1) page = 1;
	                if (page > totalPages) page = totalPages; // totalPages보다 크면 마지막 페이지로 설정

	                int offset = (page - 1) * commentsPerPage; // 댓글 조회 시작 위치

	                // 댓글 리스트 조회 (targetId: recommendId, targetType: "restaurant_recommend")
	                // commentService에 selectComments(int targetId, String targetType, int offset, int limit) 메소드가 있다고 가정
	                List<Comment> comments = commentService.selectRestaurantComments(recommendId,  offset, commentsPerPage); // 메소드명 수정 또는 확인 필요
	                if (comments == null) {
	                    logger.warn("commentService.selectComments()가 null을 반환했습니다. 빈 목록으로 초기화합니다.");
	                    comments = new ArrayList<>(); // null 대신 빈 리스트 반환
	                }
	                logger.info("조회된 댓글 리스트 크기 ({}): {}", targetType, comments.size());

	                mv.addObject("comments", comments); // 댓글 목록 모델에 추가
	                mv.addObject("commentPage", page); // 댓글 현재 페이지 모델에 추가 (일반 게시글/레시피 상세 페이지와 구분하기 위해 이름 변경)
	                mv.addObject("commentTotalPages", totalPages); // 댓글 총 페이지 수 모델에 추가

	                // 6. 뷰 이름 설정
	                mv.setViewName("restaurantrecommend/restaurantRecommendDetail"); // 맛집 추천 상세 페이지 JSP 파일 이름

	            } else {
	                // 맛집 추천 정보가 존재하지 않을 경우
	                logger.warn("{}번 맛집 추천 정보가 존재하지 않습니다.", recommendId);
	                mv.addObject("message", recommendId + "번 맛집 추천 정보가 존재하지 않습니다.");
	                mv.setViewName("common/error"); // 에러 페이지로 이동
	            }

	        } catch (Exception e) {
	            // 오류 처리
	            logger.error("맛집 추천 상세 정보 조회 중 오류 발생: recommendId={}", recommendId, e); // 예외 객체 로깅
	            mv.addObject("message", "맛집 추천 상세 정보를 가져오는 중 오류가 발생했습니다.");
	            mv.setViewName("common/error"); // 에러 페이지로 이동
	        }

	        return mv;
	    }
	 
	
	 @RequestMapping(value = "/toggleRestaurantLike.do", method = RequestMethod.POST) // POST 요청 매핑
	    @ResponseBody
	    @Transactional // Controller 메소드에 트랜잭션 적용
	    public ResponseEntity<Map<String, Object>> toggleRestaurantLikeMethod(
	            @RequestBody Map<String, Object> params,
	            HttpSession session) {

	        logger.info("/toggleRestaurantLike.do AJAX 호출 (POST)");

	        // 요청 데이터 파싱 (JSON -> Map)
	        int recommendId = ((Number) params.get("recommendId")).intValue();
	        String loginIdFromJS = (String) params.get("loginId");

	        logger.info("AJAX 좋아요 토글 - recommendId: {}, loginId (From JS): {}", recommendId, loginIdFromJS);

	        // 세션에서 로그인 사용자 정보 가져와 최종 사용자 ID 확인 (보안 강화)
	        Object loginUserObj = session.getAttribute("loginUser");
	        String loginId = null;
	        Map<String, Object> response = new HashMap<>();

	        if (loginUserObj != null) {
	            try {
	                Users loginUser = (Users) loginUserObj;
	                loginId = loginUser.getLoginId();
	                logger.info("AJAX 좋아요 토글 - 서버 세션 사용자 ID: {}", loginId);

	                if (loginIdFromJS != null && !loginId.equals(loginIdFromJS)) {
	                      logger.warn("클라이언트 ID ({}) 와 서버 세션 ID ({}) 불일치. 서버 ID 사용.", loginIdFromJS, loginId);
	                 }

	            } catch (ClassCastException e) {
	                logger.error("세션의 loginUser 객체 타입 캐스팅 오류", e);
	                response.put("status", "error");
	                response.put("message", "서버 오류가 발생했습니다.");
	                return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	            }

	        } else {
	            logger.warn("비로그인 사용자가 AJAX 좋아요 토글을 시도했습니다. recommendId: {}", recommendId);
	            response.put("status", "not_logged_in");
	            response.put("message", "로그인이 필요합니다.");
	            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
	        }

	        if (loginId == null) {
	             logger.error("AJAX 좋아요 토글 - 로그인 사용자 ID를 가져오지 못했습니다. recommendId={}", recommendId);
	             response.put("status", "error");
	             response.put("message", "사용자 정보를 가져오는 중 오류가 발생했습니다.");
	             return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	        }


	        // Controller에서 좋아요 토글 로직 직접 처리
	        try {
	             boolean isLiked = restaurantRecommendService.isLikedByUser(recommendId, loginId);

	             int actionResult = -1;
	             int updateCountResult = -1;

	             if (isLiked) {
	                 actionResult = restaurantRecommendService.deleteRecommendationLike(recommendId, loginId);
	                 if (actionResult > 0) {
	                      updateCountResult = restaurantRecommendService.updateSubtractLikeCount(recommendId);
	                      if (updateCountResult > 0) {
	                           response.put("status", "unliked");
	                      } else {
	                           throw new RuntimeException("맛집 추천 좋아요 수 감소 실패 (Controller logic)");
	                      }
	                 } else {
	                      throw new RuntimeException("맛집 추천 좋아요 기록 삭제 실패 (Controller logic)");
	                 }

	             } else {
	                 actionResult = restaurantRecommendService.insertRecommendationLike(recommendId, loginId);
	                 if (actionResult > 0) {
	                      updateCountResult = restaurantRecommendService.updateAddLikeCount(recommendId);
	                      if (updateCountResult > 0) {
	                           response.put("status", "liked");
	                      } else {
	                           throw new RuntimeException("맛집 추천 좋아요 수 증가 실패 (Controller logic)");
	                      }
	                 } else {
	                      throw new RuntimeException("맛집 추천 좋아요 기록 삽입 실패 (Controller logic)");
	                 }
	             }

	             // 변경된 좋아요 개수 조회 및 응답 데이터에 추가
	             int currentLikeCount = restaurantRecommendService.getLikeCount(recommendId);
	             response.put("likeCount", currentLikeCount);

	             // 최종 성공 응답
	             return new ResponseEntity<>(response, HttpStatus.OK);

	        } catch (Exception e) {
	            logger.error("Controller에서 좋아요 토글 로직 실행 중 예외 발생: recommendId={}, loginId={}", recommendId, loginId, e);
	            response.put("status", "error");
	            response.put("message", "좋아요 처리 중 시스템 오류가 발생했습니다.");
	            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
	 
}
