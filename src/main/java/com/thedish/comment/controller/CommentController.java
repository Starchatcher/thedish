package com.thedish.comment.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thedish.comment.model.service.CommentService;
import com.thedish.comment.model.vo.Comment;
import com.thedish.recipe.service.impl.RecipeService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpSession;

@Controller

public class CommentController {

	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

	@Autowired
	private RecipeService recipeService;

	@Autowired
	private CommentService commentService;

		@Autowired
	private CommentService drinktService;
	// 레시피 댓글등록 처리용 
		  @RequestMapping(value = "insertComment.do", method = RequestMethod.POST)
		    public String insertComment(
		            @RequestParam("recipeId") int recipeId,
		            @RequestParam("content") String content,
		            HttpSession session, // *** HttpSession 객체를 파라미터로 받도록 추가 ***
		            RedirectAttributes redirectAttributes) { // 필요시 메시지 전달 등을 위해 추가

		     
		        // @RequestParam("writer") String writer

		        logger.info("댓글 작성 요청: recipeId={}, content={}", recipeId, content); // writer는 아래에서 가져옴

		        // *** 세션에서 로그인 사용자 정보 가져오기 ***
		      
		        Object loginUserObj = session.getAttribute("loginUser");

		        String writerId = null; // 작성자 ID를 저장할 변수

		        if (loginUserObj != null) {
		            // 로그인된 사용자 정보가 세션에 있을 경우
		            // LoginUser 객체에서 사용자 ID를 가져옵니다. 실제 필드명에 맞게 수정하세요.
		            // 예: loginUser.getLoginId() 또는 loginUser.getUserId()
		            // 형변환 시 실제 LoginUser 클래스 타입으로 캐스팅해야 합니다.
		             try {
		                 // 예시: LoginUser 타입으로 캐스팅하고 getLoginId() 메소드 호출
		                 Users loginUser = (Users) loginUserObj; // *** 실제 LoginUser 클래스 타입으로 캐스팅하세요 ***
		                 writerId = loginUser.getLoginId(); // *** 실제 사용자 ID 필드의 Getter 메소드 호출하세요 ***
		                 logger.info("로그인된 사용자 ID 확인: {}", writerId);

		             } catch (ClassCastException e) {
		                 logger.error("세션의 loginUser 객체 타입 캐스팅 오류", e);
		                 // 에러 처리: 예를 들어 로그인 페이지로 리다이렉트 또는 오류 메시지 표시
		                 redirectAttributes.addFlashAttribute("message", "로그인 사용자 정보를 가져오는 중 오류가 발생했습니다.");
		                 return "redirect:/loginPage.do"; // 적절한 에러 처리 페이지 또는 로그인 페이지로 리다이렉트
		             }

		        } else {
		            // *** 로그인되지 않은 사용자의 댓글 작성 시도 처리 ***
		            logger.warn("로그인되지 않은 사용자가 댓글 작성을 시도했습니다. recipeId={}", recipeId);
		            // 예: 로그인 페이지로 리다이렉트 시키거나, 메시지를 보여줍니다.
		            redirectAttributes.addFlashAttribute("message", "댓글 작성은 로그인 후 이용 가능합니다.");
		            return "redirect:/loginPage.do"; // 적절한 로그인 페이지 경로로 수정
		        }

		        // *** writerId가 null이 아닐 경우에만 댓글 객체 생성 및 서비스 호출 ***
		        if (writerId != null) {
		            Comment comment = new Comment();
		            comment.setTargetId(recipeId);
		            comment.setTargetType("recipe");
		            comment.setContent(content);
		            comment.setLoginId(writerId); // *** 로그인된 사용자 ID를 작성자로 설정 ***

		            // 댓글 서비스 호출
		            int result = commentService.insertComment(comment); // 서비스 메소드 호출 결과(성공/실패)를 받을 수 있다면 좋습니다.

		             if (result > 0) { // 서비스 호출 성공 시 (예: 1 반환 시)
		                 logger.info("댓글 작성 성공: recipeId={}, writer={}", recipeId, writerId);
		                 redirectAttributes.addFlashAttribute("successMessage", "댓글이 성공적으로 등록되었습니다."); // 성공 메시지 전달 (선택 사항)
		             } else { // 서비스 호출 실패 시
		                 logger.error("댓글 작성 실패: recipeId={}, writer={}", recipeId, writerId);
		                 redirectAttributes.addFlashAttribute("errorMessage", "댓글 등록에 실패했습니다."); // 실패 메시지 전달 (선택 사항)
		             }

		        } else {
		             // loginUserObj가 null이 아니었음에도 writerId를 가져오지 못한 경우 (예: LoginUser 객체는 있으나 ID 필드가 null인 경우)
		             logger.error("로그인 사용자 정보에서 ID를 가져올 수 없습니다.");
		             redirectAttributes.addFlashAttribute("errorMessage", "사용자 정보를 가져오는 중 오류가 발생했습니다.");
		             return "redirect:/common/error"; // 적절한 에러 페이지로 리다이렉트
		        }


		        // 댓글 작성 후 레시피 상세 페이지로 리다이렉트
		        
		        return "redirect:/recipeDetail.do?no=" + recipeId; // 댓글 등록 후 해당 레시피 상세 페이지로 이동 (page 파라미터는 필요시 추가)
		    }

