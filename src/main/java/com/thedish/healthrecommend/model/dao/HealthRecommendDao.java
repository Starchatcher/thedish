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

    // 1. 질병명으로 conditionId 조회
    public int getConditionIdByName(String conditionName) {
        return sqlSessionTemplate.selectOne("healthMapper.selectConditionIdByName", conditionName);
    }

    // 2. 추천 재료 조회 (금기 제외됨)
    public List<String> getRecommendedIngredients(int conditionId) {
        return sqlSessionTemplate.selectList("healthMapper.selectRecommendedIngredients", conditionId);
    }

    // 3. 금기 재료 조회
    public List<String> getExcludedIngredients(int conditionId) {
        return sqlSessionTemplate.selectList("healthMapper.selectExcludedIngredients", conditionId);
    }

    // 4. 전체 안전한 레시피 조회 (비페이징용)
    public List<Recipe> getSafeRecipes(List<String> included, List<String> excluded) {
        Map<String, Object> param = new HashMap<>();
        param.put("includedIngredients", included);
        param.put("excludedIngredients", excluded);
        return sqlSessionTemplate.selectList("healthMapper.selectSafeRecipes", param);
    }

    // 5. 페이징: 총 레시피 수
    public int getFilteredRecipeCount(List<String> included, List<String> excluded) {
        Map<String, Object> param = new HashMap<>();
        param.put("includedIngredients", included);
        param.put("excludedIngredients", excluded);
        return sqlSessionTemplate.selectOne("healthMapper.selectFilteredRecipeCount", param);
    }

    // 6. 페이징: 현재 페이지의 레시피 목록
    public List<Recipe> getFilteredRecipesPaging(Map<String, Object> param) {
        return sqlSessionTemplate.selectList("healthMapper.selectFilteredRecipesPaging", param);
    }

    // 7. 자동완성
    public List<String> autocompleteCondition(String keyword) {
        return sqlSessionTemplate.selectList("healthMapper.autocompleteCondition", keyword);
    }

    // 8. 질병 존재 여부 체크
    public int countCondition(String keyword) {
        return sqlSessionTemplate.selectOne("healthMapper.countConditionByName", keyword);
    }
    
}
