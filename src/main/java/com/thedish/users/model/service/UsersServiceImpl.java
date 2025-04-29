package com.thedish.users.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.common.EmailUtil;
import com.thedish.common.Paging;
import com.thedish.common.PasswordUtil;
import com.thedish.common.Search;


@Service("usersService")
public class UsersServiceImpl implements UsersService {

    @Autowired
    private UsersDao usersDao;
    
    @Autowired
    private EmailUtil emailUtil;
    
    @Autowired
    private PasswordUtil passwordUtil;
    
    @Override
	public Users selectLogin(Users users) {
		return usersDao.selectLogin(users);
	}

	@Override
	public int selectCheckId(String userId) {
		return usersDao.selectCheckId(userId);
	}

	@Override
	public int insertUsers(Users Users) {
		return usersDao.insertUsers(Users);
	}

	@Override
	public Users selectUsers(String userId) {
		return usersDao.selectUsers(userId);
	}

	@Override
	public int updateUsers(Users Users) {
		return usersDao.updateUsers(Users);
	}

	@Override
	public int deleteUsers(String userId) {
		return usersDao.deleteUsers(userId);
	}

	// 관리자용 ------------------------------------------------------
	
	@Override
	public int selectListCount() {
		return usersDao.selectListCount();
	}

	@Override
	public ArrayList<Users> selectList(Paging paging) {
		return usersDao.selectList(paging);
	}

	@Override
	public int updateStatus(Users users) {
		return usersDao.updateLoginOk(users);
	}

	@Override
	public int selectSearchUserIdCount(String keyword) {
		return usersDao.selectSearchUserIdCount(keyword);
	}

	

	@Override
	public int selectSearchCreatedAtCount(Search search) {
		return usersDao.selectSearchCreatedAtCount(search);
	}

	@Override
	public int selectSearchStatusCount(String keyword) {
		return usersDao.selectSearchStatusCount(keyword);
	}

	@Override
	public ArrayList<Users> selectSearchUserId(Search search) {
		return usersDao.selectSearchUserId(search);
	}

	

	@Override
	public ArrayList<Users> selectSearchCreatedAt(Search search) {
		return usersDao.selectSearchCreatedAt(search);
	}

	@Override
	public ArrayList<Users> selectSearchStatus(Search search) {
		return usersDao.selectSearchStatus(search);
	}

	

}