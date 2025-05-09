<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 상세정보</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #ffffff;
      margin: 0;
      padding: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }

    .detail-box {
      background: #ffffff;
      padding: 32px 42px;
      border-radius: 16px;
      border: 1.5px solid #999999;
      box-shadow: 0 10px 24px rgba(0, 0, 0, 0.06);
      width: 540px;
      transition: all 0.3s ease;
    }

    .detail-box h2 {
      text-align: center;
      margin-bottom: 26px;
      font-size: 26px;
      color: #2471a3;
      border-bottom: 2px solid #5dade2;
      padding-bottom: 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    th, td {
      padding: 12px 10px;
      font-size: 15px;
    }

    th {
      background-color: #d6eaf8;
      color: #1b4f72;
      text-align: center;
      width: 35%;
      border-right: 1px solid #999999;
    }

    td {
      background-color: #fcfcfc;
      color: #444;
    }

    tr:nth-child(even) td {
      background-color: #f4f6f8;
    }

    .back-button {
      text-align: center;
      margin-top: 30px;
    }

    .back-button button {
      padding: 12px 24px;
      font-size: 15px;
      background-color: #2e86c1;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-weight: bold;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      transition: background-color 0.3s ease;
    }

    .back-button button:hover {
      background-color: #1c5980;
    }
  </style>
</head>
<body>
  <div class="detail-box">
    <h2>회원 상세정보</h2>
    <table>
      <tr><th>아이디</th><td>${user.loginId}</td></tr>
      <tr><th>이름</th><td>${user.userName}</td></tr>
      <tr><th>닉네임</th><td>${user.nickName}</td></tr>
      <tr><th>이메일</th><td>${user.email}</td></tr>
      <tr><th>전화번호</th><td>${user.phone}</td></tr>
      <tr><th>성별</th><td>${user.gender}</td></tr>
      <tr><th>나이</th><td>${user.age}</td></tr>
      <tr><th>가입일</th><td>${user.createdAt}</td></tr>
      <tr><th>상태</th><td>${user.status}</td></tr>
      <tr><th>역할</th><td>${user.role}</td></tr>
    </table>

    <div class="back-button">
      <button onclick="location.href='${pageContext.request.contextPath}/admin/userList.do'">이전 페이지</button>
    </div>
  </div>
</body>
</html>
