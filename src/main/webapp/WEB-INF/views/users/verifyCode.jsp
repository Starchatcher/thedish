<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>인증번호 입력</title>
</head>
<body>
  <h2>📧 이메일 인증</h2>
  <form action="verifyCode.do" method="post">
    <label for="code">이메일로 받은 인증번호 입력:</label>
    <input type="text" id="code" name="code" required><br><br>
    <input type="submit" value="인증 확인">
  </form>

  <c:if test="${not empty msg}">
    <p style="color:red">${msg}</p>
  </c:if>
</body>
</html>
