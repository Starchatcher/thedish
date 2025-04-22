package com.thedish.recipe.service.impl;

import java.util.ArrayList;

import com.thedish.common.Paging;
import com.thedish.recipe.model.vo.Recipe;

public interface RecipeService {
	
	
	int selectListCount();
	ArrayList<Recipe> selectListRecipe(Paging Paging);
}
