package com.thedish.common.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendVerificationCode(String email, String code) {
        System.out.println("메일 전송 시도 중: " + email + ", 인증코드: " + code); // ✅ 이 자리가 정답!
        
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("[The Dish] 비밀번호 재설정 인증번호입니다.");
        message.setText("인증번호: " + code + "\n5분 안에 입력해주세요.");
        mailSender.send(message);
    }
}
