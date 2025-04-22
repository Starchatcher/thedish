package com.thedish.common;

import java.util.regex.Pattern;

public class PasswordPolicy {
    
    // 비밀번호 정책: 영문, 숫자, 특수문자 조합 8-20자
    private static final Pattern PASSWORD_PATTERN = 
        Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,20}$");
    
    /**
     * 비밀번호가 정책에 부합하는지 확인합니다.
     * 
     * @param password 확인할 비밀번호
     * @return 정책 부합 여부
     */
    public static boolean isValid(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }
    
    /**
     * 비밀번호 정책 설명을 반환합니다.
     * 
     * @return 정책 설명
     */
    public static String getDescription() {
        return "비밀번호는 영문, 숫자, 특수문자 조합 8-20자로 입력해주세요.";
    }
}