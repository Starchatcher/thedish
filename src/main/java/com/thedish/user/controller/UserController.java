package com.thedish.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thedish.common.PasswordPolicy;
import com.thedish.user.model.vo.PasswordChange;
import com.thedish.user.model.vo.User;
import com.thedish.user.service.UsersService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UsersService userService;
    
    // 회원가입 페이지
    @GetMapping("/signup")
    public String signupForm() {
        return "user/signup";
    }
    
    // 회원가입 처리
    @PostMapping("/signup")
    public String signup(User user) {
        userService.registerUser(user);
        return "redirect:/user/terms";
    }
    
    // 이용약관 페이지
    @GetMapping("/terms")
    public String termsForm() {
        return "user/terms";
    }
    
    // 이용약관 동의 처리
    @PostMapping("/terms")
    public String termsAgree(HttpSession session) {
        // 약관 동의 처리 로직
        return "redirect:/user/welcome";
    }
    
    // 환영 페이지
    @GetMapping("/welcome")
    public String welcome(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        return "user/welcome";
    }
    
    // 비밀번호 변경 페이지
    @GetMapping("/change-password")
    public String changePasswordForm() {
        return "user/change-password";
    }
    
    // 비밀번호 변경 처리
    @PostMapping("/change-password")
    public String changePassword(PasswordChange passwordChange, HttpSession session) {
        User user = (User) session.getAttribute("user");
        userService.changePassword(user.getUserId(), passwordChange);
        return "redirect:/user/mypage";
    }
    
    // 회원 탈퇴 페이지
    @GetMapping("/withdrawal")
    public String withdrawalForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        return "user/withdrawal";
    }
    
    // 회원 탈퇴 처리
    @PostMapping("/withdrawal")
    public String withdrawal(HttpSession session) {
        User user = (User) session.getAttribute("user");
        userService.withdrawUser(user.getUserId());
        session.invalidate();
        return "redirect:/user/withdrawal-complete";
    }
    
    // 회원 탈퇴 완료 페이지
    @GetMapping("/withdrawal-complete")
    public String withdrawalComplete() {
        return "user/withdrawal-complete";
    }
    
    // 이메일 인증 코드 발송
    @PostMapping("/send-verification")
    @ResponseBody
    public String sendVerificationCode(String email) {
        boolean success = userService.sendVerificationCode(email);
        return "{\"success\": " + success + "}";
    }
    
    // 인증 코드 확인
    @PostMapping("/verify-code")
    @ResponseBody
    public String verifyCode(String email, String code) {
        boolean success = userService.verifyCode(email, code);
        return "{\"success\": " + success + "}";
    }

    /**
     * 아이디 중복 확인
     * 
     * @param userId 확인할 아이디
     * @return 중복 여부를 JSON 형태로 반환
     */
    @PostMapping("/check-id")
    @ResponseBody
    public String checkIdDuplicate(String userId) {
        boolean isDuplicate = userService.isUserIdDuplicate(userId);
        return "{\"isDuplicate\": " + isDuplicate + "}";
    }

    @PostMapping("/signup1")
    public String signup(User user, String confirmPassword, Model model, HttpSession session) {
    // 비밀번호 정책 검사
    if (!PasswordPolicy.isValid(user.getPassword())) {
        model.addAttribute("user", user);
        model.addAttribute("errorMsg", PasswordPolicy.getDescription());
        return "user/signup";
    }
    
    // 비밀번호 일치 여부 검사
    if (!user.getPassword().equals(confirmPassword)) {
        model.addAttribute("user", user);
        model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
        return "user/signup";
    }
    
    userService.registerUser(user);
    
    // 세션에 사용자 정보 저장 (환영 페이지에서 사용)
    session.setAttribute("user", user);
    
        return "redirect:/user/terms";
    }
}