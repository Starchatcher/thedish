<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<h2>공지사항 목록</h2>
<p>이곳에서 공지사항을 등록, 수정, 삭제할 수 있습니다.</p>

<!-- ✅ 버튼 영역 -->
<div class="btn-area">
    <a href="${pageContext.request.contextPath}/admin/noticeForm.do" class="btn">공지사항 등록</a>
    <a href="${pageContext.request.contextPath}/admin/dashboard.do" class="btn">대시보드로</a>
    <a href="${pageContext.request.contextPath}/main.do" class="btn">메인으로</a>
</div>

<!-- 📌 여기에 테이블이나 리스트가 들어갈 예정 -->
<!-- 예: 추후 <c:forEach>로 공지사항 목록 반복 출력 -->

</body>
</html>
