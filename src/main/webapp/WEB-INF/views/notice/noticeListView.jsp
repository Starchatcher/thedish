<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Dish 공지사항</title>
<style ="text/css">
h1 {
text-align: center;
position: relative;
right: 260px;
}

form {
position: relative;
left: 185px;
bottom: 10px;
text-align: center;

}

table, tr, th, td{
border-left: none;
border-right: none;
border-color: #8FBC8F;
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

<h1>공지사항</h1>

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
		<c:forEach items="${ requestScope.list }" var="notice">
		<tr align="center">
			<td>${ notice.noticeId }</td>	<%-- 번호 --%>
			<td id="title">
				<%-- 원글과 댓글, 대댓글을 구분하기 위해 제목글자 앞에 ▶ 표시함 --%>
				
				 <c:url var="no" value="ndetail.do">
					<c:param name="nnum" value="${ notice.noticeId }" />
					<c:param name="page" value="${ nowpage }" />
				</c:url>
				<a href="${ no }">${ notice.title }</a>	<%-- 제목 --%>
			</td>
			<td>${ notice.createdBy }</td> <%-- 작성자 --%>
			<td>${ notice.createdAt }</td>
			<td>${ notice.readCount }</td>
		</tr>
	</c:forEach>
</table>

	<c:import url="/WEB-INF/views/common/pagingView.jsp" />

	<c:import url="/WEB-INF/views/common/footer.jsp"></c:import>
</body>
</html>