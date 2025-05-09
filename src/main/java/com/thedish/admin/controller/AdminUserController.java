package com.thedish.admin.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.admin.model.service.AdminUserService;
import com.thedish.users.model.vo.Users;

@Controller
@RequestMapping("/admin")
public class AdminUserController {

    @Autowired
    private AdminUserService adminUserService;
    
    @RequestMapping("/userDetail.do")
    public ModelAndView userDetail(@RequestParam("userId") String userId, ModelAndView mv) {
        Users user = adminUserService.selectUserById(userId);
        mv.addObject("user", user);
        mv.setViewName("admin/userDetail");
        return mv;
    }

    // 사용자 상세 정보 수정 폼
    @RequestMapping("/userEdit.do")
    public ModelAndView editUserForm(@RequestParam("userId") String userId, ModelAndView mv) {
        Users user = adminUserService.selectUserById(userId);
        mv.addObject("user", user);
        mv.setViewName("admin/userEdit");
        return mv;
    }

    // 사용자 목록 + 통계
    @RequestMapping("/userList.do")
    public ModelAndView showUserList(ModelAndView mv) {
        List<Users> userList = adminUserService.selectAllUsers();

        int totalUsers = adminUserService.countTotalUsers();          // 전체 가입자 수
        int todayJoin = adminUserService.countActiveUsers();          // 현재 활성 회원 수
        int todayWithdraw = adminUserService.countWithdrawnUsers();   // 탈퇴한 수

        mv.addObject("userList", userList);
        mv.addObject("totalUsers", totalUsers);
        mv.addObject("todayJoin", todayJoin);
        mv.addObject("todayWithdraw", todayWithdraw);
        mv.setViewName("admin/userList");
        return mv;
    }

    // 사용자 정보 수정 처리
    @RequestMapping(value = "/updateUser.do", method = RequestMethod.POST)
    public String updateUser(Users user) {
        adminUserService.updateUser(user);
        return "redirect:/admin/userList.do";
    }
    
    @RequestMapping("/user/list.do")
    public ModelAndView showUserList(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "status", required = false) String status,
            ModelAndView mv) {

        // 검색 조건 Map 구성
        Map<String, String> paramMap = new HashMap<>();
        if (keyword != null && !keyword.isBlank()) {
            paramMap.put("keyword", keyword);
        }
        if (status != null && !status.isBlank()) {
            paramMap.put("status", status);
        }

        List<Users> userList = adminUserService.searchUsers(paramMap);

        int totalUsers = adminUserService.countTotalUsers();
        int todayJoin = adminUserService.countActiveUsers();
        int todayWithdraw = adminUserService.countWithdrawnUsers();

        mv.addObject("userList", userList);
        mv.addObject("totalUsers", totalUsers);
        mv.addObject("todayJoin", todayJoin);
        mv.addObject("todayWithdraw", todayWithdraw);

        mv.setViewName("admin/userList");
        return mv;
    }

}
