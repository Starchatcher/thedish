<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<style type="text/css">
body {
    margin: 0;
    padding: 0;
    background: #f1f3f5;
    font-family: 'Roboto', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}
.container {
    background: #ffffff;
    padding: 40px 50px;
    border-radius: 12px;
    width: 400px;
    box-shadow: 0 8px 16px rgba(0,0,0,0.1);
}
h1 {
    text-align: center;
    color: navy;
    margin-bottom: 30px;
}
form {
    display: flex;
    flex-direction: column;
}
.form-group {
    margin-bottom: 20px;
}
.form-group label {
    font-weight: bold;
    margin-bottom: 5px;
    display: block;
}
.form-group input[type="text"],
.form-group input[type="password"],
.form-group input[type="email"],
.form-group input[type="tel"],
.form-group input[type="number"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 16px;
    outline: none;
}
.gender-group {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-top: 5px;
}
.button-group {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
button, a.button-link {
    background-color: navy;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.3s;
}
button:hover, a.button-link:hover {
    background-color: #003366;
}
</style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
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
    var pwd = $('#userPwd').val();
    var pwd2 = $('#userPwd2').val();
    
    if (pwd !== pwd2) {
        alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
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
<div class="container">
    <h1>회원 가입</h1>
    <form action="enroll.do" method="post" onsubmit="return validate();">
        
        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" name="userId" id="userId" required>
            <button type="button" onclick="dupIdCheck();" style="margin-top:10px; width:100%;">아이디 중복검사</button>
        </div>

        <div class="form-group">
            <label for="userPwd">비밀번호</label>
            <input type="password" name="userPwd" id="userPwd" required>
        </div>

        <div class="form-group">
            <label for="userPwd2">비밀번호 확인</label>
            <input type="password" id="userPwd2" required>
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

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" required>
        </div>

        <div class="button-group">
            <button type="submit">가입하기</button>
            <button type="reset">작성취소</button>
            <a href="main.do" class="button-link">홈으로</a>
        </div>
    </form>
</div>
</body>
</html>
