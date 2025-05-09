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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style type="text/css">
/* 게시판 테이블 */
table#boardTable {
    width: 800px;
    margin: 30px auto;
    border-collapse: collapse;
    text-align: left;
    font-size: 14px;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    overflow: hidden;
}

table#boardTable th,
table#boardTable td {
    padding: 14px;
    border-bottom: 1px solid #e0e0e0;
    color: #333333;
}

table#boardTable th {
    background-color: #f5f5f5;
    font-weight: 600;
    color: #222;
}

.board-title a {
    display: inline-block;
    max-width: 100%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    text-decoration: none;
    color: #333333;
}

.board-title a:hover {
    text-decoration: underline;
}

tr:hover {
    background-color: #fafafa;
}

/* 제목 */
h1#boardTitle {
    font-size: 24px;
    font-weight: 600;
    width: 800px;
    margin: 40px auto 24px;
    text-align: center;
    color: #333333;
    border-bottom: 1px solid #e0e0e0;
    padding-bottom: 8px;
}

/* 검색 영역 */
#search-area {
    width: 800px;
    margin: 0 auto 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

#searchForm select,
#searchForm input[type="text"],
#searchForm input[type="submit"] {
    height: 36px;
    padding: 0 12px;
    font-size: 13px;
    border: 1px solid #dcdcdc;
    border-radius: 6px;
    background-color: #ffffff;
    color: #333333;
    transition: border 0.2s ease;
    outline: none;
}

#searchForm select:focus,
#searchForm input[type="text"]:focus {
    border-color: #bbb;
}

#searchForm input[type="text"] {
    width: 220px;
}

#searchForm input[type="submit"] {
    background-color: #888;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

#searchForm input[type="submit"]:hover {
    background-color: #555;
}

/* 글쓰기 버튼 */
#writeBtn {
    padding: 8px 14px;
    background-color: #888;
    color: white;
    border: none;
    font-size: 13px;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

#writeBtn:hover {
    background-color: #555;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1 id="boardTitle">
  <c:choose>
    <c:when test="${category eq 'free'}">
      자유게시판
    </c:when>
    <c:when test="${category eq 'review'}">
      후기게시판
    </c:when>
    <c:when test="${category eq 'tip'}">
      팁공유게시판
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
    <input type="submit" value="🔎검색" />
</form>
	<c:if test="${ !empty sessionScope.loginUser }">
		<button id="writeBtn" onclick="location.href='boardWritePage.do';">📝작성</button>
	</c:if>
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
		<th>조회수</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>좋아요</th>
	</tr>
	<c:forEach items="${ list }" var="board">
	<tr align="center">
		<td>${ board.viewCount }</td>
		<td class="board-title">
			<c:url var="bd" value="boardDetail.do">
				<c:param name="boardId" value="${ board.boardId }" />
				<c:param name="page" value="${ nowpage }" />
				<c:param name="category" value="${ category }" />
				<c:param name="likeCount" value="${ board.likeCount }" />
			</c:url>
			<a href="${ bd }">${ board.title } <span style="color: crimson;">[${ board.commentCount }]</span></a>
		</td>
		<td>${ board.nickname }</td>
		<td><fmt:formatDate value="${ board.createdAt }" pattern="yyyy-MM-dd" /></td>
		<td>${ board.likeCount }</td>
	</tr>
	</c:forEach>
</table>
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<c:import url="/WEB-INF/views/common/pagingView.jsp" />
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
