<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.signup-container {
  background-color: rgba(255, 255, 255, 0.85);
  padding: 40px 30px;
  border-radius: 15px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
  width: 420px;
  text-align: center;
}

h1 {
  font-size: 1.8em;
  margin-bottom: 25px;
  color: #333;
}

.form-group {
  text-align: left;
  margin-bottom: 15px;
}

.form-group label {
  font-weight: bold;
  margin-bottom: 6px;
  display: block;
  color: #333;
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
  gap: 8px;  /* ← 간격 줄임 */
}

.gender-group label {
  display: flex;
  align-items: center;
  gap: 4px;   /* ← '남자'와 체크박스 사이 간격 */
  flex-direction: row-reverse;
  color: #555;
}

#dupCheckBtn, #nicknameCheckBtn {
  margin-top: 8px;
  width: 100%;
  background-color: #f29abf;
  color: white;
  border: none;
  padding: 10px;
  font-weight: bold;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

#dupCheckBtn:hover, #nickNameCheckBtn:hover {
  background-color: #e77ca7;
}

.button-group {
  display: flex;
  justify-content: space-between;
  margin-top: 25px;
}

button, a.button-link {
  background-color: #f29abf;
  color: white;
  border: none;
  padding: 12px 20px;
  font-size: 15px;
  font-weight: bold;
  border-radius: 6px;
  text-decoration: none;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover, a.button-link:hover {
  background-color: #e77ca7;
}
</style>

<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script>

function dupnickNameCheck() {
    var nickName = $('#nickName').val();  // 닉네임 값 가져오기
    
    // 닉네임이 비어 있는지 확인
    if (!nickName || nickName.trim() === '') {
        alert('닉네임을 입력해주세요.');
        $('#nickName').focus();
        return;  // 빈 값이면 함수 종료
    }
    
    $.ajax({
        url: 'nickNamechk.do',
        type: 'post',
        data: { nickName: nickName },  // 닉네임 값 보내기
        success: function(data) {
            if (data === 'ok') {
                alert('사용 가능한 닉네임입니다.');
                $('#userPwd').focus();
            } else {
                alert('이미 사용중인 닉네임입니다. 다시 입력하세요.');
                $('#nickName').select();
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('nickName check error : ' + jqXHR + ', ' + textStatus + ', ' + errorThrown);
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
                alert('이미 사용중인 아이디입니다. 다시 입력하세요.');
                $('#userId').select();
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log('error : ' + jqXHR + ', ' + textStatus + ', ' + errorThrown);
        }
    });
}

function validate() {
    const pwd = $('#userPwd').val();
    const pwd2 = $('#userPwd2').val();
    
    if (pwd !== pwd2) {
        alert('비밀번호와 확인이 일치하지 않습니다.');
        $('#userPwd').val('');
        $('#userPwd2').val('');
        $('#userPwd').focus();
        return false;
    }
    return true;
}
</script>
</head>

<body>
<div class="signup-container">
    <h1>회원 가입</h1>
    <form action="enroll.do" method="post" onsubmit="return validate();">

        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" name="userId" id="userId" required>
            <button type="button" id="dupCheckBtn" onclick="dupIdCheck();">아이디 중복검사</button>
        </div>

        <div class="form-group">
            <label for="userPwd">비밀번호</label>
            <input type="password" name="userPwd" id="userPwd" required>
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
            <label for="nickName">닉네임</label>
            <input type="text" name="nickName" id="nickName" required>
            <button type="button" id="nickNameCheckBtn" onclick="dupnickNameCheck();">닉네임 중복검사</button>
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

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" required>
        </div>

        <!-- 기본값 처리용 hidden 필드 -->
        <input type="hidden" name="status" value="ACTIVE">
        <input type="hidden" name="provider" value="local">
        <input type="hidden" name="role" value="USER">
        <input type="hidden" name="loginId" value="${userId}">

        <div class="button-group">
            <button type="submit">가입하기</button>
            <button type="reset">작성취소</button>
            <a href="main.do" class="button-link">홈으로</a>
        </div>
    </form>
</div>
</body>
</html>
