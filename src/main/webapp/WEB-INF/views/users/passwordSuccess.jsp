<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 변경 완료</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      background-color: white;
      padding: 50px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
      text-align: center;
      max-width: 400px;
    }

    h2 {
      color: #2c3e50;
      margin-bottom: 20px;
    }

    p {
      font-size: 16px;
      color: #555;
      margin-bottom: 30px;
    }

    .btn {
      display: inline-block;
      padding: 12px 24px;
      background-color: #444;
      color: white;
      text-decoration: none;
      font-weight: bold;
      border-radius: 6px;
      transition: background-color 0.3s ease;
      margin: 0 10px;
    }

    .btn:hover {
      background-color: #777;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>비밀번호 변경 완료</h2>
    <p>비밀번호가 성공적으로 변경되었습니다.</p>
    <a href="${pageContext.request.contextPath}/myPage.do" class="btn">마이페이지</a>
    <a href="${pageContext.request.contextPath}/main.do" class="btn">메인으로</a>
  </div>
</body>
</html>
