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

    // ✅ 관리자 대시보드
    @RequestMapping("dashboard.do")
    public ModelAndView adminDashboard(ModelAndView mv) {
        // 📌 오늘의 알림 데이터 조회
        int todayJoin = adminService.countTodayJoin();
        int todayWithdraw = adminService.countTodayWithdraw();
        int todayReport = adminService.countTodayReports();
        int todayReview = adminService.countTodayReviews();
        int todayInquiry = adminService.countTodayInquiries();
        int totalUsers = adminService.countTotalUsers();

        // 📌 일자별 요약 데이터 조회
        List<Map<String, Object>> dailySummary = adminService.selectDailySummary();

        List<String> labels = new ArrayList<>();
        List<Integer> postData = new ArrayList<>();
        List<Integer> boardViewData = new ArrayList<>();
        List<Integer> recipeViewData = new ArrayList<>();
        List<Integer> drinkViewData = new ArrayList<>();

        for (Map<String, Object> row : dailySummary) {
            labels.add((String) row.get("DAY"));
            postData.add(row.get("POST_COUNT") != null ? ((Number) row.get("POST_COUNT")).intValue() : 0);
            boardViewData.add(row.get("BOARD_VIEW_COUNT") != null ? ((Number) row.get("BOARD_VIEW_COUNT")).intValue() : 0);
            recipeViewData.add(row.get("RECIPE_VIEW_COUNT") != null ? ((Number) row.get("RECIPE_VIEW_COUNT")).intValue() : 0);
            drinkViewData.add(row.get("DRINK_VIEW_COUNT") != null ? ((Number) row.get("DRINK_VIEW_COUNT")).intValue() : 0);
        }

        // ✅ 오늘의 알림 데이터 JSP로 전달
        mv.addObject("todayJoin", todayJoin);
        mv.addObject("todayWithdraw", todayWithdraw);
        mv.addObject("todayReport", todayReport);
        mv.addObject("todayReview", todayReview);
        mv.addObject("todayInquiry", todayInquiry);
        mv.addObject("totalUsers", totalUsers);

        // ✅ 그래프/테이블 데이터 JSP로 전달
        mv.addObject("dailySummary", dailySummary);
        mv.addObject("postViewLabels", labels);
        mv.addObject("postData", postData);
        mv.addObject("viewData", boardViewData);
        mv.addObject("recipeViewData", recipeViewData);
        mv.addObject("drinkViewData", drinkViewData);

        mv.setViewName("admin/adminDashboard");
        return mv;
    }

    // ✅ 공지사항 목록 페이지
    @RequestMapping("noticeList.do")
    public ModelAndView showNoticeList(ModelAndView mv) {
        mv.setViewName("admin/noticeList");
        return mv;
    }

    // ❌ 사용자 목록 기능은 AdminUserController로 이동했으므로 제거함
    // @RequestMapping("userList.do") → 삭제
}
