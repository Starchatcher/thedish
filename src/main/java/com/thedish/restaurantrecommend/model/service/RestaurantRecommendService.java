package com.thedish.restaurantrecommend.model.service;

import java.util.List;

import com.thedish.common.Paging;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;

public interface RestaurantRecommendService {

	
	int selectRecommendationCount();
	List<RestaurantRecommend> selectRecommendationList(Paging paging);
}
