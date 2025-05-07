<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        padding: 30px;
        background-color: #f4f7f9;
    }

    h2 {
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
</style>
</head>
<body>

<h2>사용자 관리</h2>
<p>이곳에서 회원 정보를 조회하고 관리할 수 있습니다.</p>

<!-- 관리자 대시보드로 돌아가기 버튼 -->
<div class="btn-area">
    <a href="${pageContext.request.contextPath}/admin/dashboard.do" class="btn">대시보드로</a>
    <a href="${pageContext.request.contextPath}/main.do" class="btn">메인 페이지</a>
</div>

<!-- 📌 추후 회원 목록 테이블이 들어올 자리 -->

</body>
</html>
