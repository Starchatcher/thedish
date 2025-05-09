package com.thedish.drink.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.thedish.common.Paging;
import com.thedish.common.Pairing;
import com.thedish.common.Search;
import com.thedish.common.ViewLog;
import com.thedish.drink.model.vo.Drink;
import com.thedish.drink.model.vo.DrinkStore;

public interface DrinkService {
	
	 int selectListCount();
	 ArrayList<Drink> selectListDrink(Paging paging);
	
	Drink selectDrink(int drinkId);
	void updateAddReadCount(int drinkId); 
	int selectSearchTitleCount(String keyword);
	ArrayList<Drink> selectSearchTitle(Search search);
	
	int insertDrink(Drink drink); 
	
	
	int updateDrink(Drink drink);
	int deleteDrink(int drinkId); 
 
	
	boolean incrementRecommendationCount(int drinkId);
	 
	 int getRecommendationCount(int drinkId);
	 List<Pairing> selectPairingsByDrinkId(int drinkId);
	 
	 int selectUserRating(String loginId, int drinkId);
	 void insertRating(String loginId, int drinkId, double ratingScore, String targetType);
	 void updateRating(String loginId, int drinkId, double ratingScore, String targetType);
	 void updateAverageRating(int drinkId, double avgRating);
	 double getAverageRating(int drinkId) ;
	 
	 Map<String, Object> selectStoreInfoByDrinkId(int drinkId);
	 
	 
	 Drink getDrinkById(int drinkId);
	
	 
	 int insertDrinkStore(DrinkStore drinkStore);
	 int deleteStore(int storeId);
	 
	 
void insertPostViewLog(ViewLog log);
	 
	 ViewLog getLatestPostViewLog(String userId, int postId);
	 
	 List<Pairing> selectPairings(int drinkId);
	 
	 int insertPairing(Pairing pairing); 
	 int deletePairing(int pairingId);
	List<DrinkStore> getStoresByDrinkName(String drinkName); 
}
