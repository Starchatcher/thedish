package com.thedish.healthrecommend.model.vo;

public class HealthRecommend implements java.io.Serializable {
  
	private static final long serialVersionUID = -2455321539396507959L;
	
	private int recommendId;
    private String reason;
    private int ingredientId;
    private int conditionId;

	public HealthRecommend() {
		super();
	}
	public HealthRecommend(int recommendId, String reason, int ingredientId, int conditionId) {
		super();
		this.recommendId = recommendId;
		this.reason = reason;
		this.ingredientId = ingredientId;
		this.conditionId = conditionId;
	}
	public int getRecommendId() {
		return recommendId;
	}
	public void setRecommendId(int recommendId) {
		this.recommendId = recommendId;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getIngredientId() {
		return ingredientId;
	}
	public void setIngredientId(int ingredientId) {
		this.ingredientId = ingredientId;
	}
	public int getConditionId() {
		return conditionId;
	}
	public void setConditionId(int conditionId) {
		this.conditionId = conditionId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "HealthRecommend [recommendId=" + recommendId + ", reason=" + reason + ", ingredientId=" + ingredientId
				+ ", conditionId=" + conditionId + "]";
	}
    
    
}
