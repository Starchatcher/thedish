package com.thedish.drink.controller;

import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.thedish.common.Pairing;
import com.thedish.common.Search;
import com.thedish.common.ViewLog;
import com.thedish.drink.model.vo.Drink;
import com.thedish.drink.model.vo.DrinkStore;
import com.thedish.drink.service.impl.DrinkService;
import com.thedish.image.model.service.ImageService;
import com.thedish.image.model.vo.Image;
import com.thedish.recipe.model.vo.Recipe;
import com.thedish.recipe.service.impl.RecipeService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class DrinkController {
	
	

	// 클래스 내 변수로 선언
	@Value("${kakao.map.key}")
	private String kakaoMapKey;
	
	private static final Logger logger = LoggerFactory.getLogger(DrinkController.class);

	@Autowired
	private DrinkService drinkService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private RecipeService recipeService;
	
	// 드링크 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 10개씩 출력 처리)
			@RequestMapping("drinkList.do")
			public ModelAndView drinkListMethod(ModelAndView mv, 
					@RequestParam(name = "page", required = false) String page,
					@RequestParam(name = "limit", required = false) String slimit) {
				// 페이징 처리
				int currentPage = 1;
				if (page != null) {
					currentPage = Integer.parseInt(page);
				}

				// 한 페이지에 출력할 목록 갯수 기본 12개로 지정함
				int limit = 12;
				if (slimit != null) {
					limit = Integer.parseInt(slimit);
				}

				// 총 목록 갯수 조회해서, 총 페이지 수 계산함
				int listCount = drinkService.selectListCount();
				// 페이지 관련 항목들 계산 처리
				Paging paging = new Paging(listCount, limit, currentPage, "drinkList.do");
				paging.calculate();

				// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
				ArrayList<Drink> list = drinkService.selectListDrink(paging);

				if (list != null && list.size() > 0) { // 조회 성공시
					// ModelAndView : Model + View
					mv.addObject("list", list); // request.setAttribute("list", list) 와 같음
					mv.addObject("paging", paging);

					mv.setViewName("drink/drinkList");
				} else { // 조회 실패시
					mv.addObject("message", currentPage + "페이지에 출력할 레시피 목록 조회 실패!");
					mv.setViewName("common/error");
				}

				return mv;
			}
	

			// drink 상세보기 요청 처리용
			 @RequestMapping("drinkDetail.do")
			    public ModelAndView drinkDetailMethod(
			            @RequestParam("no") int drinkId,
			            ModelAndView mv,
			            HttpSession session,
			            HttpServletRequest request,
			            @RequestParam(value = "page", required = false, defaultValue = "1") int page) {

			        logger.info("drinkDetail.do 호출 - drinkId: " + drinkId);

			        try {
			            // 1. 술 상세 정보 조회 및 조회수 증가
			            Drink drink = drinkService.selectDrink(drinkId);
			            if (drink != null) {
			                 drinkService.updateAddReadCount(drinkId); // 조회수 증가 로직

			                 mv.addObject("drink", drink); // 술 상세 정보 모델에 추가
			                 
			                 // 카카오 지도 API 키 JSP에 전달
			                 mv.addObject("kakaoMapKey", kakaoMapKey);

			                 String userId = null;
			                 // 세션에서 로그인된 사용자 정보를 가져오는 로직 (예시)
			                 Object userObj = session.getAttribute("loginUser"); // 예: 세션에 "loginUser"라는 이름으로 저장됨
			                 if (userObj != null) {
			                      try {
			                          // 사용자 객체에서 ID를 가져오는 메소드명 확인 후 사용
			                          Method getUserIdMethod = userObj.getClass().getMethod("getUserId"); // 또는 getLoginId 등
			                          userId = (String) getUserIdMethod.invoke(userObj);
			                      } catch (Exception e) {
			                          logger.error("세션에서 사용자 ID를 가져오는 중 오류 발생 (음료 상세)", e);
			                          // 오류 발생 시 비로그인 처리 또는 다른 로직 수행
			                          userId = request.getRemoteAddr(); // 비로그인 사용자로 처리 (IP 주소 사용)
			                      }
			                      logger.info("로그인된 사용자 ID 확인 (음료 상세): {}", userId);
			                 } else {
			                     // 로그인하지 않은 사용자의 경우 IP 주소 사용
			                     userId = request.getRemoteAddr();
			                     logger.info("비로그인 사용자 (IP - 음료 상세): {}", userId);
			                 }

			                 // 2-2. 게시글 타입 정의
			                 String postType = "drink"; // **음료 게시글 타입 지정**

			                 // 2-3. 파라미터 유효성 검사 (컨트롤러에서 해도 됩니다)
			                 if (userId == null || userId.trim().isEmpty() || drinkId <= 0 || postType == null || postType.trim().isEmpty()) {
			                      logger.warn("유효하지 않은 정보로 로그 기록 요청 무시 (음료 상세) - userId: {}, postId: {}, postType: {}", userId, drinkId, postType);
			                 } else { // 정보가 유효한 경우에만 로그 로직 진행
			                      try {
			                         // 2-4. 최근 로그 조회 (ViewLogService 또는 drinkService 사용)
			                         // ViewLogService에 userId, postId, postType으로 최근 로그를 조회하는 메소드가 있다고 가정합니다.
			                         // ViewLog 객체에는 방문 시각(visitTime) 필드가 있어야 합니다.
			                         ViewLog latestLog = drinkService.getLatestPostViewLog(userId, drinkId); // postType 함께 전달
			                         logger.debug("가장 최근 로그 조회 결과 (음료 상세): {}", latestLog);

			                         // 2-5. 24시간 체크
			                         boolean needsLogging = true; // 기본적으로는 로그 기록 필요
			                         if (latestLog != null) {
			                             // ViewLog 객체에서 방문 시간 가져오기 (java.util.Date 등)
			                             Date latestVisitTime = latestLog.getVisitTime(); // ViewLog에 getVisitTime() 메소드가 있다고 가정

			                             if (latestVisitTime != null) {
			                                 long currentTimeMillis = System.currentTimeMillis(); // 현재 시각 (밀리초)
			                                 long latestLogTimeMillis = latestVisitTime.getTime(); // 최근 로그 시각 (밀리초)

			                                 // 최근 로그 기록이 24시간(24 * 60 * 60 * 1000 밀리초) 이내인지 확인
			                                 if (currentTimeMillis - latestLogTimeMillis < 24 * 60 * 60 * 1000) {
			                                     needsLogging = false; // 24시간 이내에 이미 기록됨
			                                     logger.debug("24시간 이내 기록 확인 (음료 상세). 로그 기록 생략.");
			                                 } else {
			                                     logger.debug("마지막 기록이 24시간 지남 (음료 상세). 로그 기록 필요.");
			                                 }
			                             } else {
			                                  logger.warn("최근 로그 기록의 visitTime이 NULL입니다 (음료 상세). 새로운 로그 기록 진행.");
			                             }
			                         } else {
			                              logger.debug("이 사용자/게시글에 대한 기존 로그 기록 없음 (음료 상세). 새로운 로그 기록 필요.");
			                         }

			                         // 2-6. 로그 기록이 필요한 경우 삽입
			                         if (needsLogging) {
			                             // ViewLog 객체 생성 및 데이터 설정
			                             ViewLog newLog = new ViewLog();
			                             newLog.setUserId(userId);
			                             newLog.setPostId(drinkId); // **음료 ID 설정**
			                             newLog.setPostType(postType); // **게시글 타입 'drink' 설정**
			                             // visitTime, logId는 DB에서 자동 처리되도록 설계하는 것이 일반적입니다.

			                             // Service/DAO를 통해 로그 삽입 (ViewLogService 또는 drinkService 사용)
			                             drinkService.insertPostViewLog(newLog); // 로그 삽입 메소드 호출
			                             logger.info("게시글 조회 로그 기록 완료 (음료 상세) - userId: {}, postId: {}, postType: {}", userId, drinkId, postType);
			                         }

			                      } catch (Exception e) {
			                         // 로그 기록 중 예외 발생 시 에러 로깅
			                         logger.error("게시글 조회 로그 기록 중 오류 발생 (음료 상세) - userId: {}, postId: {}, postType: {}", userId, drinkId, postType, e);
			                         // 컨트롤러에서 예외를 잡았으므로, 여기서 로깅만 하고 원래 흐름을 계속합니다.
			                      }
			                 }

			                 
			                 // *** 2. 페어링 정보 조회 로직 추가 ***
			                 // PairingService를 통해 특정 drinkId에 해당하는 페어링 목록을 가져옵니다.
			                 
			                 List<Pairing> pairingList = drinkService.selectPairingsByDrinkId(drinkId);
			                 logger.info("조회된 페어링 목록 크기: " + (pairingList != null ? pairingList.size() : 0));

			                 // *** 페어링 목록을 ModelAndView 객체에 추가하여 JSP로 전달 ***
			                 mv.addObject("pairingList", pairingList);


			                 Map<String, Object> storeInfo = drinkService.selectStoreInfoByDrinkId(drinkId);

			                 if (storeInfo != null) {
			                     String storeAddress = (String) storeInfo.get("STORE_ADDRESS"); // Map에서 주소 추출
			                     String storeName = (String) storeInfo.get("STORE_NAME");       // Map에서 이름 추출 (매퍼 SELECT 절의 별칭 사용)

			                     logger.info("조회된 스토어 정보: 주소=" + storeAddress + ", 이름=" + storeName);
			                     // JSP에서 Map 형태로 접근할 수 있도록 Map 자체를 추가
			                     mv.addObject("storeInfo", storeInfo);
			                     // 또는 각각의 값을 별도로 추가
			                     // mv.addObject("storeAddress", storeAddress);
			                     // mv.addObject("storeName", storeName);
			                 } else {
			                     logger.info("해당 drinkId에 대한 스토어 정보가 없습니다.");
			                     mv.addObject("storeInfo", null); // 정보가 없음을 JSP에 전달
			                 }

			                 
			                 // 3. 댓글 관련 로직 (기존 코드 유지)
			                 int commentsPerPage = 10;
			                 String targetType = "drink";

			                 // 댓글 총 개수 조회
			                 int totalComments = commentService.selectCommentCount(drinkId, targetType);
			                 logger.info("조회된 댓글 총 개수: " + totalComments);

			                 int totalPages = (int) Math.ceil((double) totalComments / commentsPerPage);
			                 if (totalPages == 0) totalPages = 1;

			                 if (page < 1) page = 1;
			                 if (page > totalPages) totalPages = page; // totalPages보다 크면 totalPages로 설정

			                 int offset = (page - 1) * commentsPerPage;

			                 // 댓글 리스트 조회
			                 List<Comment> comments = commentService.selectDrinkComments(drinkId, targetType, offset, commentsPerPage);
			                 if (comments == null) {
			                     logger.warn("commentService.selectDrinkComments()가 null을 반환했습니다.");
			                     comments = new ArrayList<>();
			                 }
			                 logger.info("조회된 댓글 리스트 크기: " + comments.size());
			                 

			                 mv.addObject("comments", comments);
			                 mv.addObject("page", page);
			                 mv.addObject("totalPages", totalPages);

			                 mv.setViewName("drink/drinkDetail"); // 정상 처리 시 drinkDetail.jsp로 이동

			             } else {
			                 // 술 정보가 존재하지 않을 경우
			                 logger.warn(drinkId + "번 술 정보가 존재하지 않습니다.");
			                 mv.addObject("message", drinkId + "번 술이 존재하지 않습니다.");
			                 mv.setViewName("common/error"); // 에러 페이지로 이동
			             }

			        } catch (Exception e) {
			            // 예외 발생 시 처리
			            logger.error("drinkDetail.do 처리 중 오류 발생", e);
			            mv.addObject("message", "술 상세 정보를 가져오는 중 오류가 발생했습니다.");
			            mv.setViewName("common/error"); // 에러 페이지로 이동
			        }

			        return mv; // ModelAndView 객체 반환
			    }

			// 드링크 검색 기능
			 @RequestMapping("drinkSearch.do")
			    public ModelAndView drinkSearchTitleMethod(
			            ModelAndView mv,
			            @RequestParam("action") String action,
			            @RequestParam("keyword") String keyword,
			            @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			            @RequestParam(name = "limit", required = false, defaultValue = "12") int limit,
			            @RequestParam(name = "sortType", required = false, defaultValue = "latest") String sortType,
			            @RequestParam(name = "sortDirection", required = false, defaultValue = "DESC") String sortDirection) { // *** 추가: sortDirection 파라미터 받기 ***

			        // logger.info("drinkSearch.do 요청 받음 - keyword: {}, page: {}, limit: {}, sortType: {}, sortDirection: {}", keyword, currentPage, limit, sortType, sortDirection); // 로그 출력 예시 (sortDirection 추가)

			        // 검색결과가 적용된 총 목록 갯수 조회 (정렬 기준과 무관)
			        int listCount = drinkService.selectSearchTitleCount(keyword);

			        // 페이지 관련 항목 계산
			        Paging paging = new Paging(listCount, limit, currentPage, "drinkSearch.do");
			        paging.calculate();

			        // 검색, 페이징, 정렬 정보를 담을 객체
			        Search search = new Search();
			        search.setKeyword(keyword);
			        search.setStartRow(paging.getStartRow());
			        search.setEndRow(paging.getEndRow());
			        search.setSortType(sortType);
			        search.setSortDirection(sortDirection); // *** 추가: Search 객체에 sortDirection 설정 ***

			        // 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
			        // DrinkService의 메소드가 Search 객체를 받도록 수정해야 합니다.
			        ArrayList<Drink> list = drinkService.selectSearchTitle(search);

			        if (list != null && !list.isEmpty()) {
			            mv.addObject("list", list);
			            mv.addObject("paging", paging);
			            mv.addObject("action", action);
			            mv.addObject("keyword", keyword);
			            mv.addObject("sortType", sortType);
			            mv.addObject("sortDirection", sortDirection); // *** 추가: 현재 정렬 방향 값을 JSP로 다시 전달 ***

			            mv.setViewName("drink/drinkList");
			        } else {
			             mv.addObject("list", list);
			             mv.addObject("paging", paging);
			             mv.addObject("action", action);
			             mv.addObject("keyword", keyword);
			             mv.addObject("sortType", sortType);
			             mv.addObject("sortDirection", sortDirection); // *** 추가: 정렬 방향 유지 ***
			             mv.setViewName("drink/drinkList");
			        }

			        return mv;
			    }
			
			@RequestMapping("moveInsertDrink.do")
			public String moveInsertDrink() {
				return "drink/drinkInsert";
			}
			
			// 새 술 원글 등록 요청 처리용(이미지 업로드 기능 포함)	

			@RequestMapping(value = "drinkInsert.do", method = RequestMethod.POST)
			public String insertDrink( // 반환 타입 String 유지
			        Drink drink, // 사용자가 입력한 데이터가 담긴 drink 객체
			        @RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			        Model model) {

			    logger.info("insertDrink.do : " + drink);

			    try {
			        // 1. 음료 저장 (자동 생성된 ID를 drink.drinkId에 세팅)
			        // 성공적으로 insert 될 때만 ID가 세팅됩니다.
			        drinkService.insertDrink(drink);

			        // 2. 이미지 파일이 있을 경우 이미지 저장
			        if (imageFile != null && !imageFile.isEmpty()) {
			            try {
			                byte[] imageBytes = imageFile.getBytes();

			                Image image = new Image();
			                // drink.getDrinkId()가 insertDrink 호출 후 올바르게 설정되었는지 확인 중요
			                image.setTargetId(drink.getDrinkId());
			                image.setTargetType("drink");
			                image.setImageData(imageBytes);
			                image.setDescription("음료 이미지"); // "레시피 이미지" 대신 "음료 이미지"

			                imageService.insertImage(image);
			            } catch (IOException e) {
			                e.printStackTrace();
			                // 이미지 업로드 중 오류 발생 시
			                model.addAttribute("msg", "이미지 파일 처리 중 오류가 발생했습니다. 다시 시도해주세요."); // 사용자에게 보여줄 메시지
			                model.addAttribute("drink", drink); // 사용자가 입력했던 drink 객체를 다시 모델에 담아 뷰로 전달
			                return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환

			            }
			        }

			        // 성공 시 음료 목록 페이지로 리다이렉트
			        return "redirect:drinkList.do";

			    } catch (UncategorizedSQLException dbE) {
			        dbE.printStackTrace();
			        // 데이터베이스 관련 오류 발생 시 (ORA-12899 포함)
			        String userMessage = "음료 등록 중 데이터베이스 오류가 발생했습니다.";
			        if (dbE.getCause() instanceof SQLException) {
			            SQLException sqlE = (SQLException) dbE.getCause();
			            logger.error("SQL Error Code: " + sqlE.getErrorCode() + ", SQL State: " + sqlE.getSQLState()); // 서버 로그에 상세 에러 기록

			            if (sqlE.getErrorCode() == 12899) {
			                userMessage = "입력하신 음료 이름이 너무 깁니다. (최대 200자)"; // ORA-12899 특정 메시지
			            } else {
			                 // 다른 SQL 오류의 경우 일반적인 메시지 또는 더 상세한 정보 제공
			                 userMessage = "데이터베이스 처리 중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.";
			            }
			        }
			        model.addAttribute("msg", userMessage); // 사용자에게 보여줄 메시지
			        model.addAttribute("drink", drink); // 🎉 사용자가 입력했던 drink 객체를 다시 모델에 담아 뷰로 전달
			        return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환


			    } catch (Exception e) {
			        e.printStackTrace();
			        // 그 외 예상치 못한 오류 발생 시
			        logger.error("Unexpected error during drink insert", e); // 서버 로그에 상세 에러 기록
			        model.addAttribute("msg", "음료 등록 중 예상치 못한 오류가 발생했습니다. 시스템 관리자에게 문의해주세요."); // 사용자에게 보여줄 메시지
			        model.addAttribute("drink", drink); // 🎉 사용자가 입력했던 drink 객체를 다시 모델에 담아 뷰로 전달
			        return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환

			    }
			}
			
			// drink 수정 페이지로 이동 처리용
			@RequestMapping("moveUpdateDrinkPage.do")
			public String moveDrinkUpdatePage(Model model, 
					@RequestParam("drinkId") int drinkId,
					@RequestParam("page") int currentPage) {

				// 수정 페이지로 전달할 recipe 정보 조회함
				Drink drink = drinkService.selectDrink(drinkId);

				if (drink != null) {
					model.addAttribute("drink", drink);
					model.addAttribute("currentPage", currentPage);
					return "drink/drinkUpdate";
				} else {
					
					model.addAttribute("message", drinkId + "번 레시피 수정페이지로 이동 실패!");
			        return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
				}
			}
			
			// drink 수정 처리용 메소드
			@RequestMapping(value="drinkUpdate.do",
					method=RequestMethod.POST)
			public String drinkUpdateMethod(
					Drink drink, Model model,
					HttpServletRequest request,
					@RequestParam("imageFile") MultipartFile imageFile)
					
					 {
				logger.info("drinkUpdate.do : " + drink);	
					

				try {
			        // 1. 레시피 기본 정보 수정
			        int result = drinkService.updateDrink(drink);

			        if (result <= 0) {
			            model.addAttribute("message", "레시피 수정 실패");
			            return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
			        }

			        // 2. 이미지 파일이 새로 업로드 되었으면 처리
			        if (imageFile != null && !imageFile.isEmpty()) {
			            byte[] imageBytes = imageFile.getBytes();

			            Image image = new Image();
			            image.setTargetId(drink.getDrinkId());
			            image.setTargetType("drink");
			            image.setImageData(imageBytes);
			            image.setDescription("술 이미지");

			            // 기존 이미지가 있을 경우 삭제 로직(필요시) 수행 후 새 이미지 저장
			            imageService.deleteImageByTargetIdAndType(drink.getDrinkId(), "drink");
			            imageService.insertImage(image);
			        }

			        // 수정 성공 후 상세 페이지로 리다이렉트
			        return "redirect:drinkDetail.do?no=" + drink.getDrinkId();

			    } catch (IOException e) {
			        e.printStackTrace();
			        model.addAttribute("message", "이미지 업로드 중 오류가 발생했습니다.");
			        return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
			    } catch (Exception e) {
			        e.printStackTrace();
			        
			        model.addAttribute("message", "레시피 수정 중 오류가 발생했습니다.");
			        model.addAttribute("msg", "음료 등록 중 예상치 못한 오류가 발생했습니다. 시스템 관리자에게 문의해주세요."); // 사용자에게 보여줄 메시지
			        return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
			}
					 }
			
			@RequestMapping(value = "deleteDrink.do", method = RequestMethod.POST)
		    public String deleteDrink(
		            @RequestParam("drinkId") int drinkId,
		            @RequestParam(value = "page", defaultValue = "1") int page,
		            RedirectAttributes redirectAttrs) {

		        try {
		            drinkService.deleteDrink(drinkId);
		            redirectAttrs.addFlashAttribute("message", "레시피가 성공적으로 삭제되었습니다.");
		        } catch (Exception e) {
		            redirectAttrs.addFlashAttribute("errorMessage", "삭제 중 오류가 발생했습니다.");
		            e.printStackTrace();
		        }

		        return "redirect:/drinkList.do?page=" + page;
		    }
			
			// drink 평점 기능
			 @RequestMapping(value = "rateDrink.do", method = RequestMethod.POST)
			  
			    public String rateDrink(
			            @RequestParam("drinkId") int drinkId,
			            @RequestParam(value = "rating", defaultValue = "0") double ratingScore, // 평점 값, 기본값을 0으로 설정
			            HttpSession session,
			            RedirectAttributes redirectAttributes) {

				

			        // 1. 로그인한 사용자 정보 가져오기
			        Users loggedInUser = (Users) session.getAttribute("loginUser");

			        // 2. 로그인 상태 확인
			     

			        String loginId = loggedInUser.getLoginId(); // 로그인 ID 가져오기

			        System.out.println("--- Debug Info (Controller) ---");
			        System.out.println("loginId: " + loginId);
			        System.out.println("drinkId: " + drinkId);
			        System.out.println("ratingScore: " + ratingScore);
			        System.out.println("-------------------------------");

			        
			        
			        // 평점이 이미 존재하는지 확인
			        int existingRatingCount = drinkService.selectUserRating(loginId, drinkId);
			        if (existingRatingCount > 0) {
			            // 이미 평점을 부여한 경우, 업데이트
			        	drinkService.updateRating(loginId, drinkId, ratingScore, "drink");
			            redirectAttributes.addFlashAttribute("message", "평점이 수정되었습니다.");
			        } else {
			            // 평점을 새로 추가
			        	drinkService.insertRating(loginId, drinkId, ratingScore, "drink");
			            redirectAttributes.addFlashAttribute("message", "평점이 등록되었습니다.");
			        }

			        // 평균 평점 업데이트
			        double averageRating = drinkService.getAverageRating(drinkId);
			        drinkService.updateAverageRating(drinkId, averageRating); // 평균 평점 업데이트

			        redirectAttributes.addFlashAttribute("avgRating", averageRating); // 평균 평점 반환

			        return "redirect:/drinkDetail.do?no=" + drinkId; // 레시피 상세 페이지로 리다이렉션

			 }
			
			    @RequestMapping(value = "/drinkStoreInsert.do", method = RequestMethod.GET) // .do 확장자와 GET 메소드 매핑
			    public String moveInsertDrinkStorePage(@RequestParam("drinkId") int drinkId,
			                                          @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage, // page 파라미터 (필수 아님, 기본값 1)
			                                          Model model) {
			    	logger.info(">>> moveInsertDrinkStorePage (리다이렉트 후): @RequestParam으로 받은 drinkId 값: " + drinkId);
			        // 1. drinkId를 사용하여 음료 정보 조회
			      
			    	int drinkIdFromRequest = drinkId; // @RequestParam으로 받은 값

			    	logger.info(">>> Controller: Calling drinkService.getById with ID: " + drinkIdFromRequest);
			    	
			    	Drink drink = drinkService.getDrinkById(drinkIdFromRequest);

			    	logger.info(">>> Controller: Returned from drinkService.getById.");
			        
			        if (drink != null) {
			            logger.info(">>> moveInsertDrinkStorePage: 조회된 Drink 객체의 drinkId: " + drink.getDrinkId());
			        } else {
			            logger.warn(">>> moveInsertDrinkStorePage: drinkService.getDrinkById 결과가 null입니다.");
			        }
			        
			        if (drink == null) {
			            // 해당 음료가 없을 경우 처리
			            model.addAttribute("errorMessage", "해당 음료 정보를 찾을 수 없습니다.");
			            return "errorPage"; // 예시
			        }

			        // 2. 해당 음료의 이름으로 기존 판매처 목록 조회
			        List<DrinkStore> drinkStores = drinkService.getStoresByDrinkName(drink.getName());

			        // 3. 모델에 음료 정보와 판매처 목록 담기
			        model.addAttribute("drink", drink);
			        model.addAttribute("drinkStores", drinkStores);
			        model.addAttribute("currentPage", currentPage); // 필요하다면 페이지 번호도 전달

			        // 4. 판매처 관리 JSP 페이지 반환
			        // JSP 파일 이름에 따라 반환 값 조정
			        return "/drink/drinkStoreInsert";
			    }

			    @RequestMapping(value = "/drinkStoreInsert.do", method = RequestMethod.POST)
			    @ResponseBody // 이 어노테이션을 사용하여 메소드의 반환 값이 HTTP 응답 본문에 직접 쓰여지도록 합니다.
			    public String addDrinkStoreAjax(DrinkStore drinkStore,
			                                   @RequestParam("drinkId") int drinkId) { // drinkId는 필요하다면 계속 받습니다.

			        // logger 추가 (요청 받은 drinkId 값 확인)
			        logger.info(">>> addDrinkStoreAjax: @RequestParam으로 받은 drinkId 값: " + drinkId);
			        logger.info(">>> addDrinkStoreAjax: 받은 DrinkStore 객체: " + drinkStore.toString()); // DrinkStore 객체 내용 확인

			        
			        int result = drinkService.insertDrinkStore(drinkStore);

			        // 등록 결과에 따라 클라이언트에 보낼 문자열 결정
			        if (result > 0) {
			            // 등록 성공 시 'success' 문자열 반환
			            logger.info(">>> addDrinkStoreAjax: 판매처 등록 성공.");
			            return "success";
			        } else {
			            // 등록 실패 시 'fail' 문자열 반환
			            logger.warn(">>> addDrinkStoreAjax: 판매처 등록 실패.");
			            return "fail";
			        }

			       
			    }
			    @RequestMapping(value = "/deleteDrinkStore.do", method = RequestMethod.POST) // POST 메소드에 /deleteDrinkStore.do 경로 매핑
			    @ResponseBody // 클라이언트에 응답 본문을 직접 반환합니다.
			    public String deleteDrinkStoreAjax(@RequestParam("storeId") int storeId) { // 쿼리 스트링 또는 폼 데이터로 storeId 받음

			        logger.info(">>> deleteDrinkStoreAjax: @RequestParam으로 받은 storeId 값: " + storeId);

			        // Service를 호출하여 판매처 삭제
			        // drinkService에 deleteStore(int storeId) 메소드가 있다고 가정합니다.
			        int result = drinkService.deleteStore(storeId); // <-- 이 메소드는 직접 구현하셔야 합니다.

			        // 삭제 결과에 따라 클라이언트에 보낼 문자열 결정
			        if (result > 0) {
			            logger.info(">>> deleteDrinkStoreAjax: 판매처 삭제 성공 (ID: {}).", storeId);
			            return "success"; // 삭제 성공 시 'success' 문자열 반환
			        } else {
			            logger.warn(">>> deleteDrinkStoreAjax: 판매처 삭제 실패 (ID: {}).", storeId);
			            return "fail"; // 삭제 실패 시 'fail' 문자열 반환
			        }
			    }

			    @RequestMapping(value = "/pairingInsert.do", method = RequestMethod.GET) // URL 매핑
			    public ModelAndView pairingInsertView(@RequestParam("drinkId") int drinkId, ModelAndView mv) {
			        logger.info(">>> /pairingInsertView.do (GET) 요청 - drinkId: {}", drinkId); // 컨트롤러 진입 로그
			        logger.info("{}번 드링크에 대한 페어링 등록 페이지로 이동 시도", drinkId);

			        // TODO: 나중에 로그인 여부를 체크하는 로직 추가

			        // 1. 해당 drinkId에 해당하는 기존 페어링 목록 조회 (Service 호출)
			        List<Pairing> existingPairingList = drinkService.selectPairings(drinkId);
			        logger.info("기존 페어링 목록 조회 결과: {}", existingPairingList); 
			        logger.info("{}번 드링크에 대한 기존 페어링 목록 크기: {}", drinkId, (existingPairingList != null ? existingPairingList.size() : 0));

			        List<Recipe> recipeList = recipeService.getAllRecipes(); // 모든 레시피를 가져오는 메소드
			        mv.addObject("recipeList", recipeList);
			        
			        // 2. 조회된 existingPairingList와 drinkId를 ModelAndView에 담아 JSP로 전달
			        mv.addObject("existingPairingList", existingPairingList);
			        mv.addObject("drinkId", drinkId);

			        // 3. 페어링 등록 페이지 JSP 파일 이름 지정
			        mv.setViewName("drink/pairingInsert"); // /WEB-INF/views/pairingInsert.jsp

			        logger.info(">>> pairingInsert.jsp 뷰로 이동");

			        return mv;
			    }
			    
			    @RequestMapping(value = "/insertPairing.do", method = RequestMethod.POST)
			    public String insertPairing(
			            @RequestParam("drinkId") int drinkId, // 폼에서 hidden 필드로 전달받음
			            @RequestParam("recipeId") int recipeId, // 폼에서 hidden 필드로 전달받음 (레시피 선택 시 설정됨)
			            @RequestParam("reason") String reason, // 폼에서 textarea로 입력받음
			            RedirectAttributes redirectAttributes // 리다이렉트 시 메시지 전달용 (선택 사항)
			            // TODO: 등록자 정보가 필요하다면 HttpSession 등을 통해 로그인 사용자 정보 받기
			            // HttpSession session
			            ) {
			        logger.info(">>> /insertPairing.do (POST) 요청 받음");
			        logger.info("받은 데이터 - drinkId: {}, recipeId: {}, reason: {}", drinkId, recipeId, reason);

			       


			       
			        Pairing newPairing = new Pairing();
			        // PAIRING_ID는 DB에서 자동 생성 (Mapper selectKey 설정)
			        newPairing.setDrinkId(drinkId); // 폼에서 받은 drinkId 설정
			        newPairing.setRecipeId(recipeId); // 폼에서 받은 recipeId 설정
			        newPairing.setReason(reason); // 폼에서 받은 reason 설정
			        // newPairing.setCreatedBy(createdBy); // 등록자 설정 (필요하다면)


			        int result = 0; // 삽입 결과 (영향받은 행 수)
			        try {
			            // Service를 통해 페어링 등록 수행
			            // PairingService에는 insertPairing(Pairing pairing) 메소드가 필요합니다.
			            result = drinkService.insertPairing(newPairing);
			            logger.info("페어링 등록 결과: {} (성공 시 1)", result);

			            if (result > 0) {
			                // 등록 성공 시
			                // 등록된 드링크의 상세 페이지로 리다이렉트하는 것이 일반적입니다.
			                redirectAttributes.addFlashAttribute("message", "페어링이 성공적으로 등록되었습니다.");
			                // drinkId를 리다이렉트 URL에 파라미터로 추가
			                return "redirect:/drinkDetail.do?no=" + drinkId; // <-- 리다이렉트 URL 확인 (성공 시 이동할 곳)
			            } else {
			                // 등록 실패 시 (삽입된 행 수가 0)
			                logger.warn("페어링 등록 실패 (영향받은 행 0)");
			                redirectAttributes.addFlashAttribute("errorMsg", "페어링 등록에 실패했습니다.");
			                // 실패 시 페어링 등록 페이지로 돌아가거나 오류 페이지로 이동
			                return "redirect:/pairingInsertView.do?no=" + drinkId; // <-- 실패 시 리다이렉트 URL 확인
			            }

			        } catch (Exception e) {
			            // 데이터베이스 오류 등 예외 발생 시
			            logger.error("페어링 등록 중 예외 발생: {}", e.getMessage());
			            e.printStackTrace(); // 오류 스택 트레이스 출력 (개발 중 유용)

			            redirectAttributes.addFlashAttribute("errorMsg", "페어링 등록 중 오류가 발생했습니다.");
			            // 오류 발생 시 페어링 등록 페이지로 돌아가거나 오류 페이지로 이동
			            return "redirect:/pairingInsertView.do?drinkId=" + drinkId; // <-- 오류 시 리다이렉트 URL 확인
			        }
			    }
			   // 페어링 삭제기능
			    @RequestMapping(value = "/deletePairing.do", method = RequestMethod.POST) // POST 방식으로 요청받는 것이 권장됩니다.
			    @ResponseBody // 이 어노테이션을 사용하면 반환하는 문자열이 View 이름이 아닌 HTTP 응답 본문으로 직접 전송됩니다.
			    public String deletePairing(@RequestParam("pairingId") int pairingId
			           
			            ) {
			        logger.info(">>> /deletePairing.do (POST) 요청 받음 - pairingId: {}", pairingId);

			        

			        int result = 0; // 삭제 결과 (영향받은 행 수)
			        try {
			            // Service를 통해 페어링 삭제 수행
			            // PairingService 인터페이스와 구현체에 deletePairing(int pairingId) 메소드가 구현되어 있어야 합니다.
			            // 이 메소드 안에서 DAO/Mapper를 호출하여 실제 DELETE 쿼리를 실행합니다.
			            result = drinkService.deletePairing(pairingId);

			            if (result > 0) {
			                // 삭제 성공 (영향받은 행 수가 1 이상)
			                logger.info("페어링 삭제 성공: pairingId {}", pairingId);
			                return "success"; // 삭제 성공을 알리는 문자열 반환
			            } else {
			                // 삭제 실패 (영향받은 행 수가 0) - 해당 ID의 페어링이 없었거나 이미 삭제된 경우
			                logger.warn("페어링 삭제 실패 (영향받은 행 0): pairingId {}", pairingId);
			                return "fail"; // 삭제 실패를 알리는 문자열 반환
			            }

			        } catch (Exception e) {
			            // 데이터베이스 오류 등 예외 발생 시
			            logger.error("페어링 삭제 중 예외 발생: pairingId {}", pairingId, e); // 예외 객체도 로그에 포함
			            // e.printStackTrace(); // 개발 중에는 스택 트레이스 출력
			            return "error"; // 삭제 중 오류 발생을 알리는 문자열 반환
			        }
			    }
}