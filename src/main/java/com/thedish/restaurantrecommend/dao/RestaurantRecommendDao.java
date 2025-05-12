package com.thedish.restaurantrecommend.dao;

import java.util.List;

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
	
}
