package com.thedish.admin.controller;

import com.thedish.admin.model.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // 관리자 대시보드
    @RequestMapping("dashboard.do")
    public ModelAndView adminDashboard(ModelAndView mv) {

        // 1. 오늘의 통계 데이터 조회
        int todayJoin = adminService.countTodayJoin();
        int todayWithdraw = adminService.countTodayWithdraw();
        int todayReport = adminService.countTodayReports();
        int todayReview = adminService.countTodayReviews();
        int todayInquiry = adminService.countTodayInquiries();
        int totalUsers = adminService.countTotalUsers();

        // 2. 최근 7일 요약 데이터 조회
        List<Map<String, Object>> dailySummary = adminService.selectDailySummary();

        // 3. 방문자 차트용 데이터 리스트 생성
        List<String> visitLabels = new ArrayList<>();
        List<Integer> visitData = new ArrayList<>();
        for (Map<String, Object> row : dailySummary) {
            visitLabels.add((String) row.get("DAY"));
            visitData.add(((Number) row.get("VISIT_COUNT")).intValue());
        }

        // 4. 데이터 JSP로 전달
        mv.addObject("todayJoin", todayJoin);
        mv.addObject("todayWithdraw", todayWithdraw);
        mv.addObject("todayReport", todayReport);
        mv.addObject("todayReview", todayReview);
        mv.addObject("todayInquiry", todayInquiry);
        mv.addObject("dailySummary", dailySummary);
        mv.addObject("visitLabels", visitLabels);
        mv.addObject("visitData", visitData);
        mv.addObject("totalUsers", totalUsers);

        mv.setViewName("admin/adminDashboard");
        return mv;
    }

    // 공지사항 목록 페이지
    @RequestMapping("noticeList.do")
    public ModelAndView showNoticeList(ModelAndView mv) {
        mv.setViewName("admin/noticeList"); // /WEB-INF/views/admin/noticeList.jsp
        return mv;
    }

}
