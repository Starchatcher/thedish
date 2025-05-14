package com.thedish.admin.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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

    private static final int USERS_PER_PAGE = 10;

    // ✅ 사용자 목록 페이지 (페이징 포함 + 고정 높이)
    @RequestMapping("/userList.do")
    public ModelAndView showUserList(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page) {

        ModelAndView mv = new ModelAndView();

        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("status", status);

        List<Users> fullList;

        if ((keyword != null && !keyword.isEmpty()) || (status != null && !status.isEmpty())) {
            fullList = adminUserService.searchUsers(paramMap);
        } else {
            fullList = adminUserService.selectAllUsers();
        }

        int totalUsers = fullList.size();
        int totalPages = (int) Math.ceil((double) totalUsers / USERS_PER_PAGE);

        int start = (page - 1) * USERS_PER_PAGE;
        int end = Math.min(start + USERS_PER_PAGE, totalUsers);

        List<Users> paginatedList = fullList.subList(start, end);

        // ✅ 화면 높이 고정을 위한 padding row 추가
        int remaining = USERS_PER_PAGE - paginatedList.size();
        if (remaining > 0) {
            List<Users> paddingList = IntStream.range(0, remaining)
                    .mapToObj(i -> new Users()) // 빈 사용자
                    .collect(Collectors.toList());
            paginatedList.addAll(paddingList);
        }

        // ✅ 전달할 모델 값들
        mv.addObject("userList", paginatedList);
        mv.addObject("currentPage", page);
        mv.addObject("totalPages", totalPages);
        mv.addObject("param", paramMap);
        mv.addObject("keyword", keyword);
        mv.addObject("status", status);

        mv.addObject("totalUsers", adminUserService.countTotalUsers());
        mv.addObject("activeUsers", adminUserService.countActiveUsers());
        mv.addObject("withdrawnUsers", adminUserService.countWithdrawnUsers());

        mv.setViewName("admin/userList");
        return mv;
    }

    // ✅ 사용자 상세 조회
    @RequestMapping("/userDetail.do")
    public ModelAndView userDetail(@RequestParam("userId") String userId) {
        ModelAndView mv = new ModelAndView();
        Users user = adminUserService.selectUserById(userId);
        mv.addObject("user", user);
        mv.setViewName("admin/userDetail");
        return mv;
    }

    // ✅ 사용자 수정 폼
    @RequestMapping("/userEdit.do")
    public ModelAndView editUserForm(@RequestParam("userId") String userId) {
        ModelAndView mv = new ModelAndView();
        Users user = adminUserService.selectUserById(userId);
        mv.addObject("user", user);
        mv.setViewName("admin/userEdit");
        return mv;
    }

    // ✅ 사용자 수정 처리
    @RequestMapping(value = "/updateUser.do", method = RequestMethod.POST)
    public String updateUser(Users user) {
        adminUserService.updateUser(user);
        return "redirect:/admin/userList.do";
    }
}
