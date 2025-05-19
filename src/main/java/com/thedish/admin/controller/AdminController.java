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

        int todayJoin = adminService.countTodayJoin();
        int todayWithdraw = adminService.countTodayWithdraw();
        int todayReport = adminService.countTodayReports();
        int todayReview = adminService.countTodayReviews();
        int todayInquiry = adminService.countTodayInquiries();
        int totalUsers = adminService.countTotalUsers();

        List<Map<String, Object>> dailySummary = adminService.selectDailySummary();

        List<String> labels = new ArrayList<>();
        List<Integer> postData = new ArrayList<>();
        List<Integer> boardViewData = new ArrayList<>();
        List<Integer> recipeViewData = new ArrayList<>();
        List<Integer> drinkViewData = new ArrayList<>();

        for (Map<String, Object> row : dailySummary) {
            labels.add((String) row.get("DAY"));

            
            // POST_COUNT null 체크
            Object postCountObj = row.get("POST_COUNT");
            postData.add(postCountObj != null ? ((Number) postCountObj).intValue() : 0);
            
            // VIEW_COUNT null 체크
            Object viewCountObj = row.get("VIEW_COUNT");
            viewData.add(viewCountObj != null ? ((Number) viewCountObj).intValue() : 0);

        }

        mv.addObject("todayJoin", todayJoin);
        mv.addObject("todayWithdraw", todayWithdraw);
        mv.addObject("todayReport", todayReport);
        mv.addObject("todayReview", todayReview);
        mv.addObject("todayInquiry", todayInquiry);
        mv.addObject("totalUsers", totalUsers);

        // ✅ 그래프/테이블 데이터 JSP로 전달
        mv.addObject("dailySummary", dailySummary);
        mv.addObject("postViewLabels", labels);

        mv.addObject("postData", postData);             // 게시글 수 (그래프 1)
        mv.addObject("viewData", boardViewData);        // 게시판 조회수 (그래프 2)
        mv.addObject("recipeViewData", recipeViewData); // JSP 테이블용
        mv.addObject("drinkViewData", drinkViewData);   // JSP 테이블용

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
