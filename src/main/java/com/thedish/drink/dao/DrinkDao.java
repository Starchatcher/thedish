package com.thedish.drink.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;
import com.thedish.recipe.model.vo.Recipe;

@Repository("drinkDao")
public class DrinkDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("drinkMapper.selectListCount");
	}
	
	
	
	public ArrayList<Drink> selectListDrink(Paging paging) {
		List<Drink> list = sqlSessionTemplate.selectList("drinkMapper.selectListDrink");
		return(ArrayList<Drink>) list;
	}
	
	public Drink selectDrink(int drinkId) {
		return sqlSessionTemplate.selectOne("drinkMapper.selectDrink", drinkId);
	}
	
	public void updateAddReadCount(int drinkId) {
		sqlSessionTemplate.update("drinkMapper.updateAddReadCount", drinkId);
	}

	
	
	public int selectSearchTitleCount(String keyword) {
		return sqlSessionTemplate.selectOne("drinkMapper.selectSearchTitleCount", keyword);
	}
	
	public ArrayList<Drink> selectSearchTitle(Search search){
		List<Drink> list = sqlSessionTemplate.selectList("drinkMapper.selectSearchTitle", search);
		return (ArrayList<Drink>)list;
	}
	
	
	public int insertDrink(Drink drink) {
		return sqlSessionTemplate.insert("drinkMapper.insertDrink", drink);
	}
	
	public int updateDrink(Drink drink) {
		return sqlSessionTemplate.update("drinkMapper.updateDrink", drink);
	}
	public int deleteDrink(int drinkId) {
	    return sqlSessionTemplate.delete("drinkMapper.deleteDrink", drinkId);
	}
	
}
