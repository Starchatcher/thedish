package com.thedish.restaurantrecommend.model.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;
import com.thedish.restaurantrecommend.controller.RestaurantRecommendController;
import com.thedish.restaurantrecommend.dao.RestaurantRecommendDao;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;

@Service("restaurantRecommendService")
public class RestaurantRecommendServiceImpl implements  RestaurantRecommendService {

	private static final Logger logger = LoggerFactory.getLogger(RestaurantRecommendServiceImpl.class);
	
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

	@Override
	public RestaurantRecommend selectRestaurantRecommend(int recommendId) {
		return restaurantRecommendDao.selectRestaurantRecommend(recommendId);
	}

	@Override
	public int updateAddReadCount(int recommendId) {
		return restaurantRecommendDao.updateAddReadCount(recommendId);
		
	}

	@Override
	public int insertRecommendationLike(int recommendId, String loginId) {
		return restaurantRecommendDao.insertRecommendationLike(recommendId, loginId);
	}

	@Override
	public int updateAddLikeCount(int recommendId) {
		
		 logger.info("Service.updateAddLikeCount 호출: recommendId={}", recommendId); // ★ 로그 추가 ★
		    return restaurantRecommendDao.updateAddLikeCount(recommendId);
	}

	@Override
	public int deleteRecommendationLike(int recommendId, String loginId) {		
		return restaurantRecommendDao.deleteRecommendationLike(recommendId, loginId);
	}

	@Override
	public int updateSubtractLikeCount(int recommendId) {
		return restaurantRecommendDao.updateSubtractLikeCount(recommendId);
	}

	@Override
	public boolean isLikedByUser(int recommendId, String loginId) {
	
		 if (loginId == null || recommendId == 0) {
	            return false;
	        }
	        return restaurantRecommendDao.checkRecommendationLikedByUser(recommendId, loginId) > 0;
	}

	@Override
	public int getLikeCount(int recommendId) {
		 RestaurantRecommend recommend = restaurantRecommendDao.selectRestaurantRecommend(recommendId);
         return (recommend != null) ? recommend.getLikeCount() : 0;
	}

	@Override
	public int insertRestaurantRecommend(RestaurantRecommend recommend) {
		return restaurantRecommendDao.insertRestaurantRecommend(recommend);
	}

	@Override
	public int deleteRestotantRecommend(int recommendId) {
		
		return restaurantRecommendDao.deleteRestotantRecommend(recommendId);
	}

	@Override
	public int updateRestaurantRecommend(RestaurantRecommend recommend) {
		
		return restaurantRecommendDao.updateRestaurantRecommend(recommend) ;
	}

	@Override
	public int selectSearchCount(String keyword) {
		return restaurantRecommendDao.selectSearchCount(keyword);
	}

	@Override
	public ArrayList<RestaurantRecommend> selectSearchList(Search search) {
		return restaurantRecommendDao.selectSearchList(search);
	}

	
	
	
	

}
