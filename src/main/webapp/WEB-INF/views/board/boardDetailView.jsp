<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/resources/css/style.css">

<style>
.container {
	max-width: 800px;
	margin: 40px auto;
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.title {
	font-size: 26px;
	font-weight: bold;
	margin-bottom: 10px;
}

.meta-info {
	font-size: 14px;
	color: #666;
	margin-bottom: 20px;
}

.content {
	font-size: 16px;
	margin-bottom: 30px;
	line-height: 1.7;
}

.attachment {
	margin-bottom: 20px;
	background: #f8f8f8;
	padding: 10px;
	border-radius: 8px;
}

.button-row {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 30px;
}

.button-row button {
	padding: 8px 16px;
	background-color: #90bc90;
	border: none;
	border-radius: 6px;
	color: white;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.button-row button:hover {
	background-color: #7da97d;
}

hr {
	margin: 20px 0 20px;
}
</style>

<script type="text/javascript">
function requestDelete(){
    const bno = '${board.boardId}';
    const page = '${currentPage}';
    const category = '${param.category}';

    location.href = '${pageContext.request.contextPath}/boardDelete.do?bno=' + bno + '&page=' + page + '&category=' + category;
}
function requestUpdatePage(){
    location.href = '${pageContext.request.contextPath}/boardUpdatePage.do?bno=${board.boardId}&page=${currentPage}';
}
function goToList(){
	const category = '${param.category}';
	const page = '${currentPage}';

	if (category == null || category == '' || category == 'all') {
		location.href = '${pageContext.request.contextPath}/boardList.do?page=1';
	} else {
		location.href = '${pageContext.request.contextPath}/boardList.do?category=' + category + '&page=1';
	}
}

</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />


	<div class="container">

		<div class="title">${board.title}</div>

		<div class="meta-info">
			작성자: ${board.nickname} | 작성일:
			<fmt:formatDate value="${board.createdAt}" pattern="yyyy.MM.dd. HH:mm" />
		</div>
<hr>
		<div class="content">${board.content}</div>

		<c:if test="${not empty board.originalFileName}">
			<div class="attachment">
				첨부파일: <a
					href="${pageContext.servletContext.contextPath}/boardFileDown.do?ofile=${board.originalFileName}&rfile=${board.renameFileName}">
					${board.originalFileName} </a>
			</div>
		</c:if>

		<%-- (여기에 나중에 댓글 영역 들어갈 예정) --%>

		<div class="button-row">
			<c:if test="${not empty sessionScope.loginUser}">
				<c:if
					test="${loginUser.loginId eq board.writer || loginUser.role eq 'ADMIN'}">
					<button type="button" onclick="requestUpdatePage();">수정</button>
					<button type="button" onclick="requestDelete();">삭제</button>
				</c:if>
			</c:if>
			<button type="button" onclick="history.back();">이전 페이지</button>
			<button type="button" onclick="goToList();">목록</button>
		</div>

	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
