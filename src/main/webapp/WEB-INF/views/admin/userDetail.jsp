<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 상세정보</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
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
            position: relative;
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
</body>
</html>
