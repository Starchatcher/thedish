package com.thedish.drink.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.thedish.common.Paging;
import com.thedish.common.Pairing;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;

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
	 
}
