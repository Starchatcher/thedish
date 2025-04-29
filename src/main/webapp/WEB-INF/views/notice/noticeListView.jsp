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


body {
font-family: 'Arial', sans-serif;
background-color: #f4f4f4; / 배경 색상 */
margin: 0;
padding: 0;
}

h1 {
text-align: center;
color: #2c3e50; / 제목 색상 */
margin-top: 20px;
margin-bottom: 30px;
}
/* 검색 폼 스타일 */
#search-area {
text-align: center;
margin-bottom: 20px;
}
#searchForm {
display: flex;
justify-content: center;
align-items: center;
}
#search-type {
margin-right: 10px; /* 드롭다운과 입력란 사이의 간격 */
}

table {
width: 650px;
margin: 0 auto;
border-collapse: collapse; 
background-color: white; 
}
th, td {
border: 1px solid #8FBC8F; /* 테이블 셀 경계선 */
padding: 10px;
text-align: center;
}

th {
background-color: #2c3e50; 
color: white;
}

table td#title a {
text-decoration: none;
color: #2980b9; 
}
table td#title a:hover {
text-decoration: underline; 
color: #3498db;
}

@media (max-width: 700px) {
table {
width: 100%; 
}
h1 {
font-size: 24px; /* 제목 글자 크기 조정 */
}
#searchForm {
flex-direction: column; /* 검색폼 수직 정렬 */
}
#search-type {
margin-bottom: 10px; /* 드롭다운과 입력란 사이의 간격 조정 */
}

</style>

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"></c:import>

<h1>공지사항</h1>

<%
  // 기본 검색 타입을 설정 (기본은 제목)
  String defaultAction = request.getParameter("action");
  if (defaultAction == null) defaultAction = "제목";
%>
<%-- 항목별 검색 기능 추가 --%>
<div id="search-area">
<form id="searchForm" method="get">
   
    <select id="search-type" name="action" onchange="updateAction();">
        <option value="제목">제목</option>
        <option value="내용">내용</option>
    </select>

    <input type="text" id="search-query" name="keyword" placeholder="검색어를 입력하세요" required>
    <input type="submit" value="검색" />
</form>
</div>
<script type="text/javascript">
function updateAction() {
    var form = document.getElementById('searchForm');
    var searchType = document.getElementById('search-type').value;
   

    if (searchType === "제목") {
        form.action = "noticeSearchTitle.do";
    } else if (searchType === "작성자") {
        form.action = "noticeSearchContent.do";
    }
}

// 페이지 처음 로딩할 때도 form action 설정
window.onload = updateAction;
</script>



	<%-- 공지사항 목록 출력 --%>
	<table align="center" width="650" border="1" cellspacing="0"
		cellpadding="0">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="notice">
		<tr align="center">
			<td>${ notice.noticeId }</td>	<%-- 번호 --%>
			<td id="title">		
				 <c:url var="no" value="ndetail.do">
					<c:param name="no" value="${ notice.noticeId }" />
					<c:param name="page" value="${ nowpage }" />
				</c:url>
				<a href="${ no }">${ notice.title }</a>	<%-- 제목 --%>
			</td>
			<td>${ notice.createdBy }</td> <%-- 작성자 --%>
			<td>${ notice.createdAt }</td> <%-- 작성날짜 --%>
			<td>${ notice.readCount }</td> <%-- 조회수 --%>
		</tr> 
	</c:forEach>
</table>
<%-- << < 1 2 3 4 5 6 7 8 9 10 > >> 출력 : 공통 뷰로 따로 작업해서 import 해서 사용함 --%>
	<c:import url="/WEB-INF/views/common/sidebar.jsp" />
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
	<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>