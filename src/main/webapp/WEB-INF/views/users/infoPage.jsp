<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>My Info</title>
<style type="text/css">
table th { background-color: #9ff; }
table#outer { border: 2px solid navy; }
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
<hr>

<h1 align="center">내 정보 보기 페이지</h1>
<br>

<!-- 폼 시작 -->
<form action="updateUser.do" method="post" onsubmit="return validate();">
<table id="outer" align="center" width="700px" cellspacing="5" cellpadding="0">
    <tr>
        <th colspan="2">
            등록된 회원님의 정보는 아래와 같습니다. <br>
            수정할 내용이 있으면 변경하고, 수정하기 버튼을 누르세요.
        </th>
    </tr>
    <tr>
        <th>*아이디</th>
        <td><input type="text" name="loginId" value="${users.loginId}" readonly></td>
    </tr>
    <tr>
        <th>*암호</th>
        <td><input type="password" name="password" id="password" required></td>
    </tr>
    <tr>
        <th>*암호확인</th>
        <td><input type="password" id="password2" required></td>
    </tr>
    <tr>
        <th>*이름</th>
        <td><input type="text" name="userName" value="${users.userName}" readonly></td>
    </tr>
    <tr>
        <th>*닉네임</th>
        <td><input type="text" name="nickName" value="${users.nickName}"></td>
    </tr>
    <tr>
        <th>*이메일</th>
        <td><input type="email" name="email" value="${users.email}"></td>
    </tr>
    <tr>
        <th colspan="2">
            <input type="submit" value="수정하기">
            <input type="reset" value="수정취소">

            <c:url var="mdel" value="mdelete.do">
                <c:param name="loginId" value="${users.loginId}" />
            </c:url>
            <a href="${mdel}">탈퇴하기</a>
            <a href="main.do">Home</a>
        </th>
    </tr>
</table>
</form>

<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
