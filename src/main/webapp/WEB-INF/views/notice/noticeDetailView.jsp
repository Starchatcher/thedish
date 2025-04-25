<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h1 align="center">${ requestScope.notice.noticeId } 번 공지글 상세보기</h1>
<br>
<table align="center" width="650" border="1" cellspacing="0"
		cellpadding="0">
		
			<tr><th>번호</th><td>${ requestScope.notice.noticeId }</td></tr>
			<tr><th>제목</th><td>${ requestScope.notice.title }</td></tr>
			<tr><th>작성자</th><td>${ requestScope.notice.createdBy }</td></tr>
			<tr><th>작성일</th><td>${ requestScope.notice.createdAt }</td></tr>
			<tr><th>조회수</th><td>${ requestScope.notice.readCount }</td></tr>
		<tr><th>내 용</th><td>${ requestScope.notice.content }</td></tr>
		<tr><th colspan="2">
		<button onclick="location.href='noticeList.do?page=1';">목록</button> &nbsp;
		<button onclick="history.go(-1);">이전 페이지로 이동</button>
	</th></tr>
</table>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>