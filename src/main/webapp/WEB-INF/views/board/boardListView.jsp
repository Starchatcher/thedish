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
table#boardTable {
    width: 650px;
    margin: 30px auto;
    border-collapse: collapse;
    text-align: center;
    font-size: 15px;
}

table#boardTable th, table#boardTable td {
    padding: 12px;
    border-bottom: 1px solid #8FBC8F; /* 줄 색 통일 */
}

table#boardTable th {
    background-color: #8FBC8F;
    color: white;
    font-weight: bold;
}

table#boardTable td#title a {
    text-decoration: none;
    color: #333;
}

table#boardTable td#title a:hover {
    text-decoration: underline;
}

tr:hover {
    background-color: #f0f8f0; /* 연한 초록 계열 hover 효과 */
}

h1#boardTitle {
    font-size: 32px;
    font-weight: bold;
    width: 650px; /* 테이블과 같은 폭으로 */
    margin: 40px auto 30px; /* 위-좌우-아래 여백 */
    text-align: center;
    color: #2F4F4F;
    border-bottom: 2px solid #8FBC8F;
    padding-bottom: 10px;
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
#search-area {
    width: 650px; /* 게시판 테이블과 같은 폭으로 맞추기 */
    margin: 0 auto 20px; /* 가운데 정렬 + 아래 여백 */
    display: flex;
    justify-content: space-between; /* 좌우로 양쪽 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
}

#searchForm select,
#searchForm input[type="text"],
#searchForm input[type="submit"] {
    height: 36px;
    padding: 0 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 8px;
}

#searchForm select {
    min-width: 80px;
}

#searchForm input[type="text"] {
    width: 220px;
}

#searchForm input[type="submit"] {
    background-color: #8FBC8F;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
    pading: 12px 8px;
}

#searchForm input[type="submit"]:hover {
    background-color: #7aa97a;
}

#writeBtn {
    padding: 8px 12px;
    background-color: #8FBC8F;
    color: white;
    border: none;
    font-size: 14px;
    border-radius: 8px;
    cursor: pointer;
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1 id="boardTitle">
  <c:choose>
    <c:when test="${not empty category}">
      ${category} 게시판
    </c:when>
    <c:otherwise>
      전체 게시판
    </c:otherwise>
  </c:choose>
</h1>


<%
  // 기본 검색 타입을 설정 (기본은 제목)
  String defaultAction = request.getParameter("action");
  if (defaultAction == null) defaultAction = "제목";
%>
<div id="search-area">
<form id="searchForm" method="get">
    <input type="hidden" name="category" value="${category}" />

    <select id="search-type" name="action" onchange="updateAction();">
        <option value="제목">제목</option>
        <option value="작성자">작성자</option>
        <option value="내용">내용</option>
    </select>

    <input type="text" id="search-query" name="keyword" placeholder="검색어를 입력하세요" required>
    <input type="submit" value="검색" />
</form>

<button id="writeBtn" onclick="location.href='boardWritePage.do';">작성</button>
</div>
<script type="text/javascript">
function updateAction() {
    var form = document.getElementById('searchForm');
    var searchType = document.getElementById('search-type').value;
    var hasCategory = "${not empty category}" === "true";  // EL로 미리 처리한 값을 JS 변수로 만듦

    if (searchType === "제목") {
        form.action = hasCategory ? "boardSearchTitle.do" : "boardSearchTitleAll.do";
    } else if (searchType === "작성자") {
        form.action = hasCategory ? "boardSearchWriter.do" : "boardSearchWriterAll.do";
    } else if (searchType === "내용"){
    	form.action = hasCategory ? "boardSearchContent.do" : "boardSearchContentAll.do";
    }
}

// 페이지 처음 로딩할 때도 form action 설정
window.onload = updateAction;
</script>

<table id="boardTable">
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
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<c:import url="/WEB-INF/views/common/pagingView.jsp" />
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
