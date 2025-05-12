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

        // 2. 최근 7일 요약 데이터 조회 (게시글 수 + 조회수 + 방문자 수 → 전부 dailySummary 사용)
        List<Map<String, Object>> dailySummary = adminService.selectDailySummary();

        // 그래프 데이터 준비
        List<String> labels = new ArrayList<>();
        List<Integer> postData = new ArrayList<>();
        List<Integer> viewData = new ArrayList<>();
        for (Map<String, Object> row : dailySummary) {
            labels.add((String) row.get("DAY"));
            postData.add(((Number) row.get("POST_COUNT")).intValue());
            viewData.add(((Number) row.get("VIEW_COUNT")).intValue());
        }

        // 3. 데이터 JSP로 전달
        mv.addObject("todayJoin", todayJoin);
        mv.addObject("todayWithdraw", todayWithdraw);
        mv.addObject("todayReport", todayReport);
        mv.addObject("todayReview", todayReview);
        mv.addObject("todayInquiry", todayInquiry);
        mv.addObject("totalUsers", totalUsers);

        mv.addObject("dailySummary", dailySummary);

        // 그래프용 데이터
        mv.addObject("postViewLabels", labels);
        mv.addObject("postData", postData);
        mv.addObject("viewData", viewData);

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
