<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	background: linear-gradient(120deg, #f8d5dc, #d3eaf2);
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

.avatar {
	background-color: #f29abf;
	border-radius: 50%;
	width: 80px;
	height: 80px;
	margin: 0 auto 20px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.avatar::before {
	content: '👤';
	font-size: 40px;
	color: white;
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
	color: #d38fa4;
	text-decoration: none;
}

input[type="submit"] {
	background-color: #f29abf;
	color: white;
	border: none;
	padding: 12px;
	width: 100%;
	border-radius: 5px;
	font-weight: bold;
	font-size: 1em;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #e77ca7;
}

.signup-link {
	margin-top: 20px;
	font-size: 0.95em;
}

.signup-link a {
	color: #f29abf;
	text-decoration: none;
	font-weight: bold;
	margin-left: 8px;
}

.signup-link a:hover {
	text-decoration: underline;
	color: #e77ca7;
}

.sns-section img {
	height: 40px;
	margin: 5px;
}
</style>
</head>
<body>

	<div class="login-container">
		<div class="avatar"></div>
		<div class="login-title">The Dish 로그인</div>

		<form action="login.do" method="post">
			<input type="text" id="loginId" name="loginId" class="login-input"
				placeholder="아이디" required> <input type="password"
				id="userPwd" name="userPwd" class="login-input" placeholder="비밀번호"
				required>

			<div class="options">
				<label><input type="checkbox" name="remember"> 기억하기</label>
				<a href="findPassword.do" style="float: right; color: #d291bc;">Forgot Password?</a>
			</div>

			<input type="submit" value="LOGIN">
		</form>

		<div class="sns-section" style="text-align: center; margin-top: 20px;">
			<p style="font-size: 14px;">SNS 계정으로 로그인</p>
			<a href="${pageContext.request.contextPath}/kakaoLogin.do?mode=login">
				<img
				src="https://developers.kakao.com/assets/img/about/logos/kakaologin/kr/kakao_account_login_btn_medium_narrow.png"
				alt="카카오 로그인" />
			</a> <a
				href="${pageContext.request.contextPath}/naverLogin.do?mode=login">
				<img src="https://static.nid.naver.com/oauth/small_g_in.PNG"
				alt="네이버 로그인" />
			</a> <a
				href="${pageContext.request.contextPath}/googleLogin.do?mode=login">
				<img
				src="https://developers.google.com/identity/images/btn_google_signin_light_normal_web.png"
				alt="구글 로그인" style="height: 40px; margin: 5px;" />
			</a>
		</div>

		<div class="signup-link">
			<button
				onclick="location.href='${pageContext.request.contextPath}/enrollPage.do'">회원가입</button>
		</div>
	</div>

</body>
</html>