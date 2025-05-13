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

	@Override
	public RestaurantRecommend selectRestaurantRecommend(int recommendId) {
		return restaurantRecommendDao.selectRestaurantRecommend(recommendId);
	}

	@Override
	public void updateAddReadCount(int recommendId) {
		restaurantRecommendDao.updateAddReadCount(recommendId);
		
	}

	@Override
	public int insertRecommendationLike(int recommendId, String loginId) {
		return restaurantRecommendDao.insertRecommendationLike(recommendId, loginId);
	}

	@Override
	public int updateAddLikeCount(int recommendId) {
		
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

	
	
	
	

}
