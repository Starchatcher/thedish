package com.thedish.healthrecommend.model.vo;

public class HealthCondition implements java.io.Serializable {
 
	private static final long serialVersionUID = -1497608973113680231L;
	
	private int conditionId;
    private String description;
    private String conditionName;
    
	public HealthCondition() {
		super();
	}
	public HealthCondition(int conditionId, String description, String conditionName) {
		super();
		this.conditionId = conditionId;
		this.description = description;
		this.conditionName = conditionName;
	}
	public int getConditionId() {
		return conditionId;
	}
	public void setConditionId(int conditionId) {
		this.conditionId = conditionId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
		return "HealthCondition [conditionId=" + conditionId + ", description=" + description + ", conditionName="
				+ conditionName + "]";
	}
    
}
