package com.thedish.users.model.service;

import java.util.ArrayList;

import com.thedish.common.Paging;
import com.thedish.common.Search;

public interface UsersService {
	/*public abstract*/ Users selectLogin(Users users);
	int selectCheckId(String userId);
	Users selectUsers(String userId);	
	//dml ----------------------------
	int insertUsers(Users users);
	int updateUsers(Users users);
	int deleteUsers(String userId);
	//관리자용 ---------------------------
	int selectListCount();
	ArrayList<Users> selectList(Paging paging);
	int updateStatus(Users users);
	//관리자용 검색 카운트용 -----------------
	int selectSearchUserIdCount(String keyword);

	
	int selectSearchCreatedAtCount(Search search);
	int selectSearchStatusCount(String keyword);
	//관리자용 검색 목록 조회용 -------------------
	ArrayList<Users> selectSearchUserId(Search search);
	

	ArrayList<Users> selectSearchCreatedAt(Search search);
	ArrayList<Users> selectSearchStatus(Search search);

}