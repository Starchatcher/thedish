package com.thedish.drink.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thedish.comment.model.service.CommentService;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;
import com.thedish.drink.service.impl.DrinkService;
import com.thedish.image.service.ImageService;
import com.thedish.image.vo.Image;
import com.thedish.recipe.model.vo.Recipe;

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
			public ModelAndView recipeListMethod(ModelAndView mv, 
					@RequestParam(name = "page", required = false) String page,
					@RequestParam(name = "limit", required = false) String slimit) {
				// 페이징 처리
				int currentPage = 1;
				if (page != null) {
					currentPage = Integer.parseInt(page);
				}

				// 한 페이지에 출력할 목록 갯수 기본 10개로 지정함
				int limit = 10;
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

			    Drink drink = drinkService.selectDrink(drinkId);
			    drinkService.updateAddReadCount(drinkId);

			    if (drink != null) {
			        mv.addObject("drink", drink);

			        int commentsPerPage = 10;
			        String targetType = "drink";

			        // 댓글 총 개수 조회
			        int totalComments = commentService.selectCommentCount(drinkId, targetType);
			        logger.info("조회된 댓글 총 개수: " + totalComments);

			        int totalPages = (int) Math.ceil((double) totalComments / commentsPerPage);
			        if (totalPages == 0) totalPages = 1;

			        if (page < 1) page = 1;
			        if (page > totalPages) page = totalPages;

			        int offset = (page - 1) * commentsPerPage;

			        // 댓글 리스트 조회
			        List<Comment> comments = commentService.selectComments(drinkId, targetType, offset, commentsPerPage);
			        if (comments == null) {
			            logger.warn("commentService.selectComments()가 null을 반환했습니다.");
			            comments = new ArrayList<>();
			        }
			        logger.info("조회된 댓글 리스트 크기: " + comments.size());
			        for (Comment c : comments) {
			            logger.info("댓글 ID: " + c.getCommentId() + ", 내용: " + c.getContent());
			        }

			        mv.addObject("comments", comments);
			        mv.addObject("page", page);
			        mv.addObject("totalPages", totalPages);

			        mv.setViewName("drink/drinkDetail");
			    } else {
			        mv.addObject("message", drinkId + "번 레시피가 존재하지 않습니다.");
			        mv.setViewName("common/error");
			    }

			    return mv;
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
				int limit = 10;
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
			public String moveInsertRecipe() {
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
			
}