		  @RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
			public String deleteComment(@RequestParam("commentId") int commentId,
			                            @RequestParam("recipeId") int recipeId,
			                            @RequestParam("targetType") String targetType,
			                            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
			                            RedirectAttributes redirectAttributes) {

				
				
			    boolean isDeleted = commentService.deleteComment(commentId, targetType);
			   
			    
			    if (isDeleted) {
			        redirectAttributes.addFlashAttribute("message", "댓글이 삭제되었습니다.");
			    } else {
			        redirectAttributes.addFlashAttribute("message", "댓글 삭제에 실패했습니다.");
			    }

			    return "redirect:/recipeDetail.do?no=" + recipeId + "&page=" + page;
			}

	

	// drink 댓글등록 처리용 
		  @RequestMapping(value = "insertDrinkComment.do", method = RequestMethod.POST)
		    public String insertDrinkComment(
		            @RequestParam("drinkId") int drinkId,
		            @RequestParam("content") String content,
		            HttpSession session, // *** HttpSession 객체를 파라미터로 받도록 추가 ***
		            RedirectAttributes redirectAttributes) { // 필요시 메시지 전달 등을 위해 추가

		        // *** 요청 파라미터에서 writer 제거했습니다. ***
		        // @RequestParam("writer") String writer

		        logger.info("음료 댓글 작성 요청: drinkId={}, content={}", drinkId, content); // writer는 아래에서 가져옴

		        // *** 세션에서 로그인 사용자 정보 가져오기 ***
		        // "loginUser"는 세션에 로그인 사용자 정보가 저장된 키 이름입니다. 실제 키 이름과 타입에 맞게 수정하세요.
		        Object loginUserObj = session.getAttribute("loginUser");

		        String writerId = null; // 작성자 ID를 저장할 변수

		        if (loginUserObj != null) {
		            // 로그인된 사용자 정보가 세션에 있을 경우
		            // LoginUser 객체에서 사용자 ID를 가져옵니다. 실제 필드명과 클래스에 맞게 수정하세요.
		             try {
		                 // 예시: LoginUser 타입으로 캐스팅하고 getLoginId() 메소드 호출
		                 Users loginUser = (Users) loginUserObj; // *** 실제 LoginUser 클래스 타입으로 캐스팅하세요 ***
		                 writerId = loginUser.getLoginId(); // *** 실제 사용자 ID 필드의 Getter 메소드 호출하세요 ***
		                 logger.info("로그인된 사용자 ID 확인: {}", writerId);

		             } catch (ClassCastException e) {
		                 logger.error("세션의 loginUser 객체 타입 캐스팅 오류 (음료 댓글)", e);
		                 redirectAttributes.addFlashAttribute("message", "로그인 사용자 정보를 가져오는 중 오류가 발생했습니다.");
		                 return "redirect:/loginPage.do"; // 적절한 에러 처리 페이지 또는 로그인 페이지로 리다이렉트
		             }

		        } else {
		            // *** 로그인되지 않은 사용자의 댓글 작성 시도 처리 ***
		            logger.warn("로그인되지 않은 사용자가 음료 댓글 작성을 시도했습니다. drinkId={}", drinkId);
		            redirectAttributes.addFlashAttribute("message", "댓글 작성은 로그인 후 이용 가능합니다.");
		            return "redirect:/loginPage.do"; // 적절한 로그인 페이지 경로로 수정
		        }

		        // *** writerId가 null이 아닐 경우에만 댓글 객체 생성 및 서비스 호출 ***
		        if (writerId != null) {
		            Comment comment = new Comment(); // Comment 클래스 사용
		            comment.setTargetId(drinkId);
		            comment.setTargetType("drink"); // 대상 타입을 "drink"으로 설정
		            comment.setContent(content);
		            comment.setLoginId(writerId); // *** 로그인된 사용자 ID를 작성자로 설정 ***

		            // 댓글 서비스 호출
		            int result = commentService.insertComment(comment); // 서비스 메소드 호출 결과(성공/실패)를 받을 수 있다면 좋습니다.

		             if (result > 0) { // 서비스 호출 성공 시 (예: 1 반환 시)
		                 logger.info("음료 댓글 작성 성공: drinkId={}, writer={}", drinkId, writerId);
		                 redirectAttributes.addFlashAttribute("successMessage", "댓글이 성공적으로 등록되었습니다."); // 성공 메시지 전달 (선택 사항)
		             } else { // 서비스 호출 실패 시
		                 logger.error("음료 댓글 작성 실패: drinkId={}, writer={}", drinkId, writerId);
		                 redirectAttributes.addFlashAttribute("errorMessage", "댓글 등록에 실패했습니다."); // 실패 메시지 전달 (선택 사항)
		             }

		        } else {
		             // loginUserObj가 null이 아니었음에도 writerId를 가져오지 못한 경우
		             logger.error("로그인 사용자 정보에서 ID를 가져올 수 없습니다. (음료 댓글)");
		             redirectAttributes.addFlashAttribute("errorMessage", "사용자 정보를 가져오는 중 오류가 발생했습니다.");
		             return "redirect:/common/error"; // 적절한 에러 페이지로 리다이렉트
		        }

		        // 댓글 작성 후 음료 상세 페이지로 리다이렉트
		        // 리다이렉트 시 page=1 파라미터는 필요시 유지하거나 삭제, 또는 조정하세요.
		        return "redirect:/drinkDetail.do?no=" + drinkId; // 댓글 등록 후 해당 음료 상세 페이지로 이동 (page 파라미터는 필요시 추가)
		    }
		
		
		// drknk상세 페이지 댓글 삭제용
		@RequestMapping(value = "/deleteDrinkComment.do", method = RequestMethod.POST)
		public String deleteDrinkComment(@RequestParam("commentId") int commentId,
		                            @RequestParam("drinkId") int drinkId,
		                            @RequestParam("targetType") String targetType,
		                            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
		                            RedirectAttributes redirectAttributes) {

			
			
		    boolean isDeleted = commentService.deleteComment(commentId, targetType);
		   
		    
		    if (isDeleted) {
		        redirectAttributes.addFlashAttribute("message", "댓글이 삭제되었습니다.");
		    } else {
		        redirectAttributes.addFlashAttribute("message", "댓글 삭제에 실패했습니다.");
		    }

		    return "redirect:/drinkDetail.do?no=" + drinkId + "&page=" + page;
		}

