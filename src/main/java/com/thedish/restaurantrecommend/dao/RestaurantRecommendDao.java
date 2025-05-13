package com.thedish.restaurantrecommend.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;

@Repository("restaurantRecommendDao")
public class RestaurantRecommendDao {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	 
	public int selectRecommendationCount() {
        return sqlSessionTemplate.selectOne("restaurantRecommendMapper.selectRecommendationCount"); // 전체 개수 조회 SQL 호출
    }
	
	 public List<RestaurantRecommend> selectRecommendationList(Paging paging) {
	        // Paging 객체를 파라미터로 넘겨서 페이징 쿼리 실행
	        return sqlSessionTemplate.selectList("restaurantRecommendMapper.selectRecommendationList", paging);
	    }
	 
	public RestaurantRecommend selectRestaurantRecommend(int recommendId) {
		return sqlSessionTemplate.selectOne("restaurantRecommendMapper.selectRestaurantRecommend",recommendId);
	}
	
	
	public void updateAddReadCount(int recommendId) {
		sqlSessionTemplate.update("restaurantRecommendMapper.updateAddReadCount", recommendId);
	}
	
	 public int insertRecommendationLike(int recommendId, String loginId) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("recommendId", recommendId);
	        params.put("loginId", loginId);
	        return sqlSessionTemplate.insert("restaurantRecommendMapper.insertRecommendationLike", params);
	    }
	 public int updateAddLikeCount(int recommendId) {
	        return sqlSessionTemplate.update("restaurantRecommendMapper.updateAddLikeCount", recommendId);
	    }
	 public int deleteRecommendationLike(int recommendId, String loginId) {
         Map<String, Object> params = new HashMap<>();
         params.put("recommendId", recommendId);
         params.put("loginId", loginId);
         return sqlSessionTemplate.delete("restaurantRecommendMapper.deleteRecommendationLike", params);
    }
	  public int updateSubtractLikeCount(int recommendId) {
	        return sqlSessionTemplate.update("restaurantRecommendMapper.updateSubtractLikeCount", recommendId);
	    }

	public int checkRecommendationLikedByUser(int recommendId, String loginId) {
		 Map<String, Object> params = new HashMap<>();
	        params.put("recommendId", recommendId);
	        params.put("loginId", loginId);
		return sqlSessionTemplate.selectOne("restaurantRecommendMapper.checkRecommendationLikedByUser",params);
	
	}
	 
	 
}
