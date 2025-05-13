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
	public List<Comment> selectRestaurantComments(int targetId, int offset, int limit) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("targetId", targetId);
	    params.put("targetType", "restaurant"); // ★ 맛집 추천 타입을 여기서 고정
	    params.put("offset", offset);
	    params.put("limit", limit);
	    // 매퍼 XML에서는 여전히 범용적인 selectComments 쿼리를 사용
	    return sqlSessionTemplate.selectList("commentMapper.selectComments", params);
	}
	public int insertRestaurantComment(Comment comment) {
		return sqlSessionTemplate.insert("commentMapper.insertComment", comment);
	}
}
