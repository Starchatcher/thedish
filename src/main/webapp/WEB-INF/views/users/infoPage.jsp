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
<%-- jQuery js 파일 로드 선언 --%>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
function validate(){
	//서버측으로 보내기 전에 입력값들이 유효한지 검사하는 함수
	
	//암호와 암호확인이 일치하는지 확인
	var passwordValue = $('#userPassword').val();
	var passwordValue2 = document.getElementById('userPassword2').value;
	if(passwordValue !== passwordValue2){
		alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
		document.getElementById('userPassword').value = ''; 	 //기록된 값 지우기 javascript
		$('#userPassword2').val('');		//기록된 값 지우기	jQuery
		document.getElementById('userPassword').focus();		//입력커서 지정함
		return false;		//전송 취소
	}
	
	//아이디의 값 형식이 요구대로 구성되었는지 확인
	//암호의 값 형식이 요구대로 구성되었는지 확인
	//정규표현식 사용함
	
	return true;		//전송 보냄
	
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>

<h1 align="center">내 정보 보기 페이지</h1>
<br>

<table id="outer" align="center" width="700px" cellspacing="5" cellpadding="0">
	<tr><th colspan="2">등록된 회원님의 정보는 아래와 같습니다. <br>
				수정할 내용이 있으면 변경하고, 수정하기 버튼을 누르세요.
	</th></tr>
	<tr><th width="120">*아이디</th>
	<%-- input 태그의 name 속성의 이름은 member.dto.Member 클래스의 property 명과 같게 함 --%>
		<td><input type="text" name="userId" id="userId" value="${ requestScope.users.loginId }" readonly> &nbsp;
		</td></tr>
	<tr><th>*암호</th>
		<td><input type="password" name="userPassword" id="userPassword" ></td></tr>
	<tr><th>*암호확인</th>
		<td><input type="password" id="userPassword2" ></td></tr>
	<tr><th>*이름</th>
		<td><input type="text" name="userName" id="userName"  value="${ requestScope.users.userName }" readonly></td></tr>
		</td></tr>
	<tr><th>*닉네임</th>
		<td><input type="text" name="nickName" id="nickName"  value="${ requestScope.member.nickName }"></td></tr>
		</td></tr>
	<tr><th>*이메일</th>
		<td><input type="email" name="email" value="${ member.email }"></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="수정하기"> &nbsp;
		<input type="reset" value="수정취소"> &nbsp;
		<c:url var="mdel" value="mdelete.do">
			<c:param name="loginId" value="${ requestScope.users.loginId }"></c:param>
		</c:url>
		<a href="${ mdel }">탈퇴하기</a>
		<%-- <a href=" mdelete.do?userId=${ requestScope.member.userId }">탈퇴하기</a> --%>
		<a href="main.do">Home</a>
	</th></tr>

</table>

</form>

<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>