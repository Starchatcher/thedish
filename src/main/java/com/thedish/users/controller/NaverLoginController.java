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
public class NaverLoginController {

	// 보안 강화를 위해 application.properties에서 naver clientId 및 clientSecret, redirectUri를 불러옵니다.
	@Value("${naver.clientId}")
	private String clientId;
	
	@Value("${naver.clientSecret}")
	private String clientSecret;
	

	@Value("${naver.redirectUri}")
	private String redirectUri;
	
    @Autowired
    private UsersService usersService;

    @RequestMapping("naverLogin.do")
    public String redirectToNaver(@RequestParam(value = "mode", required = false) String mode) throws Exception {
        String naverUrl = "https://nid.naver.com/oauth2.0/authorize?" +
                "client_id=" + clientId +
                "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8") +
                "&response_type=code";
        if (mode != null) {
            naverUrl += "&state=" + mode;
        }
        return "redirect:" + naverUrl;
    }

    @RequestMapping("/oauth/naver.do")
    public String naverCallback(@RequestParam("code") String code,
                                @RequestParam(value = "state", required = false) String mode,
                                HttpSession session, Model model) throws Exception {

        String tokenUrl = "https://nid.naver.com/oauth2.0/token?" +
                "grant_type=authorization_code" +
                "&client_id=" + clientId +
                "&client_secret=" + clientSecret +
                "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8") +
                "&code=" + code;

        URL url = new URL(tokenUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String line, result = "";
        while ((line = br.readLine()) != null) {
            result += line;
        }
        JSONObject tokenJson = new JSONObject(result);
        String accessToken = tokenJson.getString("access_token");
        br.close();

        URL meUrl = new URL("https://openapi.naver.com/v1/nid/me");
        HttpURLConnection meConn = (HttpURLConnection) meUrl.openConnection();
        meConn.setRequestMethod("GET");
        meConn.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader meBr = new BufferedReader(new InputStreamReader(meConn.getInputStream()));
        String meResult = "", meLine;
        while ((meLine = meBr.readLine()) != null) {
            meResult += meLine;
        }
        JSONObject meJson = new JSONObject(meResult);
        JSONObject response = meJson.getJSONObject("response");
        String naverId = response.getString("id");
        String nickname = response.optString("nickname", "네이버사용자");
        String email = response.optString("email", naverId + "@naver.com");
        String gender = response.optString("gender", "U"); // M: 남자, F: 여자, U: 미지정
        String mobile = response.optString("mobile", ""); // 휴대전화번호

        String loginId = "naver_" + naverId;
        String password = "SNS_USER";

        Users existingUser = usersService.selectUsers(loginId);

        if ("register".equals(mode)) {
            if (existingUser != null) {
                String errorMessage = URLEncoder.encode("이미 등록된 네이버 계정입니다.", "UTF-8");
                return "redirect:/enrollPage.do?error=" + errorMessage;
            } else {
                Users newUser = new Users();
                newUser.setLoginId(loginId);
                newUser.setPassword(password);
                newUser.setNickName(nickname);
                newUser.setUserName("네이버회원");
                newUser.setEmail(email);
                newUser.setGender(gender);
                newUser.setPhone(mobile);
                newUser.setProvider("naver");
                newUser.setStatus("ACTIVE");
                newUser.setRole("USER");

                usersService.insertUser(newUser);
                existingUser = newUser;
            }
        } else if (existingUser == null) {
            return "redirect:/enrollPage.do?error=가입되지 않은 계정입니다. 회원가입을 진행해주세요.";
        }

        session.setAttribute("loginUser", existingUser);
        return "redirect:/main.do";
    }
}