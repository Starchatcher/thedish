package com.thedish.board.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Board implements java.io.Serializable{
	private static final long serialVersionUID = 2543203798808544380L;
	
	//Field
	private int boardId;
	private String title;
	private String content;
	private String writer;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private java.sql.Date createdAt;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private java.sql.Date updatedAt;
	private String boardCategory;
	private int viewCount;
	private int avgRating;
	private String nickname;
	private String originalFileName;
	private String renameFileName;
	private int likeCount;
	private int commentCount;
	
	public int getCommentCount() {
		return commentCount;
	}
	
	

	public Board(int boardId, String title, String content, String writer, Date createdAt, Date updatedAt,
			String boardCategory, int viewCount, int avgRating, String nickname, String originalFileName,
			String renameFileName, int likeCount, int commentCount) {
		super();
		this.boardId = boardId;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.boardCategory = boardCategory;
		this.viewCount = viewCount;
		this.avgRating = avgRating;
		this.nickname = nickname;
		this.originalFileName = originalFileName;
		this.renameFileName = renameFileName;
		this.likeCount = likeCount;
		this.commentCount = commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

		//Constructor
		public Board() {
			super();
		}

	public int getLikeCount() {
			return likeCount;
		}

		public void setLikeCount(int likeCount) {
			this.likeCount = likeCount;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
	@Override
	public String toString() {
		return "Board [boardId=" + boardId + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", boardCategory=" + boardCategory
				+ ", viewCount=" + viewCount + ", avgRating=" + avgRating + ", nickname=" + nickname
				+ ", originalFileName=" + originalFileName + ", renameFileName=" + renameFileName + ", likeCount="
				+ likeCount + ", commentCount=" + commentCount + "]";
	}
	
	
}
