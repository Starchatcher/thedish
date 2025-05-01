package com.thedish.healthrecommend.model.service;

import java.util.List;

import com.thedish.recipe.model.vo.Recipe;

public interface HealthRecommendService {

	List<String> getRecommendedIngredients(String conditionName);
    List<Recipe> getRecipesByConditionExcludingIngredients(String conditionName, List<String> excluded);
	List<String> autocompleteCondition(String keyword);
	boolean doesConditionExist(String keyword);
}