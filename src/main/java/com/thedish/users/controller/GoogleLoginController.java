package com.thedish.users.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thedish.users.model.service.UsersService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class GoogleLoginController {

	// 보안 강화를 위해 application.properties에서 google clientId 및 clientSecret, redirectUri를 불러옵니다.
	@Value("${google.clientId}")
	private String clientId;
	
	@Value("${google.clientSecret}")
	private String clientSecret;
	

	@Value("${google.redirectUri}")
	private String redirectUri;

    @Autowired
    private UsersService usersService;

    // 1. Google 로그인 요청 URL로 리다이렉트
    @RequestMapping("googleLogin.do")
    public String redirectToGoogle(@RequestParam(value = "mode", required = false) String mode) throws Exception {
        String googleUrl = "https://accounts.google.com/o/oauth2/v2/auth?" +
                "client_id=" + clientId +
                "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8") +
                "&response_type=code" +
                "&scope=email%20profile" + 
                "&prompt=login";;
        if (mode != null) {
            googleUrl += "&state=" + mode; // mode를 state로 전달
        }
        return "redirect:" + googleUrl;
    }

    // 2. Google로부터 인가 코드 받아 처리
    @RequestMapping("/oauth/google.do")
    public String googleCallback(@RequestParam("code") String code,
                                 @RequestParam(value = "state", required = false) String mode,
                                 HttpSession session, Model model) throws Exception {

        // 1단계: 액세스 토큰 요청
        String tokenRequestUrl = "https://oauth2.googleapis.com/token";
        String tokenParams = "code=" + code +
                "&client_id=" + clientId +
                "&client_secret=" + clientSecret +
                "&redirect_uri=" + redirectUri +
                "&grant_type=authorization_code";

        URL url = new URL(tokenRequestUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.getOutputStream().write(tokenParams.getBytes());
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String line, result = "";
        while ((line = br.readLine()) != null) {
            result += line;
        }
        JSONObject tokenJson = new JSONObject(result);
        String accessToken = tokenJson.getString("access_token");
        br.close();

        // 2단계: 사용자 정보 요청
        URL meUrl = new URL("https://www.googleapis.com/oauth2/v3/userinfo?access_token=" + accessToken);
        HttpURLConnection meConn = (HttpURLConnection) meUrl.openConnection();
        meConn.setRequestMethod("GET");
        BufferedReader meBr = new BufferedReader(new InputStreamReader(meConn.getInputStream()));
        String meResult = "", meLine;
        while ((meLine = meBr.readLine()) != null) {
            meResult += meLine;
        }
        JSONObject meJson = new JSONObject(meResult);
        String googleId = meJson.getString("sub"); // Google 사용자 ID
        String name = meJson.getString("name");
        String email = meJson.getString("email");

        // 3단계: 사용자 정보 처리
        String loginId = "google_" + googleId;
        String password = "SNS_USER";

        Users existingUser = usersService.selectUsers(loginId);

        if ("register".equals(mode)) {
            if (existingUser != null) {
                String errorMessage = URLEncoder.encode("이미 등록된 구글 계정입니다.", "UTF-8");
                return "redirect:/enrollPage.do?error=" + errorMessage;
            } else {
                Users newUser = new Users();
                newUser.setLoginId(loginId);
                newUser.setPassword(password);
                newUser.setNickName(name);
                newUser.setUserName(name);
                newUser.setEmail(email);
                newUser.setProvider("google");
                newUser.setStatus("ACTIVE");
                newUser.setRole("USER");
                usersService.insertUser(newUser);
                existingUser = newUser;
            }
        } else if (existingUser == null) {
            return "redirect:/enrollPage.do?error=가입되지 않은 계정입니다. 회원가입을 진행해주세요.";
        }

        // 4단계: 세션 로그인 처리
        session.setAttribute("loginUser", existingUser);
        return "redirect:/main.do";
    }
}