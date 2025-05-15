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
<title>내 게시글</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style type="text/css">
/* 게시판 테이블 */
table#boardTable {
    width: 80%;
    margin: 30px auto;
    border-collapse: collapse;
    text-align: left;
    font-size: 14px;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    overflow: hidden;
    margin-bottom: 200px;
}

table#boardTable th,
table#boardTable td {
    padding: 14px;
    border-bottom: 1px solid #e0e0e0;
    color: #333333;
    text-align: center;
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
    width: 80%;
    margin: 40px auto 24px;
    text-align: center;
    color: #333333;
    border-bottom: 1px solid #e0e0e0;
    padding-bottom: 8px;
}

/* 글쓰기 버튼 */
.write-btn-wrap {
    width: 80%;
    margin: 0 auto 10px auto;
    text-align: right;
}

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

.table-action-buttons {
    display: flex;
    justify-content: right;
    gap: 6px;
}

.action-btn {
    padding: 4px 10px;
    border: none;
    border-radius: 5px;
    font-size: 13px;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.action-btn.edit {
    background-color: #d9eaff;
    color: #1a73e8;
}

.action-btn.edit:hover {
    background-color: #bcdfff;
}

.action-btn.delete {
    background-color: #ffe0e0;
    color: #e53935;
}

.action-btn.delete:hover {
    background-color: #ffcccc;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1 id="boardTitle">내 게시글</h1>
	
<div class="write-btn-wrap">
	<c:if test="${ !empty sessionScope.loginUser }">
		<button id="writeBtn" onclick="location.href='boardWritePage.do?source=my';">📝작성</button>
	</c:if>
</div>

<table id="boardTable">
	<tr>
		<th>조회수</th>
		<th>제목</th>
		<th>작성일</th>
		<th>좋아요</th>
		<th></th>
	</tr>
	<c:forEach items="${ list }" var="board">
	<tr align="center">
		<td>${ board.viewCount }</td>
		<td class="board-title">
			<c:url var="bd" value="boardDetail.do">
				<c:param name="boardId" value="${ board.boardId }" />
				<c:param name="page" value="${ nowpage }" />
				<c:param name="likeCount" value="${ board.likeCount }" />
				<c:param name="source" value="my" />
			</c:url>
			<a href="${ bd }">${ board.title } <span style="color: crimson;">[${ board.commentCount }]</span></a>
		</td>
		<td><fmt:formatDate value="${ board.createdAt }" pattern="yyyy-MM-dd HH:mm" /></td>
		<td>${ board.likeCount }</td>
		<td>
		  <c:if test="${loginUser.loginId eq board.writer || loginUser.role eq 'ADMIN'}">
		    <div class="table-action-buttons">
		      <form action="boardUpdatePage.do" method="get">
		        <input type="hidden" name="boardId" value="${board.boardId}" />
		        <input type="hidden" name="page" value="${nowpage}" />
		        <input type="hidden" name="source" value="my"/>
		        <button type="submit" class="action-btn edit">✏️ 수정</button>
		      </form>
		      <form action="boardDelete.do" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
		        <input type="hidden" name="boardId" value="${board.boardId}" />
		        <input type="hidden" name="page" value="${nowpage}" />
		        <input type="hidden" name="source" value="my"/>
		        <button type="submit" class="action-btn delete">🗑️ 삭제</button>
		      </form>
		    </div>
		  </c:if>
		</td>
	</tr>
	</c:forEach>
	<c:if test="${empty list}">
            <tr class="empty-row">
                <td colspan="5">작성한 게시글이 없습니다.</td>
            </tr>
    </c:if>
</table>
<c:if test="${paging.listCount > 10}">
    <c:import url="/WEB-INF/views/common/pagingView.jsp" />
</c:if>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
