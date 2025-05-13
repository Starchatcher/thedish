<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>인증번호 입력</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, #f8d5dc, #d3eaf2);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      background-color: white;
      padding: 40px 30px;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
      width: 360px;
      text-align: center;
    }

    h2 {
      margin-bottom: 20px;
      color: #333;
    }

    input[type="text"] {
      width: 100%;
      padding: 12px 15px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-sizing: border-box;
      font-size: 14px;
    }

    input[type="submit"],
    .back-button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      border-radius: 10px;
      margin-top: 10px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    input[type="submit"] {
      background-color: #4CAF50;
      border: none;
      color: white;
    }

    input[type="submit"]:hover {
      background-color: #45a049;
    }

    .back-button {
      background-color: #f0f0f0;
      border: 1px solid #ccc;
      color: #333;
    }

    .back-button:hover {
      background-color: #e0e0e0;
    }

    .error-msg {
      color: red;
      margin-top: 15px;
      font-size: 13px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>이메일 인증</h2>
    <form action="verifyCode.do" method="post">
      <input type="text" name="code" placeholder="인증번호 입력" required>
      <input type="submit" value="인증 확인">
    </form>

    <button type="button" class="back-button" onclick="history.back()">이전 페이지로</button>

    <c:if test="${not empty msg}">
      <p class="error-msg">${msg}</p>
    </c:if>
  </div>
</body>
</html>
