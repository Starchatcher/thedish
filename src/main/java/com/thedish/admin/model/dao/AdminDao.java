package com.thedish.admin.model.dao;

import java.util.List;
import java.util.Map;

public interface AdminDao {
    int countTodayJoin();
    int countTodayWithdraw();
    int countTodayReports();
    int countTodayReviews();
    int countTodayInquiries();
    int countTotalUsers(); 
    List<Map<String, Object>> selectDailySummary();
    
}


