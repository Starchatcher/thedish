<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  max-width: 1600px; /* ← 전체 폭 확장 */
  margin: 40px auto;
}

.sidebar {
  width: 260px;
  background-color: #ffffff;
  padding: 30px 24px;
  border: 1px solid #eee;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.03);
}

.sidebar h3 {
  font-size: 16px;
  margin-top: 20px;
  margin-bottom: 12px;
  color: #2c3e50;
  border-bottom: 1px solid #dcdde1;
  padding-bottom: 6px;
}

.sidebar ul {
  list-style: none;
  padding-left: 0;
  margin: 0 0 25px 0;
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
  background-color: #fff;
  padding: 50px; /* ← 여백 증가 */
  border-radius: 10px;
  margin-left: 30px; /* ← 좌우 간격 증가 */
  box-shadow: 0 6px 16px rgba(0,0,0,0.06);
}

.main-content h2 {
  margin-bottom: 35px;
  font-size: 24px;
  color: #2c3e50;
  font-weight: 700;
}

label {
  font-weight: 600;
  display: block;
  margin-bottom: 8px;
  margin-top: 20px;
  color: #34495e;
  font-size: 15px;
}

input[type="text"], input[type="email"], input[type="password"], input[type="tel"] {
  width: 100%;
  padding: 12px;
  font-size: 15px;
  border: 1px solid #ccc;
  border-radius: 8px;
  box-sizing: border-box;
}

.btn-group {
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
  background-color: #3498db;
  color: white;
  cursor: pointer;
  transition: background-color 0.2s ease-in-out;
}

.btn-group button:hover,
input[type="submit"]:hover {
  background-color: #2980b9;
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
<div class="sidebar">
  <h3>회원정보</h3>
  <ul>
    <li><a href="${pageContext.request.contextPath}/myPage.do">메인페이지</a></li>
    <li><a href="${pageContext.request.contextPath}/confirmDelete.do?loginId=${users.loginId}">회원 탈퇴</a></li>
  </ul>

  <h3>Community</h3>
  <ul>
    <li><a href="${pageContext.request.contextPath}/inquiryList.do">1:1 문의</a></li>
    <li><a href="${pageContext.request.contextPath}/myBoardList.do">내가 쓴 글</a></li>
    <li><a href="${pageContext.request.contextPath}/faqList.do">FAQ</a></li>
    <li><a href="${pageContext.request.contextPath}/qnaList.do">Q&A</a></li>
  </ul>
</div>
  <div class="main-content">
    <h2>회원정보 수정</h2>
    <form action="updateUser.do" method="post" onsubmit="return checkPw();">
      <input type="hidden" name="loginId" value="${users.loginId}" />

      <label>이름</label>
      <input type="text" name="userName" value="${users.userName}" required />

      <label>비밀번호</label>
      <input type="password" name="password" id="password" required />

      <label>비밀번호 확인</label>
      <input type="password" id="password2" required />

      <label>닉네임</label>
      <input type="text" name="nickName" value="${users.nickName}" />

      <label>이메일</label>
      <input type="email" name="email" value="${users.email}" />

      <label>전화번호</label>
      <input type="tel" name="phone" value="${users.phone}" />
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
