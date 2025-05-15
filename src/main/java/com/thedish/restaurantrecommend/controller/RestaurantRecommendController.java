package com.thedish.restaurantrecommend.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thedish.comment.model.service.CommentService;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.image.model.service.ImageService;
import com.thedish.image.model.vo.Image;
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
	              
	               // ✅ createdAt → KST 시간으로 변환해 문자열로 저장
	               for (RestaurantRecommend recommend : recommendList) {
	                   if (recommend.getCreatedAt() != null) {
	                       LocalDateTime utcTime = recommend.getCreatedAt().toLocalDateTime();
	                       ZonedDateTime kstTime = utcTime
	                               .atZone(ZoneId.of("UTC"))
	                               .withZoneSameInstant(ZoneId.of("Asia/Seoul"));
	                       String formatted = kstTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	                       recommend.setCreatedAtKst(formatted);
	                   }
	               }
	               
	               mv.addObject("recommendList", recommendList); // 모델에 추천 목록 추가
	               mv.addObject("paging", paging); // 모델에 페이징 정보 추가 (pagingView.jsp에서 사용)

	               mv.setViewName("restaurantrecommend/restaurantRecommendList"); // 뷰 이름 설정 (WEB-INF/views/restaurantRecommendList.jsp)
	           } else { // 조회 실패시 (예: DB 연결 문제 등)
	                // 실제 애플리케이션에서는 에러 처리가 더 상세해야 함
	                mv.addObject("msg", "맛집 추천 목록 조회 중 오류가 발생했습니다.");
	                mv.setViewName("common/alertMessage"); // 에러 페이지로 이동
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
	                Users loginUser = (Users) session.getAttribute("loginUser"); // 세션에서 로그인 사용자 객체 가져옴
	                boolean isLiked = false; // 기본값: 좋아요 누르지 않음

	                if (loginUser != null) {
	                     try {
	                         // 실제 Users 클래스의 사용자 ID 필드 Getter 사용
	                         userId = loginUser.getLoginId(); // 예: loginUser.getLoginId(), loginUser.getUserId() 등
	                         logger.info("로그인된 사용자 ID 확인: {}", userId);

	                         // **좋아요 상태 확인 서비스 호출**
	                         // restaurantRecommendService (또는 별도의 LikeService)에
	                         // isLikedByUser(String userId, int targetId, String targetType) 메서드가 있다고 가정
	                         // targetType은 좋아요 기록 테이블의 대상 타입을 나타냅니다 (예: "restaurant")
	                         isLiked = restaurantRecommendService.isLikedByUser(recommendId, userId); // ★ 이 부분 확인/수정 ★
	                         logger.info("사용자 {}의 맛집 추천(ID: {}) 좋아요 상태: {}", userId, recommendId, isLiked);

	                     } catch (Exception e) {
	                         logger.error("로그인 사용자 ID 또는 좋아요 상태 확인 중 오류 발생", e);
	                         // 오류 발생 시 기본값 (false) 유지
	                     }
	                } else {
	                    // 비로그인 사용자는 좋아요 누르지 않은 상태로 처리
	                    logger.info("비로그인 사용자. 좋아요 상태: false");
	                    isLiked = false; // 비로그인 사용자는 좋아요 누르지 않은 상태
	                }
	                 mv.addObject("liked", isLiked); // ★ 좋아요 상태(boolean)를 모델에 "liked" 이름으로 추가 ★
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
	                mv.addObject("msg", recommendId + "번 맛집 추천 정보가 존재하지 않습니다.");
	                mv.setViewName("common/alertMessage"); // 에러 페이지로 이동
	            }

	        } catch (Exception e) {
	            // 오류 처리
	            logger.error("맛집 추천 상세 정보 조회 중 오류 발생: recommendId={}", recommendId, e); // 예외 객체 로깅
	            mv.addObject("msg", "맛집 추천 상세 정보를 가져오는 중 오류가 발생했습니다.");
	            mv.setViewName("common/alertMessage"); // 에러 페이지로 이동
	        }

	        return mv;
	    }
	 
	
	 @RequestMapping(value = "/toggleRestaurantLike.do", method = RequestMethod.POST)
	 @ResponseBody
	 @Transactional // Controller 메소드에 트랜잭션 적용 (Service로 옮기는 것을 권장하지만, 현재는 Controller에 유지)
	 public ResponseEntity<Map<String, Object>> toggleRestaurantLikeMethod(
	         @RequestBody Map<String, Object> params,
	         HttpSession session) {

	     logger.info("/toggleRestaurantLike.do AJAX 호출 (POST)");

	     int recommendId = ((Number) params.get("recommendId")).intValue();
	     String loginIdFromJS = (String) params.get("loginId");

	     logger.info("AJAX 좋아요 토글 - recommendId: {}, loginId (From JS): {}", recommendId, loginIdFromJS);

	     Object loginUserObj = session.getAttribute("loginUser");
	     String loginId = null;
	     Map<String, Object> response = new HashMap<>();

	     // --- 로그인 및 사용자 ID 확인 로직 (기존 코드 유지) ---
	     if (loginUserObj != null) {
	         try {
	             Users loginUser = (Users) loginUserObj;
	             loginId = loginUser.getLoginId();
	             logger.info("AJAX 좋아요 토글 - 서버 세션 사용자 ID: {}", loginId);
	             if (loginIdFromJS != null && !loginId.equals(loginIdFromJS)) {
	                   logger.warn("클라이언트 ID ({}) 와 서버 세션 ID ({}) 불일치. 서버 세션 ID 사용.", loginIdFromJS, loginId);
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
	     if (loginId == null || loginId.isEmpty()) {
	          logger.error("AJAX 좋아요 토글 - 로그인 사용자 ID를 가져오지 못했습니다. recommendId={}", recommendId);
	          response.put("status", "error");
	          response.put("message", "사용자 정보를 가져오는 중 오류가 발생했습니다.");
	          return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	     }
	    
	     try {
	          // 1. 현재 좋아요 상태 확인 (Service 호출)
	          boolean isLiked = restaurantRecommendService.isLikedByUser(recommendId, loginId );
	          logger.info("AJAX 좋아요 토글 - 현재 좋아요 상태 (isLiked): {}", isLiked);

	          int actionResult = -1; // 좋아요 기록 삽입/삭제 결과

	          if (isLiked) { // 이미 좋아요를 눌렀다면 -> 좋아요 기록 삭제 및 좋아요 수 감소
	              logger.info("AJAX 좋아요 토글 - 좋아요 취소 시도. recommendId: {}, loginId: {}", recommendId, loginId);
	              // Service 호출하여 좋아요 기록 삭제
	              actionResult = restaurantRecommendService.deleteRecommendationLike(recommendId, loginId);
	              logger.info("AJAX 좋아요 토글 - deleteRecommendationLike 결과: {}", actionResult); // ★ 로그 추가 ★

	              if (actionResult > 0) {
	                   // 기록 삭제 성공 시 좋아요 수 감소 (Service 호출)
	                   int updateCountResult = restaurantRecommendService.updateSubtractLikeCount(recommendId);
	                   logger.info("AJAX 좋아요 토글 - updateSubtractLikeCount 결과: {}", updateCountResult); // ★ 로그 추가 ★

	                   if (updateCountResult > 0) {
	                        response.put("status", "unliked");
	                        logger.info("AJAX 좋아요 토글 - 좋아요 취소 처리 완료.");
	                   } else {
	                        // 카운트 감소 실패는 심각한 데이터 불일치 -> 예외 발생 또는 강력 경고
	                        logger.error("맛집 추천 좋아요 수 감소 실패 (updateSubtractLikeCount 결과: {}). recommendId: {}", updateCountResult, recommendId); // 상세 로그
	                        throw new RuntimeException("맛집 추천 좋아요 수 감소 실패"); // 트랜잭션 롤백
	                   }
	              } else {
	                  
	                   logger.error("맛집 추천 좋아요 기록 삭제 실패 (deleteRecommendationLike 결과: {}). recommendId: {}, loginId: {}", actionResult, recommendId, loginId); // 상세 로그
	                   throw new RuntimeException("맛집 추천 좋아요 기록 삭제 실패"); // 트랜잭션 롤백
	              }

	          } else { // 좋아요를 누르지 않았다면 -> 좋아요 기록 삽입 및 좋아요 수 증가
	              logger.info("AJAX 좋아요 토글 - 좋아요 추가 시도. recommendId: {}, loginId: {}", recommendId, loginId);
	              actionResult = restaurantRecommendService.insertRecommendationLike(recommendId, loginId);
	              logger.info("AJAX 좋아요 토글 - insertRecommendationLike 결과: {}", actionResult);

	              if (actionResult > 0) { // 좋아요 기록 삽입 성공 시 (일반적으로 1 반환)
	                   // 기록 삽입 성공 시 좋아요 수 증가 (Service 호출)
	                   int updateCountResult = restaurantRecommendService.updateAddLikeCount(recommendId);
	                   logger.info("AJAX 좋아요 토글 - updateAddLikeCount 결과: {}", updateCountResult);

	                   if (updateCountResult > 0) { // 카운트 증가 성공 시
	                        // **★ 이 부분에 성공 로직 추가 ★**
	                        response.put("status", "liked");
	                        logger.info("AJAX 좋아요 토글 - 좋아요 추가 처리 완료.");
	                   } else {
	                        // 카운트 증가 실패는 심각한 데이터 불일치 -> 예외 발생
	                         logger.error("맛집 추천 좋아요 수 증가 실패 (updateAddLikeCount 결과: {}). recommendId: {}", updateCountResult, recommendId);
	                        throw new RuntimeException("맛집 추천 좋아요 수 증가 실패"); // 트랜잭션 롤백
	                   }
	              } else {
	                   
	                   logger.error("맛집 추천 좋아요 기록 삽입 실패 (insertRecommendationLike 결과: {}). recommendId: {}, loginId: {}", actionResult, recommendId, loginId);
	                
	                   throw new RuntimeException("맛집 추천 좋아요 기록 삽입 실패"); // 트랜잭션 롤백
	                   
	              }
	          } // <--- else 블록 끝

	        
	          int currentLikeCount = restaurantRecommendService.getLikeCount(recommendId);
	          response.put("likeCount", currentLikeCount);
	          logger.info("AJAX 좋아요 토글 - 최종 좋아요 개수 조회 결과: {}", currentLikeCount);

	          // 최종 성공 응답 반환
	          return new ResponseEntity<>(response, HttpStatus.OK);

	      } catch (Exception e) {
	          logger.error("Controller에서 좋아요 토글 로직 실행 중 예외 발생: recommendId={}, loginId={}", recommendId, loginId, e);
	          response.put("status", "error");
	          response.put("message", "좋아요 처리 중 시스템 오류가 발생했습니다. 다시 시도해주세요.");
	          return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	      }
	  }
	 @RequestMapping("moveRestaurantRecommendInsert.do")
		public String moveRestaurantRecommendInsert() {
			return "restaurantrecommend/restaurantRecommendInsert";
		}
	 

	    @RequestMapping(value = "/restaurantRecommendInsert.do", method = RequestMethod.POST)
	    public String insertRestaurantRecommend(
	            RestaurantRecommend recommend,
	            @RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
	            Model model,
	            HttpSession session) {

	        Users loggedInUser = (Users) session.getAttribute("loginUser");

	        if (loggedInUser != null) {
	            String writerId = loggedInUser.getLoginId();
	             if (writerId == null || writerId.isEmpty()) {
	                  model.addAttribute("msg", "사용자 정보를 가져오는 중 오류가 발생했습니다.");
	                  return "errorPage";
	             }
	             recommend.setLoginId(writerId);

	             

	        } else {
	            model.addAttribute("msg", "로그인이 필요합니다.");
	             return "redirect:/loginPage.do";
	        }

	        try {
	            int insertResult = restaurantRecommendService.insertRestaurantRecommend(recommend);
	            logger.debug("맛집 추천 insert 서비스 호출 완료. recommend 객체 ID: {}", recommend.getRecommendId());
	            if (imageFile != null && !imageFile.isEmpty()) {
	                try {
	                 byte[] imageBytes = imageFile.getBytes();

	                 Image image = new Image();
	                 Integer generatedRecommendId = recommend.getRecommendId();
	                 logger.debug("가져온 generatedRecommendId: {}", generatedRecommendId);
	                 if (generatedRecommendId != null && generatedRecommendId > 0) {
	                	 logger.debug("Image VO 설정 - targetId: {}", generatedRecommendId);
	                     image.setTargetId(generatedRecommendId);
	                     image.setTargetType("restaurant");
	                     image.setImageData(imageBytes);
	                     image.setDescription(recommend.getName() + " 이미지");

	                     imageService.insertImage(image);
	                 } else {
	                	 logger.error("생성된 맛집 추천 ID가 유효하지 않아 이미지 저장 불가.");
	                     model.addAttribute("errorMessage", "글 등록 중 내부 오류가 발생했습니다 (ID 누락).");
	                 }


	               } catch (IOException e) {
	                   model.addAttribute("msg", "이미지 업로드 중 오류가 발생했습니다.");
	                   return  "common/alertMessage";
	               }
	            }


	            return "redirect:restaurantRecommendList.do";


	    } catch (Exception e) {
	        model.addAttribute("msg", "맛집 추천 글 등록 중 예상치 못한 오류가 발생했습니다.");
	        return "common/alertMessage";
	    }
	    }
	    
	    
	    @RequestMapping(value = "restaurantRecommendDelete.do", method = RequestMethod.POST)
	    public String deleteRestotantRecommend(
	            @RequestParam("recommendId") int recommendId,
	            @RequestParam(value = "page", defaultValue = "1") int page,
	            RedirectAttributes redirectAttrs) {

	        try {
	        	restaurantRecommendService.deleteRestotantRecommend(recommendId);
	            redirectAttrs.addFlashAttribute("message", "레시피가 성공적으로 삭제되었습니다.");
	        } catch (Exception e) {
	            redirectAttrs.addFlashAttribute("errorMessage", "삭제 중 오류가 발생했습니다.");
	            e.printStackTrace();
	        }

	        return "redirect:/restaurantRecommendList.do?page=" + page;
	    }
	    	    
	    
	    @RequestMapping("moveRestaurantRecommendUpdate.do")
		public String moveRestaurantRecommendUpdate(Model model,
				@RequestParam("recommendId") int recommendId, // recommendId는 필수 파라미터이므로 int로 받아도 괜찮습니다. (값이 안 오면 다른 오류)
				@RequestParam(name = "page", required = false) String currentPageStr) { // ★ page 파라미터를 String으로 받음, required=false 추가 ★

			int currentPage = 1; // 기본값 설정
			if (currentPageStr != null && !currentPageStr.isEmpty()) { // null 또는 빈 문자열이 아닌 경우에만 변환 시도
				try {
					currentPage = Integer.parseInt(currentPageStr);
				} catch (NumberFormatException e) {
					// 숫자로 변환 실패 시 기본값 유지 또는 에러 처리
                    logger.warn("page 파라미터 변환 오류: {}", currentPageStr, e); // 로깅 추가
					currentPage = 1; // 변환 실패 시 기본값 1 유지
                    model.addAttribute("warningMessage", "잘못된 페이지 정보가 전달되었습니다. 1페이지로 이동합니다."); // 메시지 추가
				}
			}


			// 수정 페이지로 전달할 맛집 추천 정보 조회함
			RestaurantRecommend recommend = restaurantRecommendService.selectRestaurantRecommend(recommendId); // Service 호출

			if (recommend != null) {
				model.addAttribute("recommend", recommend);
				model.addAttribute("currentPage", currentPage); // 모델에 변환된 int 값 담음
				return "restaurantrecommend/restaurantRecommendUpdate";
			} else {
				// 메시지 내용 수정
				model.addAttribute("msg", recommendId + "번 맛집 추천 수정 페이지로 이동 실패! 해당 글이 존재하지 않습니다.");
				return  "common/alertMessage";
			}
		}

	    
	    @RequestMapping(value="restaurantRecommendUpdate.do",
				method=RequestMethod.POST)
		public String restaurantRecommendUpdate(RestaurantRecommend recommend, Model model,
				HttpServletRequest request,
				 @RequestParam(name = "imageFile", required = false) MultipartFile imageFile)
				
				 {
	    	
			logger.info("restaurantRecommendUpdate.do : " + recommend);	
				

			try {
		        // 1. 레시피 기본 정보 수정
		        int result = restaurantRecommendService.updateRestaurantRecommend(recommend);

		        if (result <= 0) {
		            model.addAttribute("message", "레시피 수정 실패");
		            return "common/error";
		        }

		        // 2. 이미지 파일이 새로 업로드 되었으면 처리
		        if (imageFile != null && !imageFile.isEmpty()) {
		            byte[] imageBytes = imageFile.getBytes();

		            Image image = new Image();
		            image.setTargetId(recommend.getRecommendId());
		            image.setTargetType("restaurant");
		            image.setImageData(imageBytes);
		            image.setDescription("맛집추천 이미지");

		            // 기존 이미지가 있을 경우 삭제 로직(필요시) 수행 후 새 이미지 저장
		            imageService.deleteImageByTargetIdAndType(recommend.getRecommendId(), "restaurant");
		            imageService.insertImage(image);
		        }

		        // 수정 성공 후 상세 페이지로 리다이렉트
		     // 예를 들어 상세 페이지 URL 매핑이 "/restaurantRecommendDetail.do" 라면:
		        return "redirect:/restaurantRecommendDetail.do?no=" + recommend.getRecommendId();


		    } catch (IOException e) {
		        e.printStackTrace();
		        model.addAttribute("msg", "이미지 업로드 중 오류가 발생했습니다.");
		        return "common/alertMessage";
		    } catch (Exception e) {
		        e.printStackTrace();
		        model.addAttribute("msg", "레시피 수정 중 오류가 발생했습니다.");
		        return "common/alertMessage";
		}
				 }
	    
	    @RequestMapping("restaurantRecommendSearch.do")
	    public ModelAndView restaurantRecommendSearchMethod( 
	            ModelAndView mv,
	           
	            @RequestParam("keyword") String keyword, // 검색어
	            @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, // 현재 페이지
	            @RequestParam(name = "limit", required = false, defaultValue = "10") int limit, // 페이지당 항목 수 (기본값 10으로 변경)
	            @RequestParam(name = "sortType", required = false, defaultValue = "latest") String sortType, // 정렬 기준 (예: "latest", "views", "likes")
	            @RequestParam(name = "sortDirection", required = false, defaultValue = "DESC") String sortDirection) { // 정렬 방향 (ASC/DESC)

	        logger.info("/restaurantRecommendSearch.do 요청 받음 - action: {}, keyword: {}, page: {}, limit: {}, sortType: {}, sortDirection: {}",
	                     keyword, currentPage, limit, sortType, sortDirection); // 로그

	     
	        // Service 메소드는 Search 객체 또는 keyword, action 등을 받아 총 개수를 반환
	        // 드링크 검색 코드는 keyword만 사용했지만, 필요에 따라 action 등도 넘길 수 있습니다.
	        int listCount = restaurantRecommendService.selectSearchCount(keyword); // ★ 서비스 메소드 호출 변경 ★
	        logger.info("검색 조건에 맞는 총 맛집 추천 개수: {}", listCount);

	        // 2. 페이지 관련 항목 계산
	        // Paging 객체 생성 시, urlMapping에 이 검색 컨트롤러 URL을 지정
	        Paging paging = new Paging(listCount, limit, currentPage, "restaurantRecommendSearch.do"); // ★ Paging URL 변경 ★
	        paging.calculate(); // 페이징 계산
	        logger.debug("페이징 계산 결과: startRow={}, endRow={}, maxPage={}, startPage={}, endPage={}",
	                     paging.getStartRow(), paging.getEndRow(), paging.getMaxPage(), paging.getStartPage(), paging.getEndPage());


	        // 3. 검색, 페이징, 정렬 정보를 담을 객체 (Search VO 사용)
	        Search search = new Search(); // Search 객체 생성
	        
	        search.setKeyword(keyword); // 검색어 설정
	        search.setStartRow(paging.getStartRow()); // 페이징 시작 행 설정
	        search.setEndRow(paging.getEndRow()); // 페이징 끝 행 설정
	        search.setSortType(sortType); // 정렬 기준 설정
	        search.setSortDirection(sortDirection); // 정렬 방향 설정
	        logger.debug("Search 객체 설정: {}", search);


	        // 4. 서비스 모델로 페이징, 정렬, 검색 적용된 목록 조회 요청
	        // Service 메소드는 Search 객체를 받아 DB에서 해당 범위의 데이터를 가져옴
	        ArrayList<RestaurantRecommend> list = restaurantRecommendService.selectSearchList(search); // ★ 서비스 메소드 호출 변경 ★
	        logger.info("검색 결과 맛집 추천 목록 {}개 조회됨.", (list != null ? list.size() : 0));

	        // ✅ createdAt → KST 시간으로 변환해 문자열로 저장
            for (RestaurantRecommend recommend : list) {
                if (recommend.getCreatedAt() != null) {
                    LocalDateTime utcTime = recommend.getCreatedAt().toLocalDateTime();
                    ZonedDateTime kstTime = utcTime
                            .atZone(ZoneId.of("UTC"))
                            .withZoneSameInstant(ZoneId.of("Asia/Seoul"));
                    String formatted = kstTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    recommend.setCreatedAtKst(formatted);
                }
            }
	        
	        // 5. ModelAndView에 결과 및 정보 추가 및 뷰 설정
	        mv.addObject("recommendList", list); // 모델에 맛집 추천 목록 추가
	        mv.addObject("paging", paging); // 모델에 페이징 정보 추가 (JSP에서 사용)
	        
	        mv.addObject("keyword", keyword); // 모델에 검색어 유지
	        mv.addObject("sortType", sortType); // 모델에 정렬 기준 유지
	        mv.addObject("sortDirection", sortDirection); // 모델에 정렬 방향 유지

	        
	        mv.setViewName("restaurantrecommend/restaurantRecommendList"); 

	        logger.info("검색 결과 맛집 추천 목록 {}개 조회됨.", (list != null ? list.size() : 0));
	        return mv; // ModelAndView 반환
	    }
}
