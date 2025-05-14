package com.thedish.recipe.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Allergy;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.common.ViewLog;
import com.thedish.recipe.model.vo.Recipe;


@Repository("recipeDao")
public class RecipeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("recipeMapper.selectListCount");
	}
	
	
	
	public ArrayList<Recipe> selectListRecipe(Paging paging) {
		List<Recipe> list = sqlSessionTemplate.selectList("recipeMapper.selectListRecipe",paging);
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
	public int updateRecipe(Recipe recipe) {
		return sqlSessionTemplate.update("recipeMapper.updateRecipe", recipe);
	}
	public int deleteRecipe(int recipeId) {
	    return sqlSessionTemplate.delete("recipeMapper.deleteRecipe", recipeId);
	}
	
    // 레시피에 포함된 알러지 정보 조회
    public List<Allergy> selectAllergyByRecipeId(int recipeId) {    	
        return sqlSessionTemplate.selectList("recipeMapper.selectAllergyByRecipeId", recipeId);       

    }

    public boolean incrementRecommendationCount(int recipeId) {
        int rowsAffected = sqlSessionTemplate.update("recipeMapper.incrementRecommendationCount", recipeId);
        return rowsAffected > 0; // 업데이트 성공 여부 반환
    }

    public int getRecommendationCount(int recipeId) {
    	return sqlSessionTemplate.selectOne("recipeMapper.getRecommendationCount", recipeId);
    }
    // 특정 사용자가 특정 레시피에 대한 평점이 있는지 확인
    public int selectUserRating(String loginId, int recipeId) {
        Map<String, Object> params = new HashMap<>();
        params.put("loginId", loginId);
        params.put("recipeId", recipeId);
        return sqlSessionTemplate.selectOne("recipeMapper.selectUserRating", params);
    }

    // 평점 추가
    public void insertRating(String loginId, int recipeId, double ratingScore, String targetType) {
        Map<String, Object> params = new HashMap<>();
        params.put("loginId", loginId);
        params.put("recipeId", recipeId);
        params.put("ratingScore", ratingScore);
        params.put("targetType", targetType);
        sqlSessionTemplate.insert("recipeMapper.insertRating", params);
    }

    // 평점 수정
    public void updateRating(String loginId, int recipeId, double ratingScore, String targetType) {
        Map<String, Object> params = new HashMap<>();
        params.put("loginId", loginId);
        params.put("recipeId", recipeId);
        params.put("ratingScore", ratingScore);
        params.put("targetType", targetType);
        sqlSessionTemplate.update("recipeMapper.updateRating", params);
    }
    
    public void updateAverageRating(int recipeId, double avgRating) {
        Map<String, Object> params = new HashMap<>();
        params.put("recipeId", recipeId);
        params.put("avgRating", avgRating);
        sqlSessionTemplate.update("recipeMapper.updateAverageRating", params);
    }
    
    public double getAverageRating(int recipeId) {
        return sqlSessionTemplate.selectOne("recipeMapper.getAverageRating", recipeId);
    }
    
    
    public Recipe selectRandomRecipe() {
        
        return sqlSessionTemplate.selectOne("recipeMapper.selectRandomRecipe");
    }
    public void insertPostViewLog(ViewLog log) {

        sqlSessionTemplate.insert("recipeMapper.insertPostViewLog", log);
    }
    public ViewLog getLatestPostViewLog(String userId, int postId) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("postId", postId);

       
        return sqlSessionTemplate.selectOne("recipeMapper.getLatestPostViewLog", params);
    }
    	public List<Recipe> getAllRecipes(){
    		return sqlSessionTemplate.selectList("recipeMapper.selectAllRecipes");
    	}
    

}
