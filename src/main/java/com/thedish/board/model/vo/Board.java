package com.thedish.board.model.vo;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thedish.postFile.model.vo.PostFile;

public class Board implements java.io.Serializable{
	private static final long serialVersionUID = 2543203798808544380L;
	
	//Field
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private int boardId;
	private String title;
	private String content;
	private String loginId;
	private java.sql.Date createdAt;
	private java.sql.Date updatedAt;
	private String boardCategory;
	private int viewCount;
	private int avgRating;
	private String nickname;
	
	public Board(int boardId, String title, String content, String loginId, Date createdAt, Date updatedAt,
			String boardCategory, int viewCount, int avgRating,String nickname,
			List<PostFile> fileList) {
		super();
		this.boardId = boardId;
		this.title = title;
		this.content = content;
		this.loginId = loginId;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.boardCategory = boardCategory;
		this.viewCount = viewCount;
		this.avgRating = avgRating;
		this.nickname = nickname;
		this.fileList = fileList;
	}
	private List<PostFile> fileList;
	
	//Constructor
	public Board() {
		super();
	}
	
	public List<PostFile> getPostList() {
        return fileList;
    }

    public void setPostList(List<PostFile> postList) {
        this.fileList = postList;
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
	@Override
	public String toString() {
		return "Board [boardId=" + boardId + ", title=" + title + ", content=" + content + ", loginId=" + loginId
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", boardCategory=" + boardCategory
				+ ", viewCount=" + viewCount + ", avgRating=" + avgRating + ", nickname=" + nickname + ", fileList=" + fileList + "]";
	}
	
	
}
