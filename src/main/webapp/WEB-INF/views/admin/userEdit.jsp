<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>사용자 수정</title>
</head>
<body>
    <h2>사용자 정보 수정</h2>
    <form action="${pageContext.request.contextPath}/admin/updateUser.do" method="post">
        <input type="hidden" name="userId" value="${user.userId}" />
        로그인 ID: <input type="text" name="loginId" value="${user.loginId}" readonly /><br/>
        닉네임: <input type="text" name="nickName" value="${user.nickName}" /><br/>
        이메일: <input type="email" name="email" value="${user.email}" /><br/>
        전화번호: <input type="text" name="phone" value="${user.phone}" /><br/>
        나이: <input type="number" name="age" value="${user.age}" /><br/>
        상태:
        <select name="status">
            <option value="ACTIVE" <c:if test="${user.status == 'ACTIVE'}">selected</c:if>>활성</option>
            <option value="INACTIVE" <c:if test="${user.status == 'INACTIVE'}">selected</c:if>>탈퇴</option>
        </select><br/>
        <button type="submit">수정 완료</button>
    </form>
</body>
</html>
