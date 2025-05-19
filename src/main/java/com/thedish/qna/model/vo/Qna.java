package com.thedish.qna.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Qna implements java.io.Serializable{
	private static final long serialVersionUID = -7370875045617624684L;

	private int qnaId;
	private String title;
	private String content;
	private String userId;
	private String createdBy;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private java.sql.Date createdAt;
	private String isAnswered;
	private String answer;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private java.sql.Date answeredAt;
	private String status;
	private String originalFileName;
	private String renameFileName;

	public Qna() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Qna(int qnaId, String title, String content, String userId, String createdBy, Date createdAt,
			String isAnswered, String answer, Date answeredAt, String status, String originalFileName,
			String renameFileName) {
		super();
		this.qnaId = qnaId;
		this.title = title;
		this.content = content;
		this.userId = userId;
		this.createdBy = createdBy;
		this.createdAt = createdAt;
		this.isAnswered = isAnswered;
		this.answer = answer;
		this.answeredAt = answeredAt;
		this.status = status;
		this.originalFileName = originalFileName;
		this.renameFileName = renameFileName;
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

	public int getQnaId() {
		return qnaId;
	}

	public void setQnaId(int qnaId) {
		this.qnaId = qnaId;
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getIsAnswered() {
		return isAnswered;
	}

	public void setIsAnswered(String isAnswered) {
		this.isAnswered = isAnswered;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public java.sql.Date getAnsweredAt() {
		return answeredAt;
	}

	public void setAnsweredAt(java.sql.Date answeredAt) {
		this.answeredAt = answeredAt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Qna [qnaId=" + qnaId + ", title=" + title + ", content=" + content + ", userId=" + userId
				+ ", createdBy=" + createdBy + ", createdAt=" + createdAt + ", isAnswered=" + isAnswered + ", answer="
				+ answer + ", answeredAt=" + answeredAt + ", status=" + status + ", originalFileName="
				+ originalFileName + ", renameFileName=" + renameFileName + "]";
	}
	
}
