package com.thedish.drinkrecommend.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.drink.model.vo.Drink;
import com.thedish.drinkrecommend.model.dao.DrinkRecommendDao;
import com.thedish.drinkrecommend.model.vo.DrinkRecommend;

@Service("drinkRecommendService")
public class DrinkRecommendServiceImpl implements DrinkRecommendService{

	
	@Autowired
	private DrinkRecommendDao drinkRecommendDao;

	@Override
	public List<Drink> searchDrinkRecommend(DrinkRecommend recommend) {
		return drinkRecommendDao.searchDrinkRecommend(recommend);
	}

	

	
	
}
