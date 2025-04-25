package com.thedish.recipe.service.impl;

import java.util.ArrayList;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.recipe.model.vo.Recipe;

public interface RecipeService {

	
	
	int selectListCount();

	ArrayList<Recipe> selectListRecipe(Paging paging);

	Recipe selectRecipe(int recipeId);

	void updateAddReadCount(int recipeId);

	int selectSearchTitleCount(String keyword);

	ArrayList<Recipe> selectSearchTitle(Search search);

	int insertRecipe(Recipe recipe);
	
	int updateRecipe(Recipe recipe);
	
	 int deleteRecipe(int recipeId);
	 
	 
}
