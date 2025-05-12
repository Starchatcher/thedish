<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>비밀번호 재설정</title>
</head>
<body>
  <form action="resetPassword.do" method="post">
    새 비밀번호: <input type="password" name="newPassword" required><br>
    <input type="submit" value="비밀번호 변경">
  </form>
  <c:if test="${not empty msg}">
    <p style="color:green">${msg}</p>
  </c:if>
</body>
</html>
