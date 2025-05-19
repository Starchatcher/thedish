<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f6f8fb;
    }
    .wrapper {
      display: flex;
      max-width: 1200px;
      margin: 40px auto;
      gap: 15px;
    }
    .sidebar {
      position: relative;
      width: 280px;
      background-color: #ffffff;
      padding: 30px 24px;
      border: 1px solid #cccccc; 
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.03);
      text-align: center;
    }
    .sidebar img.logo {
      width: 240px;
      height: auto;
      margin-bottom: 70px;
    }
    .welcome-box {
      position: absolute;
      top: 210px;
      left: 50%;
      transform: translateX(-50%);
      background-color: #2364aa;
      color: white;
      font-weight: bold;
      font-size: 21px;
      width: 250px;
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .sidebar h3 {
      font-size: 16px;
      margin-top: 10px;
      margin-bottom: 12px;
      color: #2c3e50;
      border-bottom: 1px solid #dcdde1;
      padding-bottom: 6px;
      text-align: left;
    }
    .sidebar ul {
      list-style: none;
      padding-left: 0;
      margin: 0 0 30px 0;
      text-align: left;
    }
    .sidebar ul li {
      margin: 10px 0;
    }
    .sidebar ul li a {
      text-decoration: none;
      font-size: 16px;
      color: #2980b9;
      transition: all 0.2s ease-in-out;
      display: block;
      padding: 6px 10px;
      border-radius: 6px;
    }
    .sidebar ul li a:hover {
      background-color: #eaf6ff;
      color: #1a5e89;
      font-weight: 600;
    }

    .main-content {
      flex: 1;
      width: 100%;
      background-color: #fff;
      padding: 30px 40px;
      border-radius: 10px;
      border: 1px solid #cccccc; 
      margin: 0 auto;
      box-shadow: 0 6px 16px rgba(0,0,0,0.06);
      position: relative;
    }
    .main-content h2 {
      margin-bottom: 35px;
      font-size: 24px;
      color: #2c3e50;
      font-weight: 700;
    }

    .activity-summary {
      position: absolute;
      right: 60px;
      width: 220px;
      background-color: #ffffff;
      padding: 18px;
      border-radius: 12px;
      border: 1px solid #a2c1e5;
      box-shadow: 0 4px 14px rgba(0,0,0,0.08);
      color: #2c3e50;
      font-size: 14px;
      display: flex;
      flex-direction: column;
      gap: 14px;
      text-align: left;
    }
    .activity-summary-title {
      font-size: 16px;
      font-weight: 700;
      margin-bottom: 10px;
      color: #2c3e50;
    }
    .activity-row {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 15px;
    }

    .form-group {
      margin-bottom: 24px;
    }
    label {
      font-weight: 600;
      display: block;
      margin-bottom: 8px;
      color: #34495e;
      font-size: 15px;
    }
    input[type="name"],
    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="tel"] {
      width: 45%;
      padding: 12px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 8px;
      box-sizing: border-box;
    }

    .btn-group {
      width: 19%;
      display: flex;
      gap: 16px;
      margin-top: 40px;
    }
    .btn-group button,
    input[type="submit"],
    input[type="reset"] {
      flex: 1;
      min-width: 140px;
      padding: 14px 0;
      font-size: 15px;
      border: none;
      border-radius: 8px;
      background-color: #555;
      color: white;
      cursor: pointer;
      transition: background-color 0.2s ease-in-out;
    }
    .btn-group button:hover,
    input[type="submit"]:hover {
      background-color: #333;
    }
    .danger-btn {
      background-color: #3498db !important;
      color: white;
    }
    .danger-btn:hover {
      background-color: #2980b9 !important;
    }
  </style>
  <script>
    function checkPw() {
      var pw = document.getElementById("password").value;
      var pw2 = document.getElementById("password2").value;
      if (pw !== pw2) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
      }
      return true;
    }
  </script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="wrapper">
  <!-- Sidebar -->
  <div class="sidebar">
    <img src="${pageContext.request.contextPath}/resources/images/thedishlogo.jpg" alt="The Dish 로고" class="logo" />
    <div class="welcome-box"><strong>${users.nickName}</strong> 님, 환영합니다</div>
    <h3>회원정보</h3>
    <ul>
      <li><a href="${pageContext.request.contextPath}/confirmDelete.do?loginId=${users.loginId}">회원 탈퇴</a></li>
    </ul>
    <h3>Community</h3>
    <ul>
      <li><a href="${pageContext.request.contextPath}/qnaList.do">1:1 문의</a></li>
      <li><a href="${pageContext.request.contextPath}/myBoardList.do">내가 쓴 글</a></li>
      <li><a href="${pageContext.request.contextPath}/FAQList.do">FAQ</a></li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <!-- 통계 박스 1 -->
    <div class="activity-summary" style="top: 100px;">
      <div class="activity-summary-title">자유게시판 활동 요약</div>
      <div class="activity-row">최근 작성일: ${lastPostDate}</div>
      <div class="activity-row">작성 횟수: ${freeBoardPosts}개</div>
    </div>

    <!-- 통계 박스 2 -->
	<div class="activity-summary" style="top: 260px;">
	  <div class="activity-summary-title">후기게시판 활동 요약</div>
	  <div class="activity-row">최근 작성일: ${reviewLastPostDate}</div>
	  <div class="activity-row">작성 횟수: ${reviewBoardPosts}개</div>
	</div>

    <!-- 통계 박스 3 -->
    <div class="activity-summary" style="top: 420px;">
      <div class="activity-summary-title">팁공유게시판 활동 요약</div>
  <div class="activity-row">최근 작성일: <span>${tipLastPostDate}</span></div>
  <div class="activity-row">작성 횟수: <span>${tipBoardPosts}개</span></div>
    </div>

    <h2>회원정보 수정</h2>
    <form action="updateUser.do" method="post" onsubmit="return checkPw();">
      <input type="hidden" name="loginId" value="${users.loginId}" />
      <div class="form-group"><label>이름</label><input type="name" name="userName" value="${users.userName}" required /></div>
      <div class="form-group"><label>비밀번호</label><input type="password" name="password" id="password" required /></div>
      <div class="form-group"><label>비밀번호 확인</label><input type="password" id="password2" required /></div>
      <div class="form-group"><label>닉네임</label><input type="text" name="nickName" value="${users.nickName}" /></div>
      <div class="form-group"><label>이메일</label><input type="email" name="email" value="${users.email}" /></div>
      <div class="form-group"><label>전화번호</label><input type="tel" name="phone" value="${users.phone}" /></div>
      <div class="btn-group">
        <button type="submit">수정하기</button>
        <button type="button" onclick="location.href='changePassword.do?loginId=${users.loginId}'">비밀번호 변경</button>
        <button type="button" onclick="location.href='confirmDelete.do?loginId=${users.loginId}'">회원탈퇴</button>
      </div>
    </form>
  </div>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
