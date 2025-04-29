package com.thedish.common;

public class Pairing {
	private int pairingId;		//	PAIRING_ID	NUMBER
	private int	recipeId;		//	RECIPE_ID	NUMBER
	private int	drinkId;			//	DRINK_ID	NUMBER
	private String reason;	
	
	 private String recipeName;
	 
	 
	public String getRecipeName() {
		return recipeName;
	}
	public void setRecipeName(String recipeName) {
		this.recipeName = recipeName;
	}
	public Pairing() {
		super();
	}
	public int getPairingId() {
		return pairingId;
	}
	public void setPairingId(int pairingId) {
		this.pairingId = pairingId;
	}
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public int getDrinkId() {
		return drinkId;
	}
	public void setDrinkId(int drinkId) {
		this.drinkId = drinkId;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
}
