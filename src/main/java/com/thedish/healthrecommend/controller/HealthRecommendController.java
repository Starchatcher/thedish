package com.thedish.healthrecommend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thedish.healthrecommend.model.service.HealthRecommendService;
import com.thedish.recipe.model.vo.Recipe;

@Controller
public class HealthRecommendController {

    @Autowired
    private HealthRecommendService healthRecommendService;

    // 질병 검색 폼
    @RequestMapping("healthSearchForm.do")
    public String showSearchForm() {
        return "healthrecommend/healthSearchForm";
    }

    // 질병 검색 결과로 재료 추천
    @RequestMapping("recommendIngredients.do")
    public String recommendIngredients(@RequestParam("condition") String conditionName, Model model) {
        List<String> ingredients = healthRecommendService.getRecommendedIngredients(conditionName);
        model.addAttribute("condition", conditionName);
        model.addAttribute("ingredients", ingredients);
        return "healthrecommend/selectIngredients"; // 체크박스로 싫은 재료 고르기
    }

    // 최종 재료로 레시피 추천
    @RequestMapping("recommendRecipes.do")
    public String recommendRecipes(
            @RequestParam("condition") String conditionName,
            @RequestParam(value = "excludedIngredients", required = false) List<String> excluded,
            Model model) {

        List<Recipe> recipes = healthRecommendService.getRecipesByConditionExcludingIngredients(conditionName, excluded);
        model.addAttribute("recipes", recipes);
        return "healthrecommend/recipeList";
    }
}