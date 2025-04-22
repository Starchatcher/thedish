package com.thedish.user.service;

import com.thedish.user.model.vo.User;
import com.thedish.user.model.vo.PasswordChange;

public interface UserService {
    void registerUser(User user);
    User getUserById(String userId);
    User loginUser(String userId, String password);
    void changePassword(String userId, PasswordChange passwordChange);
    void withdrawUser(String userId);
    boolean sendVerificationCode(String email);
    boolean verifyCode(String email, String code);
    void saveTermsAgreement(String userId);
    boolean isUserIdDuplicate(String userId); // 아이디 중복 확인 메서드 추가
}