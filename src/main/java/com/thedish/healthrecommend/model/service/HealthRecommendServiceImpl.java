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
	    public int getConditionIdByName(String conditionName) {
	        return healthRecommendDao.getConditionIdByName(conditionName);
	    }

	    @Override
	    public List<String> getRecommendedIngredients(int conditionId) {
	        return healthRecommendDao.getRecommendedIngredients(conditionId);
	    }

	    @Override
	    public List<String> getExcludedIngredients(int conditionId) {
	        return healthRecommendDao.getExcludedIngredients(conditionId);
	    }

	    @Override
	    public List<Recipe> getFilteredRecipes(List<String> included, List<String> excluded) {
	        return healthRecommendDao.getSafeRecipes(included, excluded);
	    }

		@Override
		public List<String> autocompleteCondition(String keyword) {
			return healthRecommendDao.autocompleteCondition(keyword);
		}

		@Override
		public int countCondition(String keyword) {
			return healthRecommendDao.countCondition(keyword);
		}
	}