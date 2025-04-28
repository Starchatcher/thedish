package com.thedish.common;

public class Allergy {

	private int allergyId;        // 알러지 ID
    private String name;          // 알러지 이름
    private String description;   // 알러지 설명
	public Allergy() {
		super();
	}
	public int getAllergyId() {
		return allergyId;
	}
	public void setAllergyId(int allergyId) {
		this.allergyId = allergyId;
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

    
}
