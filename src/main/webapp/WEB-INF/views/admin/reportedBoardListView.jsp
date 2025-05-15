<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String todayKorean = new SimpleDateFormat("yyyy년 M월 d일").format(new Date());
%>
<html>
<head>
  <title>신고된 게시글 목록</title>
  <style>
    body {
      font-family: '맑은 고딕', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f6f8;
    }

    .content {
      margin-left: 240px;
      padding: 40px;
    }

    h2 {
      margin-top: 0;
      font-size: 24px;
      color: #2c3e50;
      border-bottom: 2px solid #ccc;
      padding-bottom: 10px;
      text-align: center;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background: #fff;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border-radius: 8px;
      overflow: hidden;
    }

    th {
      background-color: #2c3e50;
      color: #fff;
      padding: 12px;
      font-size: 14px;
    }

    td {
      padding: 12px;
      border-bottom: 1px solid #eee;
      font-size: 13px;
      color: #333;
    }

    tr:hover {
      background-color: #f1f1f1;
    }

    .paging {
      text-align: center;
      margin-top: 25px;
    }

    .paging a {
      margin: 0 5px;
      text-decoration: none;
      color: #007bff;
    }

    .paging a.current {
      font-weight: bold;
      color: #000;
    }

    .sidebar {
      width: 220px;
      height: 100vh;
      background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
      position: fixed;
      color: #ecf0f1;
      display: flex;
      flex-direction: column;
      padding: 20px 15px;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
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
    
    td{
      text-align: center;
    }
  </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-nav">
        <h2>관리자 메뉴</h2>
        <a href="${pageContext.request.contextPath}/main.do">메인 페이지</a>
        <a href="${pageContext.request.contextPath}/noticeList.do">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/reportedBoardList.do">신고게시판 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">사용자 관리</a>
        <a href="${pageContext.request.contextPath}/recipeList.do">레시피 데이터관리</a>
        <a href="${pageContext.request.contextPath}/drinkList.do">술 데이터관리</a>
        <a href="${pageContext.request.contextPath}/FAQList.do">FAQ</a>
        <a href="${pageContext.request.contextPath}/qnaList.do">1:1문의</a>
    </div>
    <div class="calendar-box">
        오늘은 <%= todayKorean %>입니다
    </div>
</div>

<div class="content">
  <h2>신고된 게시글 목록</h2>

  <table>
    <thead>
      <tr>
        <th>신고번호</th>
        <th>게시글 번호</th>
        <th>신고자</th>
        <th>신고 사유</th>
        <th>신고일</th>
        <th>처리 여부</th>
      </tr>
    </thead>
    <tbody>
  <c:choose>
    <c:when test="${not empty list}">
      <c:forEach var="r" items="${list}">
        <tr>
          <td>${r.reportId}</td>

          <!-- 📌 게시글 상세페이지 링크 -->
          <td>
            <a href="${pageContext.request.contextPath}/boardDetail.do?boardId=${r.boardId}" target="_blank">
              ${r.boardId}
            </a>
          </td>

          <td>${r.reporterId}</td>
          <td>${r.reason}</td>
          <td><fmt:formatDate value="${r.reportedAt}" pattern="yyyy.MM.dd" /></td>

          <!-- 📌 처리 여부 & 처리 버튼 -->
          <td>
            <c:choose>
              <c:when test="${r.isChecked eq 'Y'}">
                처리됨<br/>
                <fmt:formatDate value="${r.checkedAt}" pattern="yyyy.MM.dd" />
              </c:when>
              <c:otherwise>
                <form action="${pageContext.request.contextPath}/checkReport.do" method="post" style="margin:0;">
                  <input type="hidden" name="reportId" value="${r.reportId}" />
                  <input type="hidden" name="page" value="${paging.currentPage}" />
                  <button type="submit" onclick="return confirm('해당 신고를 처리하시겠습니까?');">
                    처리
                  </button>
                </form>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <tr>
        <td colspan="6">신고된 게시글이 없습니다.</td>
      </tr>
    </c:otherwise>
  </c:choose>
</tbody>
  </table>

  <c:import url="/WEB-INF/views/common/pagingView.jsp" />
</div>

</body>
</html>
