package com.thedish.recipe.controller;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.thedish.common.Allergy;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.common.ViewLog;
import com.thedish.image.model.service.ImageService;
import com.thedish.image.model.vo.Image;
import com.thedish.recipe.model.vo.Recipe;
import com.thedish.recipe.service.impl.RecipeService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;




@Controller
public class RecipeController {

	private static final Logger logger = LoggerFactory.getLogger(RecipeController.class);
	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private CommentService commentService;	 
	 
	// 레시피 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 12개씩 출력 처리)
		@RequestMapping("recipeList.do")
		public ModelAndView recipeListMethod(ModelAndView mv, 
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
			int listCount = recipeService.selectListCount();
			// 페이지 관련 항목들 계산 처리
			Paging paging = new Paging(listCount, limit, currentPage, "recipeList.do");
			paging.calculate();

			// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
			ArrayList<Recipe> list = recipeService.selectListRecipe(paging);

			if (list != null && list.size() > 0) { // 조회 성공시
				// ModelAndView : Model + View
				mv.addObject("list", list); // request.setAttribute("list", list) 와 같음
				mv.addObject("paging", paging);

				mv.setViewName("recipe/recipeList");
			} else { // 조회 실패시
				mv.addObject("message", currentPage + "페이지에 출력할 레시피 목록 조회 실패!");
				mv.setViewName("common/error");
			}

			return mv;
		}
				
