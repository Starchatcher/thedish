package com.thedish.comment.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.comment.model.vo.Comment;

@Repository("commentDao")
public class CommentDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int insertComment(Comment comment) {
		return sqlSessionTemplate.insert("commentMapper.insertComment", comment);
	}
	
	public List<Comment> selectComments(int targetId, int offset, int limit) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("targetId", targetId);
	    params.put("targetType", "recipe"); 
	    params.put("offset", offset);
	    params.put("limit", limit);
	    return sqlSessionTemplate.selectList("commentMapper.selectComments", params);
	}
	
	public int selectCommentCount(int targetId, String targetType) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("targetId", targetId);
	    params.put("targetType", targetType);
	    return sqlSessionTemplate.selectOne("commentMapper.selectCommentCount", params);
	}
	
	public int deleteComment(int commentId, String targetType) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("commentId", commentId);
	    params.put("targetType", targetType);
	    return sqlSessionTemplate.delete("commentMapper.deleteComment", params);
	}

	public List<Comment> selectDrinkComments(int targetId, int offset, int limit) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("targetId", targetId);
	    params.put("targetType", "drink"); 
	    params.put("offset", offset);
	    params.put("limit", limit);
	    return sqlSessionTemplate.selectList("commentMapper.selectDrinkComments", params);
	}
	
	public int insertDrinkComment(Comment comment) {
		return sqlSessionTemplate.insert("commentMapper.insertDrinkComment", comment);
				
	}
	
	public int deleteDrinkComment(int commentId, String targetType) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("commentId", commentId);
	    params.put("targetType", targetType);
	    return sqlSessionTemplate.delete("commentMapper.deleteDrinkComment", params);
	}
}
