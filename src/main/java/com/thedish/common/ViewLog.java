package com.thedish.common;

import java.sql.Date;

public class ViewLog implements java.io.Serializable{	
	private static final long serialVersionUID = 1109682907644695773L;
	
	private int logId;
	private String userId;
	private int postId;
	private String postType;
	private java.util.Date visitTime;
	public ViewLog() {
		super();
	}
	
	public java.util.Date getVisitTime() {
		return visitTime;
	}

	public void setVisitTime(java.util.Date visitTime) {
		this.visitTime = visitTime;
	}

	public ViewLog(int logId, String userId, int postId, String postType, java.util.Date visitTime) {
		super();
		this.logId = logId;
		this.userId = userId;
		this.postId = postId;
		this.postType = postType;
		this.visitTime = visitTime;
	}

	public int getLogId() {
		return logId;
	}
	public void setLogId(int logId) {
		this.logId = logId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
