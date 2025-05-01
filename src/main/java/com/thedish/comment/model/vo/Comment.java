package com.thedish.comment.model.vo;

import java.sql.Date;

public class Comment implements java.io.Serializable {

	private static final long serialVersionUID = -1521188059818762531L;
	
	
	private int commentId;        // COMMENT_ID
    private String loginId;       // LOGIN_ID
    private int targetId;         // TARGET_ID
    private String content;       // CONTENT
    private java.sql.Date createdAt;       // CREATED_AT
    private java.sql.Date updatedAt;       // UPDATED_AT
    private Integer parentId;     // PARENT_ID (null 가능)
    private String targetType;    // TARGET_TYPE
    private String nickName;
    
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public Integer getParentId() {
	    return parentId;
	}
	public void setParentId(Integer parentId) {
	    this.parentId = parentId;
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
	public Comment() {
		super();
	}
    
    
}
