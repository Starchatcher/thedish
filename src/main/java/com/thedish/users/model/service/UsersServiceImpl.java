package com.thedish.users.model.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.users.model.dao.UsersDao;
import com.thedish.users.model.vo.Users;

@Service("usersService")
public class UsersServiceImpl implements UsersService {

    private static final Logger logger = LoggerFactory.getLogger(UsersServiceImpl.class);

    @Autowired
    private UsersDao usersDao;

    @Autowired
    private HttpSession session;

    @Override
    public Users selectLogin(Users users) {
        return usersDao.selectLogin(users);
    }

    @Override
    public Users selectUsers(String loginId) {
        return usersDao.selectUsers(loginId);
    }

    @Override
    public int insertUser(Users user) {
        return usersDao.insertUser(user);
    }

    @Override
    public int selectChecknickName(String nickName) {
        return usersDao.selectChecknickName(nickName);  
    }

    @Override
    public int selectCheckId(String userId) {
        return usersDao.selectCheckId(userId);
    }

    @Override
    public int updateUser(Users user) {
        return usersDao.updateUser(user);
    }

    @Override
    public int deleteUsers(String userId) {
        logger.info("Attempting to delete user with loginId: " + userId);
        int result = usersDao.deleteUsers(userId);
        if (result > 0) {
            logger.info("User successfully deleted: " + userId);
            session.invalidate();
        } else {
            logger.error("Failed to delete user: " + userId);
        }
        return result;
    }

    // ✅ 비밀번호 변경
    @Override
    public int updatePassword(Users user) {
        logger.info("Updating password for userId: " + user.getUserId());
        return usersDao.updatePassword(user);
    }

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