		@RequestMapping(value = "insertRestaurantComment.do", method = RequestMethod.POST)
		public String insertRestaurantComment(
		        @RequestParam("recommendId") int recommendId, // ★ 파라미터 이름을 "targetId"로 수정합니다.
		        @RequestParam("content") String content,
		        @RequestParam("targetType") String targetType, // 폼에서 targetType을 받도록 추가했으므로 함께 받습니다.
		        @RequestParam("page") int page, // 댓글 현재 페이지를 받습니다.
		        @RequestParam("redirectUrl") String redirectUrl, // 리다이렉트 URL을 받습니다.
		        HttpSession session,
		        RedirectAttributes redirectAttributes) {
	        // *** 요청 파라미터에서 writer 제거했습니다. ***
	        // @RequestParam("writer") String writer

	        logger.info("음료 댓글 작성 요청: recommendId={}, content={}", recommendId, content); // writer는 아래에서 가져옴

	        // *** 세션에서 로그인 사용자 정보 가져오기 ***
	        // "loginUser"는 세션에 로그인 사용자 정보가 저장된 키 이름입니다. 실제 키 이름과 타입에 맞게 수정하세요.
	        Object loginUserObj = session.getAttribute("loginUser");

	        String writerId = null; // 작성자 ID를 저장할 변수

	        if (loginUserObj != null) {
	            // 로그인된 사용자 정보가 세션에 있을 경우
	            // LoginUser 객체에서 사용자 ID를 가져옵니다. 실제 필드명과 클래스에 맞게 수정하세요.
	             try {
	                 // 예시: LoginUser 타입으로 캐스팅하고 getLoginId() 메소드 호출
	                 Users loginUser = (Users) loginUserObj; // *** 실제 LoginUser 클래스 타입으로 캐스팅하세요 ***
	                 writerId = loginUser.getLoginId(); // *** 실제 사용자 ID 필드의 Getter 메소드 호출하세요 ***
	                 logger.info("로그인된 사용자 ID 확인: {}", writerId);

	             } catch (ClassCastException e) {
	                 logger.error("세션의 loginUser 객체 타입 캐스팅 오류 (음료 댓글)", e);
	                 redirectAttributes.addFlashAttribute("message", "로그인 사용자 정보를 가져오는 중 오류가 발생했습니다.");
	                 return "redirect:/loginPage.do"; // 적절한 에러 처리 페이지 또는 로그인 페이지로 리다이렉트
	             }

	        } else {
	            // *** 로그인되지 않은 사용자의 댓글 작성 시도 처리 ***
	            logger.warn("로그인되지 않은 사용자가 음료 댓글 작성을 시도했습니다. drinkId={}", recommendId);
	            redirectAttributes.addFlashAttribute("message", "댓글 작성은 로그인 후 이용 가능합니다.");
	            return "redirect:/loginPage.do"; // 적절한 로그인 페이지 경로로 수정
	        }

	        // *** writerId가 null이 아닐 경우에만 댓글 객체 생성 및 서비스 호출 ***
	        if (writerId != null) {
	            Comment comment = new Comment(); // Comment 클래스 사용
	            comment.setTargetId(recommendId);
	            comment.setTargetType("restaurant"); // 대상 타입을 "drink"으로 설정
	            comment.setContent(content);
	            comment.setLoginId(writerId); // *** 로그인된 사용자 ID를 작성자로 설정 ***

	            // 댓글 서비스 호출
	            int result = commentService.insertRestaurantComment(comment); // 서비스 메소드 호출 결과(성공/실패)를 받을 수 있다면 좋습니다.

	             if (result > 0) { // 서비스 호출 성공 시 (예: 1 반환 시)
	                 logger.info("음료 댓글 작성 성공: recommendId={}, writer={}", recommendId, writerId);
	                 redirectAttributes.addFlashAttribute("successMessage", "댓글이 성공적으로 등록되었습니다."); // 성공 메시지 전달 (선택 사항)
	             } else { // 서비스 호출 실패 시
	                 logger.error("음료 댓글 작성 실패: drinkId={}, writer={}", recommendId, writerId);
	                 redirectAttributes.addFlashAttribute("errorMessage", "댓글 등록에 실패했습니다."); // 실패 메시지 전달 (선택 사항)
	             }

	        } else {
	             // loginUserObj가 null이 아니었음에도 writerId를 가져오지 못한 경우
	             logger.error("로그인 사용자 정보에서 ID를 가져올 수 없습니다. (음료 댓글)");
	             redirectAttributes.addFlashAttribute("errorMessage", "사용자 정보를 가져오는 중 오류가 발생했습니다.");
	             return "redirect:/common/error"; // 적절한 에러 페이지로 리다이렉트
	        }

	        // 댓글 작성 후 음료 상세 페이지로 리다이렉트
	        // 리다이렉트 시 page=1 파라미터는 필요시 유지하거나 삭제, 또는 조정하세요.
	        return "redirect:/restaurantRecommendDetail.do?no=" + recommendId; // 댓글 등록 후 해당 음료 상세 페이지로 이동 (page 파라미터는 필요시 추가)
	    }
		
		@RequestMapping(value = "/deleteRestaurantComment.do", method = RequestMethod.POST)
		public String deleteRestaurantComment(@RequestParam("commentId") int commentId,
		                            @RequestParam("recommendId") int recommendId,
		                            @RequestParam("targetType") String targetType,
		                            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
		                            RedirectAttributes redirectAttributes) {

			
			
		    boolean isDeleted = commentService.deleteComment(commentId, targetType);
		   
		    
		    if (isDeleted) {
		        redirectAttributes.addFlashAttribute("message", "댓글이 삭제되었습니다.");
		    } else {
		        redirectAttributes.addFlashAttribute("message", "댓글 삭제에 실패했습니다.");
		    }

		    return "redirect:/restaurantRecommendDetail.do?no=" + recommendId + "&page=" + page;
		}
		
}
