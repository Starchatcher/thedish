<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    String todayKorean = new SimpleDateFormat("yyyy년 M월 d일").format(new Date());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 상세정보</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        /* ✅ sidebar */
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

        /* ✅ main content */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
        }

        .main-content {
            margin-left: 260px;
            padding: 80px 20px;
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .card {
            background: #ffffff;
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 40px 50px;
            width: 550px;
            animation: fadeIn 0.7s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            font-size: 30px;
            color: #34495e;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        th, td {
            padding: 14px 16px;
            font-size: 15px;
        }

        th {
            background-color: #2364aa;
            color: white;
            text-align: center;
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
            width: 35%;
            font-weight: 600;
        }

        td {
            background-color: #f9f9f9;
            color: #2c3e50;
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
            font-weight: 500;
        }

        tr:nth-child(even) td {
            background-color: #ecf0f1;
        }

        .back-button {
            text-align: center;
            margin-top: 25px;
        }

        .back-button button {
            padding: 10px 25px;
            font-size: 13px;
            background-color: #2364aa;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            box-shadow: 0 3px 8px rgba(0,0,0,0.08);
            transition: background-color 0.3s ease;
        }

        .back-button button:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
        }
    </style>
</head>
<body>

<!-- ✅ 사이드바 삽입 -->
<div class="sidebar">
    <div class="sidebar-nav">
        <h2>관리자 메뉴</h2>
        <a href="${pageContext.request.contextPath}/main.do">메인 페이지</a>
        <a href="${pageContext.request.contextPath}/ndetail.do?no=1&page=1">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/board/boardList.do">자유게시판 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">사용자 관리</a>
        <a href="${pageContext.request.contextPath}/recipe/recipeList.do">레시피 데이터관리</a>
        <a href="${pageContext.request.contextPath}/drink/drinkList.do">술 데이터관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">FAQ</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">1:1문의</a>
    </div>
    <div class="calendar-box">
        오늘은 <%= todayKorean %>입니다
    </div>
</div>

<!-- ✅ 본문 영역 -->
<div class="main-content">
    <div class="card">
        <h2>회원 상세정보</h2>
        <table>
            <tr><th>아이디</th><td>${user.loginId}</td></tr>
            <tr><th>이름</th><td>${user.userName}</td></tr>
            <tr><th>닉네임</th><td>${user.nickName}</td></tr>
            <tr><th>이메일</th><td>${user.email}</td></tr>
            <tr><th>전화번호</th><td>${user.phone}</td></tr>
            <tr><th>성별</th><td>${user.gender}</td></tr>
            <tr><th>나이</th><td>${user.age}</td></tr>
            <tr><th>가입일</th><td>${user.createdAt}</td></tr>
            <tr><th>상태</th><td>${user.status}</td></tr>
            <tr><th>역할</th><td>${user.role}</td></tr>
        </table>

        <div class="back-button">
            <button onclick="location.href='${pageContext.request.contextPath}/admin/userList.do'">목록으로 돌아가기</button>
        </div>
    </div>
</div>

</body>
</html>
