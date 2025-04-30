package com.thedish.healthrecommend.model.vo;

public class HealthRecommend implements java.io.Serializable {
  
	private static final long serialVersionUID = -2455321539396507959L;
	
	private int recommendId;
    private String reason;
    private int recipeId;
    private String conditionName;

	public HealthRecommend() {
		super();
	}
	public HealthRecommend(int recommendId, String reason, int recipeId, String conditionName) {
		super();
		this.recommendId = recommendId;
		this.reason = reason;
		this.recipeId = recipeId;
		this.conditionName = conditionName;
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
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public String getConditionName() {
		return conditionName;
	}
	public void setConditionName(String conditionName) {
		this.conditionName = conditionName;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "HealthRecommend [recommendId=" + recommendId + ", reason=" + reason + ", recipeId=" + recipeId
				+ ", conditionName=" + conditionName + "]";
	}
    
    
}
