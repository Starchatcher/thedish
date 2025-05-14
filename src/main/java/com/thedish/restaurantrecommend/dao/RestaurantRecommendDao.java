package com.thedish.restaurantrecommend.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;

@Repository("restaurantRecommendDao")
public class RestaurantRecommendDao {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private static final Logger logger = LoggerFactory.getLogger(RestaurantRecommendDao.class);
	 
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
	
	
	public int updateAddReadCount(int recommendId) {
		   
		     return sqlSessionTemplate.update("restaurantRecommendMapper.updateAddReadCount",recommendId );
	}
	
	 public int insertRecommendationLike(int recommendId, String loginId) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("recommendId", recommendId);
	        params.put("loginId", loginId);
	        return sqlSessionTemplate.insert("restaurantRecommendMapper.insertRecommendationLike", params);
	    }
	 public int updateAddLikeCount(int recommendId) {
		 logger.info("Dao.updateAddLikeCount 호출: recommendId={}", recommendId); // ★ 로그 추가 ★
		    // sqlSessionTemplate 호출 전후 로그 추가
		    logger.info("sqlSessionTemplate.update 호출 전");
		    int result = sqlSessionTemplate.update("restaurantRecommendMapper.updateAddLikeCount", recommendId);
		    logger.info("sqlSessionTemplate.update 호출 후, 반환 값: {}", result); // ★ 이 로그 값 확인 ★
		    return result;
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
	 
	public int insertRestaurantRecommend(RestaurantRecommend recommend) {
		return sqlSessionTemplate.insert("restaurantRecommendMapper.insertRestaurantRecommend",recommend );
	}
	
	public int deleteRestotantRecommend(int recommendId) {
	    return sqlSessionTemplate.delete("restaurantRecommendMapper.deleteRestotantRecommend", recommendId);
	}
	public int updateRestaurantRecommend(RestaurantRecommend recommend) {
		return sqlSessionTemplate.update("restaurantRecommendMapper.updateRestaurantRecommend",recommend );
	}
	
	
	public int selectSearchCount(String keyword) {
		return sqlSessionTemplate.selectOne("restaurantRecommendMapper.selectSearchCount", keyword);
	}
	
	public ArrayList<RestaurantRecommend> selectSearchList(Search search){
		List<RestaurantRecommend> list = sqlSessionTemplate.selectList("restaurantRecommendMapper.selectSearchList", search);
		return (ArrayList<RestaurantRecommend>)list;
	}
}
