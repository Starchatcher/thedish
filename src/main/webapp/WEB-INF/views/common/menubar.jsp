<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>메뉴바 예제</title>
<style>
  body {
    margin: 0;
    font-family: Arial, sans-serif;
  }
  .navbar {
    display: flex;
    justify-content: space-between; /* 좌우 끝 정렬 */
    align-items: center;
    background-color: #333;
    padding: 10px 20px;
  }
  /* 로고 이미지 */
  .navbar .logo img {
    height: 40px;
  }
  /* 중앙 메뉴 */
  .navbar .menu {
    display: flex;
    gap: 20px; /* 메뉴 항목 간 간격 */
  }
  .navbar .menu a {
    color: white;
    text-decoration: none;
    padding: 8px 12px;
    font-size: 16px;
  }
  .navbar .menu a:hover {
    background-color: #555;
    border-radius: 4px;
  }
  /* 로그인 버튼 */
  .navbar .login-btn {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 8px 16px;
    cursor: pointer;
    font-size: 16px;
    border-radius: 4px;
    text-decoration: none;
  }
  .navbar .login-btn:hover {
    background-color: #45a049;
    text-decoration: none;
    color: white;
  }
</style>
</head>
<body>

<div class="navbar">
  <div class="logo">
    <a href="#">
      <img src="https://via.placeholder.com/150x40?text=Logo" alt="로고" />
    </a>
  </div>
  <div class="menu">
    <a href="#home">홈</a>
    <a href="#about">소개</a>
    <a href="#services">서비스</a>
    <a href="#contact">연락처</a>
  </div>
  <div>
    <a href="#login" class="login-btn">로그인</a>
  </div>
</div>

</body>
</html>
