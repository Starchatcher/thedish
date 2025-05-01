package com.thedish.users.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thedish.users.model.service.UsersService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsersController {
    private static final Logger logger = LoggerFactory.getLogger(UsersController.class);

    @Autowired
    private UsersService usersService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

    @RequestMapping("loginPage.do")
    public String moveLoginPage() {
        return "users/loginPage";
    }

    @RequestMapping("enrollPage.do")
    public String moveEnrollPage() {
        return "users/enrollPage";
    }

    // 로그인 처리
    @RequestMapping(value = "login.do", method = RequestMethod.POST)
    public String loginMethod(Users users, HttpSession session, SessionStatus status, Model model) {
        logger.info("login.do : " + users);
        Users loginUser = usersService.selectUsers(users.getLoginId());

        if (loginUser != null && bcryptPasswordEncoder.matches(users.getPassword(), loginUser.getPassword())) {
            session.setAttribute("loginUser", loginUser);
            status.setComplete();
            return "common/main";
        } else {
            model.addAttribute("message", "로그인 실패! 아이디나 암호를 다시 확인하세요. 또는 로그인 제한 회원입니다. 관리자에게 문의하세요.");
            return "common/error";
        }
    }

    // 회원가입 처리
    @RequestMapping(value = "enroll.do", method = RequestMethod.POST)
    public String insertUser(Users user, Model model) {
        logger.info("enroll.do : " + user);

        // loginId가 비어 있다면 userId 값을 loginId로 설정
        if (user.getLoginId() == null || user.getLoginId().trim().isEmpty()) {
            user.setLoginId(user.getUserId());
        }

        // 비밀번호 암호화
        if (user.getUserPwd() != null && !user.getUserPwd().isEmpty()) {
            String encPwd = bcryptPasswordEncoder.encode(user.getUserPwd());
            user.setPassword(encPwd);
        }

        int result = usersService.insertUser(user);

        if (result > 0) {
            return "redirect:loginPage.do"; // 회원가입 후 로그인 페이지로
        } else {
            model.addAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
            return "common/error";
        }
    }

    // 로그아웃 처리
    @RequestMapping("logout.do")
    public String logoutMethod(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            return "common/main";
        } else {
            model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
            return "common/error";
        }
    }

    // 내 정보 조회
    @RequestMapping("myinfo.do")
    public String usersDetailMethod(@RequestParam("loginId") String loginId, Model model) {
        logger.info("myinfo.do : " + loginId);
        Users users = usersService.selectUsers(loginId);

        if (users != null) {
            model.addAttribute("users", users);
            return "users/infoPage";
        } else {
            model.addAttribute("message", loginId + " 에 대한 회원 정보 조회 실패! 아이디를 다시 확인하세요.");
            return "common/error";
        }
    }

    // 아이디 중복 확인
    @ResponseBody
    @RequestMapping(value = "idchk.do", method = RequestMethod.POST)
    public String checkUserId(@RequestParam("userId") String userId) {
        int result = usersService.selectCheckId(userId);
        return (result == 0) ? "ok" : "dup";
    }

    // 닉네임 중복 확인
    @ResponseBody
    @RequestMapping(value = "nicknamechk.do", method = RequestMethod.POST)
    public String checkNickname(@RequestParam("nickname") String nickname) {
        int result = usersService.selectCheckNickname(nickname);
        return (result == 0) ? "ok" : "dup";
    }
} 
