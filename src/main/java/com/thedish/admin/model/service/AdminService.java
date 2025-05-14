package com.thedish.admin.model.service;

import java.util.List;
import java.util.Map;

import com.thedish.users.model.vo.Users;

public interface AdminService {
    int countTodayJoin();
    int countTodayWithdraw();
    int countTodayReports();
    int countTodayReviews();
    int countTodayInquiries();
    int countActiveUsers();
    int countWithdrawnUsers();
    int countUsersByStatus(Map<String, Object> param);
    
    public int countTotalUsers();
    List<Map<String, Object>> selectDailySummary(); // 이미 구현된 경우 제외
    List<Map<String, Object>> selectDailyPostAndView();
    List<Users> searchUsers(Map<String, Object> param);
}
