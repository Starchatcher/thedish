package com.thedish.admin.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.admin.model.dao.AdminDao;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDao adminDao;

    @Override
    public int countTodayJoin() {
        return adminDao.countTodayJoin();
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
        List<Map<String, Object>> result = adminDao.selectDailySummary();
        
        // 결과가 없는 경우 빈 리스트 반환
        if (result == null) {
            return new ArrayList<>();
        }
        
        // 각 행의 데이터에서 null 값 처리
        for (Map<String, Object> row : result) {
            // POST_COUNT 처리
            if (row.get("POST_COUNT") == null) {
                row.put("POST_COUNT", 0);
            }
            
            // VIEW_COUNT 처리
            if (row.get("VIEW_COUNT") == null) {
                row.put("VIEW_COUNT", 0);
            }
        }
        
        return result;
    }
    
    @Override
    public List<Map<String, Object>> selectDailyPostAndView() {
        return adminDao.selectDailyPostAndView();
    }

}
