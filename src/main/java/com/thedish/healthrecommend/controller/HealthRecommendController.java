package com.thedish.healthrecommend.controller;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
        List<String> ingredients = healthRecommendService.getRecommendedIngredients(conditionId); // 금기제외된 추천만
        List<String> excluded = healthRecommendService.getExcludedIngredients(conditionId);       // 금기 목록 표시

        ModelAndView mv = new ModelAndView("healthrecommend/selectIngredients");
        mv.addObject("condition", conditionName);
        mv.addObject("ingredients", ingredients);
        mv.addObject("excluded", excluded);
        
        System.out.println("추천 재료 수: " + ingredients.size());
        ingredients.forEach(i -> System.out.println("재료: " + i));
        
        return mv;
    }

    @RequestMapping("recommendRecipes.do")
    public ModelAndView recommendRecipes(
        @RequestParam("condition") String conditionName,
        @RequestParam(value = "excludedIngredients", required = false) List<String> userExcluded) {

        int conditionId = healthRecommendService.getConditionIdByName(conditionName);
        List<String> included = healthRecommendService.getRecommendedIngredients(conditionId); // 이미 금기 제거됨
        List<String> excluded = healthRecommendService.getExcludedIngredients(conditionId);

        if (userExcluded != null) excluded.addAll(userExcluded);

        List<Recipe> recipes = healthRecommendService.getFilteredRecipes(included, excluded);

        ModelAndView mv = new ModelAndView("healthrecommend/recipeList");
        mv.addObject("recipes", recipes);
        return mv;
    }
}