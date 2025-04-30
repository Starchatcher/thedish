package com.thedish.common;

import java.sql.Date;

public class Rating implements java.io.Serializable {	
	private static final long serialVersionUID = -4062334598875041517L;
	
	private int ratingId; // RATING_ID	NUMBER
	private String loginId;	//	LOGIN_ID	VARCHAR2(50 BYTE)
	private int targetId;//	TARGET_ID	NUMBER
	private double ratingScore;//	RATING_SCORE	NUMBER(3,1)
	private java.sql.Date createdAt;	//	CREATED_AT	DATE
	private String targetType;	//	TARGET_TYPE	VARCHAR2(20 BYTE)
	public Rating(int ratingId, String loginId, int targetId, double ratingScore, Date createdAt, String targetType) {
		super();
		this.ratingId = ratingId;
		this.loginId = loginId;
		this.targetId = targetId;
		this.ratingScore = ratingScore;
		this.createdAt = createdAt;
		this.targetType = targetType;
	}
	public Rating() {
		super();
	}
	public int getRatingId() {
		return ratingId;
	}
	public void setRatingId(int ratingId) {
		this.ratingId = ratingId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public int getTargetId() {
		return targetId;
	}
	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}
	public double getRatingScore() {
		return ratingScore;
	}
	public void setRatingScore(double ratingScore) {
		this.ratingScore = ratingScore;
	}
	public java.sql.Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(java.sql.Date createdAt) {
		this.createdAt = createdAt;
	}
	public String getTargetType() {
		return targetType;
	}
	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Rating [ratingId=" + ratingId + ", loginId=" + loginId + ", targetId=" + targetId + ", ratingScore="
				+ ratingScore + ", createdAt=" + createdAt + ", targetType=" + targetType + "]";
	}

}
