package com.thedish.like.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.like.model.dao.LikeDao;
import com.thedish.like.model.vo.Like;

@Service("likeService")
public class LikeServiceImpl implements LikeService{

	@Autowired
	LikeDao likeDao;
	
	@Override
	public int insertLike(Like like) {
		return likeDao.insertLike(like);
	}

	@Override
	public int deleteLike(Like like) {
		return likeDao.deleteLike(like);
	}

	@Override
	public int checkLike(Like like) {
		return likeDao.checkLike(like);
	}

	@Override
	public int countLikes(int targetId) {
		return likeDao.countLikes(targetId);
	}

	@Override
	public boolean isLiked(String loginId, int targetId) {
		Like like = new Like();
	    like.setLoginId(loginId);
	    like.setTargetId(targetId);
	    
	    return checkLike(like) > 0;
	}

}
