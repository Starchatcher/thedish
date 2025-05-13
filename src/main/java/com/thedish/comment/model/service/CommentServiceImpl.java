package com.thedish.comment.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.comment.dao.CommentDao;
import com.thedish.comment.model.vo.Comment;

@Service("commentService")
public class CommentServiceImpl implements CommentService{

	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private CommentService commentService; 
	
	@Override
	public int insertComment(Comment comment) {
		
		return commentDao.insertComment(comment);
	}

	

	@Override
	public int selectCommentCount(int targetId, String targetType) {
		
		return commentDao.selectCommentCount(targetId, targetType)
				;
	}



	@Override
	public List<Comment> selectComments(int targetId, String targetType, int offset, int limit) {
		
		return commentDao.selectComments(targetId, offset, limit);
	}



	@Override
	public boolean deleteComment(int commentId, String targetType) {
	    int result = commentDao.deleteComment(commentId, targetType);
	    return result > 0;
	}



	@Override
	public boolean deleteDrinkComment(int commentId, String targetType) {
		 int result = commentDao.deleteDrinkComment(commentId, targetType);
		    return result > 0;
	}



	@Override
	public int insertDrinkComment(Comment comment) {
		return commentDao.insertDrinkComment(comment);
	}



	@Override
	public List<Comment> selectDrinkComments(int targetId, String targetType,int offset, int limit) {
		return commentDao.selectDrinkComments(targetId, offset, limit);
	}



	@Override
	public List<Comment> selectRestaurantComments(int targetId, int offset, int limit) {
		
		return commentDao.selectRestaurantComments(targetId, offset, limit);
	}



	@Override
	public int insertRestaurantComment(Comment comment) {
		return commentDao.insertRestaurantComment(comment);
	}



	@Override
	public int deleteRestaurantComment(int commentId, String targetType) {
		
		return commentDao.deleteRestaurantComment(commentId, targetType);
	}



	

	

	

}
