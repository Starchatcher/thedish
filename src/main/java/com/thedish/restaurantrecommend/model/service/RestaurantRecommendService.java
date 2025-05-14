package com.thedish.restaurantrecommend.model.service;

import java.util.ArrayList;
import java.util.List;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;

public interface RestaurantRecommendService {

	
	int selectRecommendationCount();
	List<RestaurantRecommend> selectRecommendationList(Paging paging);
	RestaurantRecommend selectRestaurantRecommend(int recommendId);
	int  updateAddReadCount(int recommendId);
	
	int insertRecommendationLike(int recommendId, String loginId);
	int updateAddLikeCount(int recommendId);
	int deleteRecommendationLike(int recommendId, String loginId);
	int updateSubtractLikeCount(int recommendId);
	
	 boolean isLikedByUser(int recommendId, String loginId);
	 int getLikeCount(int recommendId);
	 int insertRestaurantRecommend(RestaurantRecommend recommend);
	 
	 int updateRestaurantRecommend(RestaurantRecommend recommend);
	 int deleteRestotantRecommend(int recommendId);
	 
	 int selectSearchCount(String keyword);
	 ArrayList<RestaurantRecommend> selectSearchList(Search search);
}
