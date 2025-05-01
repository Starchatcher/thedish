package com.thedish.drinkrecommend.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.drink.model.vo.Drink;
import com.thedish.drinkrecommend.model.vo.DrinkRecommend;

@Repository("drinkRecommendDao")
public class DrinkRecommendDao {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public List<Drink> searchDrinkRecommend(DrinkRecommend recommend) {
        String searchKeyword = "%" + recommend.getKeyword() + "%";
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", searchKeyword);
        params.put("minPrice", recommend.getMinPrice());
        params.put("maxPrice", recommend.getMaxPrice());
        params.put("minAlcohol", recommend.getMinAlcohol());
        params.put("maxAlcohol", recommend.getMaxAlcohol());

        return sqlSessionTemplate.selectList("drinkMapper.searchDrinkRecommend", params);
    }

}
