<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.paging.currentPage }">
	<c:set var="nowpage" value="${ requestScope.paging.currentPage }" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${category} 게시판</title>
<style type="text/css">
h1 {
	text-align: center;
	position: relative;
	right: 260px;
}
form {
	position: relative;
	right: 185px;
	bottom: 10px;
	text-align: center;
}
table, tr, th, td {
	border-left: none;
	border-right: none;
	border-color: #8FBC8F;
}
table td#title a {
	text-decoration: none;
	color: black;
}
#writeBtn {
	position: relative;
	left: 870px;
	top: 20px;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1>
  <c:choose>
    <c:when test="${not empty category}">
      ${category} 게시판
    </c:when>
    <c:otherwise>
      전체 게시판
    </c:otherwise>
  </c:choose>
</h1>

<c:if test="${ !empty loginUser }">
	<button id="writeBtn" onclick="location.href='boardWritePage.do';">작성</button>
</c:if>

<%
  // 기본 검색 타입을 설정 (기본은 제목)
  String defaultAction = request.getParameter("action");
  if (defaultAction == null) defaultAction = "제목";
%>

<form action="${empty category ? 'boardSearchTitleAll.do' : 'boardSearchTitle.do'}" method="get">
  <input type="hidden" name="category" value="${category}" />

  <select id="search-type" name="action">
    <option value="제목">제목</option>
    <option value="작성자">작성자</option>
  </select>

  <input type="text" id="search-query" name="keyword" placeholder="검색어를 입력하세요">
  <input type="submit" value="검색" />
</form>

<table align="center" width="650" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<c:forEach items="${ list }" var="board">
	<tr align="center">
		<td>${ board.boardId }</td>
		<td id="title">
			<c:url var="bd" value="boardDetail.do">
				<c:param name="bno" value="${ board.boardId }" />
				<c:param name="page" value="${ nowpage }" />
				<c:param name="category" value="${category}" />
			</c:url>
			<a href="${ bd }">${ board.title }</a>
		</td>
		<td>${ board.nickname }</td>
		<td><fmt:formatDate value="${ board.createdAt }" pattern="yyyy-MM-dd" /></td>
		<td>${ board.viewCount }</td>
	</tr>
	</c:forEach>
</table>

<c:import url="/WEB-INF/views/common/pagingView.jsp" />
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
