<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f9f9f9;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .container {
        background: #fff;
        padding: 40px 50px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        width: 400px;
        text-align: center;
    }
    h2 {
        color: #2c3e50;
        margin-bottom: 30px;
    }
    form {
        display: flex;
        flex-direction: column;
    }
    input[type="password"] {
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
    }
    button {
        padding: 12px;
        border: none;
        background-color: #3498db;
        color: white;
        font-size: 15px;
        border-radius: 6px;
        cursor: pointer;
        margin-top: 10px;
    }
    button:hover {
        background-color: #2980b9;
    }
    a {
        display: block;
        margin-top: 20px;
        text-decoration: none;
        color: #3498db;
        font-size: 14px;
    }
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script>
    function checkPasswordMatch() {
        var pw1 = $('#newPassword').val();
        var pw2 = $('#confirmPassword').val();
        if (pw1 !== pw2) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
        return true;
    }
</script>
</head>
<body>

<div class="container">
    <h2>비밀번호 변경</h2>
    
    <form action="${pageContext.request.contextPath}/updatePassword.do" method="post" onsubmit="return checkPasswordMatch();">
        <input type="password" name="currentPassword" placeholder="현재 비밀번호" required />
        <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required />
        <input type="password" id="confirmPassword" placeholder="새 비밀번호 확인" required />
        <button type="submit">비밀번호 변경</button>
    </form>

    <!-- 비밀번호 변경 페이지 새로고침용 링크 (필요 시) -->
    <a href="${pageContext.request.contextPath}/changePassword.do">다시 입력하기</a>

    <!-- 마이페이지 이동 -->
    <a href="${pageContext.request.contextPath}/myPage.do">이전 페이지로 돌아가기</a>
</div>


</body>
</html>
