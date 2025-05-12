package com.thedish.restaurantrecommend.model.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Arrays;

public class RestaurantRecommend implements java.io.Serializable {

	
	private static final long serialVersionUID = 196254004283316952L;
	 private int recommendId; // RECOMMEND_ID (NUMBER)
	    private String loginId; // LOGIN_ID (VARCHAR2)
	    private String nickname; // USERS 테이블에서 가져올 닉네임
	    private String name; // NAME (VARCHAR2)
	    private String phone; // PHONE (VARCHAR2)
	    private String address; // ADDRESS (VARCHAR2)
	    private String openingHours; // OPENING_HOURS (VARCHAR2)
	    private String menu; // MENU (VARCHAR2)
	    private String review; // REVIEW (CLOB)
	    private int viewCount; // VIEW_COUNT (NUMBER)
	    private int likeCount; // LIKE_COUNT (NUMBER)
	    private java.sql.Timestamp  createdAt; 
	    private java.sql.Timestamp  updatedAt;
	    
	    private String imageUrl;  // 이미지 URL
		 private int imageId;
		 private byte[] imageData; 
		 
		 
		 
		 
		public java.sql.Timestamp getCreatedAt() {
			return createdAt;
		}
		public void setCreatedAt(java.sql.Timestamp createdAt) {
			this.createdAt = createdAt;
		}
		public java.sql.Timestamp getUpdatedAt() {
			return updatedAt;
		}
		public void setUpdatedAt(java.sql.Timestamp updatedAt) {
			this.updatedAt = updatedAt;
		}
		public RestaurantRecommend(int recommendId, String loginId, String nickname, String name, String phone,
				String address, String openingHours, String menu, String review, int viewCount, int likeCount,
				Timestamp createdAt, Timestamp updatedAt, String imageUrl, int imageId, byte[] imageData) {
			super();
			this.recommendId = recommendId;
			this.loginId = loginId;
			this.nickname = nickname;
			this.name = name;
			this.phone = phone;
			this.address = address;
			this.openingHours = openingHours;
			this.menu = menu;
			this.review = review;
			this.viewCount = viewCount;
			this.likeCount = likeCount;
			this.createdAt = createdAt;
			this.updatedAt = updatedAt;
			this.imageUrl = imageUrl;
			this.imageId = imageId;
			this.imageData = imageData;
		}
		@Override
		public String toString() {
			return "RestaurantRecommend [recommendId=" + recommendId + ", loginId=" + loginId + ", nickname=" + nickname
					+ ", name=" + name + ", phone=" + phone + ", address=" + address + ", openingHours=" + openingHours
					+ ", menu=" + menu + ", review=" + review + ", viewCount=" + viewCount + ", likeCount=" + likeCount
					+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", imageUrl=" + imageUrl + ", imageId="
					+ imageId + ", imageData=" + Arrays.toString(imageData) + "]";
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
	
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
		public RestaurantRecommend() {
			super();
		}
		
		public int getRecommendId() {
			return recommendId;
		}
		public void setRecommendId(int recommendId) {
			this.recommendId = recommendId;
		}
		public String getLoginId() {
			return loginId;
		}
		public void setLoginId(String loginId) {
			this.loginId = loginId;
		}
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getPhone() {
			return phone;
		}
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getOpeningHours() {
			return openingHours;
		}
		public void setOpeningHours(String openingHours) {
			this.openingHours = openingHours;
		}
		public String getMenu() {
			return menu;
		}
		public void setMenu(String menu) {
			this.menu = menu;
		}
		public String getReview() {
			return review;
		}
		public void setReview(String review) {
			this.review = review;
		}
		public int getViewCount() {
			return viewCount;
		}
		public void setViewCount(int viewCount) {
			this.viewCount = viewCount;
		}
		public int getLikeCount() {
			return likeCount;
		}
		public void setLikeCount(int likeCount) {
			this.likeCount = likeCount;
		}
	
		public static long getSerialversionuid() {
			return serialVersionUID;
		}
		
	

}
