package com.thedish.recipe.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.image.service.ImageService;
import com.thedish.recipe.dao.RecipeDao;
import com.thedish.recipe.model.vo.Recipe;
@Service("recipeService")
public class RecipeServiceImpl implements RecipeService{

	@Autowired
	private RecipeDao recipeDao;
	
	@Autowired
	private ImageService imageService; 

	@Override
	public int selectListCount() {		
		return recipeDao.selectListCount();
	}


	@Override
	public ArrayList<Recipe> selectListRecipe(Paging paging) {
		
		return recipeDao.selectListRecipe(paging);
	}
	@Override
	public Recipe selectRecipe(int recipeId) {		
		return recipeDao.selectRecipe(recipeId);
	}


	@Override
	public void updateAddReadCount(int recipeId) {
		recipeDao.updateAddReadCount(recipeId);
		
	}


	@Override
	public int selectSearchTitleCount(String keyword) {		
		return recipeDao.selectSearchTitleCount(keyword);
	}


	@Override
	public ArrayList<Recipe> selectSearchTitle(Search search) {		
		return recipeDao.selectSearchTitle(search);
	}


	@Override
	public int insertRecipe(Recipe recipe) {		
		return recipeDao.insertRecipe(recipe);
	}


	@Override
	public int updateRecipe(Recipe recipe) {		
		return recipeDao.updateRecipe(recipe);
	}


	@Override
	@Transactional
	public int deleteRecipe(int recipeId) {
		imageService.deleteImageByTargetIdAndType(recipeId, "recipe");

		return recipeDao.deleteRecipe(recipeId);
	}


	
	
	

}
