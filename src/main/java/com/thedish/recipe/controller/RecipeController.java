package com.thedish.recipe.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.common.Paging;
import com.thedish.recipe.model.vo.Recipe;
import com.thedish.recipe.service.impl.RecipeService;

@Controller
public class RecipeController {

	@Autowired
	private RecipeService recipeService;
	
	// 레시피 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 10개씩 출력 처리)
		@RequestMapping("recipeList.do")
		public ModelAndView noticeListMethod(ModelAndView mv, 
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
}
