package com.thedish.healthrecommend.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.healthrecommend.model.dao.HealthRecommendDao;
import com.thedish.recipe.model.vo.Recipe;

@Service("HealthRecommendService")

public class HealthRecommendServiceImpl implements HealthRecommendService {

	@Autowired
	private HealthRecommendDao healthRecommendDao;
	
	@Override
	public List<String> getRecommendedIngredients(String conditionName) {
		return healthRecommendDao.selectRecommendedIngredients(conditionName);
	}

	@Override
	public List<Recipe> getRecipesByConditionExcludingIngredients(String conditionName, List<String> excluded) {
		 return healthRecommendDao.selectRecipesByCondition(conditionName, excluded);
	}
	@Override
	public List<String> autocompleteCondition(String keyword) {
	    return healthRecommendDao.autocompleteCondition(keyword);
	}
	
	@Override
	public boolean doesConditionExist(String keyword) {
	    return healthRecommendDao.countMatchingConditions(keyword) > 0;
	}
	
}