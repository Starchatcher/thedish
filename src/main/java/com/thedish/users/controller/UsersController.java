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
import org.springframework.web.servlet.ModelAndView;

import com.thedish.common.mail.MailService;
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

    @RequestMapping("terms.do")
    public String moveTermsPage() {
        return "users/terms";
    }

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

    @RequestMapping("myPage.do")
    public String showMyPage(HttpSession session, Model model) {
        Users loginUser = (Users) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:loginPage.do";
        model.addAttribute("users", loginUser);
        return "users/infoPage";
    }

    @RequestMapping("changePassword.do")
    public String showChangePasswordPage() {
        return "users/changePassword";
    }

    @RequestMapping(value = "updatePassword.do", method = RequestMethod.POST)
    public ModelAndView updatePassword(@RequestParam("currentPassword") String currentPassword,
                                       @RequestParam("newPassword") String newPassword,
                                       HttpSession session,
                                       ModelAndView mv) {
        Users loginUser = (Users) session.getAttribute("loginUser");
        if (loginUser != null && bcryptPasswordEncoder.matches(currentPassword, loginUser.getPassword())) {
            String encNewPwd = bcryptPasswordEncoder.encode(newPassword);
            loginUser.setPassword(encNewPwd);
            int result = usersService.updatePassword(loginUser);
            if (result > 0) {
                mv.addObject("msg", "비밀번호가 변경되었습니다.");
                session.setAttribute("loginUser", loginUser);
                mv.setViewName("users/passwordSuccess");
                return mv;
            } else {
                mv.addObject("msg", "비밀번호 변경 실패");
            }
        } else {
            mv.addObject("msg", "현재 비밀번호가 일치하지 않습니다.");
        }
        mv.setViewName("users/changePassword");
        return mv;
    }

    @RequestMapping("enrollPage.do")
    public String moveEnrollPage(@RequestParam(value = "enrollSuccess", required = false) String enrollSuccess, Model model) {
        if ("true".equals(enrollSuccess)) {
            model.addAttribute("enrollSuccess", true);
        }
        return "users/enrollPage";
    }

    @RequestMapping(value = "enroll.do", method = RequestMethod.POST)
    public String insertUser(Users user, Model model) {
        logger.info("enroll.do : " + user);

        if (user.getLoginId() == null || user.getLoginId().trim().isEmpty()) {
            user.setLoginId(user.getUserId());
        }

        // ✅ 중복 아이디 및 닉네임 체크
        if (usersService.selectCheckId(user.getLoginId()) > 0) {
            model.addAttribute("msg", "이미 사용 중인 아이디입니다. 다른 아이디를 입력해주세요.");
            return "common/error";
        }

        if (usersService.selectChecknickName(user.getNickName()) > 0) {
            model.addAttribute("msg", "이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해주세요.");
            return "common/error";
        }

        // ✅ 비밀번호 유효성 검사
        String pw = user.getPassword();
        if (pw == null || pw.length() < 8 || !pw.matches("^(?=.*[a-zA-Z])(?=.*\\d).+$")) {
            model.addAttribute("msg", "비밀번호는 영문자+숫자 조합 8자 이상이어야 합니다.");
            return "common/error";
        }

        String encPwd = bcryptPasswordEncoder.encode(pw);
        user.setPassword(encPwd);

        int result = usersService.insertUser(user);
        return (result > 0) ? "users/enrollSuccess" : "common/error";
    }

    @RequestMapping("myinfo.do")
    public String usersDetailMethod(@RequestParam("loginId") String loginId, Model model) {
        Users users = usersService.selectUsers(loginId);
        if (users != null) {
            model.addAttribute("users", users);
            return "users/infoPage";
        } else {
            model.addAttribute("message", loginId + " 에 대한 회원 정보 조회 실패!");
            return "common/error";
        }
    }

    @RequestMapping(value = "updateUser.do", method = RequestMethod.POST)
    public String updateUser(Users user, Model model, HttpSession session) {
        String encPwd = bcryptPasswordEncoder.encode(user.getPassword());
        user.setPassword(encPwd);
        int result = usersService.updateUser(user);
        if (result > 0) {
            session.setAttribute("loginUser", usersService.selectUsers(user.getLoginId()));
            return "redirect:myinfo.do?loginId=" + user.getLoginId();
        } else {
            model.addAttribute("message", "회원정보 수정에 실패했습니다.");
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
        int result = usersService.deactivateUser(loginId);
        if (result > 0) {
            if (session != null && session.getAttribute("loginUser") != null) {
                session.invalidate();
            }
            return "redirect:loginPage.do";
        } else {
            model.addAttribute("message", "회원 탈퇴에 실패했습니다.");
            return "common/error";
        }
    }

    @RequestMapping("/findPassword.do")
    public String showFindPasswordPage() {
        return "users/findPassword";
    }

    @PostMapping("/sendCode.do")
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

    @PostMapping("/verifyCode.do")
    public ModelAndView verifyCode(@RequestParam("code") String code, HttpSession session, ModelAndView mv) {
        String sessionCode = (String) session.getAttribute("verifyCode");
        if (code.equals(sessionCode)) {
            mv.setViewName("users/resetPassword");
        } else {
            mv.addObject("msg", "인증번호가 올바르지 않습니다.");
            mv.setViewName("users/verifyCode");
        }
        return mv;
    }

    @PostMapping("/resetPassword.do")
    public ModelAndView resetPassword(@RequestParam("newPassword") String newPassword, HttpSession session, ModelAndView mv) {
        String loginId = (String) session.getAttribute("loginIdForReset");
        int result = usersService.resetPassword(loginId, newPassword);
        if (result > 0) {
            mv.addObject("msg", "비밀번호가 성공적으로 변경되었습니다.");
            mv.setViewName("users/passwordSuccess");
        } else {
            mv.addObject("msg", "비밀번호 변경 실패. 다시 시도해주세요.");
            mv.setViewName("users/resetPassword");
        }
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "idchk.do", method = RequestMethod.POST)
    public String checkUserId(@RequestParam("userId") String userId) {
        int result = usersService.selectCheckId(userId);
        return (result == 0) ? "ok" : "dup";
    }

    @ResponseBody
    @RequestMapping(value = "nickNamechk.do", method = RequestMethod.POST)
    public String checknickName(@RequestParam("nickName") String nickName) {
        int result = usersService.selectChecknickName(nickName);
        return (result == 0) ? "ok" : "dup";
    }

    @ResponseBody
    @RequestMapping("encodeAdminPwd.do")
    public String encodeAdminPassword() {
        String rawPwd = "admin1234";
        return "암호화된 관리자 비밀번호: " + bcryptPasswordEncoder.encode(rawPwd);
    }
}
