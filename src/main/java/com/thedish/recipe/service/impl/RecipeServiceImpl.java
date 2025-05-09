package com.thedish.recipe.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.thedish.common.Allergy;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.common.ViewLog;
import com.thedish.image.model.service.ImageService;
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


	@Override
	public List<Allergy> selectAllergyByRecipeId(int recipeId) {
		
		return recipeDao.selectAllergyByRecipeId(recipeId);
	}


	@Override
	public boolean incrementRecommendationCount(int recipeId) {
		return recipeDao.incrementRecommendationCount(recipeId);
	}


	@Override
	public int getRecommendationCount(int recipeId) {
		return recipeDao.getRecommendationCount(recipeId);
	}


	@Override
	public int selectUserRating(String loginId, int recipeId) {
		return recipeDao.selectUserRating(loginId, recipeId);
	}


	@Override
	public void insertRating(String loginId, int recipeId, double ratingScore, String targetType) {
		recipeDao.insertRating(loginId, recipeId, ratingScore, targetType);
	}


	@Override
	public void updateRating(String loginId, int recipeId, double ratingScore, String targetType) {
		recipeDao.updateRating(loginId, recipeId, ratingScore, targetType);
	}


	@Override
	public void updateAverageRating(int recipeId, double avgRating) {
		recipeDao.updateAverageRating(recipeId, avgRating);
	}


	@Override
	public double getAverageRating(int recipeId) {
		
		return recipeDao.getAverageRating(recipeId);
	}


	@Override
	public Recipe selectRandomRecipe() {
		
		return recipeDao.selectRandomRecipe();
	}


	@Override
	public void insertPostViewLog(ViewLog log) {
		recipeDao.insertPostViewLog(log);
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public ViewLog getLatestPostViewLog(String userId, int postId) {
		return recipeDao.getLatestPostViewLog(userId, postId);
	}


	@Override
	public List<Recipe> getAllRecipes() {
		return recipeDao.getAllRecipes();
	}


	


	


	
	
	

}
