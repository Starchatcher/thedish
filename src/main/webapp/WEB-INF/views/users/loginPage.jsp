<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String rememberedId = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("rememberId".equals(cookie.getName())) {
                rememberedId = cookie.getValue();
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>The Dish 로그인</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Arial', sans-serif;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .login-container {
      background-color: rgba(255, 255, 255, 0.8);
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
      width: 350px;
      text-align: center;
      position: relative;
    }

    .logo {
      width: 250px;
      height: 250px;
      margin-bottom: -40px;
      margin-top: -40px;
    }

    .login-title {
      font-size: 1.5em;
      margin-bottom: 20px;
      color: #333;
    }

    .login-input {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
    }

    .options {
      display: flex;
      justify-content: space-between;
      font-size: 0.9em;
      margin-bottom: 20px;
    }

    .options label {
      color: #666;
    }

    .options a {
      color: #2364aa;
      text-decoration: none;
    }

    .login-button {
      background-color: #444;
      color: white;
      border: none;
      padding: 12px;
      width: 100%;
      border-radius: 5px;
      font-weight: bold;
      font-size: 1em;
      cursor: pointer;
      margin-top: 10px;
    }

    .login-button:hover {
      background-color: #777;
    }

    .signup-link {
      margin-top: 20px;
      font-size: 0.95em;
    }

.signup-link button {
  background-color: #444;
  color: white;
  border: none;
  padding: 7px 0;
  width: 90px;             /* ✅ 너비만 줄임 */
  font-size: 15px;
  font-weight: bold;
  border-radius: 5px;
  cursor: pointer;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

    .signup-link button:hover {
      background-color: #777;
    }

    .sns-section {
      text-align: center;
      margin-top: 25px;
    }

    .sns-section p {
      font-size: 13px;
      margin-bottom: 10px;
      color: #555;
    }

    .sns-buttons {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 6px;
    }

    .sns-buttons img {
      width: 160px;
      height: 30px;
      object-fit: cover;
      cursor: pointer;
    }
  </style>
</head>
<body>

  <div class="login-container">
    <img src="${pageContext.request.contextPath}/resources/images/thedishlogo.jpg" alt="The Dish 로고" class="logo">

    <div class="login-title">The Dish 로그인</div>

    <form action="login.do" method="post">
      <!-- ✅ 자동 아이디 입력 -->
      <input type="text" id="loginId" name="loginId" class="login-input" placeholder="아이디" required
             value="<%= rememberedId %>">

      <input type="password" id="userPwd" name="userPwd" class="login-input" placeholder="비밀번호" required>

      <div class="options">
        <!-- ✅ 기억하기 체크박스 상태 유지 -->
        <label>
          <input type="checkbox" name="remember" <%= rememberedId.isEmpty() ? "" : "checked" %> > 기억하기
        </label>
        <a href="findPassword.do">Forgot Password?</a>
      </div>

      <!-- ✅ 비밀번호 저장 안내 문구 -->
      <p class="info-text">
        비밀번호는 보안상 저장되지 않으며, 브라우저의 저장 기능을 이용하실 수 있습니다.
      </p>

      <input type="submit" class="login-button" value="LOGIN">
    </form>

    <!-- ✅ SNS 로그인 섹션 -->
    <div class="sns-section">
      <p>SNS 계정으로 로그인</p>
      <div class="sns-buttons">
        <a href="${pageContext.request.contextPath}/kakaoLogin.do?mode=login">
          <img src="https://developers.kakao.com/assets/img/about/logos/kakaologin/kr/kakao_account_login_btn_medium_narrow.png" alt="카카오 로그인" />
        </a>
        <a href="${pageContext.request.contextPath}/naverLogin.do?mode=login">
          <img src="https://static.nid.naver.com/oauth/small_g_in.PNG" alt="네이버 로그인" />
        </a>
        <a href="${pageContext.request.contextPath}/googleLogin.do?mode=login">
          <img src="https://developers.google.com/identity/images/btn_google_signin_light_normal_web.png" alt="구글 로그인" />
        </a>
      </div>
    </div>

    <div class="signup-link" style="display: flex; justify-content: center; gap: 10px;">
      <button onclick="location.href='${pageContext.request.contextPath}/enrollterms.do'">회원가입</button>
      <button onclick="location.href='${pageContext.request.contextPath}/'">홈으로</button>
    </div>

  </div>


</body>
</html>
