<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>환영합니다 - The Dish</title>
    <link rel="stylesheet" href="<c:url value='/resources/static/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">The Dish</h1>
        </header>
        
        <main class="welcome-container">
            <div class="welcome-image">
                <img src="<c:url value='/resources/static/img/welcome-character.png'/>" alt="Welcome Character">
            </div>
            
            <div class="welcome-message">
                <h2>${user.name}님, 만나서 반가워요!</h2>
                <p>모두가 즐겨 찾는 서비스 The Dish를 시작해보세요!</p>
            </div>
            
            <!-- 로그인 페이지로 명확하게 리다이렉트 -->
            <button class="btn-confirm" onclick="location.href='<c:url value="/user/login"/>'">확인</button>
        </main>
    </div>
</body>
</html>