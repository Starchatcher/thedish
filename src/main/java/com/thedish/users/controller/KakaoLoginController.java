package com.thedish.users.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thedish.users.model.service.UsersService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class KakaoLoginController {

    // 카카오 REST API 키와 리다이렉트 URI (환경에 맞게 수정 필요)
	private final String clientId = "f658a389331286bdf55a803fc040f507";
	private final String redirectUri = "http://localhost:8080/thedish/oauth/kakao.do";

    @Autowired
    private UsersService usersService; // 사용자 정보를 DB에서 관리하는 서비스 (가정)

    // 1. 카카오 로그인 요청 URL로 리다이렉트
    @RequestMapping("kakaoLogin.do")
    public String redirectToKakao(@RequestParam(value = "mode", required = false) String mode) throws UnsupportedEncodingException {
        String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?" +
                "client_id=" + clientId +
                "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8") +
                "&response_type=code";
        if (mode != null) {
            kakaoUrl += "&state=" + mode; // mode를 state로 전달
        }
        return "redirect:" + kakaoUrl;
    }

    // 2. 카카오로부터 인가 코드 받아 처리
    @RequestMapping("/oauth/kakao.do")
    public String kakaoCallback(@RequestParam("code") String code,
                                @RequestParam(value = "state", required = false) String mode,
                                HttpSession session, Model model) throws Exception {

        // 1단계: 액세스 토큰 요청
        String tokenRequestUrl = "https://kauth.kakao.com/oauth/token";
        String tokenParams = "grant_type=authorization_code" +
                "&client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&code=" + code;

        String accessToken = "";
        URL url = new URL(tokenRequestUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
        bw.write(tokenParams);
        bw.flush();
        bw.close();

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String line, result = "";
        while ((line = br.readLine()) != null) {
            result += line;
        }
        JSONObject tokenJson = new JSONObject(result);
        accessToken = tokenJson.getString("access_token");
        br.close();

        // 2단계: 사용자 정보 요청
        URL meUrl = new URL("https://kapi.kakao.com/v2/user/me");
        HttpURLConnection meConn = (HttpURLConnection) meUrl.openConnection();
        meConn.setRequestMethod("GET");
        meConn.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader meBr = new BufferedReader(new InputStreamReader(meConn.getInputStream()));
        String meResult = "", meLine;
        while ((meLine = meBr.readLine()) != null) {
            meResult += meLine;
        }
        JSONObject meJson = new JSONObject(meResult);
        long kakaoId = meJson.getLong("id");

        String nickname = "카카오사용자";
        if (meJson.has("properties")) {
            JSONObject properties = meJson.getJSONObject("properties");
            if (properties.has("nickname")) {
                nickname = properties.getString("nickname");
            }
        }

        String loginId = "kakao_" + kakaoId;
        String password = "SNS_USER"; // 더미 비밀번호
        String email = loginId + "@kakao.com";

        // 3단계: 회원 존재 여부 확인 및 처리
        Users existingUser = usersService.selectUsers(loginId);

        if ("register".equals(mode)) {
            if (existingUser != null) {
                // 이미 가입된 계정이면 회원가입 페이지로 오류와 함께 리다이렉트
            	String errorMessage = URLEncoder.encode("이미 등록된 카카오 계정입니다.", "UTF-8");
            	return "redirect:/enrollPage.do?error=" + errorMessage;
            } else {
                // 새 사용자 생성
                Users newUser = new Users();
                newUser.setLoginId(loginId);
                newUser.setPassword(password);
                newUser.setNickName(nickname);
                newUser.setUserName("카카오회원");
                newUser.setEmail(email);
                newUser.setProvider("kakao");
                newUser.setStatus("ACTIVE");
                newUser.setRole("USER");

                usersService.insertUser(newUser);
                existingUser = newUser;
            }
        } else if (existingUser == null) {
            // 로그인 모드인데 사용자가 없으면 회원가입 페이지로 리다이렉트
            return "redirect:/enrollPage.do?error=가입되지 않은 계정입니다. 회원가입을 진행해주세요.";
        }

        // 4단계: 세션 로그인 처리
        session.setAttribute("loginUser", existingUser);
        return "redirect:/main.do";
    }
}