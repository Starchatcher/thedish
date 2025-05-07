package com.thedish.like.model.vo;

import java.sql.Date;

public class Like implements java.io.Serializable{
	private static final long serialVersionUID = -1693634971599506006L;
	
	private int likeId;
	private String loginId;
	private int targetId;
	private java.sql.Date createdAt;
	
	
	public Like() {
		super();
	}


	public Like(int likeId, String loginId, int targetId, Date createdAt) {
		super();
		this.likeId = likeId;
		this.loginId = loginId;
		this.targetId = targetId;
		this.createdAt = createdAt;
	}


	public int getLikeId() {
		return likeId;
	}


	public void setLikeId(int likeId) {
		this.likeId = likeId;
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


	public java.sql.Date getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(java.sql.Date createdAt) {
		this.createdAt = createdAt;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	@Override
	public String toString() {
		return "Like [likeId=" + likeId + ", loginId=" + loginId + ", targetId=" + targetId + ", createdAt=" + createdAt
				+ "]";
	}
}
