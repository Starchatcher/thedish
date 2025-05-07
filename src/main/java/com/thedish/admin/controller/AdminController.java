package com.thedish.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController {

    // 관리자 대시보드
    @RequestMapping("dashboard.do")
    public ModelAndView adminDashboard(ModelAndView mv) {
        mv.setViewName("admin/adminDashboard");
        return mv;
    }

    // 공지사항 목록 페이지
    @RequestMapping("noticeList.do")
    public ModelAndView showNoticeList(ModelAndView mv) {
        mv.setViewName("admin/noticeList"); // /WEB-INF/views/admin/noticeList.jsp
        return mv;
    }

    // 회원 목록 페이지
    @RequestMapping("userList.do")
    public ModelAndView showUserList(ModelAndView mv) {
        mv.setViewName("admin/userList"); // /WEB-INF/views/admin/userList.jsp
        return mv;
    }
}
