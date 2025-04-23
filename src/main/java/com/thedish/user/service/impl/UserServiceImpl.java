package com.thedish.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thedish.common.EmailUtil;
import com.thedish.common.PasswordUtil;
import com.thedish.user.dao.UserDAO;
import com.thedish.user.model.vo.PasswordChange;
import com.thedish.user.model.vo.User;
import com.thedish.user.service.UserService;

import jakarta.servlet.http.HttpSession;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private EmailUtil emailUtil;
    
    @Autowired
    private PasswordUtil passwordUtil;
    
    @Override
    public void registerUser(User user) {
        // 비밀번호 암호화
        String encodedPassword = passwordUtil.encode(user.getPassword());
        user.setPassword(encodedPassword);
        
        userDAO.insertUser(user);
    }
    
    @Override
    public User getUserById(String userId) {
        return userDAO.selectUserById(userId);
    }
    
    @Override
    public User loginUser(String userId, String password) {
        // 사용자 조회
        User user = userDAO.selectUserById(userId);
        
        // 사용자가 존재하고 비밀번호가 일치하는지 확인
        if (user != null && passwordUtil.matches(password, user.getPassword())) {
            return user;
        }
        
        return null;
    }
    
    @Override
    public void changePassword(String userId, PasswordChange passwordChange) {
        User user = userDAO.selectUserById(userId);
        
        // 현재 비밀번호 확인
        if (user != null && passwordUtil.matches(passwordChange.getCurrentPassword(), user.getPassword())) {
            // 새 비밀번호 암호화
            String encodedNewPassword = passwordUtil.encode(passwordChange.getNewPassword());
            userDAO.updatePassword(userId, encodedNewPassword);
        } else {
            throw new IllegalArgumentException("현재 비밀번호가 일치하지 않습니다.");
        }
    }

	/*
	 * @Controller
	 * 
	 * @RequestMapping("/user") public class UserController {
	 * 
	 * @Autowired private UserService userService;
	 * 
	 * // 로그인 페이지
	 * 
	 * @GetMapping("/login") public String loginForm() { return "user/login"; }
	 * 
	 * // 로그인 처리
	 * 
	 * @PostMapping("/login") public String login(String userId, String password,
	 * boolean remember, Model model, HttpSession session) { User user =
	 * userService.loginUser(userId, password);
	 * 
	 * if (user != null) { // 로그인 성공 session.setAttribute("user", user);
	 * 
	 * // 로그인 상태 유지 설정 if (remember) { session.setMaxInactiveInterval(60 * 60 * 24 *
	 * 7); // 7일 }
	 * 
	 * return "redirect:/"; // 메인 페이지로 리다이렉트 } else { // 로그인 실패
	 * model.addAttribute("errorMsg", "로그인 실패! 아이디/비밀번호 확인"); return "user/login"; }
	 * }
	 * 
	 * // 로그아웃
	 * 
	 * @GetMapping("/logout") public String logout(HttpSession session) {
	 * session.invalidate(); return "redirect:/user/login"; }
	 * 
	 * // 회원가입 페이지
	 * 
	 * @GetMapping("/signup") public String signupForm() { return "user/signup"; }
	 * 
	 * // 회원가입 처리
	 * 
	 * @PostMapping("/signup") public String signup(User user, HttpSession session)
	 * { userService.registerUser(user);
	 * 
	 * // 세션에 사용자 정보 저장 (환영 페이지에서 사용) session.setAttribute("user", user);
	 * 
	 * return "redirect:/user/terms"; }
	 * 
	 * // 이용약관 페이지
	 * 
	 * @GetMapping("/terms") public String termsForm() { return "user/terms"; }
	 * 
	 * // 이용약관 동의 처리
	 * 
	 * @PostMapping("/terms") public String termsAgree(HttpSession session) { // 약관
	 * 동의 처리 로직 User user = (User) session.getAttribute("user"); if (user != null) {
	 * userService.saveTermsAgreement(user.getUserId()); }
	 * 
	 * return "redirect:/user/welcome"; }
	 * 
	 * // 환영 페이지
	 * 
	 * @GetMapping("/welcome") public String welcome(Model model, HttpSession
	 * session) { User user = (User) session.getAttribute("user");
	 * model.addAttribute("user", user); return "user/welcome"; }
	 * 
	 * 
	 * }
	 */
    
    
    @Override
    public void saveTermsAgreement(String userId) {
        userDAO.insertTermsAgreement(userId);
    }
    
   
    
    @Override
    public void withdrawUser(String userId) {
        userDAO.updateUserStatus(userId, "WITHDRAWN");
    }
    
    @Override
    public boolean sendVerificationCode(String email) {
        // 인증 코드 생성 및 저장
        String code = generateVerificationCode();
        userDAO.saveVerificationCode(email, code);
        
        // 이메일 발송
        String subject = "The Dish 이메일 인증 코드";
        String content = "인증 코드: " + code;
        return emailUtil.sendEmail(email, subject, content);
    }
    
    @Override
    public boolean verifyCode(String email, String code) {
        String savedCode = userDAO.getVerificationCode(email);
        return savedCode != null && savedCode.equals(code);
    }
    
    private String generateVerificationCode() {
        // 6자리 랜덤 숫자 생성
        return String.format("%06d", (int)(Math.random() * 1000000));
    }

    @Override
    public boolean isUserIdDuplicate(String userId) {
        User user = userDAO.selectUserById(userId);
        return user != null;
    }
}