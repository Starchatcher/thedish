package com.thedish.healthrecommend.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.recipe.model.vo.Recipe;

@Repository("healthRecommendDao")
public class HealthRecommendDao {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 1. 질병명으로 추천 재료 리스트 조회
	

    public int getConditionIdByName(String conditionName) {
        return sqlSessionTemplate.selectOne("healthMapper.selectConditionIdByName", conditionName);
    }

    public List<String> getRecommendedIngredients(int conditionId) {
        List<String> result = sqlSessionTemplate.selectList("healthMapper.selectRecommendedIngredients", conditionId);
        return result;
    }

    public List<String> getExcludedIngredients(int conditionId) {
        return sqlSessionTemplate.selectList("healthMapper.selectExcludedIngredients", conditionId);
    }

    public List<Recipe> getSafeRecipes(List<String> included, List<String> excluded) {
        Map<String, Object> param = new HashMap<>();
        param.put("includedIngredients", included);
        param.put("excludedIngredients", excluded);
        return sqlSessionTemplate.selectList("healthMapper.selectSafeRecipes", param);
    }

	public List<String> autocompleteCondition(String keyword) {
		return sqlSessionTemplate.selectList("healthMapper.autocompleteCondition", keyword);
    }

	public int countCondition(String keyword) {
		return sqlSessionTemplate.selectOne("healthMapper.countConditionByName", keyword);
    }
}