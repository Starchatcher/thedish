package com.thedish.users.controller;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

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

    // ✅ 로그인 기록 저장 (loginId → {ip, sessionId})
    private static final Map<String, LoginInfo> activeUsers = new ConcurrentHashMap<>();

    // ✅ 로그인 정보 저장용 내부 클래스
    private static class LoginInfo {
        private final String ip;
        private final String sessionId;

        public LoginInfo(String ip, String sessionId) {
            this.ip = ip;
            this.sessionId = sessionId;
        }

        public String getIp() {
            return ip;
        }

        public String getSessionId() {
            return sessionId;
        }
    }

    @RequestMapping("loginPage.do")
    public String moveLoginPage() {
        return "users/loginPage";
    }

    @RequestMapping("enrollPage.do")
    public String moveEnrollPage() {
        return "users/enrollPage";
    }

    // ✅ 로그인 처리 (중복 로그인 방지 포함)
    @RequestMapping(value = "login.do", method = RequestMethod.POST)
    public String loginMethod(Users users, HttpServletRequest request, HttpSession session, SessionStatus status, Model model) {
        logger.info("로그인 시도: " + users.getLoginId());
        Users loginUser = usersService.selectLogin(users);

        if (loginUser == null) {
            model.addAttribute("msg", "아이디가 존재하지 않습니다.");
            return "common/error";
        }

        String dbPw = loginUser.getPassword();
        boolean isBcrypt = dbPw.startsWith("$2a$") || dbPw.startsWith("$2b$") || dbPw.startsWith("$2y$");
        boolean match = isBcrypt
            ? bcryptPasswordEncoder.matches(users.getPassword(), dbPw)
            : users.getPassword().equals(dbPw);

        if (!match) {
            model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
            return "common/error";
        }

        if (!"ACTIVE".equals(loginUser.getStatus())) {
            model.addAttribute("msg", "탈퇴했거나 제한된 계정입니다. 관리자에게 문의하세요.");
            return "common/error";
        }

        // ✅ 중복 로그인 방지 로직
        String loginId = loginUser.getLoginId();
        String currentIp = request.getRemoteAddr();
        String currentSessionId = session.getId();

        LoginInfo existing = activeUsers.get(loginId);
        if (existing != null && (
                !existing.getIp().equals(currentIp) ||
                !existing.getSessionId().equals(currentSessionId))) {
            model.addAttribute("msg", "이미 다른 위치 또는 브라우저에서 로그인 중입니다.");
            return "common/error";
        }

        // 로그인 성공 처리
        activeUsers.put(loginId, new LoginInfo(currentIp, currentSessionId));
        session.setAttribute("loginUser", loginUser);

        if ("ADMIN".equalsIgnoreCase(loginUser.getRole())) {
            return "redirect:/admin/dashboard.do";
        }
        return "redirect:main.do";
    }

    // ✅ 로그아웃 시 로그인 기록 삭제
    @RequestMapping("logout.do")
    public String logoutMethod(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Users loginUser = (Users) session.getAttribute("loginUser");
            if (loginUser != null) {
                activeUsers.remove(loginUser.getLoginId());
            }
            session.invalidate();
            return "redirect:main.do";
        } else {
            model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
            return "common/error";
        }
    }

    @RequestMapping("myinfo.do")
    public String usersDetailMethod(@RequestParam("loginId") String loginId, Model model) {
        logger.info("myinfo.do : " + loginId);
        Users users = usersService.selectUsers(loginId);

        if (users != null) {
            model.addAttribute("users", users);
            return "users/infoPage";
        } else {
            model.addAttribute("message", loginId + " 에 대한 회원 정보 조회 실패!");
            return "common/error";
        }
    }

    @RequestMapping(value = "enroll.do", method = RequestMethod.POST)
    public String insertUser(Users user, Model model) {
        logger.info("enroll.do : " + user);

        if (user.getLoginId() == null || user.getLoginId().trim().isEmpty()) {
            user.setLoginId(user.getUserId());
        }

        if (user.getUserPwd() != null && !user.getUserPwd().isEmpty()) {
            String encPwd = bcryptPasswordEncoder.encode(user.getUserPwd());
            user.setPassword(encPwd);
        }

        int result = usersService.insertUser(user);
        return result > 0 ? "redirect:loginPage.do" : "common/error";
    }

    @RequestMapping(value = "updateUser.do", method = RequestMethod.POST)
    public String updateUser(Users user, Model model, HttpSession session) {
        logger.info("updateUser.do : " + user);

        String encPwd = bcryptPasswordEncoder.encode(user.getPassword());
        user.setPassword(encPwd);

        int result = usersService.updateUser(user);
        if (result > 0) {
            session.setAttribute("loginUser", usersService.selectUsers(user.getLoginId()));
            return "redirect:myinfo.do?loginId=" + user.getLoginId();
        } else {
            model.addAttribute("message", "회원정보 수정 실패");
            return "common/error";
        }
    }

    @RequestMapping("confirmDelete.do")
    public String confirmDelete(@RequestParam("loginId") String loginId, Model model) {
        model.addAttribute("loginId", loginId);
        return "users/deleteConfirmationPage";
    }

    @RequestMapping(value = "deleteUser.do", method = RequestMethod.POST)
    public String deleteUser(@RequestParam("loginId") String loginId, HttpSession session, Model model) {
        logger.info("Attempting to delete user with loginId: " + loginId);
        int result = usersService.deleteUsers(loginId);

        if (result > 0) {
            if (session != null && session.getAttribute("loginUser") != null) {
                activeUsers.remove(loginId);
                session.invalidate();
            }
            return "redirect:loginPage.do";
        } else {
            model.addAttribute("message", "회원 탈퇴 실패");
            return "common/error";
        }
    }

    @ResponseBody
    @RequestMapping(value = "idchk.do", method = RequestMethod.POST)
    public String checkUserId(@RequestParam("userId") String userId) {
        return usersService.selectCheckId(userId) == 0 ? "ok" : "dup";
    }

    @ResponseBody
    @RequestMapping(value = "nickNamechk.do", method = RequestMethod.POST)
    public String checknickName(@RequestParam("nickName") String nickName) {
        return usersService.selectChecknickName(nickName) == 0 ? "ok" : "dup";
    }

    @ResponseBody
    @RequestMapping("encodeAdminPwd.do")
    public String encodeAdminPassword() {
        return "암호화된 관리자 비밀번호: " + bcryptPasswordEncoder.encode("admin1234");
    }
}
