<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>오류 발생</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, #e3f2fd, #f0f8ff);
      color: #333;
      margin: 0;
      padding: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: flex-start;
    }

    .error-container {
      margin-top: -10vh;
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .logo-wrapper {
      margin-bottom: -50px;
    }

    .dish-logo {
      width: 500px;  /* 너무 크지 않도록 조정 */
      height: auto;
    }

    .error-box {
      max-width: 480px;
      width: 100%;
      border: 1px solid #2196f3;
      background-color: #ffffff;
      padding: 40px 30px;
      border-radius: 0px;
      text-align: center;
    }

    .error-box h2 {
      color: #1976d2;
      font-size: 24px;
      margin-bottom: 10px;
    }

    .error-box p {
      font-size: 16px;
      color: #555;
      margin-bottom: 25px;
      line-height: 1.6;
    }

    .home-link {
      display: inline-block;
      padding: 12px 24px;
      background-color: #1976d2;
      color: white;
      text-decoration: none;
      font-weight: bold;
      border-radius: 6px;
      transition: background-color 0.3s ease;
    }

    .home-link:hover {
      background-color: #1565c0;
    }
  </style>
</head>
<body>

  <c:if test="${not empty msg}">
    <script>
      alert("${msg}");
    </script>
  </c:if>

  <div class="error-container">
    <div class="logo-wrapper">
      <img src="${pageContext.request.contextPath}/resources/images/thedishlogo.jpg" alt="The Dish 로고" class="dish-logo">
    </div>

    <div class="error-box">
      <h2>⚠ 오류가 발생했습니다</h2>
      <p>
        <c:out value="${msg}" default="죄송합니다. 예상치 못한 문제가 발생했습니다." />
      </p>
      <a href="${pageContext.request.contextPath}/main.do" class="home-link">메인으로 돌아가기</a>
    </div>
  </div>

</body>
</html>
