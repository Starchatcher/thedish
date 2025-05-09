<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오류 발생</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff3f3;
            color: #333;
            padding: 50px;
            text-align: center;
        }
        .error-box {
            border: 2px solid #f44336;
            padding: 30px;
            background-color: #ffe5e5;
            border-radius: 8px;
            display: inline-block;
        }
        .error-box h2 {
            color: #f44336;
        }
        .home-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .home-link:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>

    <c:if test="${not empty msg}">
        <script>
            alert("${msg}");
        </script>
    </c:if>

    <div class="error-box">
        <h2>⚠ 오류가 발생했습니다</h2>
        <p><c:out value="${msg}" default="죄송합니다. 예상치 못한 문제가 발생했습니다." /></p>
        <a href="${pageContext.request.contextPath}/main.do" class="home-link">메인으로 돌아가기</a>
    </div>

</body>
</html>
