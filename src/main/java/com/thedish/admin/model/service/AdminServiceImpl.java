package com.thedish.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.admin.model.dao.AdminUserDao;
import com.thedish.users.model.vo.Users;

@Service
public class AdminUserServiceImpl implements AdminUserService {

    @Autowired
    private AdminUserDao adminUserDao;

    @Override
    public Users selectUserById(String userId) {
        return adminUserDao.selectUserById(userId);
    }

    @Override
    public int updateUser(Users user) {
        return adminUserDao.updateUser(user);
    }
    
    @Override
    public List<Users> selectAllUsers() {
        return adminUserDao.selectAllUsers();
    }
    @Override
    public int countTotalUsers() {
        return adminUserDao.countTotalUsers();
    }

    @Override
    public int countActiveUsers() {
        return adminUserDao.countActiveUsers();
    }

    @Override
    public int countWithdrawnUsers() {
        return adminUserDao.countWithdrawnUsers();
    }
    
    @Override
    public List<Users> searchUsers(Map<String, String> paramMap) {
        return adminUserDao.searchUsers(paramMap);
    }
}