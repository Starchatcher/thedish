package com.thedish.restaurantrecommend.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.restaurantrecommend.dao.RestaurantRecommendDao;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;

@Service("restaurantRecommendService")
public class RestaurantRecommendServiceImpl implements  RestaurantRecommendService {

	@Autowired
	private RestaurantRecommendDao restaurantRecommendDao;

	@Override
	public int selectRecommendationCount() {
		return restaurantRecommendDao.selectRecommendationCount();
	}

	@Override
	public List<RestaurantRecommend> selectRecommendationList(Paging paging) {
		return restaurantRecommendDao.selectRecommendationList(paging);
	}
	
	
	

}
