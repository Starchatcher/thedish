package com.thedish.drink.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.thedish.common.Paging;
import com.thedish.common.Pairing;
import com.thedish.common.Search;
import com.thedish.drink.dao.DrinkDao;
import com.thedish.drink.model.vo.Drink;
import com.thedish.drink.model.vo.DrinkStore;
import com.thedish.image.model.service.ImageService;

@Service("drinkService")
public class DrinkServiceImpl implements DrinkService{

	
	  private static final Logger logger = LoggerFactory.getLogger(DrinkServiceImpl.class);
	@Autowired
	private DrinkDao drinkDao;
	
	@Autowired
	private ImageService imageService; 
	
	

	@Override
	public Drink selectDrink(int drinkId) {
		
		return drinkDao.selectDrink(drinkId);
	}

	@Override
	public void updateAddReadCount(int drinkId) {		
		drinkDao.updateAddReadCount(drinkId);
	}

	@Override
	public int selectSearchTitleCount(String keyword) {
		return drinkDao.selectSearchTitleCount(keyword);
	}

	@Override
	public ArrayList<Drink> selectSearchTitle(Search search) {
		return drinkDao.selectSearchTitle(search);
	}

	@Override
	public int insertDrink(Drink drink) {
		return drinkDao.insertDrink(drink);
	}

	@Override
	public int updateDrink(Drink drink) {
		return drinkDao.updateDrink(drink);
	}

	@Override
	public int deleteDrink(int drinkId) {
		return drinkDao.deleteDrink(drinkId);
	}

	@Override
	public boolean incrementRecommendationCount(int drinkId) {
		return drinkDao.incrementRecommendationCount(drinkId);
	}

	@Override
	public int getRecommendationCount(int drinkId) {
		return drinkDao.getRecommendationCount(drinkId)
				;
	}

	@Override
	public List<Pairing> selectPairingsByDrinkId(int drinkId) {
		return drinkDao.selectPairingsByDrinkId(drinkId);
	}

	@Override
	public int selectUserRating(String loginId, int drinkId) {
		return drinkDao.selectUserRating(loginId, drinkId);
	}

	@Override
	public void insertRating(String loginId, int drinkId, double ratingScore, String targetType) {
		drinkDao.insertRating(loginId, drinkId, ratingScore, targetType);
	}

	@Override
	public void updateRating(String loginId, int drinkId, double ratingScore, String targetType) {
		 // 디버깅 구문 삽입 (서비스 레벨)
	    System.out.println("--- Debug Info (Service - updateRating) ---");
	    System.out.println("loginId: " + loginId);
	    System.out.println("drinkId: " + drinkId);
	    System.out.println("ratingScore: " + ratingScore);
	    System.out.println("targetType: " + targetType);
	    System.out.println("-------------------------------------------");
		drinkDao.updateRating(loginId, drinkId, ratingScore, targetType);
	}

	@Override
	public void updateAverageRating(int drinkId, double avgRating) {
		drinkDao.updateAverageRating(drinkId, avgRating);
		
	}

	@Override
	public double getAverageRating(int drinkId) {
		return drinkDao.getAverageRating(drinkId);
	}

	@Override
	public int selectListCount() {
		return drinkDao.selectListCount();
	}

	@Override
	public ArrayList<Drink> selectListDrink(Paging paging) {
		return drinkDao.selectListDrink(paging);
	}

	@Override
	public Map<String, Object> selectStoreInfoByDrinkId(int drinkId) {
		
		return drinkDao.selectStoreInfoByDrinkId(drinkId);
	}

	@Override
	public Drink getDrinkById(int drinkId) {
		logger.info(">>> DrinkServiceImpl.getDrinkById: 파라미터 drinkId = " + drinkId);
		return drinkDao.getDrinkById(drinkId);
	}

	@Override
	public List<DrinkStore> getStoresByDrinkName(String drinkName) {
		return drinkDao.getStoresByDrinkName(drinkName);
	}

	@Override
	public int insertDrinkStore(DrinkStore drinkStore) {
		return drinkDao.insertDrinkStore(drinkStore);
	}

	@Override
	public int deleteStore(int storeId) {
		
		return drinkDao.deleteStore(storeId);
	}

	

	

	
	
	
	


	
}
