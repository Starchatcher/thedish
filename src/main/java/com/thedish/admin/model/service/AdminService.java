package com.thedish.admin.model.service;

import java.util.List;
import java.util.Map;

public interface AdminService {
    int countTodayJoin();
    int countTodayWithdraw();
    int countTodayReports();
    int countTodayReviews();
    int countTodayInquiries();
    public int countTotalUsers();
    List<Map<String, Object>> selectDailySummary(); // 이미 구현된 경우 제외
}
