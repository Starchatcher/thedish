<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>My Page</title>
<style>
body {
  margin: 0;
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f9f9f9;
}

.container {
  max-width: 1000px;
  margin: 40px auto;
  display: flex;
  gap: 30px;
  padding: 0 20px;
}

.sidebar {
  background: white;
  padding: 30px;
  width: 320px;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
  text-align: left;
}

.sidebar h2 {
  font-size: 20px;
  margin-bottom: 10px;
  color: #2c3e50;
  text-align: center;
}

.sidebar .info-label {
  font-weight: bold;
  color: #444;
  margin-bottom: 5px;
}

.sidebar .info-item {
  margin: 8px 0;
  font-size: 14px;
  color: #555;
  display: flex;
  align-items: center;
  gap: 8px; /* 아이콘과 텍스트 사이 간격 */
}

.sidebar button {
  display: block;
  margin: 20px auto 0;
  background: #2ecc71;
  color: white;
  border: none;
  padding: 10px 25px;
  border-radius: 6px;
  cursor: pointer;
}

.sidebar button:hover {
  background: #27ae60;
}

.content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.box {
  background: white;
  border-radius: 12px;
  padding: 25px 30px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
}

.box h3 {
  margin-bottom: 10px;
  font-size: 17px;
  color: #333;
}

.box p {
  font-size: 14px;
  color: #666;
}

.form-section input[type="text"],
.form-section input[type="email"],
.form-section input[type="password"],
.form-section input[type="tel"] {
  width: 100%;
  padding: 10px;
  margin-top: 6px;
  margin-bottom: 15px;
  border: 1px solid #ccc;
  border-radius: 6px;
}

.form-section input[type="submit"],
.form-section input[type="reset"] {
  padding: 10px 20px;
  border: none;
  border-radius: 6px;
  background-color: #3498db;
  color: white;
  cursor: pointer;
  margin-right: 10px;
}

.form-section input[type="submit"]:hover {
  background-color: #2980b9;
}
.form-section a {
  margin-left: 10px;
  text-decoration: none;
  color: #e74c3c;
}
</style>

<script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script>
function validate() {
    var passwordValue = $('#password').val();
    var passwordValue2 = $('#password2').val();
    if (passwordValue !== passwordValue2) {
        alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
        $('#password').val('');
        $('#password2').val('');
        $('#password').focus();
        return false;
    }
    return true;
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
  <!-- 사이드바 유저 정보 -->
  <div class="sidebar">
    <h2>${users.nickName}</h2>
    <div class="info-item">
      <span class="info-label">📞 Phone :</span>
      <c:choose>
        <c:when test="${not empty users.phone}">
          ${users.phone}
        </c:when>
        <c:otherwise>
          <span style="color:gray;">미입력</span>
        </c:otherwise>
      </c:choose>
    </div>
    <div class="info-item"><span class="info-label">✉ Email :</span> ${users.email}</div>
    <button type="button" onclick="alert('좌측 정보는 아래 폼에서 수정 가능합니다.')">개인정보설정 변경</button>
  </div>

  <!-- 우측 기능 폼 -->
  <div class="content">
    <div class="box form-section">
      <h3>회원정보 수정</h3>
      <form action="updateUser.do" method="post" onsubmit="return validate();">
        <input type="hidden" name="loginId" value="${users.loginId}">

        <label>이름</label>
        <input type="text" name="userName" value="${users.userName}" required>

        <label>비밀번호</label>
        <input type="password" name="password" id="password" required>

        <label>비밀번호 확인</label>
        <input type="password" id="password2" required>

        <label>닉네임</label>
        <input type="text" name="nickName" value="${users.nickName}">

        <label>이메일</label>
        <input type="email" name="email" value="${users.email}">

        <label>전화번호</label>
        <input type="tel" name="phone" id="phone" value="${users.phone}" required>

        <input type="submit" value="수정하기">
        <input type="reset" value="취소">
      </form>

      <!-- 탈퇴하기 버튼 추가 -->
      <br>
      <a href="confirmDelete.do?loginId=${users.loginId}" style="color: red; font-weight: bold; text-decoration: underline;">탈퇴하기</a>
    </div>

    <div class="box">
      <h3>🔔 알림 설정</h3>
      <p>The Dish 서비스의 알림 여부를 설정할 수 있습니다.</p>
    </div>

    <div class="box">
      <h3>🔒 비밀번호 변경</h3>
      <p>주기적인 비밀번호 변경을 통해 개인정보를 안전하게 보호하세요.</p>
    </div>

    <div class="box">
      <h3>📝 내 문의</h3>
      <p>내가 남긴 문의를 확인할 수 있습니다.</p>
    </div>
  </div>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
