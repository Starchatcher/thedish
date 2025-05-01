package com.thedish.drinkrecommend.model.vo;

public class DrinkRecommend {

	   private String keyword;
	    private double minPrice;
	    private double maxPrice;
	    private double minAlcohol;
	    private double maxAlcohol;
		public DrinkRecommend() {
			super();
		}
		public String getKeyword() {
			return keyword;
		}
		public void setKeyword(String keyword) {
			this.keyword = keyword;
		}
		public double getMinPrice() {
			return minPrice;
		}
		public void setMinPrice(double minPrice) {
			this.minPrice = minPrice;
		}
		public double getMaxPrice() {
			return maxPrice;
		}
		public void setMaxPrice(double maxPrice) {
			this.maxPrice = maxPrice;
		}
		public double getMinAlcohol() {
			return minAlcohol;
		}
		public void setMinAlcohol(double minAlcohol) {
			this.minAlcohol = minAlcohol;
		}
		public double getMaxAlcohol() {
			return maxAlcohol;
		}
		public void setMaxAlcohol(double maxAlcohol) {
			this.maxAlcohol = maxAlcohol;
		}
}
