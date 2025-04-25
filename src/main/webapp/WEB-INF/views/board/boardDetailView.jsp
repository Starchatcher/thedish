<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세보기</title>
<%-- 아래의 자바스크립트 함수에서 사용할 url 변수 만들기 --%>
<c:url var="boardDel" value="boardDelete.do">
	<c:param name="bno" value="${ board.boardId }" />
	<c:param name="page" value="${ currentPage }" />
</c:url>

<c:url var="boardUpdate" value="boardUpdateView.do">
	<c:param name="bno" value="${ board.boardId }" />
	<c:param name="page" value="${ currentPage }" />
</c:url>

<script type="text/javascript">
//삭제하기 버튼 클릭시 실행 함수
function requestDelete(){
	location.href = '${ boardDel }';	
}

//수정페이지로 이동 버튼 클릭시 실행 함수
function requestUpdatePage(){
	location.href = '${ boardUpdate }';
}

//목록 버튼 클릭시 실행 함수

</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td>${ board.title }</td></tr>
	<tr><th>작성자</th><td>${ board.loginId }</td></tr>
	<tr><th>등록날짜</th>
		<td><fmt:formatDate value="${ board.createdAt }" pattern="yyyy-MM-dd" /></td></tr>
	<tr><th>내 용</th><td>${ board.content }</td></tr>
	<tr><th colspan="2">
		<%-- 로그인한 경우에 표시되게 함 --%>
		<c:if test="${ !empty sessionScope.loginUser }">
			<%-- 본인이 작성한 글 또는 관리자이면 수정, 삭제 버튼 제공함 --%>
			<c:if test="${ loginUser.loginId eq board.loginId or loginUser.role eq 'ADMIN' }">
				<button onclick="requestUpdatePage(); return false;">수정페이지로 이동</button> &nbsp;
				<button onclick="requestDelete(); return false;">글삭제</button> &nbsp;
			</c:if>
			
			<%-- 본인이 작성한 글이 아니거나 관리자이면 댓글달기 버튼 표시함 --%>
			<c:if test="${ loginUser.loginId ne board.loginId or loginUser.role eq 'ADMIN' }">
					<button onclick="">댓글달기</button> &nbsp;
			</c:if>
		</c:if>
		<button onclick="location.href='boardList.do?page=${ requestScope.currentPage }';">전체게시판 목록</button> &nbsp;
		<button onclick="history.go(-1);">이전 페이지로 이동</button>
	</th></tr>
</table>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>