package com.thedish.like.model.service;

import com.thedish.like.model.vo.Like;

public interface LikeService {

	int insertLike (Like like);
	int deleteLike (Like like);
	int checkLike (Like like);
	int countLikes (int targetId);
	boolean isLiked(String loginId, int targetId);
}
