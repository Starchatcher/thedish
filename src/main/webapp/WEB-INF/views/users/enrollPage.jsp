<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<style>
body {
  margin: 0;
  padding: 0;
  font-family: 'Arial', sans-serif;

  background: linear-gradient(120deg, #f8d5dc, #d3eaf2);

  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.signup-container {
  background-color: rgba(255, 255, 255, 0.85);
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
  width: 600px;
  text-align: center;
}

h1 {
  font-size: 1.8em;
  margin-bottom: 20px;
  color: #333;
}

.form-wrapper {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: space-between;
}

.form-group {
  flex: 0 0 48%;
  text-align: left;
}

.form-group-full {
  flex: 0 0 100%;
  text-align: left;
}

.form-group label {
  font-weight: bold;
  margin-bottom: 6px;
  display: block;
  color: #333;
}

.form-group small {
  color: #888;
  font-size: 13px;
  margin-top: 4px;
  display: block;
}

input[type="text"],
input[type="password"],
input[type="email"],
input[type="tel"],
input[type="number"] {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 14px;
  box-sizing: border-box;
}

.gender-group {
  display: flex;
  gap: 10px;
  align-items: center;
}

.gender-group label {
  color: #555;
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 14px;
}

#dupCheckBtn,
#nickNameCheckBtn {
  margin-top: 8px;
  width: 100%;

  background-color: #2364aa;

  color: white;
  border: none;
  padding: 10px;
  font-weight: bold;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

#dupCheckBtn:hover,
#nickNameCheckBtn:hover {
  background-color: #777;
}

.button-group {
  margin-top: 25px;
  display: flex;
  justify-content: center;
  gap: 15px;
}

.button-group button,
.button-group a {
  width: 100px;
  padding: 12px 0;
  font-size: 15px;
  font-weight: bold;
  border: none;
  border-radius: 6px;
  color: white;
  cursor: pointer;
  transition: background-color 0.3s;
  text-align: center;

  background-color: #2364aa;

  text-decoration: none;
}

.button-group button:hover,
.button-group a:hover {

  background-color: #1e5799;

}

.success-message {
  background: #dff0d8;
  color: #3c763d;
  padding: 12px;
  border-radius: 6px;
  margin-bottom: 20px;
  font-weight: bold;
}
</style>

<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script>
function dupnickNameCheck() {
    var nickName = $('#nickName').val();
    if (!nickName || nickName.trim() === '') {
        alert('닉네임을 입력해주세요.');
        $('#nickName').focus();
        return;
    }

    $.ajax({
        url: 'nickNamechk.do',
        type: 'post',
        data: { nickName: nickName },
        success: function(data) {
            if (data === 'ok') {
                alert('사용 가능한 닉네임입니다.');
                $('#userPwd').focus();
            } else {
                alert('이미 사용중인 닉네임입니다. 다시 입력하세요.');
                $('#nickName').select();
            }
        }
    });
}

function dupIdCheck() {
    $.ajax({
        url: 'idchk.do',
        type: 'post',
        data: { userId: $('#userId').val() },
        success: function(data) {
            if(data === 'ok') {
                alert('사용 가능한 아이디입니다.');
                $('#userPwd').focus();
            } else {
                alert('이미 사용중인 아이디입니다.');
                $('#userId').select();
            }
        }
    });
}

function validate() {
    const pwd = $('#userPwd').val();
    const pwd2 = $('#userPwd2').val();
    const pwdRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
    if (!pwdRegex.test(pwd)) {
        alert('비밀번호는 영문자 + 숫자 조합의 8자 이상이어야 합니다.');
        return false;
    }
    if (pwd !== pwd2) {
        alert('비밀번호와 확인이 일치하지 않습니다.');
        return false;
    }
    return true;
}
</script>
</head>
<body>
<div class="signup-container">
    <h1>회원 가입</h1>

    <c:if test="${param.enrollSuccess eq 'true'}">
        <div class="success-message">
            회원가입이 성공적으로 완료되었습니다! 환영합니다 😊
        </div>
    </c:if>

    <form action="enroll.do" method="post" onsubmit="return validate();">
        <div class="form-wrapper">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" name="userId" id="userId" required>
                <button type="button" id="dupCheckBtn" onclick="dupIdCheck();">중복확인</button>
            </div>

            <div class="form-group">
                <label for="nickName">닉네임</label>
                <input type="text" name="nickName" id="nickName" required>
                <button type="button" id="nickNameCheckBtn" onclick="dupnickNameCheck();">중복확인</button>
            </div>

            <div class="form-group">
                <label for="userPwd">비밀번호</label>
                <input type="password" name="userPwd" id="userPwd" required>
                <small>영문자 + 숫자 조합, 8자 이상</small>
            </div>

            <div class="form-group">
                <label for="userPwd2">비밀번호 확인</label>
                <input type="password" name="userPwd2" id="userPwd2" required>
            </div>

            <div class="form-group">
                <label for="userName">이름</label>
                <input type="text" name="userName" id="userName" required>
            </div>

            <div class="form-group">
                <label>성별</label>
                <div class="gender-group">
                    <label><input type="radio" name="gender" value="M" required> 남자</label>
                    <label><input type="radio" name="gender" value="F" required> 여자</label>
                </div>
            </div>

            <div class="form-group">
                <label for="age">나이</label>
                <input type="number" name="age" min="19" max="100" value="20" required>
            </div>

            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" name="phone" required>
            </div>

            <div class="form-group-full">
                <label for="email">이메일</label>
                <input type="email" name="email" required>
            </div>

            <input type="hidden" name="status" value="ACTIVE">
            <input type="hidden" name="provider" value="local">
            <input type="hidden" name="role" value="USER">
            <input type="hidden" name="loginId" value="${userId}">
        </div>

        <div class="button-group">
            <button type="submit" class="submit-btn">가입하기</button>
            <a href="main.do" class="home-link">홈으로</a>
        </div>
    </form>
</div>
</body>
</html>
