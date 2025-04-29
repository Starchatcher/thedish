package com.thedish.user.dao;

import com.thedish.user.model.vo.User;

public interface UserDAO {
    void insertUser(User user);
    User selectUserById(String userId);
    void updatePassword(String userId, String newPassword);
    void updateUserStatus(String userId, String status);
    void saveVerificationCode(String email, String code);
    String getVerificationCode(String email);
    void insertTermsAgreement(String userId); // 약관 동의 저장 메서드 추가
}