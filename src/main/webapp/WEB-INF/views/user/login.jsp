<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - The Dish</title>
    <link rel="stylesheet" href="<c:url value='/resources/static/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">The Dish</h1>
        </header>
        
        <main class="login-form">
            <form action="<c:url value='/user/login'/>" method="post">
                <div class="form-group">
                    <input type="text" id="userId" name="userId" placeholder="아이디 입력" required>
                </div>
                
                <div class="form-group">
                    <input type="password" id="password" name="password" placeholder="비밀번호 입력" required>
                </div>
                
                <div class="remember-me">
                    <label class="checkbox-container">
                        <input type="checkbox" name="remember" id="remember">
                        <span class="checkmark"></span>
                        <span class="label-text">로그인 상태 유지</span>
                    </label>
                </div>
                
                <button type="submit" class="btn-confirm">로그인</button>
                
                <!-- 에러 메시지 표시 -->
                <c:if test="${not empty errorMsg}">
                    <div class="error-message">${errorMsg}</div>
                </c:if>
                
                <!-- 회원가입 및 ID/PW 찾기 링크 -->
                <div class="login-links">
                    <a href="<c:url value='/user/signup'/>">회원가입</a>
                    <span class="divider">|</span>
                    <a href="<c:url value='/user/find-id'/>">아이디 찾기</a>
                    <span class="divider">|</span>
                    <a href="<c:url value='/user/find-password'/>">비밀번호 찾기</a>
                </div>
                
                <!-- 소셜 로그인 -->
                <div class="social-login">
                    <a href="<c:url value='/user/oauth/google'/>">
                        <img src="<c:url value='/resources/static/img/google-icon.png'/>" alt="Google Login">
                    </a>
                    <a href="<c:url value='/user/oauth/facebook'/>">
                        <img src="<c:url value='/resources/static/img/facebook-icon.png'/>" alt="Facebook Login">
                    </a>
                    <a href="<c:url value='/user/oauth/naver'/>">
                        <img src="<c:url value='/resources/static/img/naver-icon.png'/>" alt="Naver Login">
                    </a>
                </div>
            </form>
        </main>
    </div>
</body>
</html>