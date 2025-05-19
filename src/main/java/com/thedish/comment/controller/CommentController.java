package com.thedish.comment.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		            HttpSession session,
		            Model model, // 🎉 Model 객체를 파라미터로 받도록 추가 (오류 메시지를 담기 위해 사용)
		            RedirectAttributes redirectAttributes) { // 성공 시 리다이렉트 메시지 전달 위해 유지

		        logger.info("댓글 작성 요청: recipeId={}, content={}", recipeId, content);

		        // 세션에서 로그인 사용자 정보 가져오기
		        Object loginUserObj = session.getAttribute("loginUser");
		        String writerId = null; // 작성자 ID를 저장할 변수

		        // 1. 로그인 상태 확인 및 사용자 ID 가져오기
		        if (loginUserObj != null) {
		             try {
		                 // LoginUser 타입으로 캐스팅하고 실제 사용자 ID를 가져오는 메소드 호출
		                 // *** 실제 LoginUser 클래스 타입으로 캐스팅하고 Getter 메소드 호출하세요 ***
		                 Users loginUser = (Users) loginUserObj;
		                 writerId = loginUser.getLoginId(); // 예: getLoginId()
		                 logger.info("로그인된 사용자 ID 확인: {}", writerId);

		             } catch (ClassCastException e) {
		                 logger.error("세션의 loginUser 객체 타입 캐스팅 오류", e);
		                 model.addAttribute("msg", "사용자 정보를 가져오는 중 시스템 오류가 발생했습니다. 다시 로그인 해주세요."); // 🎉 Model에 메시지 담기
		                 // 캐스팅 오류 발생 시 알림창 띄우고 로그인 페이지로 이동 (alertMessage.jsp에서 이동 처리)
		                 // alertMessage.jsp 에서 이동할 페이지를 로그인 페이지로 설정해야 함
		                 return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		             }

		        } else {
		            // 로그인되지 않은 사용자의 댓글 작성 시도
		            logger.warn("로그인되지 않은 사용자가 댓글 작성을 시도했습니다. recipeId={}", recipeId);
		            model.addAttribute("msg", "댓글 작성은 로그인 후 이용 가능합니다."); // 🎉 Model에 메시지 담기
		            // 알림창 띄우고 로그인 페이지로 이동 (alertMessage.jsp에서 이동 처리)
		            // alertMessage.jsp 에서 이동할 페이지를 로그인 페이지로 설정해야 함
		            return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		        }

		        // writerId가 정상적으로 확보된 경우에만 댓글 객체 생성 및 서비스 호출 진행
		        if (writerId != null) {
		            Comment comment = new Comment();
		            comment.setTargetId(recipeId);
		            comment.setTargetType("recipe"); // 대상 타입이 레시피인지 확인 (필요에 따라 달라질 수 있음)
		            comment.setContent(content);
		            comment.setLoginId(writerId); // 로그인된 사용자 ID를 작성자로 설정

		            int result = 0; // 서비스 호출 결과 저장 변수
		            try {
		                result = commentService.insertComment(comment); // 댓글 등록 서비스 호출
		            } catch (Exception e) {
		                 // 서비스 호출 중 예외 발생 시 (DB 오류 등)
		                 logger.error("댓글 서비스 insertComment 호출 중 오류 발생", e);
		                 model.addAttribute("msg", "댓글 등록 중 오류가 발생했습니다. 다시 시도해주세요."); // 🎉 Model에 메시지 담기
		                 // 예외 발생 시 알림창 띄우고 레시피 상세 페이지로 이동 (alertMessage.jsp에서 이동 처리)
		                 // alertMessage.jsp 에서 이동할 페이지를 레시피 상세 페이지로 설정해야 함
		                 // 이때 recipeId 정보가 필요하므로 alertMessage.jsp에서 이동 시 recipeId를 어떻게 넘길지 고려 필요 (예: 세션, hidden 필드 등)
		                 // 간단하게는 alertMessage.jsp에서 history.back()으로 이전 페이지(레시피 상세)로 돌아가게 할 수 있습니다.
		                 return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		            }

		             // 서비스 호출 결과 처리
		             if (result > 0) { // 서비스 호출 성공 시 (예: 1 반환 시)
		                 logger.info("댓글 작성 성공: recipeId={}, writer={}", recipeId, writerId);
		                 // 성공 시에는 알림창 대신 RedirectAttributes를 사용하여 레시피 상세 페이지에서 성공 메시지 표시 (PRG 패턴)
		                 redirectAttributes.addFlashAttribute("successMessage", "댓글이 성공적으로 등록되었습니다.");
		                 // 성공 시에는 레시피 상세 페이지로 리다이렉트
		                 return "redirect:/recipeDetail.do?no=" + recipeId;
		             } else { // 서비스 호출 실패 시 (영향 받은 행이 없는 경우 등)
		                 logger.error("댓글 작성 실패 (서비스 처리 문제): recipeId={}, writer={}", recipeId, writerId);
		                 model.addAttribute("msg", "댓글 등록에 실패했습니다. 잠시 후 다시 시도해주세요."); // 🎉 Model에 메시지 담기
		                 // 실패 시 알림창 띄우고 레시피 상세 페이지로 이동 (alertMessage.jsp에서 이동 처리)
		                 // alertMessage.jsp 에서 이동할 페이지를 레시피 상세 페이지로 설정해야 함
		                 return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		             }

		        } else {
		             // loginUserObj는 null이 아니었으나 writerId를 가져오지 못한 경우 (매우 드물지만 안전하게 처리)
		             logger.error("로그인 사용자 정보에서 ID를 가져올 수 없습니다. loginUserObj: {}", loginUserObj);
		             model.addAttribute("msg", "사용자 정보를 가져오는 중 오류가 발생했습니다."); // 🎉 Model에 메시지 담기
		             // 알림창 띄우고 레시피 상세 페이지로 이동 (alertMessage.jsp에서 이동 처리)
		             // alertMessage.jsp 에서 이동할 페이지를 레시피 상세 페이지로 설정해야 함
		             return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		        }
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
		            HttpSession session,
		            Model model, // 🎉 Model 객체를 파라미터로 받도록 추가
		            RedirectAttributes redirectAttributes) { // 성공 시 리다이렉트 메시지 전달 위해 유지

		        logger.info("음료 댓글 작성 요청: drinkId={}, content={}", drinkId, content);

		        // 세션에서 로그인 사용자 정보 가져오기
		        Object loginUserObj = session.getAttribute("loginUser");
		        String writerId = null; // 작성자 ID를 저장할 변수

		        // 1. 로그인 상태 확인 및 사용자 ID 가져오기
		        if (loginUserObj != null) {
		             try {
		                 // LoginUser 타입으로 캐스팅하고 실제 사용자 ID를 가져오는 메소드 호출
		                 // *** 실제 LoginUser 클래스 타입으로 캐스팅하고 Getter 메소드 호출하세요 ***
		                 Users loginUser = (Users) loginUserObj;
		                 writerId = loginUser.getLoginId(); // 예: getLoginId()
		                 logger.info("로그인된 사용자 ID 확인: {}", writerId);

		             } catch (ClassCastException e) {
		                 logger.error("세션의 loginUser 객체 타입 캐스팅 오류 (음료 댓글)", e);
		                 model.addAttribute("msg", "사용자 정보를 가져오는 중 시스템 오류가 발생했습니다. 다시 로그인 해주세요."); // 🎉 Model에 메시지 담기
		                 // nextUrl 담는 부분 제거
		                 return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		             }

		        } else {
		            // 로그인되지 않은 사용자의 댓글 작성 시도
		            logger.warn("로그인되지 않은 사용자가 음료 댓글 작성을 시도했습니다. drinkId={}", drinkId);
		            model.addAttribute("msg", "댓글 작성은 로그인 후 이용 가능합니다."); // 🎉 Model에 메시지 담기
		             // nextUrl 담는 부분 제거
		            return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		        }

		        // writerId가 정상적으로 확보된 경우에만 댓글 객체 생성 및 서비스 호출 진행
		        if (writerId != null) {
		            Comment comment = new Comment(); // Comment 클래스 사용
		            comment.setTargetId(drinkId);
		            comment.setTargetType("drink"); // 대상 타입을 "drink"으로 설정
		            comment.setContent(content);
		            comment.setLoginId(writerId); // 로그인된 사용자 ID를 작성자로 설정

		            int result = 0; // 서비스 호출 결과 저장 변수
		            try {
		                result = commentService.insertComment(comment); // 댓글 등록 서비스 호출
		            } catch (Exception e) {
		                 // 서비스 호출 중 예외 발생 시 (DB 오류 등)
		                 logger.error("댓글 서비스 insertComment 호출 중 오류 발생 (음료)", e);
		                 model.addAttribute("msg", "댓글 등록 중 오류가 발생했습니다. 다시 시도해주세요."); // 🎉 Model에 메시지 담기
		                 // nextUrl 담는 부분 제거
		                 return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		            }

		             // 서비스 호출 결과 처리
		             if (result > 0) { // 서비스 호출 성공 시 (RedirectAttributes 사용 유지)
		                 logger.info("음료 댓글 작성 성공: drinkId={}, writer={}", drinkId, writerId);
		                 // 성공 시에는 RedirectAttributes를 사용하여 레시피 상세 페이지에서 성공 메시지 표시 (PRG 패턴 유지)
		                 redirectAttributes.addFlashAttribute("successMessage", "댓글이 성공적으로 등록되었습니다.");
		                 // 성공 시에는 레시피 상세 페이지로 리다이렉트
		                 return "redirect:/drinkDetail.do?no=" + drinkId;
		             } else { // 서비스 호출 실패 시 (영향 받은 행이 없는 경우 등)
		                 logger.error("음료 댓글 작성 실패 (서비스 처리 문제): drinkId={}, writer={}", drinkId, writerId);
		                 model.addAttribute("msg", "댓글 등록에 실패했습니다. 잠시 후 다시 시도해주세요."); // 🎉 Model에 메시지 담기
		                 // nextUrl 담는 부분 제거
		                 return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		             }

		        } else {
		             // writerId를 가져오지 못한 경우
		             logger.error("로그인 사용자 정보에서 ID를 가져올 수 없습니다. (음료 댓글) loginUserObj: {}", loginUserObj);
		             model.addAttribute("msg", "사용자 정보를 가져오는 중 오류가 발생했습니다."); // 🎉 Model에 메시지 담기
		             // nextUrl 담는 부분 제거
		             return "common/alertMessage"; // 🎉 알림창 JSP 뷰 이름 반환
		        }
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

		 // 맛집 추천 댓글 등록 요청 처리용
		@RequestMapping(value = "insertRestaurantComment.do", method = RequestMethod.POST)
		public String insertRestaurantComment(
		        @RequestParam("recommendId") int recommendId, // 맛집 추천 ID
		        @RequestParam("content") String content,
		        @RequestParam("targetType") String targetType, // 댓글 대상 타입 (예: "restaurant")
		        // 클라이언트에서 이 파라미터에 '순수한 정수'만 담아 보내야 합니다.
		        // 예: page=1, page=2 등. "1?no=110,1"과 같은 값은 오류를 유발합니다.
		        @RequestParam("page") int page, // 댓글 목록 페이징용 현재 페이지 번호 (리다이렉트 시 활용)
		        // 클라이언트에서 이 파라미터에 '경로'만 담아 보내야 합니다.
		        // 예: redirectUrl=/restaurantRecommendDetail.do. 쿼리 스트링은 포함하지 마세요.
		        @RequestParam("redirectUrl") String redirectUrl, // 댓글 등록 후 리다이렉트할 URL (성공 시 사용)
		        HttpSession session,
		        Model model,
		        RedirectAttributes redirectAttributes) {

		    logger.info("맛집 추천 댓글 작성 요청: recommendId={}, content={}, targetType={}", recommendId, content, targetType);

		    // 세션에서 로그인 사용자 정보 가져오기
		    Object loginUserObj = session.getAttribute("loginUser");
		    String writerId = null; // 작성자 ID를 저장할 변수

		    // 1. 로그인 상태 확인 및 사용자 ID 가져오기
		    if (loginUserObj != null) {
		         try {
		             // LoginUser 타입으로 캐스팅하고 실제 사용자 ID를 가져오는 메소드 호출
		             // *** 실제 LoginUser 클래스 타입으로 캐스팅하고 Getter 메소드 호출하세요 ***
		             Users loginUser = (Users) loginUserObj;
		             writerId = loginUser.getLoginId(); // 예: getLoginId()
		             logger.info("로그인된 사용자 ID 확인: {}", writerId);

		         } catch (ClassCastException e) {
		             logger.error("세션의 loginUser 객체 타입 캐스팅 오류 (맛집 추천 댓글)", e);
		             model.addAttribute("msg", "사용자 정보를 가져오는 중 시스템 오류가 발생했습니다. 다시 로그인 해주세요.");
		             return "common/alertMessage";
		         }

		    } else {
		        // 로그인되지 않은 사용자의 댓글 작성 시도
		        logger.warn("로그인되지 않은 사용자가 맛집 추천 댓글 작성을 시도했습니다. recommendId={}", recommendId);
		        model.addAttribute("msg", "댓글 작성은 로그인 후 이용 가능합니다.");
		        return "common/alertMessage";
		    }

		    // writerId가 정상적으로 확보된 경우에만 댓글 객체 생성 및 서비스 호출 진행
		    if (writerId != null) {
		        Comment comment = new Comment(); // Comment 클래스 사용
		        comment.setTargetId(recommendId);
		        comment.setTargetType(targetType); // 대상 타입을 "restaurant" 등으로 설정 (파라미터로 받은 값 사용)
		        comment.setContent(content);
		        comment.setLoginId(writerId); // 로그인된 사용자 ID를 작성자로 설정

		        int result = 0; // 서비스 호출 결과 저장 변수
		        try {
		            result = commentService.insertRestaurantComment(comment); // 댓글 등록 서비스 호출 (서비스 메소드명 확인 필요)
		        } catch (Exception e) {
		             // 서비스 호출 중 예외 발생 시 (DB 오류 등)
		             logger.error("댓글 서비스 insertRestaurantComment 호출 중 오류 발생", e);
		             model.addAttribute("msg", "댓글 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
		             return "common/alertMessage";
		        }

		         // 서비스 호출 결과 처리
		         if (result > 0) { // 서비스 호출 성공 시 (예: 1 반환 시)
		             logger.info("맛집 추천 댓글 작성 성공: recommendId={}, writer={}", recommendId, writerId);
		             // 성공 시에는 RedirectAttributes를 사용하여 상세 페이지에서 메시지 표시 (PRG 패턴 유지)
		             redirectAttributes.addFlashAttribute("successMessage", "댓글이 성공적으로 등록되었습니다.");

		             // ** 중요: 클라이언트에서 넘겨받은 redirectUrl (경로만 있어야 함)에 no와 page 파라미터를 붙여서 리다이렉트 URL을 생성합니다. **
		             String finalRedirectUrl = redirectUrl + "?no=" + recommendId + "&page=" + page;
		             logger.debug("댓글 등록 후 리다이렉트 URL: {}", finalRedirectUrl); // 생성된 최종 URL 확인용 로그

		             return "redirect:" + finalRedirectUrl; // 성공 시 리다이렉트
		         } else { // 서비스 호출 실패 시 (영향 받은 행이 없는 경우 등)
		             logger.error("맛집 추천 댓글 작성 실패 (서비스 처리 문제): recommendId={}, writer={}", recommendId, writerId);
		             model.addAttribute("msg", "댓글 등록에 실패했습니다. 잠시 후 다시 시도해주세요.");
		             return "common/alertMessage";
		         }

		    } else {
		         // loginUserObj는 null이 아니었으나 writerId를 가져오지 못한 경우 (매우 드물지만 안전하게 처리)
		         logger.error("로그인 사용자 정보에서 ID를 가져올 수 없습니다. (맛집 추천 댓글) loginUserObj: {}", loginUserObj);
		         model.addAttribute("msg", "사용자 정보를 가져오는 중 오류가 발생했습니다.");
		         return "common/alertMessage";
		    }
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
