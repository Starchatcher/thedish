package com.thedish.drink.service.impl;

import java.util.ArrayList;

import com.thedish.common.Paging;
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

}
