package com.thedish.notice.model.vo;

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
	private String originalFileName;
	private String renameFileName;
	private int readCount;
	
	//Constructor
	public Notice() {
		super();
	}


	
	public Notice(int noticeId, String title, String content, String createdBy, Date createdAt, String originalFileName,
			String renameFileName, int readCount) {
		super();
		this.noticeId = noticeId;
		this.title = title;
		this.content = content;
		this.createdBy = createdBy;
		this.createdAt = createdAt;
		this.originalFileName = originalFileName;
		this.renameFileName = renameFileName;
		this.readCount = readCount;
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



	public String getOriginalFileName() {
		return originalFileName;
	}



	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}



	public String getRenameFileName() {
		return renameFileName;
	}



	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}



	public int getReadCount() {
		return readCount;
	}



	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}



	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", title=" + title + ", content=" + content + ", createdBy=" + createdBy
				+ ", createdAt=" + createdAt + ", originalFileName=" + originalFileName + ", renameFileName="
				+ renameFileName + ", readCount=" + readCount + "]";
	}




	
	
	
	
}
