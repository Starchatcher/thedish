package com.thedish.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.thedish.users.model.vo.Users;

public interface AdminDao {
    int countTodayJoin();
    int countTodayWithdraw();
    int countTodayReports();
    int countTodayReviews();
    int countTodayInquiries();
    int countTotalUsers(); 
    int countUsersByStatus(Map<String, Object> param);
    
    int countActiveUsers();
    int countWithdrawnUsers();
    
    List<Map<String, Object>> selectDailySummary();
    List<Map<String, Object>> selectDailyPostAndView();
    List<Users> searchUsers(Map<String, Object> param);
}


