package com.thedish.like.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.like.model.vo.Like;

@Repository("LikeDao")
public class LikeDao {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int insertLike (Like like) {
		return sqlSessionTemplate.insert("likeMapper.insertLike", like);
	}
	
	public int deleteLike (Like like) {
		return sqlSessionTemplate.delete("likeMapper.deleteLike", like);
	}
	
	public int checkLike (Like like) {
		return sqlSessionTemplate.selectOne("likeMapper.checkLike", like);
	}
	
	public int countLikes (int targetId) {
		return sqlSessionTemplate.selectOne("likeMapper.countLikes", targetId);
	}
	
	public int deleteLikeAll (int targetId) {
		return sqlSessionTemplate.delete("likeMapper.deleteLikeAll", targetId);
	}
}
