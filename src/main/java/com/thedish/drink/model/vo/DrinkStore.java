package com.thedish.drink.model.vo;

public class DrinkStore implements java.io.Serializable {
	private static final long serialVersionUID = 9094027522392308469L;	
	
	private int storeId;
	private String drinkName;
	private String storeName;
	private String storeAddress;
	public DrinkStore(int storeId, String drinkName, String storeName, String storeAddress) {
		super();
		this.storeId = storeId;
		this.drinkName = drinkName;
		this.storeName = storeName;
		this.storeAddress = storeAddress;
	}
	public DrinkStore() {
		super();
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getDrinkName() {
		return drinkName;
	}
	public void setDrinkName(String drinkName) {
		this.drinkName = drinkName;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreAddress() {
		return storeAddress;
	}
	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "DrinkStore [storeId=" + storeId + ", drinkName=" + drinkName + ", storeName=" + storeName
				+ ", storeAddress=" + storeAddress + "]";
	}
	


}
