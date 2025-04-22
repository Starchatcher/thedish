package com.thedish.recipe.model.vo;

import java.sql.Date;

public class Recipe implements java.io.Serializable{
	
	private static final long serialVersionUID = 7282748304609321736L;
	
	private int recipeId;				//	RECIPE_ID	NUMBER
	private String name;		//	NAME	VARCHAR2(200 BYTE)
				//	RECIPE_CATEGORY	VARCHAR2(50 BYTE)
	private String description;		//	DESCRIPTION	VARCHAR2(500 BYTE)
	private String 	createBy;//	CREATED_BY	VARCHAR2(50 BYTE)
	private java.sql.Date createdAt;		//	CREATED_AT	DATE
	private String instructions;			//	INSTRUCTIONS	VARCHAR2(4000 BYTE)
	private int recommendNumber; 			//	RECOMMEND_NUMBER	NUMBER
	private int avgRating;	//	AVG_RATING	NUMBER(3,1)
	private int viewCount;		//	VIEW_COUNT	NUMBER
	private String ingredientName;		//	INGREDIENT_NAME	VARCHAR2(2000 BYTE)
	public Recipe() {
		super();
	}
	public Recipe(int recipeId, String name, String description, String createBy, Date createdAt, String instructions,
			int recommendNumber, int avgRating, int viewCount, String ingredientName) {
		super();
		this.recipeId = recipeId;
		this.name = name;
		this.description = description;
		this.createBy = createBy;
		this.createdAt = createdAt;
		this.instructions = instructions;
		this.recommendNumber = recommendNumber;
		this.avgRating = avgRating;
		this.viewCount = viewCount;
		this.ingredientName = ingredientName;
	}
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public java.sql.Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(java.sql.Date createdAt) {
		this.createdAt = createdAt;
	}
	public String getInstructions() {
		return instructions;
	}
	public void setInstructions(String instructions) {
		this.instructions = instructions;
	}
	public int getRecommendNumber() {
		return recommendNumber;
	}
	public void setRecommendNumber(int recommendNumber) {
		this.recommendNumber = recommendNumber;
	}
	public int getAvgRating() {
		return avgRating;
	}
	public void setAvgRating(int avgRating) {
		this.avgRating = avgRating;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getIngredientName() {
		return ingredientName;
	}
	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Recipe [recipeId=" + recipeId + ", name=" + name + ", description=" + description + ", createBy="
				+ createBy + ", createdAt=" + createdAt + ", instructions=" + instructions + ", recommendNumber="
				+ recommendNumber + ", avgRating=" + avgRating + ", viewCount=" + viewCount + ", ingredientName="
				+ ingredientName + "]";
	}

	
}
