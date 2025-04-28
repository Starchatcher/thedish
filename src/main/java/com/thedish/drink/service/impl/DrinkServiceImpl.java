package com.thedish.drink.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.drink.dao.DrinkDao;
import com.thedish.drink.model.vo.Drink;
import com.thedish.image.service.ImageService;

@Service("drinkService")
public class DrinkServiceImpl implements DrinkService{

	@Autowired
	private DrinkDao drinkDao;
	
	@Autowired
	private ImageService imageService; 
	
	@Override
	public int selectListCount() {
		
		return drinkDao.selectListCount();
	}

	@Override
	public ArrayList<Drink> selectListDrink(Paging paging) {
		return drinkDao.selectListDrink(paging);
	}

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

}
