package com.thedish.board.model.vo;

public class Board implements java.io.Serializable{
	private static final long serialVersionUID = 2543203798808544380L;
	
	//Field
	private int boardId;
	private String title;
	private String content;
	private String loginId;
	private java.sql.Date createdAt;
	private java.sql.Date updatedAt;
	private String boardCategory;
	private int viewCount;
	private int avgRating;
	private int recommendNumber;
	
	//Constructor
	public Board() {
		super();
	}
	
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
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
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public java.sql.Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(java.sql.Date createdAt) {
		this.createdAt = createdAt;
	}
	public java.sql.Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(java.sql.Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getBoardCategory() {
		return boardCategory;
	}
	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getAvgRating() {
		return avgRating;
	}
	public void setAvgRating(int avgRating) {
		this.avgRating = avgRating;
	}
	public int getRecommendNumber() {
		return recommendNumber;
	}
	public void setRecommendNumber(int recommendNumber) {
		this.recommendNumber = recommendNumber;
	}
	@Override
	public String toString() {
		return "Board [boardId=" + boardId + ", title=" + title + ", content=" + content + ", loginId=" + loginId
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", boardCategory=" + boardCategory
				+ ", viewCount=" + viewCount + ", avgRating=" + avgRating + ", recommendNumber=" + recommendNumber
				+ "]";
	}
	
	
}
