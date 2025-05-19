package com.thedish.users.controller;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import com.thedish.common.mail.MailService;
import com.thedish.users.model.service.UsersService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsersController {

    private static final Logger logger = LoggerFactory.getLogger(UsersController.class);

    @Value("${kakao.clientId}")
    private String clientId;

    @Value("${kakao.redirectUri}")
    private String redirectUri;

    @Autowired
    private UsersService usersService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

    @Autowired
    private MailService mailService;

    private static final Map<String, LoginInfo> activeUsers = new ConcurrentHashMap<>();

    private static class LoginInfo {
        private final String ip;
        private final String sessionId;

        public LoginInfo(String ip, String sessionId) {
            this.ip = ip;
            this.sessionId = sessionId;
        }

        public String getIp() { return ip; }
        public String getSessionId() { return sessionId; }
    }

    @RequestMapping("loginPage.do")
    public String moveLoginPage() {
        return "users/loginPage";
    }

    @RequestMapping("enrollterms.do")
    public String moveTermsPage() {
        return "users/enrollterms";
    }

    @RequestMapping(value = "login.do", method = RequestMethod.POST)
    public String loginMethod(Users users,
                              HttpServletRequest request,
                              HttpServletResponse response,
                              HttpSession session,
                              SessionStatus status,
                              Model model,
                              @RequestParam(value = "remember", required = false) String remember) {

        logger.info("로그인 시도: " + users.getLoginId());
        Users loginUser = usersService.selectLogin(users);

        if (loginUser == null) {
            model.addAttribute("msg", "아이디가 존재하지 않습니다.");
            return "common/error";
        }

        String dbPw = loginUser.getPassword();
        boolean isBcrypt = dbPw.startsWith("$2a$") || dbPw.startsWith("$2b$") || dbPw.startsWith("$2y$");
        boolean match = isBcrypt ? bcryptPasswordEncoder.matches(users.getPassword(), dbPw) : users.getPassword().equals(dbPw);

        if (!match) {
            model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
            return "common/error";
        }

        if (!"ACTIVE".equals(loginUser.getStatus())) {
            model.addAttribute("msg", "탈퇴했거나 제한된 계정입니다. 관리자에게 문의하세요.");
            return "common/error";
        }

        String loginId = loginUser.getLoginId();
        String currentIp = request.getRemoteAddr();
        String currentSessionId = session.getId();

        LoginInfo existing = activeUsers.get(loginId);
        if (existing != null && (!existing.getIp().equals(currentIp) || !existing.getSessionId().equals(currentSessionId))) {
            model.addAttribute("msg", "이미 다른 위치 또는 브라우저에서 로그인 중입니다.");
            return "common/error";
        }

        activeUsers.put(loginId, new LoginInfo(currentIp, currentSessionId));
        session.setAttribute("loginUser", loginUser);

        if ("on".equals(remember)) {
            Cookie rememberCookie = new Cookie("rememberId", loginUser.getLoginId());
            rememberCookie.setMaxAge(7 * 24 * 60 * 60);
            rememberCookie.setPath(request.getContextPath());
            response.addCookie(rememberCookie);
        } else {
            Cookie rememberCookie = new Cookie("rememberId", null);
            rememberCookie.setMaxAge(0);
            rememberCookie.setPath(request.getContextPath());
            response.addCookie(rememberCookie);
        }

        return "ADMIN".equalsIgnoreCase(loginUser.getRole()) ? "redirect:/admin/dashboard.do" : "redirect:main.do";
    }

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

    // 비밀번호 변경 화면 진입
    @RequestMapping("changePassword.do")
    public String showChangePasswordPage() {
        return "users/changePassword";
    }

    // 비밀번호 변경 처리 (세션에서 loginId 꺼내는 방식)
    @RequestMapping(value = "updatePassword.do", method = RequestMethod.POST)
    public String updatePassword(HttpSession session,
                                 @RequestParam("newPassword") String newPassword,
                                 Model model) {

        Users loginUser = (Users) session.getAttribute("loginUser");

        if (loginUser == null) {
            model.addAttribute("msg", "세션이 만료되었습니다. 다시 로그인 해주세요.");
            return "common/error";
        }

        String loginId = loginUser.getLoginId();
        String encPwd = bcryptPasswordEncoder.encode(newPassword);
        int result = usersService.updatePassword(loginId, encPwd);

        if (result > 0) {
            return "users/passwordSuccess";
        } else {
            model.addAttribute("msg", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
            return "common/error";
        }
    }

    @RequestMapping("confirmDelete.do")
    public String confirmDelete(@RequestParam("loginId") String loginId, Model model) {
        model.addAttribute("loginId", loginId);
        return "users/deleteConfirmationPage";
    }

    @RequestMapping("enrollPage.do")
    public String moveEnrollPage() {
        return "users/enrollPage";
    }

    @ResponseBody
    @RequestMapping(value = "idchk.do", method = RequestMethod.POST)
    public String checkUserId(@RequestParam("userId") String userId) {
        int count = usersService.selectCheckId(userId);
        return (count == 0) ? "ok" : "duplicated";
    }


    @RequestMapping("/sendCode.do")
    public ModelAndView sendVerificationCode(@RequestParam("loginId") String loginId,
                                             @RequestParam("email") String email,
                                             HttpSession session,
                                             ModelAndView mv) {
        Users user = usersService.findByLoginIdAndEmail(loginId, email);
        if (user != null) {
            String code = String.valueOf((int)(Math.random() * 900000) + 100000);
            session.setAttribute("verifyCode", code);
            session.setAttribute("loginIdForReset", loginId);
            mailService.sendVerificationCode(email, code);
            mv.setViewName("users/verifyCode");
        } else {
            mv.addObject("msg", "아이디와 이메일이 일치하지 않습니다.");
            mv.setViewName("users/findPassword");
        }
        return mv;
    }

    @RequestMapping("/verifyCode.do")
    public ModelAndView verifyCode(@RequestParam("code") String code, 
    		HttpSession session, ModelAndView mv) {
        String sessionCode = (String) session.getAttribute("verifyCode");
        if (code.equals(sessionCode)) {
            mv.setViewName("users/resetPassword");
        } else {
            mv.addObject("msg", "인증번호가 올바르지 않습니다.");
            mv.setViewName("users/verifyCode");
        }
        return mv;
    }

    @RequestMapping("/resetPassword.do")
    public ModelAndView resetPassword(@RequestParam("newPassword") 
    String newPassword, HttpSession session, ModelAndView mv) {
        String loginId = (String) session.getAttribute("loginIdForReset");
        int result = usersService.resetPassword(loginId, newPassword);

        if (result > 0) {
            return "redirect:enrollPage.do?enrollSuccess=true";
        } else {
            model.addAttribute("msg", "회원가입에 실패했습니다. 다시 시도해주세요.");
            return "common/error";
        }
    }

    @RequestMapping("myPage.do")
    public String showMyPage(HttpSession session, Model model) {
        Users loginUser = (Users) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:loginPage.do";

        String loginId = loginUser.getLoginId();


    @ResponseBody
    @RequestMapping(value = "encodeAdminPwd.do", method = RequestMethod.POST)
    public String encodeAdminPassword() {
        String rawPwd = "admin";
        String encodedPwd = bcryptPasswordEncoder.encode(rawPwd);
        return "암호화된 관리자 비밀번호: " + encodedPwd;
    }


        return "users/infoPage";
    }
}
