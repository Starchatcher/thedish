<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 메인화면</title>
<style ="text/css">
h1 {
position: relative;
left: 300px;
}

form {
position: relative;
left: 700px;
bottom: 10px;
}

table, tr, th, td{
border-left: none;
border-right: none;
border-color: #8FBC8F ;
}

table td#title a {
text-decoration: none;
color: black;
}

table td {

}

</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"></c:import>

<h1>전체 게시판</h1>

<form action="search" method="get">
  <label for="search-type"></label>
  <select id="search-type" name="searchType">
    <option value="title">제목</option>
    <option value="writer">작성자</option>
    <!-- 필요에 따라 다른 검색 기준 추가 -->
  </select>

  <label for="search-query"></label>
  <input type="text" id="search-query" name="query" placeholder="검색어를 입력하세요">

  <input type="submit" value="검색"></input>
</form>


	<%-- 조회된 게시글 목록 출력 --%>
	<table align="center" width="650" border="1" cellspacing="0"
		cellpadding="0">
		<tr>
			<th></th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="board">
		<tr align="center">
			<td>${ board.boardId }</td>	<%-- 번호 --%>
			<td id="title">
				<%-- 원글과 댓글, 대댓글을 구분하기 위해 제목글자 앞에 ▶ 표시함 --%>
				
				 <c:url var="bd" value="bdetail.do">
					<c:param name="bnum" value="${ board.boardId }" />
					<c:param name="page" value="${ nowpage }" />
				</c:url>
				<a href="${ bd }">${ board.title }</a>	<%-- 제목 --%>
			</td>
			<td>${ board.loginId }</td> <%-- 작성자 --%>
			<td>${ board.createdAt }</td>
			<td>${ board.viewCount }</td>
		</tr>
	</c:forEach>
</table>

	<c:import url="/WEB-INF/views/common/pagingView.jsp" />

	<c:import url="/WEB-INF/views/common/footer.jsp"></c:import>
</body>
</html>