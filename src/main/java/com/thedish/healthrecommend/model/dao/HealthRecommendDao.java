package com.thedish.healthrecommend.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.recipe.model.vo.Recipe;

@Repository("healthRecommendDao")
public class HealthRecommendDao {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 1. 질병명으로 추천 재료 리스트 조회
	
    public ArrayList<String> selectRecommendedIngredients(String conditionName) {
        List<String> list = sqlSessionTemplate.selectList("healthMapper.selectRecommendedIngredients", conditionName);
        return (ArrayList<String>) list;
    }

    // 2. 제외 재료를 고려하여 레시피 추천
    public ArrayList<Recipe> selectRecipesByCondition(String conditionName, List<String> excluded) {
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("conditionName", conditionName);
        paramMap.put("excluded", excluded);

        List<Recipe> list = sqlSessionTemplate.selectList("healthMapper.selectRecipesByCondition", paramMap);
        return (ArrayList<Recipe>) list;
    }
}

