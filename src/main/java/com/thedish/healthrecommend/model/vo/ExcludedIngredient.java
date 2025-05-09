package com.thedish.healthrecommend.model.vo;

public class ExcludedIngredient implements java.io.Serializable {

	private static final long serialVersionUID = 6323385329877056873L;
	
	private int excludeId;
	private int conditionId;
	private String ingredientName;
	
	public ExcludedIngredient() {
		super();
	}

	public ExcludedIngredient(int excludeId, int conditionId, String ingredientName) {
		super();
		this.excludeId = excludeId;
		this.conditionId = conditionId;
		this.ingredientName = ingredientName;
	}

	public int getExcludeId() {
		return excludeId;
	}

	public void setExcludeId(int excludeId) {
		this.excludeId = excludeId;
	}

	public int getConditionId() {
		return conditionId;
	}

	public void setConditionId(int conditionId) {
		this.conditionId = conditionId;
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
		return "ExcludedIngredient [excludeId=" + excludeId + ", conditionId=" + conditionId + ", ingredientName="
				+ ingredientName + "]";
	}
	
	
	
}
