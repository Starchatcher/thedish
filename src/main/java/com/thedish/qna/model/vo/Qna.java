package com.thedish.qna.model.vo;

import java.sql.Date;

public class Qna implements java.io.Serializable{
	private static final long serialVersionUID = -7370875045617624684L;

	private int qanId;
	private String title;
	private String content;
	private String userId;
	private String createdBy;
	private java.sql.Date createdAt;
	private String isAnswered;
	private String answer;
	private java.sql.Date answeredAt;
	private String status;

	public Qna() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Qna(int qanId, String title, String content, String userId, String createdBy, Date createdAt,
			String isAnswered, String answer, Date answeredAt, String status) {
		super();
		this.qanId = qanId;
		this.title = title;
		this.content = content;
		this.userId = userId;
		this.createdBy = createdBy;
		this.createdAt = createdAt;
		this.isAnswered = isAnswered;
		this.answer = answer;
		this.answeredAt = answeredAt;
		this.status = status;
	}

	public int getQanId() {
		return qanId;
	}

	public void setQanId(int qanId) {
		this.qanId = qanId;
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
		return "Qna [qanId=" + qanId + ", title=" + title + ", content=" + content + ", userId=" + userId
				+ ", createdBy=" + createdBy + ", createdAt=" + createdAt + ", isAnswered=" + isAnswered + ", answer="
				+ answer + ", answeredAt=" + answeredAt + ", status=" + status + "]";
	}
	
}
