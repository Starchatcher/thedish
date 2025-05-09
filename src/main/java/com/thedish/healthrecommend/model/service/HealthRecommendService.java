package com.thedish.healthrecommend.model.service;

import java.util.List;
import java.util.Map;

import com.thedish.recipe.model.vo.Recipe;

public interface HealthRecommendService {

	int getConditionIdByName(String conditionName);
    List<String> getRecommendedIngredients(int conditionId);
    List<String> getExcludedIngredients(int conditionId);
    List<Recipe> getFilteredRecipes(List<String> included, List<String> excluded);
	List<String> autocompleteCondition(String keyword);
	int countCondition(String keyword);
	int getFilteredRecipeCount(List<String> included, List<String> excluded);
	List<Recipe> getFilteredRecipesPaging(Map<String, Object> param);

}