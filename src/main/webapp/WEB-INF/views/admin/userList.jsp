<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>사용자 관리</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f6f8;
      margin: 0;
      padding: 20px;
    }

    h1 {
      color: #2c3e50;
      margin-bottom: 30px;
    }

    .user-stats {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
    }

    .stat-box {
      flex: 1;
      background: #2980b9;
      color: white;
      padding: 15px;
      border-radius: 10px;
      text-align: center;
      font-size: 18px;
      font-weight: bold;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    }

    form.search-form {
      display: flex;
      gap: 10px;
      margin-bottom: 20px;
    }

    .search-form input[type="text"],
    .search-form select {
      padding: 10px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

    .search-form button {
      background-color: #3498db;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 14px;
      border-radius: 6px;
      cursor: pointer;
    }

    .user-table {
      width: 100%;
      border-collapse: collapse;
    }

    .user-table th, .user-table td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: center;
    }

    .user-table th {
      background-color: #2c3e50;
      color: white;
    }

    .user-table tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    .user-table a {
      color: #2980b9;
      text-decoration: none;
      font-weight: bold;
    }

    .user-table a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <h1>사용자 관리</h1>

  <!-- 🔷 통계 박스 -->
  <div class="user-stats">
    <div class="stat-box">
	  총 가입자 수: ${totalUsers}
	</div>
    <div class="stat-box">현재 회원 수: ${todayJoin}</div>
    <div class="stat-box">현재 탈퇴한 수: ${todayWithdraw}</div>
  </div>

  <!-- 🔎 검색 필터 -->
  <form class="search-form" method="get" action="${pageContext.request.contextPath}/admin/user/list.do">
    <input type="text" name="keyword" placeholder="닉네임 또는 ID 검색" value="${param.keyword}" />
    <select name="status">
      <option value="">전체 상태</option>
      <option value="ACTIVE" <c:if test="${param.status == 'ACTIVE'}">selected</c:if>>활성</option>
      <option value="INACTIVE" <c:if test="${param.status == 'INACTIVE'}">selected</c:if>>탈퇴</option>
    </select>
    <button type="submit">검색</button>
  </form>

  <!-- 📋 사용자 목록 테이블 -->
  <table class="user-table">
    <thead>
      <tr>
        <th>회원ID</th>
        <th>닉네임</th>
        <th>이메일</th>
        <th>상태</th>
        <th>가입일</th>
        <th>관리</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="user" items="${userList}">
        <tr>
          <td>${user.loginId}</td>
          <td>${user.nickName}</td>
          <td>${user.email}</td>
          <td>${user.status}</td>
          <td>${user.createdAt}</td>
          <td>
            <a href="${pageContext.request.contextPath}/admin/userDetail.do?userId=${user.userId}">보기</a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  
<div style="text-align: center; margin-top: 30px;">
  <button style="padding: 10px 20px; font-size: 14px; background-color: #34495e; color: white; border: none; border-radius: 6px; cursor: pointer;"
          onclick="location.href='${pageContext.request.contextPath}/admin/dashboard.do'">
    이전 페이지
  </button>
</div>

</body>
</html>
