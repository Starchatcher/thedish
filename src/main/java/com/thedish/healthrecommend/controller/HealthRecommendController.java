package com.thedish.healthrecommend.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.common.Paging;
import com.thedish.healthrecommend.model.service.HealthRecommendService;
import com.thedish.recipe.model.vo.Recipe;

@Controller
public class HealthRecommendController {

	private static final Logger logger = LoggerFactory.getLogger(HealthRecommendController.class);
	
    @Autowired
    private HealthRecommendService healthRecommendService;

    // 질병 검색 폼
    @RequestMapping("healthSearchForm.do")
    public String showSearchForm() {
    	
        return "healthrecommend/healthSearchForm";
        
    }

    @RequestMapping("autocompleteCondition.do")
    @ResponseBody
    public List<String> autocomplete(@RequestParam("keyword") String keyword) {
        return healthRecommendService.autocompleteCondition(keyword);
    }

    @RequestMapping("checkConditionExists.do")
    @ResponseBody
    public boolean checkCondition(@RequestParam("keyword") String keyword) {
        return healthRecommendService.countCondition(keyword) > 0;
    }

    @RequestMapping("recommendIngredients.do")
    public ModelAndView recommendIngredients(@RequestParam("condition") String conditionName) {
        int conditionId = healthRecommendService.getConditionIdByName(conditionName);

        List<String> recommendedIngredients = healthRecommendService.getRecommendedIngredients(conditionId); // 금기제외된 추천만
        List<String> excludedIngredients = healthRecommendService.getExcludedIngredients(conditionId);       // 금기 목록

        ModelAndView mv = new ModelAndView("healthrecommend/selectIngredients");
        mv.addObject("condition", conditionName);
        mv.addObject("recommendedIngredients", recommendedIngredients);  // ✅ 이름 분리
        mv.addObject("excludedIngredients", excludedIngredients);

        logger.info("추천 재료 수: {}", recommendedIngredients.size());
        recommendedIngredients.forEach(i -> logger.info("추천 재료: {}", i));

        return mv;
    }

    @RequestMapping("recommendRecipes.do")
    public ModelAndView recommendRecipes(
        @RequestParam("condition") String conditionName,
        @RequestParam(value = "excludedIngredients", required = false) List<String> userExcluded,
        @RequestParam(value = "page", defaultValue = "1") int currentPage) {

        int conditionId = healthRecommendService.getConditionIdByName(conditionName);
        List<String> included = healthRecommendService.getRecommendedIngredients(conditionId);
        List<String> excluded = healthRecommendService.getExcludedIngredients(conditionId);

        if (userExcluded != null) excluded.addAll(userExcluded);

        // 1. 총 개수 조회
        int listCount = healthRecommendService.getFilteredRecipeCount(included, excluded);

        // 2. 페이징 계산
        Paging paging = new Paging(listCount, 6, currentPage, "recommendRecipes.do");
        paging.calculate();

        // 3. 파라미터 구성
        Map<String, Object> map = new HashMap<>();
        map.put("includedIngredients", included);
        map.put("excludedIngredients", excluded);
        map.put("startRow", paging.getStartRow());
        map.put("endRow", paging.getEndRow());

        List<Recipe> recipes = healthRecommendService.getFilteredRecipesPaging(map);

        ModelAndView mv = new ModelAndView("healthrecommend/recipeList");
        mv.addObject("recipes", recipes);
        mv.addObject("paging", paging);
        mv.addObject("condition", conditionName);
        return mv;
    }
    
   
}