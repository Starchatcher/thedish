package com.thedish.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.admin.model.dao.AdminDao;
import com.thedish.users.model.vo.Users;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDao adminDao;

    @Override
    public int countTodayJoin() {
        return adminDao.countTodayJoin();
    }
    
    @Override
    public int countActiveUsers() {
    	return adminDao.countActiveUsers();
    }
    
    @Override
    public int countWithdrawnUsers() {
    	return adminDao.countWithdrawnUsers();
    }

    @Override
    public int countTotalUsers() {
        return adminDao.countTotalUsers();
    }

    @Override
    public int countTodayWithdraw() {
        return adminDao.countTodayWithdraw();
    }

    @Override
    public int countTodayReports() {
        return adminDao.countTodayReports();
    }

    @Override
    public int countTodayReviews() {
        return adminDao.countTodayReviews();
    }

    @Override
    public int countTodayInquiries() {
        return adminDao.countTodayInquiries();
    }

    @Override
    public List<Map<String, Object>> selectDailySummary() {
        return adminDao.selectDailySummary();
    }

    @Override
    public List<Map<String, Object>> selectDailyPostAndView() {
        return adminDao.selectDailyPostAndView();
    }

    @Override
    public List<Users> searchUsers(Map<String, Object> param) {
        return adminDao.searchUsers(param);
    }
    
    @Override
    public int countUsersByStatus(Map<String, Object> param) {
    	return adminDao.countUsersByStatus(param);
    }
}
