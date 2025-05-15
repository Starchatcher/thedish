<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입 성공</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .container {
      background-color: #fff;
      padding: 50px 40px;
      border-radius: 16px;
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
      text-align: center;
      max-width: 500px;
      width: 90%;
    }

    h2 {
      color: #2c3e50;
      font-size: 24px;
      margin-bottom: 15px;
    }

    p {
      color: #555;
      font-size: 16px;
      margin-bottom: 30px;
    }

    .btn {
      display: inline-block;
      padding: 12px 24px;
      background-color: #444;
      color: white;
      border-radius: 6px;
      text-decoration: none;
      font-weight: bold;
      margin: 0 10px;
      transition: background-color 0.3s ease;
    }

    .btn:hover {
      background-color: #777;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>회원가입을 축하드립니다</h2>
    <p>이제 다양한 서비스를 이용하실 수 있어요.<br>로그인 후 The Dish의 기능을 자유롭게 즐겨보세요.</p>

    <a href="${pageContext.request.contextPath}/loginPage.do" class="btn">로그인하기</a>
    <a href="${pageContext.request.contextPath}/main.do" class="btn">메인으로</a>
  </div>
</body>
</html>
