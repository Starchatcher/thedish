package com.thedish.recipe.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.recipe.model.vo.Recipe;


@Repository("recipeDao")
public class RecipeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("recipeMapper.selectListCount");
	}
	
	
	
	public ArrayList<Recipe> selectListRecipe(Paging paging) {
		List<Recipe> list = sqlSessionTemplate.selectList("recipeMapper.selectListRecipe");
		return(ArrayList<Recipe>) list;
	}
	
	
	public Recipe selectRecipe(int recipeId) {
		return sqlSessionTemplate.selectOne("recipeMapper.selectRecipe", recipeId);
	}
	
	public void updateAddReadCount(int recipeId) {
		sqlSessionTemplate.update("recipeMapper.updateAddReadCount", recipeId);
	}
	
	
	public int selectSearchTitleCount(String keyword) {
		return sqlSessionTemplate.selectOne("recipeMapper.selectSearchTitleCount", keyword);
	}
	
	public ArrayList<Recipe> selectSearchTitle(Search search){
		List<Recipe> list = sqlSessionTemplate.selectList("recipeMapper.selectSearchTitle", search);
		return (ArrayList<Recipe>)list;
	}
	
	public int insertRecipe(Recipe recipe) {
		return sqlSessionTemplate.insert("recipeMapper.insertRecipe", recipe);
	}
}
