package com.thedish.notice.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Notice	implements java.io.Serializable {
	private static final long serialVersionUID = -5175649665343126014L;
	
	//Field
	private int noticeId;
	private String title;
	private String content;
	private String createdBy;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private java.sql.Date createdAt;
	
	//Constructor
	public Notice() {
		super();
	}

	public Notice(int noticeId, String title, String content, String createdBy, Date createdAt) {
		super();
		this.noticeId = noticeId;
		this.title = title;
		this.content = content;
		this.createdBy = createdBy;
		this.createdAt = createdAt;
	}
	
	//getters and setters
	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
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

	// toString()
	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", title=" + title + ", content=" + content + ", createdBy=" + createdBy
				+ ", createdAt=" + createdAt + "]";
	}
	
	
	
}
