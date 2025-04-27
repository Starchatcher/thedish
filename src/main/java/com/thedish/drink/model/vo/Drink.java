package com.thedish.drink.model.vo;

public class Drink implements java.io.Serializable {
	

	private static final long serialVersionUID = -5377626004524391456L;
	private int drinkId;             // drink_id
	    private String name;              // name
	    private double alcoholContent;    // alcohol_content
	    private int price;            // price
	    private String pairingFood;       // pairing_food
	    private String description;       // description
	    private int recommendNumber;  // recommend_number
	    private double avgRating;         // avg_rating
	    private Integer viewCount;        // view_count
	    
	    
	    private String imageUrl;  // 이미지 URL
		 private int imageId;
		 public String getImageUrl() {
			return imageUrl;
		}
		public void setImageUrl(String imageUrl) {
			this.imageUrl = imageUrl;
		}
		public int getImageId() {
			return imageId;
		}
		public void setImageId(int imageId) {
			this.imageId = imageId;
		}
		public byte[] getImageData() {
			return imageData;
		}
		public void setImageData(byte[] imageData) {
			this.imageData = imageData;
		}
		private byte[] imageData; 
		 
		 
		public Drink() {
			super();
		}
		public int getDrinkId() {
			return drinkId;
		}
		public void setDrinkId(int drinkId) {
			this.drinkId = drinkId;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public double getAlcoholContent() {
			return alcoholContent;
		}
		public void setAlcoholContent(double alcoholContent) {
			this.alcoholContent = alcoholContent;
		}
		public int getPrice() {
			return price;
		}
		public void setPrice(int price) {
			this.price = price;
		}
		public String getPairingFood() {
			return pairingFood;
		}
		public void setPairingFood(String pairingFood) {
			this.pairingFood = pairingFood;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public int getRecommendNumber() {
			return recommendNumber;
		}
		public void setRecommendNumber(int recommendNumber) {
			this.recommendNumber = recommendNumber;
		}
		public double getAvgRating() {
			return avgRating;
		}
		public void setAvgRating(double avgRating) {
			this.avgRating = avgRating;
		}
		public Integer getViewCount() {
			return viewCount;
		}
		public void setViewCount(Integer viewCount) {
			this.viewCount = viewCount;
		}
		public static long getSerialversionuid() {
			return serialVersionUID;
		}
		@Override
		public String toString() {
			return "Drink [drinkId=" + drinkId + ", name=" + name + ", alcoholContent=" + alcoholContent + ", price="
					+ price + ", pairingFood=" + pairingFood + ", description=" + description + ", recommendNumber="
					+ recommendNumber + ", avgRating=" + avgRating + ", viewCount=" + viewCount + "]";
		}
	    
	    
}
