package com.thedish.users.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

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
    
    @RequestMapping("myPage.do")
    public String showMyPage(HttpSession session, Model model) {
        Users loginUser = (Users) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:loginPage.do";
        }

        model.addAttribute("users", loginUser);
        return "users/infoPage"; // ← 바로 이 JSP로 돌아오게끔!
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
        if (loginUser != null && bcryptPasswordEncoder.matches(currentPassword, loginUser.getUserPwd())) {
            String encNewPwd = bcryptPasswordEncoder.encode(newPassword);
            loginUser.setUserPwd(encNewPwd);
            int result = usersService.updatePassword(loginUser);
            if (result > 0) {
                mv.addObject("msg", "비밀번호가 변경되었습니다.");
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
    public String moveEnrollPage() {
        return "users/enrollPage";
    }

    @RequestMapping(value = "login.do", method = RequestMethod.POST)
    public String loginMethod(Users users, HttpSession session, SessionStatus status, Model model) {
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

        session.setAttribute("loginUser", loginUser);

        if ("ADMIN".equalsIgnoreCase(loginUser.getRole())) {
            return "redirect:/admin/dashboard.do";
        }
        return "redirect:main.do";
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

        if (result > 0) {
            return "redirect:loginPage.do";
        } else {
            model.addAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
            return "common/error";
        }
    }

    @RequestMapping("logout.do")
    public String logoutMethod(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session != null) {
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
            model.addAttribute("message", loginId + " 에 대한 회원 정보 조회 실패! 아이디를 다시 확인하세요.");
            return "common/error";
        }
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
        logger.info("Attempting to delete user with loginId: " + loginId);

        int result = usersService.deleteUsers(loginId);

        if (result > 0) {
            logger.info("User deletion successful for loginId: " + loginId);
            if (session != null && session.getAttribute("loginUser") != null) {
                session.invalidate();
            }
            return "redirect:loginPage.do";
        } else {
            logger.error("Failed to delete user with loginId: " + loginId);
            model.addAttribute("message", "회원 탈퇴에 실패했습니다. 관리자에게 문의하세요.");
            return "common/error";
        }
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
        String encodedPwd = bcryptPasswordEncoder.encode(rawPwd);
        return "암호화된 관리자 비밀번호: " + encodedPwd;
    }
}
