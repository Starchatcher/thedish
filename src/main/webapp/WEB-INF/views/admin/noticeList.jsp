<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        padding: 30px;
        background-color: #f4f7f9;
    }

    h2, h3 {
        color: #2c3e50;
        margin-bottom: 10px;
    }

    p {
        color: #555;
        margin-bottom: 20px;
    }

    .btn-area {
        margin-bottom: 30px;
    }

    .btn {
        display: inline-block;
        padding: 10px 20px;
        margin-right: 10px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 6px;
    }

    .btn:hover {
        background-color: #0056b3;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background-color: white;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }

    th {
        background-color: #f0f0f0;
        color: #333;
    }

    form {
        display: inline;
    }

    .btn-small {
        padding: 6px 12px;
        font-size: 13px;
        background-color: #dc3545;
    }

    .btn-small:hover {
        background-color: #c82333;
    }
</style>
</head>
<body>

<h2>공지사항 목록</h2>
<p>이곳에서 공지사항을 등록, 수정, 삭제할 수 있습니다.</p>

<!-- ✅ 버튼 영역 -->
<div class="btn-area">
    <a href="${pageContext.request.contextPath}/admin/noticeForm.do" class="btn">공지사항 등록</a>
    <a href="${pageContext.request.contextPath}/admin/dashboard.do" class="btn">대시보드로</a>
    <a href="${pageContext.request.contextPath}/main.do" class="btn">메인으로</a>
</div>

<!-- 📌 여기에 공지사항 리스트 나중에 들어감 -->

<hr>

<!-- 👤 유저 탈퇴 기능 테스트용 리스트 -->
<h3>회원 목록 (탈퇴 관리)</h3>
<table>
    <thead>
        <tr>
            <th>아이디</th>
            <th>닉네임</th>
            <th>상태</th>
            <th>관리</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="user" items="${userList}">
            <tr>
                <td>${user.loginId}</td>
                <td>${user.nickName}</td>
                <td>${user.status}</td>
                <td>
                    <c:if test="${user.status eq 'ACTIVE'}">
                        <form action="${pageContext.request.contextPath}/admin/deactivateUser.do" method="post">
                            <input type="hidden" name="loginId" value="${user.loginId}" />
                            <button type="submit" class="btn btn-small"
                                onclick="return confirm('${user.loginId} 님을 탈퇴 처리하시겠습니까?');">
                                탈퇴
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${user.status ne 'ACTIVE'}">
                        <span style="color: gray;">탈퇴됨</span>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
