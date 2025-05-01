package com.thedish.drink.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.thedish.common.Paging;
import com.thedish.common.Pairing;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;
import com.thedish.drink.service.impl.DrinkService;
import com.thedish.image.model.service.ImageService;
import com.thedish.image.model.vo.Image;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class DrinkController {

	
	
	private static final Logger logger = LoggerFactory.getLogger(DrinkController.class);

	@Autowired
	private DrinkService drinkService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private CommentService commentService;
	
	
	
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
			            @RequestParam(value = "page", required = false, defaultValue = "1") int page) {

			        logger.info("drinkDetail.do 호출 - drinkId: " + drinkId);

			        try {
			            // 1. 술 상세 정보 조회 및 조회수 증가
			            Drink drink = drinkService.selectDrink(drinkId);
			            if (drink != null) {
			                 drinkService.updateAddReadCount(drinkId); // 조회수 증가 로직

			                 mv.addObject("drink", drink); // 술 상세 정보 모델에 추가

			                 // *** 2. 페어링 정보 조회 로직 추가 ***
			                 // PairingService를 통해 특정 drinkId에 해당하는 페어링 목록을 가져옵니다.
			                 
			                 List<Pairing> pairingList = drinkService.selectPairingsByDrinkId(drinkId);
			                 logger.info("조회된 페어링 목록 크기: " + (pairingList != null ? pairingList.size() : 0));

			                 // *** 페어링 목록을 ModelAndView 객체에 추가하여 JSP로 전달 ***
			                 mv.addObject("pairingList", pairingList);


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
			                 // 댓글 로깅은 필요에 따라 유지 또는 제거 (상세 정보 확인용으로 남겨둠)
			                 // for (Comment c : comments) {
			                 //     logger.info("댓글 ID: " + c.getCommentId() + ", 내용: " + c.getContent());
			                 // }

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

			// 레시피 검색 기능
			@RequestMapping("drinkSearch.do")
			public ModelAndView drinkSearchTitleMethod(
					ModelAndView mv, 
					@RequestParam("action") String action,
					@RequestParam("keyword") String keyword, 
					@RequestParam(name = "page", required = false) String page,
					@RequestParam(name = "limit", required = false) String slimit) {
				// 페이징 처리
				int currentPage = 1;
				if (page != null) {
					currentPage = Integer.parseInt(page);
				}

				// 한 페이지에 출력할 목록 갯수 기본 10개로 지정함
				int limit = 12;
				if (slimit != null) {
					limit = Integer.parseInt(slimit);
				}

				// 검색결과가 적용된 총 목록 갯수 조회해서, 총 페이지 수 계산함
				int listCount = drinkService.selectSearchTitleCount(keyword);
				// 페이지 관련 항목들 계산 처리
				Paging paging = new Paging(listCount, limit, currentPage, "drinkSearch.do");
				paging.calculate();

				// 마이바티스 매퍼에서 사용되는 메소드는 Object 1개만 전달할 수 있음
				// paging.startRow, paging.endRow, keyword 같이 전달해야 하므로 => 객체 하나를 만들어서 저장해서 보냄
				Search search = new Search();
				search.setKeyword(keyword);
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());

				// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
				ArrayList<Drink> list = drinkService.selectSearchTitle(search);
				

				if (list != null && list.size() > 0) { // 조회 성공시
					// ModelAndView : Model + View
					
					mv.addObject("list", list); // request.setAttribute("list", list) 와 같음
					mv.addObject("paging", paging);
					mv.addObject("action", action);
					mv.addObject("keyword", keyword);

					mv.setViewName("drink/drinkList");
				} else { // 조회 실패시
					mv.addObject("message", action + "에 대한 " + keyword + " 검색 결과가 존재하지 않습니다.");
					mv.setViewName("common/error");
				}

				return mv;
			}
			
			@RequestMapping("moveInsertDrink.do")
			public String moveInsertDrink() {
				return "drink/drinkInsert";
			}
			
			// 새 술 원글 등록 요청 처리용(이미지 업로드 기능 포함)	

			@RequestMapping(value = "drinkInsert.do", method = RequestMethod.POST)
			public String insertDrink(
			        Drink drink,
			        @RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
			        Model model) {

			    // 1. 레시피 저장 (자동 생성된 ID를 recipe.id에 세팅)
				drinkService.insertDrink(drink);

			    // 2. 이미지 파일이 있을 경우 이미지 저장
			    if (imageFile != null && !imageFile.isEmpty()) {
			        try {
			        	 byte[] imageBytes = imageFile.getBytes();

			            Image image = new Image();
			            image.setTargetId(drink.getDrinkId());
			            image.setTargetType("drink");
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
			    return "redirect:drinkList.do";
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
					return "common/error";
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
			            return "common/error";
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
			        return "common/error";
			    } catch (Exception e) {
			        e.printStackTrace();
			        model.addAttribute("message", "레시피 수정 중 오류가 발생했습니다.");
			        return "common/error";
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
			
			// 레시피 평점 기능
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
			 
			
}
