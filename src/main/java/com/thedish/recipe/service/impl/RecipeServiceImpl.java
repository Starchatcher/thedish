package com.thedish.recipe.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.recipe.dao.RecipeDao;
import com.thedish.recipe.model.vo.Recipe;
@Service("recipeService")
public class RecipeServiceImpl implements RecipeService{

	@Autowired
	private RecipeDao recipeDao;
	

	@Override
	public int selectListCount() {		
		return recipeDao.selectListCount();
	}


	@Override
	public ArrayList<Recipe> selectListRecipe(Paging Paging) {
		
		return recipeDao.selectListRecipe(Paging);
	}

}
