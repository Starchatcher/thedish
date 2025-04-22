<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>탈퇴 완료 - The Dish</title>
    <link rel="stylesheet" href="<c:url value='/resources/static/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">The Dish</h1>
        </header>
        
        <main class="withdrawal-complete">
            <div class="welcome-image">
                <img src="<c:url value='/resources/static/img/chef-icon.png'/>" alt="Chef Icon">
            </div>
            
            <h2>회원탈퇴가 완료되었습니다.</h2>
            <p>The Dish를 이용해주셔서 감사합니다.</p>
            <p>더욱 더 노력하고 발전하는 The Dish가 되겠습니다.</p>
            
            <button class="btn-confirm" onclick="location.href='<c:url value="/"/>'">확인</button>
        </main>
    </div>
</body>
</html>