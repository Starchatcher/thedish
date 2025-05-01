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

    // 회원 정보 수정 처리
    @RequestMapping(value = "updateUser.do", method = RequestMethod.POST)
    public String updateUser(Users user, Model model, HttpSession session) {
        logger.info("updateUser.do : " + user);

        String encPwd = bcryptPasswordEncoder.encode(user.getPassword());
        user.setPassword(encPwd);

        int result = usersService.updateUser(user);  // 사용자 정보 수정

        if (result > 0) {
            session.setAttribute("loginUser", usersService.selectUsers(user.getLoginId()));  // 수정된 정보로 세션 업데이트
            return "redirect:myinfo.do?loginId=" + user.getLoginId();  // 내 정보 페이지로 리다이렉트
        } else {
            model.addAttribute("message", "회원정보 수정에 실패했습니다.");
            return "common/error";
        }
    }

    // 회원 탈퇴 페이지로 이동 (탈퇴 확인 페이지로 리디렉션)
    @RequestMapping("confirmDelete.do")
    public String confirmDelete(@RequestParam("loginId") String loginId, Model model) {
        model.addAttribute("loginId", loginId);
        return "users/deleteConfirmationPage";  // 탈퇴 확인 페이지로 리디렉션
    }

    // 회원 탈퇴 처리
    @RequestMapping(value = "deleteUser.do", method = RequestMethod.POST)
    public String deleteUser(@RequestParam("loginId") String loginId, HttpSession session, Model model) {
        logger.info("Attempting to delete user with loginId: " + loginId); // 로그 추가

        // 회원 탈퇴 처리
        int result = usersService.deleteUsers(loginId);

        if (result > 0) {
            logger.info("User deletion successful for loginId: " + loginId); // 성공 로그 추가
            // 세션이 존재하는 경우에만 invalidate 호출
            if (session != null && session.getAttribute("loginUser") != null) {
                session.invalidate();
            }
            return "redirect:loginPage.do";  // 메인 페이지로 리다이렉트
        } else {
            logger.error("Failed to delete user with loginId: " + loginId); // 실패 로그 추가
            model.addAttribute("message", "회원 탈퇴에 실패했습니다. 관리자에게 문의하세요.");
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
    @RequestMapping(value = "nickNamechk.do", method = RequestMethod.POST)
    public String checknickName(@RequestParam("nickName") String nickName) {
        int result = usersService.selectChecknickName(nickName);  // 메서드 이름 및 필드 일치
        return (result == 0) ? "ok" : "dup";
    }
}
