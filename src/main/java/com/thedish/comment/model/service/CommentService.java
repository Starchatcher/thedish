package com.thedish.comment.model.service;

import java.util.List;

import com.thedish.comment.model.vo.Comment;

public interface CommentService   {

	int insertComment(Comment comment);
	
	List<Comment> selectComments(int targetId, String targetType, int offset, int limit);

	int selectCommentCount(int targetId, String targetType);
	
	boolean deleteComment(int commentId, String targetType);
	
	 List<Comment> selectDrinkComments(int targetId,String targetType, int offset, int limit);

	 int insertDrinkComment(Comment comment);
	 
	boolean deleteDrinkComment(int commentId, String targetType);
    
}
