package com.thedish.drinkrecommend.model.service;

import java.util.List;

import com.thedish.drink.model.vo.Drink;
import com.thedish.drinkrecommend.model.vo.DrinkRecommend;

public interface DrinkRecommendService {

	List<Drink> searchDrinkRecommend(DrinkRecommend recommend);
}
