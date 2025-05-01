package com.thedish.drinkrecommend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.thedish.drink.model.vo.Drink;
import com.thedish.drinkrecommend.model.service.DrinkRecommendService;
import com.thedish.drinkrecommend.model.vo.DrinkRecommend;
@Controller
public class DrinkRecommendController {

	
	@Autowired
	private DrinkRecommendService drinkRecommendService;
	
	
	  //  검색 폼
    @RequestMapping("drinkSearchForm.do")
    public String showSearchForm() {
        return "drinkrecommend/drinkSearchForm";
    }
    
    @RequestMapping(value = "drinkSearchRecommend.do", method = RequestMethod.GET)
    public String searchDrinks(@RequestParam("keyword") String keyword,
                                @RequestParam("minPrice") double minPrice,
                                @RequestParam("maxPrice") double maxPrice,
                                @RequestParam("minAlcohol") double minAlcohol,
                                @RequestParam("maxAlcohol") double maxAlcohol,
                                Model model) {
        // DrinkRecommend 객체 생성 및 값 설정
        DrinkRecommend recommend = new DrinkRecommend();
        recommend.setKeyword(keyword);
        recommend.setMinPrice(minPrice);
        recommend.setMaxPrice(maxPrice);
        recommend.setMinAlcohol(minAlcohol);
        recommend.setMaxAlcohol(maxAlcohol);

        // 음료 추천 검색
        List<Drink> drinks = drinkRecommendService.searchDrinkRecommend(recommend);
        model.addAttribute("drinks", drinks);
        return "drinkrecommend/drinkSearchResults"; // 결과를 출력할 JSP 페이지
    }

}
