<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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

/* 게시글 내용 영역 */
.content {
    font-size: 16px;
    margin-bottom: 30px;
    line-height: 1.7;
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

/* 댓글 영역 */
.comment-section {
    margin-top: 40px;
    background-color: #fafafa;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

/* 댓글 제목 스타일 */
.comment-title {
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
}

/* 댓글 박스 스타일 */
.comment-box {
    padding: 12px 16px;
    background-color: #f8f9fa;
    border-radius: 10px;
    margin-bottom: 14px;
    border: 1px solid #e0e0e0;
}

.comment-buttons {
    display: flex;
    gap: 6px;
    flex-wrap: wrap;
}

.comment-buttons button,
.comment-buttons form button {
    background-color: #e3e3e3;
    border: none;
    border-radius: 6px;
    padding: 5px 12px;
    font-size: 13px;
    cursor: pointer;
    transition: background-color 0.2s;
}

.comment-buttons button:hover {
    background-color: #cfcfcf;
}

.comment-meta {
    font-size: 13px;
    color: #888;
    margin-bottom: 6px;
}

.comment-content {
    font-size: 15px;
    line-height: 1.6;
    font-weight: 400;        /* 일반 굵기 */
    color: #333;             /* 너무 진하지 않게 */
    padding: 6px 0;
    white-space: normal;
    word-break: break-word;
}

/* 댓글 박스 구분선 */
hr {
    margin: 20px 0;
    border: 0;
    border-top: 1px solid #ddd;
}

.comment-form {
    margin-top: 30px;
    background-color: #f8f8f8;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    position: relative;
}

.comment-form textarea {
    width: 100%;
    height: 100px;
    padding: 12px 90px 12px 12px; /* 오른쪽 공간 확보 */
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
    resize: vertical;
    background-color: #fdfdfd;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    transition: border-color 0.3s, box-shadow 0.3s;
    box-sizing: border-box;
}

.comment-form textarea:focus {
    outline: none;
    border-color: #90bc90;
    box-shadow: 0 0 0 3px rgba(144, 188, 144, 0.2);
}

.comment-submit-btn {
    position: absolute;
    bottom: 20px;
    right: 20px;
    padding: 8px 16px;
    background-color: #90bc90;
    border: none;
    border-radius: 6px;
    color: white;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.comment-submit-btn:hover {
    background-color: #7da97d;
}

.comment-box.reply {
    margin-left: 24px;
    background-color: #fcfcfc;
    border-left: 3px solid #d0d0d0;
}

textarea {
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    padding: 10px;
    width: 100%;
    resize: vertical;
    box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
}

textarea:focus {
    outline: none;
    border-color: #90bc90;
    box-shadow: 0 0 0 3px rgba(144, 188, 144, 0.2);
}

#replyForm-123 {
    margin-top: 10px;
}

.edit-buttons button {
    background-color: #e3e3e3;
    border: none;
    border-radius: 6px;
    padding: 5px 12px;
    font-size: 13px;
    cursor: pointer;
    transition: background-color 0.2s;
    margin-right: 6px;
}

.edit-buttons button:hover {
    background-color: #cfcfcf;
}

.comment-content textarea {
    width: 100%;
    max-width: 100%;
    box-sizing: border-box;
    padding: 10px;
    font-size: 14px;
    border-radius: 6px;
    border: 1px solid #ccc;
    resize: vertical;
}
</style>


</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />


	<div class="container">

		<div class="title">${board.title}</div>

		<div class="meta-info">
			${board.nickname} &nbsp; | &nbsp;
			<fmt:formatDate value="${board.createdAt}" pattern="yyyy.MM.dd" />
		</div>
		<hr>
		
		<div class="content">
			<!-- 게시글 내용 출력 -->
			${board.content} <!-- HTML 형태로 저장된 게시글 내용 출력 -->

			<!-- 첨부파일을 게시글 내용 중간에 삽입 -->
			<c:if test="${not empty board.originalFileName}">
				<c:set var="ext" value="${fn:toLowerCase(fn:substringAfter(board.originalFileName, '.'))}"/>

				<c:choose>
					<c:when test="${ext eq 'jpg' || ext eq 'jpeg' || ext eq 'png' || ext eq 'gif' || ext eq 'webp'}">
						<!-- 이미지 파일을 게시글 내용 중에 삽입 -->
						<p>
							<img src="${pageContext.servletContext.contextPath}/resources/board_upfiles/${board.renameFileName}"
								alt="${board.originalFileName}" style="max-width: 100%; height: auto; border-radius: 6px; margin-top: 10px;" />
						</p>
					</c:when>
					<c:otherwise>
						<!-- 다른 파일은 다운로드 링크로 삽입 -->
						<a href="${pageContext.servletContext.contextPath}/boardFileDown.do?ofile=${board.originalFileName}&rfile=${board.renameFileName}">
							${board.originalFileName} 다운로드
						</a>
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
		
		<!-- 댓글 출력 -->
<div class="comment-section">
    <div class="comment-title">댓글 ${commentCount}</div>

    <c:forEach var="c" items="${commentList}">
        <c:if test="${empty c.parentId}">
            <!--  부모 댓글 -->
            <div class="comment-box">
                <div class="comment-meta">
                    <strong>${c.nickName}</strong> |
                    <fmt:formatDate value="${c.createdAt}" pattern="MM.dd HH:mm" />
                </div>

                <!-- 댓글 내용 or 수정 폼 -->
                <div class="comment-content">
                    <c:choose>
                        <c:when test="${not empty editCommentId and editCommentId eq c.commentId}">
                            <form action="boardCommentUpdate.do" method="post">
                                <input type="hidden" name="commentId" value="${c.commentId}" />
                                <input type="hidden" name="boardId" value="${board.boardId}" />
                                <input type="hidden" name="category" value="${param.category}" />
                                <textarea name="content" style="width:100%; height:80px;">${c.content}</textarea>
                                <div class="edit-buttons" style="margin-top:8px;">
                                    <button type="submit">저장</button>
                                    <a href="boardDetail.do?boardId=${board.boardId}&category=${param.category}">
                                        <button type="button">취소</button>
                                    </a>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
						   ${ c.content }
						</c:otherwise>
                    </c:choose>
                </div>

                <!-- 버튼: 수정 중일 때 숨김 -->
                <c:if test="${empty editCommentId or editCommentId ne c.commentId}">
                    <div class="comment-buttons" style="margin-top: 8px;">
                        <c:if test="${loginUser.loginId eq c.loginId || loginUser.role eq 'ADMIN'}">
                            <form action="boardDetail.do" method="get" style="display:inline;">
                                <input type="hidden" name="boardId" value="${board.boardId}" />
                                <input type="hidden" name="category" value="${param.category}" />
                                <input type="hidden" name="editCommentId" value="${c.commentId}" />
                                <button type="submit">수정</button>
                            </form>
                            <form action="boardCommentDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                <input type="hidden" name="commentId" value="${c.commentId}" />
                                <input type="hidden" name="boardId" value="${board.boardId}" />
                                <input type="hidden" name="category" value="${param.category}" />
                                <button type="submit">삭제</button>
                            </form>
                        </c:if>
                        <c:if test="${!empty sessionScope.loginUser}">
                           <button type="button" onclick="toggleReplyForm(${c.commentId})">답글달기</button>
                        </c:if>
                    </div>
                    <div id="replyForm-${c.commentId}" style="margin-top: 8px;"></div>
                </c:if>
            </div>

            <!-- 🔵 대댓글 출력 -->
            <c:forEach var="r" items="${commentList}">
                <c:if test="${r.parentId eq c.commentId}">
                    <div class="comment-box reply">
                        <div class="comment-meta">
                            <strong>${r.nickName}</strong> |
                            <fmt:formatDate value="${r.createdAt}" pattern="MM.dd HH:mm" />
                        </div>
                        <div class="comment-content">${r.content}</div>
                        <div class="comment-buttons" style="margin-top: 8px;">
                            <c:if test="${loginUser.loginId eq board.writer || loginUser.role eq 'ADMIN'}">
                                <form action="boardDetail.do" method="get" style="display:inline;">
                                    <input type="hidden" name="boardId" value="${board.boardId}" />
                                    <input type="hidden" name="category" value="${param.category}" />
                                    <input type="hidden" name="editCommentId" value="${r.commentId}" />
                                    <button type="submit">수정</button>
                                </form>
                                <form action="boardCommentDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                    <input type="hidden" name="commentId" value="${r.commentId}" />
                                    <input type="hidden" name="boardId" value="${board.boardId}" />
                                    <input type="hidden" name="category" value="${param.category}" />
                                    <button type="submit">삭제</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

        </c:if>
    </c:forEach>
</div>

		
		<!-- 댓글 작성 폼 -->
		<c:if test="${!empty sessionScope.loginUser}">
		    <div class="comment-form">
		        <form action="boardCommentInsert.do" method="post">
		            <input type="hidden" name="boardId" value="${board.boardId}">
		            <input type="hidden" name="category" value="${board.boardCategory}">
		            <div style="position: relative;">
		                <textarea name="content" id="commentContent" placeholder="댓글을 작성하세요." required></textarea>
		                <input type="submit" value="작성" class="comment-submit-btn">
		            </div>
		        </form>
		    </div>
		</c:if>

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
<script type="text/javascript">

const boardId = '${board.boardId}';
const category = '${param.category}';

function requestDelete(){
    const boardId = '${board.boardId}';
    const page = '${currentPage}';
    const category = '${param.category}';

    location.href = '${pageContext.request.contextPath}/boardDelete.do?boardId=' + boardId + '&page=' + page + '&category=' + category;
}
function requestUpdatePage(){
    location.href = '${pageContext.request.contextPath}/boardUpdatePage.do?boardId=${board.boardId}&page=${currentPage}';
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





function toggleReplyForm(commentId) {
    const container = document.getElementById(`replyForm-${commentId}`);
    if (!container) return;

    if (container.innerHTML.trim() !== "") {
        container.innerHTML = "";
        return;
    }
    
    console.log("댓글 ID:", commentId);
    console.log("boardId:", boardId);
    console.log("category:", category);

    container.innerHTML = `
        <form action="boardCommentInsert.do" method="post" class="reply-form">
            <input type="hidden" name="boardId" value="` + boardId + `" />
            <input type="hidden" name="parentId" value="` + commentId + `" />
            <input type="hidden" name="category" value="` + category + `" />
            <textarea name="content" placeholder="답글을 입력하세요" required></textarea>
            <div class="reply-buttons">
                <button type="submit">등록</button>
                <button type="button" onclick="cancelReplyForm(` + commentId + `)">취소</button>
            </div>
        </form>
    `;
}

function cancelReplyForm(commentId) {
    const container = document.getElementById(`replyForm-${commentId}`);
    if (container) container.innerHTML = "";
}

</script>
</body>
</html>