		// 레시피 상세보기 요청 처리용
				@RequestMapping("/recipeDetail.do")				
				public ModelAndView recipeDetailMethod(
				    @RequestParam("no") int recipeId, 
				    ModelAndView mv, 
				    HttpSession session,
				    HttpServletRequest request,
				    @RequestParam(value = "page", required = false, defaultValue = "1") int page
				) {
				    logger.info("recipeDetail.do 호출 - recipeId: {}", recipeId);

				    // 레시피 조회
				    Recipe recipe = recipeService.selectRecipe(recipeId);
				    if (recipe != null) {
			            // 1. 게시글 조회수 증가 (기존 로직)
			            // 조회수 증가 로직과 로그 기록 로직은 별개로 처리될 수 있습니다.
			            recipeService.updateAddReadCount(recipeId);
			            logger.info("{}번 레시피 조회수 증가", recipeId);		         

			            // 1. 사용자 ID 가져오기 (로그인된 경우, 아니면 IP 주소 등 활용)
			            String userId = null;
			            // 세션에서 로그인된 사용자 정보를 가져오는 로직 (예시)
			            Object userObj = session.getAttribute("loginUser"); // 예: 세션에 "loggedInUser"라는 이름으로 저장됨
			            if (userObj != null) {
			                 try {	                    
			                     
			                     Method getUserIdMethod = userObj.getClass().getMethod("getUserId"); // 또는 getLoginId 등
			                     userId = (String) getUserIdMethod.invoke(userObj);
			                 } catch (Exception e) {
			                     logger.error("세션에서 사용자 ID를 가져오는 중 오류 발생", e);
			                     // 오류 발생 시 비로그인 처리 또는 다른 로직 수행
			                     userId = request.getRemoteAddr(); // 비로그인 사용자로 처리 (IP 주소 사용)
			                 }
			                 logger.info("로그인된 사용자 ID 확인: {}", userId);
			            } else {
			                // 로그인하지 않은 사용자의 경우 IP 주소 사용
			                userId = request.getRemoteAddr();
			                logger.info("비로그인 사용자 (IP): {}", userId);
			            }

			            // 2. 게시글 타입 정의
			            String postType = "recipe"; // 레시피 게시글 타입 지정

			            // 파라미터 유효성 검사 (컨트롤러에서 해도 됩니다)
			            if (userId == null || userId.trim().isEmpty() || recipeId <= 0 || postType == null || postType.trim().isEmpty()) {
			                 logger.warn("유효하지 않은 정보로 로그 기록 요청 무시 (컨트롤러) - userId: {}, postId: {}, postType: {}", userId, recipeId, postType);
			            } else { // 정보가 유효한 경우에만 로그 로직 진행
			                 try {
			                  
			                    ViewLog latestLog = recipeService.getLatestPostViewLog(userId, recipeId);
			                    logger.debug("가장 최근 로그 조회 결과 (컨트롤러): {}", latestLog);

			                    // 4. 24시간 체크
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
			                                logger.debug("24시간 이내 기록 확인 (컨트롤러). 로그 기록 생략.");
			                            } else {
			                                logger.debug("마지막 기록이 24시간 지남 (컨트롤러). 로그 기록 필요.");
			                            }
			                        } else {
			                             logger.warn("최근 로그 기록의 visitTime이 NULL입니다 (컨트롤러). 새로운 로그 기록 진행.");
			                        }
			                    } else {
			                         logger.debug("이 사용자/게시글에 대한 기존 로그 기록 없음 (컨트롤러). 새로운 로그 기록 필요.");
			                    }

			                    // 5. 로그 기록이 필요한 경우 삽입
			                    if (needsLogging) {
			                        // ViewLog 객체 생성 및 데이터 설정
			                        ViewLog newLog = new ViewLog();
			                        newLog.setUserId(userId);
			                        newLog.setPostId(recipeId);
			                        newLog.setPostType(postType);
			                        // visitTime, logId는 DB에서 자동 처리

			                        // Service/DAO를 통해 로그 삽입
			                        // Service의 insertPostViewLog 메소드는 DAO의 동일 메소드를 호출할 것입니다.
			                        recipeService.insertPostViewLog(newLog);
			                        logger.info("게시글 조회 로그 기록 완료 (컨트롤러) - userId: {}, postId: {}, postType: {}", userId, recipeId, postType);
			                    }

			                 } catch (Exception e) {
			                    // 로그 기록 중 예외 발생 시 에러 로깅
			                    logger.error("게시글 조회 로그 기록 중 오류 발생 (컨트롤러) - userId: {}, postId: {}, postType: {}", userId, recipeId, postType, e);
			                    // 컨트롤러에서 예외를 잡았으므로, 여기서 에러 페이지로 리다이렉트하거나 다른 처리를 할 수 있습니다.
			                    // 여기서는 로깅만 하고 원래 흐름을 계속합니다.
			                 }
			            } 


			            mv.addObject("recipe", recipe);

				        // 알러지 정보 조회
				        List<Allergy> allergyList = recipeService.selectAllergyByRecipeId(recipeId);
				        if (allergyList != null && !allergyList.isEmpty()) {
				            logger.info("조회된 알러지 리스트: {}", allergyList);
				            mv.addObject("allergyList", allergyList);
				        } else {
				            logger.warn("알러지 리스트가 비어 있습니다!");
				            mv.addObject("allergyList", new ArrayList<>());
				        }

				        // 댓글 관련 처리
				        int commentsPerPage = 10;
				        String targetType = "recipe";

				        // 댓글 총 개수 조회
				        int totalComments = commentService.selectCommentCount(recipeId, targetType);
				        logger.info("조회된 댓글 총 개수: {}", totalComments);

				        int totalPages = (int) Math.ceil((double) totalComments / commentsPerPage);
				        if (totalPages == 0) totalPages = 1;

				        if (page < 1) page = 1;
				        if (page > totalPages) page = totalPages;

				        int offset = (page - 1) * commentsPerPage;

				        // 댓글 리스트 조회
				        List<Comment> comments = commentService.selectComments(recipeId, targetType, offset, commentsPerPage);
				        if (comments == null) {
				            logger.warn("commentService.selectComments()가 null을 반환했습니다.");
				            comments = new ArrayList<>();
				        }
				        logger.info("조회된 댓글 리스트 크기: {}", comments.size());
				        for (Comment c : comments) {
				            logger.info("댓글 ID: {}, 내용: {}", c.getCommentId(), c.getContent());
				        }

				        mv.addObject("comments", comments);
				        mv.addObject("page", page);
				        mv.addObject("totalPages", totalPages);

				        mv.setViewName("recipe/recipeDetail");
				    } else {
				        logger.error("{}번 레시피가 존재하지 않습니다!", recipeId);
				        mv.addObject("message", recipeId + "번 레시피가 존재하지 않습니다.");
				        mv.setViewName("common/error");
				    }

				    return mv;
				}




		// 레시피 검색 기능
				 @RequestMapping("recipeSearch.do")
				    public ModelAndView recipeSearchTitleMethod(
				            ModelAndView mv,
				            @RequestParam("action") String action,
				            @RequestParam("keyword") String keyword,
				            @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, // page 파라미터 타입을 int로 변경하고 기본값 설정
				            @RequestParam(name = "limit", required = false, defaultValue = "12") int limit, // limit 파라미터 타입을 int로 변경하고 기본값 설정
				            @RequestParam(name = "sortType", required = false, defaultValue = "latest") String sortType) { // @RequestParam에 sortType 추가

				        // @RequestParam의 defaultValue와 required=false 속성을 사용하여
				        // 파라미터가 없을 경우 기본값이 적용되도록 처리했습니다.
				        // 따라서 page, limit, sortType에 대한 null 체크 로직이 간소화됩니다.

				        // logger.info("recipeSearch.do 요청 받음 - keyword: {}, page: {}, limit: {}, sortType: {}", keyword, currentPage, limit, sortType); // 로그 출력 예시

				        // 검색결과가 적용된 총 목록 갯수 조회 (정렬 기준과 무관)
				        int listCount = recipeService.selectSearchTitleCount(keyword);

				        // 페이지 관련 항목 계산
				        Paging paging = new Paging(listCount, limit, currentPage, "recipeSearch.do");
				        paging.calculate();

				        // 검색, 페이징, 정렬 정보를 담을 객체
				        Search search = new Search();
				        search.setKeyword(keyword);
				        search.setStartRow(paging.getStartRow());
				        search.setEndRow(paging.getEndRow());
				        search.setSortType(sortType); // *** Search 객체에 sortType 설정 ***

				        // 서비스 메소드 호출 (Search 객체 전달)
				        ArrayList<Recipe> list = recipeService.selectSearchTitle(search);

				        if (list != null && !list.isEmpty()) { // 조회 성공시 (목록이 비어있지 않으면)
				            // ModelAndView에 결과 및 페이징 정보 담기
				            mv.addObject("list", list);
				            mv.addObject("paging", paging);
				            mv.addObject("action", action);
				            mv.addObject("keyword", keyword);
				            mv.addObject("sortType", sortType); // *** 현재 정렬 기준 값을 JSP로 다시 전달 ***

				            mv.setViewName("recipe/recipeList"); // 결과 페이지 경로 확인
				        } else { // 조회 결과 없음
				            // mv.addObject("message", "'" + keyword + "'에 대한 검색 결과가 존재하지 않습니다.");
				            // mv.setViewName("common/error"); // 또는 검색 결과 없음 페이지로 이동
				            // 검색 결과가 없을 때도 페이지는 표시하되 목록만 비어있도록 처리하는 경우가 많습니다.
				            // 이 경우 list와 paging 객체를 그대로 add해도 JSP에서 목록 크기를 체크하여 처리할 수 있습니다.
				             mv.addObject("list", list); // 빈 목록 전달
				             mv.addObject("paging", paging);
				             mv.addObject("action", action);
				             mv.addObject("keyword", keyword);
				             mv.addObject("sortType", sortType); // 정렬 기준 유지
				             mv.setViewName("recipe/recipeList"); // 목록 페이지로 이동
				        }

				        return mv;
				    }

		
		

		@RequestMapping("moveInsertRecipePage.do")
		public String moveInsertRecipe() {
			return "recipe/insertRecipe";
		}

		// 새 레시피 원글 등록 요청 처리용(이미지 업로드 기능 포함)	

		@RequestMapping(value = "insertRecipe.do", method = RequestMethod.POST)
		public String insertRecipe(
		        Recipe recipe,
		        @RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
		        Model model) {

		    // 1. 레시피 저장 (자동 생성된 ID를 recipe.id에 세팅)
		    recipeService.insertRecipe(recipe);

		    // 2. 이미지 파일이 있을 경우 이미지 저장
		    if (imageFile != null && !imageFile.isEmpty()) {
		        try {
		        	 byte[] imageBytes = imageFile.getBytes();

		            Image image = new Image();
		            image.setTargetId(recipe.getRecipeId());
		            image.setTargetType("recipe");
		            image.setImageData(imageBytes);
		            image.setDescription("레시피 이미지");

		            imageService.insertImage(image);
		        } catch (IOException e) {
		            e.printStackTrace();
		            // 예외 처리 로직 추가 (예: 에러 메시지 모델에 담기, 로그 기록 등)
		            model.addAttribute("msg", "이미지 업로드 중 오류가 발생했습니다.");
		            return "errorPage";  // 적절한 에러 페이지로 이동
		        }
		    }


		    return "redirect:recipeList.do";
		}
		
		// 레시피 수정 페이지로 이동 처리용
		@RequestMapping("moveUpdateRecipePage.do")
		public String moveBoardUpdatePage(Model model, 
				@RequestParam("recipeId") int recipeId,
				@RequestParam("page") int currentPage) {

			// 수정 페이지로 전달할 board 정보 조회함
			Recipe recipe = recipeService.selectRecipe(recipeId);

			if (recipe != null) {
				model.addAttribute("recipe", recipe);
				model.addAttribute("currentPage", currentPage);
				return "recipe/recipeUpdate";
			} else {
				model.addAttribute("message", recipeId + "번 레시피 수정페이지로 이동 실패!");
				return "common/error";
			}
		}
		
		// 레시피 수정 처리용 메소드
		@RequestMapping(value="recipeUpdate.do",
				method=RequestMethod.POST)
		public String recipeUpdateMethod(Recipe recipe, Model model,
				HttpServletRequest request,
				@RequestParam("imageFile") MultipartFile imageFile)
				
				 {
			logger.info("recipeUpdate.do : " + recipe);	
				

			try {
		        // 1. 레시피 기본 정보 수정
		        int result = recipeService.updateRecipe(recipe);

		        if (result <= 0) {
		            model.addAttribute("message", "레시피 수정 실패");
		            return "common/error";
		        }

		        // 2. 이미지 파일이 새로 업로드 되었으면 처리
		        if (imageFile != null && !imageFile.isEmpty()) {
		            byte[] imageBytes = imageFile.getBytes();

		            Image image = new Image();
		            image.setTargetId(recipe.getRecipeId());
		            image.setTargetType("recipe");
		            image.setImageData(imageBytes);
		            image.setDescription("레시피 이미지");

		            // 기존 이미지가 있을 경우 삭제 로직(필요시) 수행 후 새 이미지 저장
		            imageService.deleteImageByTargetIdAndType(recipe.getRecipeId(), "recipe");
		            imageService.insertImage(image);
		        }

		        // 수정 성공 후 상세 페이지로 리다이렉트
		        return "redirect:recipeDetail.do?no=" + recipe.getRecipeId();

		    } catch (IOException e) {
		        e.printStackTrace();
		        model.addAttribute("message", "이미지 업로드 중 오류가 발생했습니다.");
		        return "common/error";
		    } catch (Exception e) {
		        e.printStackTrace();
		        model.addAttribute("message", "레시피 수정 중 오류가 발생했습니다.");
		        return "common/error";
		}
				 }
		// 레시피 삭제
		 @RequestMapping(value = "deleteRecipe.do", method = RequestMethod.POST)
		    public String deleteRecipe(
		            @RequestParam("recipeId") int recipeId,
		            @RequestParam(value = "page", defaultValue = "1") int page,
		            RedirectAttributes redirectAttrs) {

		        try {
		            recipeService.deleteRecipe(recipeId);
		            redirectAttrs.addFlashAttribute("message", "레시피가 성공적으로 삭제되었습니다.");
		        } catch (Exception e) {
		            redirectAttrs.addFlashAttribute("errorMessage", "삭제 중 오류가 발생했습니다.");
		            e.printStackTrace();
		        }

		        return "redirect:/recipeList.do?page=" + page;
		    }
		
		 // 레시피 평점 기능
		 @RequestMapping(value = "rateRecipe.do", method = RequestMethod.POST)
		  
		    public String rateRecipe(
		            @RequestParam("recipeId") int recipeId,
		            @RequestParam(value = "rating", defaultValue = "0") double ratingScore, // 평점 값, 기본값을 0으로 설정
		            HttpSession session,
		            RedirectAttributes redirectAttributes) {

			

		        // 1. 로그인한 사용자 정보 가져오기
		        Users loggedInUser = (Users) session.getAttribute("loginUser");

		        // 2. 로그인 상태 확인
		     

		        String loginId = loggedInUser.getLoginId(); // 로그인 ID 가져오기

		        // 평점이 이미 존재하는지 확인
		        int existingRatingCount = recipeService.selectUserRating(loginId, recipeId);
		        if (existingRatingCount > 0) {
		            // 이미 평점을 부여한 경우, 업데이트
		            recipeService.updateRating(loginId, recipeId, ratingScore, "recipe");
		            redirectAttributes.addFlashAttribute("message", "평점이 수정되었습니다.");
		        } else {
		            // 평점을 새로 추가
		            recipeService.insertRating(loginId, recipeId, ratingScore, "recipe");
		            redirectAttributes.addFlashAttribute("message", "평점이 등록되었습니다.");
		        }

		        // 평균 평점 업데이트
		        double averageRating = recipeService.getAverageRating(recipeId);
		        recipeService.updateAverageRating(recipeId, averageRating); // 평균 평점 업데이트

		        redirectAttributes.addFlashAttribute("avgRating", averageRating); // 평균 평점 반환

		        return "redirect:/recipeDetail.do?no=" + recipeId; // 레시피 상세 페이지로 리다이렉션

		 }
		 
		 
		 

}

