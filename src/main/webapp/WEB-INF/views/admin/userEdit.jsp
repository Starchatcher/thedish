<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    String todayKorean = new SimpleDateFormat("yyyy년 M월 d일").format(new Date());
%>
<html>
<head>
    <title>사용자 정보 수정</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f0f2f5;
        }

        /* ✅ sidebar 스타일 */
        .sidebar {
            width: 240px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            padding: 20px 15px;
            color: #ecf0f1;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
            box-sizing: border-box;
        }

        .sidebar h2 {
            font-size: 18px;
            margin-bottom: 25px;
            text-align: center;
        }

        .sidebar a {
            color: #bdc3c7;
            text-decoration: none;
            display: block;
            margin: 10px 0;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 14px;
            transition: background 0.3s, color 0.3s;
        }

        .sidebar a:hover {
            background-color: #2980b9;
            color: #fff;
        }

        .calendar-box {
            margin-top: 20px;
            padding: 8px;
            background-color: #34495e;
            border-radius: 10px;
            text-align: center;
            font-size: 13px;
        }

        /* ✅ 메인 폼 영역 */
        .main-content {
            margin-left: 260px;
            padding: 80px 40px;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
        }

        form {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.06);
            max-width: 600px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-top: 15px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        input[readonly] {
            background-color: #f1f1f1;
            color: #666;
        }

        button {
            margin-top: 25px;
            padding: 12px 20px;
            background-color: #2364aa;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<!-- ✅ sidebar -->
<div class="sidebar">
    <div class="sidebar-nav">
        <h2>관리자 메뉴</h2>
        <a href="${pageContext.request.contextPath}/main.do">메인 페이지</a>
        <a href="${pageContext.request.contextPath}/ndetail.do?no=1&page=1">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/board/boardDetailView.do?boardId=1">자유게시판 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">사용자 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">레시피 데이터관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">술 데이터관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">FAQ</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">1:1문의</a>
    </div>
    <div class="calendar-box">
        오늘은 <%= todayKorean %>입니다
    </div>
</div>

<!-- ✅ 사용자 수정 폼 -->
<div class="main-content">
    <h2>사용자 정보 수정</h2>
    <form action="${pageContext.request.contextPath}/admin/updateUser.do" method="post">
        <input type="hidden" name="userId" value="${user.userId}" />

        <label>로그인 ID</label>
        <input type="text" name="loginId" value="${user.loginId}" readonly />

        <label>닉네임</label>
        <input type="text" name="nickName" value="${user.nickName}" />

        <label>이메일</label>
        <input type="email" name="email" value="${user.email}" />

        <label>전화번호</label>
        <input type="text" name="phone" value="${user.phone}" />

        <label>나이</label>
        <input type="number" name="age" value="${user.age}" />

        <label>상태</label>
        <select name="status">
            <option value="ACTIVE" <c:if test="${user.status == 'ACTIVE'}">selected</c:if>>활성</option>
            <option value="INACTIVE" <c:if test="${user.status == 'INACTIVE'}">selected</c:if>>탈퇴</option>
        </select>

        <button type="submit">수정 완료</button>
    </form>
</div>

</body>
</html>
