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
<script>
    const commentCount = ${commentCount};
</script>
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
	background-color: #f9f9f9;
	padding: 15px;
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

/* 첨부파일 영역 */
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
	margin: 20px 0;
	border: 0;
	border-top: 1px solid #ddd;
}

/* 댓글 전체 영역 */
.comment-section {
	margin-top: 40px;
	background-color: #fafafa;
	padding: 15px;
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

/* 댓글 제목 */
.comment-title {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 15px;
	color: #333;
}

/* 댓글 박스 */
.comment-box {
	padding: 12px 16px;
	background-color: #f8f9fa;
	border-radius: 10px;
	margin-bottom: 14px;
	border: 1px solid #e0e0e0;
}

.comment-box.reply {
	margin-left: 24px;
	background-color: #fcfcfc;
	border-left: 3px solid #d0d0d0;
}

/* 댓글 메타 정보 */
.comment-meta {
	font-size: 13px;
	color: #888;
	margin-bottom: 6px;
}

/* 댓글 본문 */
.comment-content {
	font-size: 15px;
	line-height: 1.6;
	font-weight: 400;
	color: #333;
	padding: 6px 0;
	white-space: normal;
	word-break: break-word;
}

/* 댓글 입력 영역 (최상단 폼) */
.comment-form {
	margin-top: 30px;
	margin-bottom: 20px;
	background-color: #f8f8f8;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	position: relative; /* ⭐ 이게 핵심입니다 */
}

.comment-form textarea {
	width: 100%;
	height: 100px;
	padding: 12px 90px 12px 12px; /* ← 오른쪽 공간 확보 */
	border-radius: 8px;
	border: 1px solid #ccc;
	font-size: 14px;
	resize: vertical;
	background-color: #fdfdfd;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	transition: border-color 0.3s, box-shadow 0.3s;
	box-sizing: border-box;
	resize: none;
}

.comment-form textarea:focus {
	outline: none;
	border-color: #90bc90;
	box-shadow: 0 0 0 3px rgba(144, 188, 144, 0.2);
}

/* 공통 textarea 스타일 (대댓글, 수정 등) */
textarea {
	width: 100%;
	max-width: 100%;
	height: 80px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 14px;
	resize: none;
	box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
	box-sizing: border-box;
}

textarea:focus {
	outline: none;
	border-color: #90bc90;
	box-shadow: 0 0 0 3px rgba(144, 188, 144, 0.2);
}

/* 버튼 그룹 공통 */
.comment-buttons {
	display: flex;
	gap: 6px;
	flex-wrap: wrap;
	margin-top: 8px;
}

.comment-buttons button,
.comment-buttons form button,
.edit-buttons button {
	background-color: #e3e3e3;
	border: none;
	border-radius: 6px;
	padding: 5px 12px;
	font-size: 13px;
	cursor: pointer;
	transition: background-color 0.2s;
}

.comment-buttons button:hover,
.comment-buttons form button:hover,
.edit-buttons button:hover {
	background-color: #cfcfcf;
}

/* 수정 버튼 전용 */
.edit-buttons {
	margin-top: 8px;
	display: flex;
	gap: 6px;
}

/* 댓글 전용 작성 버튼 (오른쪽 하단 고정) */
.comment-submit-btn {
	position: absolute;
	top: auto;
	bottom: 40px; /* 더 위로 올림 */
	right: 27px;
	padding: 6px 14px;
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

.post-actions {
    text-align: center;
    margin-top: 20px;
    margin-bottom: 20px;
}

.post-actions button {
    font-size: 16px;
    padding: 10px 16px;
    margin: 0 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: 0.2s ease;
}

.like-btn {
    background-color: #ffecec;
    color: #d32f2f;
    font-size: 15px;
    border: none;
    border-radius: 6px;
    padding: 6px 14px;
    cursor: pointer;
    transition: 0.2s ease;
}

.like-btn:hover {
    background-color: #ffd4d4;
    font-family: Arial, sans-serif;
}

.report-btn {
    background-color: #f4f4f4;
    color: #333;
}

.report-btn:hover {
    background-color: #e0e0e0;
}

.go-list-btn-wrap {
    width: 100%;
    display: flex;
    justify-content: flex-end;
    padding: 20px 24px 40px 0;
}

.go-list-btn {
    background-color: #fff;
    border: 1px solid #ccc;
    color: #333;
    font-size: 14px;
    padding: 8px 18px;
    border-radius: 6px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    transition: all 0.2s ease;
    cursor: pointer;
}

.go-list-btn:hover {
    background-color: #f9f9f9;
    border-color: #999;
}

#like-count-display{
	margin-bottom:10px;
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
			${board.content}
		</div>
		
		<div class="post-actions">
		    <button class="like-btn" data-id="${board.boardId}">
			    <span class="like-icon">${liked ? '❤️ 좋아요' : '🤍 좋아요'}</span>
			</button>
			
			<c:if test="${ loginUser.role ne 'ADMIN' and loginUser.loginId ne board.writer }">
				<form id="reportForm" action="boardReportPage.do" method="get" style="display: inline;">
					<input type="hidden" name="targetId" value="${ board.boardId }">
					<input type="hidden" name="category" value="${ category }">
					<button type="submit">🚨 신고</button>
				</form>
			</c:if>
			
			<c:if test="${loginUser.loginId eq board.writer || loginUser.role eq 'ADMIN'}">
		        <form action="boardUpdatePage.do" method="get" style="display:inline;">
		            <input type="hidden" name="boardId" value="${board.boardId}" />
		            <input type="hidden" name="page" value="${currentPage}" />
		            <button type="submit" class="report-btn">✏️ 수정</button>
		        </form>
		
		        <form action="boardDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
		            <input type="hidden" name="boardId" value="${board.boardId}" />
		            <input type="hidden" name="category" value="${category}" />
		            <input type="hidden" name="page" value="${currentPage}" />
		            <button type="submit" class="report-btn">🗑️ 삭제</button>
		        </form>
		    </c:if>
		</div>
		
		
		
		<c:if test="${not empty board.originalFileName}">
			<div class="attachment">
				<h4>첨부파일</h4>
				<a href="${pageContext.servletContext.contextPath}/boardFileDown.do?ofile=${board.originalFileName}&rfile=${board.renameFileName}">
					${board.originalFileName}
				</a>
			</div>
		</c:if>
		
<!-- 댓글 출력 -->
<div class="comment-section">
    <div id="like-count-display">
	    댓글 ${commentCount} &nbsp; ❤️ <span id="like-num">${board.likeCount}</span>
	</div>

    <c:forEach var="c" items="${commentList}">
        <c:if test="${empty c.parentId}">
            <!-- 부모 댓글 -->
            <div class="comment-box">
                <div class="comment-meta">
                    <strong>${c.nickName}</strong> |
                    <fmt:formatDate value="${c.createdAt}" pattern="MM.dd HH:mm" />
                </div>

                <div class="comment-content">
				    <c:choose>
				        <c:when test="${not empty editCommentId and editCommentId eq c.commentId}">
				            <form action="boardCommentUpdate.do" method="post">
				                <input type="hidden" name="commentId" value="${c.commentId}" />
				                <input type="hidden" name="boardId" value="${board.boardId}" />
				                <input type="hidden" name="category" value="${param.category}" />
				                <textarea name="content" required style="width:100%; height:80px;">${c.content}</textarea>
				                <div class="edit-buttons" style="margin-top:8px;">
				                    <button type="submit">저장</button>
				                    <a href="boardDetail.do?boardId=${board.boardId}&category=${param.category}">
				                        <button type="button">취소</button>
				                    </a>
				                </div>
				            </form>
				        </c:when>
				        <c:otherwise>
				            ${c.content}
				        </c:otherwise>
				    </c:choose>
				</div>

                <c:if test="${empty editCommentId or editCommentId ne c.commentId}">
				    <div class="comment-buttons">
				        <!-- 답글달기 -->
				        <c:if test="${ !empty loginUser.loginId }">
				        <form action="boardDetail.do" method="get" style="display:inline;">
				            <input type="hidden" name="boardId" value="${board.boardId}" />
				            <input type="hidden" name="category" value="${param.category}" />
				            <input type="hidden" name="replyTargetId" value="${c.commentId}" />
				            <button type="submit">답글달기</button>
				        </form>
				        </c:if>
				
				        <!-- 수정/삭제 버튼 -->
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
				    </div>
				</c:if>

                <!-- 대댓글 작성 폼 -->
                <c:if test="${param.replyTargetId eq c.commentId}">
				    <form action="boardReplyInsert.do" method="post" style="margin-top: 8px;">
				        <input type="hidden" name="boardId" value="${board.boardId}" />
				        <input type="hidden" name="parentId" value="${c.commentId}" />
				        <input type="hidden" name="category" value="${param.category}" />
				        <textarea name="content" required placeholder="답글 입력"></textarea>
				
				        <div class="comment-buttons">
				            <button type="submit">등록</button>
				            <button type="button"
				                    onclick="location.href='boardDetail.do?boardId=${board.boardId}&category=${param.category}'">취소</button>
				        </div>
				    </form>
				</c:if>
            </div>

            <!-- 대댓글 루프: 부모 댓글 바로 아래 출력 -->
            <c:forEach var="r" items="${commentList}">
                <c:if test="${r.parentId eq c.commentId}">
                    <div class="comment-box reply">
                        <div class="comment-meta">
                            <strong>${r.nickName}</strong> |
                            <fmt:formatDate value="${r.createdAt}" pattern="MM.dd HH:mm" />
                        </div>

                        <!-- 대댓글 수정 or 보기 -->
                        <div class="comment-content">
                            <c:choose>
                                <c:when test="${not empty editCommentId and editCommentId eq r.commentId}">
                                    <form action="boardCommentUpdate.do" method="post">
                                        <input type="hidden" name="commentId" value="${r.commentId}" />
                                        <input type="hidden" name="boardId" value="${board.boardId}" />
                                        <input type="hidden" name="category" value="${param.category}" />
                                        <textarea name="content" required style="width:100%; height:80px;">${r.content}</textarea>
                                        <div class="edit-buttons" style="margin-top:8px;">
                                            <button type="submit">저장</button>
                                            <a href="boardDetail.do?boardId=${board.boardId}&category=${param.category}">
                                                <button type="button">취소</button>
                                            </a>
                                        </div>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    ${r.content}
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- 대댓글 버튼 -->
                        <c:if test="${loginUser.loginId eq r.loginId || loginUser.role eq 'ADMIN'}">
						    <c:if test="${empty editCommentId or editCommentId ne r.commentId}">
						        <div class="comment-buttons" style="margin-top: 8px;">
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
						        </div>
						    </c:if>
						</c:if>

                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </c:forEach>
</div>

<!-- 새 댓글 작성 폼 -->
<c:if test="${!empty sessionScope.loginUser}">
    <div class="comment-form" style="margin-top: 30px;">
        <form action="boardCommentInsert.do" method="post">
            <input type="hidden" name="boardId" value="${board.boardId}" />
            <input type="hidden" name="category" value="${param.category}" />
            <textarea name="content" placeholder="댓글을 입력하세요" required style="width:100%; height:80px;"></textarea>
            <div style="margin-top: 8px;">
                <button class="comment-submit-btn" type="submit">작성</button>
            </div>
        </form>
    </div>
</c:if>

<div class="go-list-btn-wrap">
    <button type="button" class="go-list-btn" onclick="goList();">📋 목록</button>
</div>

<c:if test="${param.reportSuccess eq 'true'}">
    <script>
        alert('🚨 신고가 완료되었습니다.');
    </script>
</c:if>

<c:import url="/WEB-INF/views/common/footer.jsp" />	

<script type="text/javascript">
    const boardId = '${board.boardId}';
    const category = '${param.category}';
    const page = '${currentPage}';
    const ctx = '${pageContext.request.contextPath}';
    
    // 댓글 지우기
    window.requestDelete = function() {
        location.href = `${ctx}/boardDelete.do?boardId=${boardId}&page=${page}&category=${category}`;
    }

    // 댓글 수정하기
    window.requestUpdatePage = function() {
        location.href = `${ctx}/boardUpdatePage.do?boardId=${boardId}&page=${page}`;
    }

    // 목록
    window.goList = function() {
        if (!category || category === 'all' || category === 'indefined') {
            location.href = ctx + `/boardList.do?page=1`;
        } else {
            location.href = ctx + `/boardList.do?category=${category}&page=1`;
        }
    }
    
    $(document).ready(function () {
        // JSP 변수 commentCount를 JavaScript로 전달
        const commentCount = ${commentCount};

        $('.like-btn').on('click', function () {
            const boardId = $(this).data('id');
            toggleLike(boardId, this, commentCount);
        });
    });

    function toggleLike(boardId, buttonElement, commentCount) {
        if (!boardId) {
            console.error("❗ boardId 값이 없습니다.");
            return;
        }

        const loginId = '${sessionScope.loginUser.loginId}';
        if (!loginId) {
            alert("로그인이 필요합니다.");
            location.href = 'loginPage.do';
            return;
        }

        $.ajax({
            url: 'toggleLike.do',
            method: 'post',
            contentType: 'application/json',
            data: JSON.stringify({ loginId, targetId: boardId }),
            success: function (response) {
                const $btn = $(buttonElement);
                const count = response.likeCount;

                // 텍스트만 교체
                const iconText = (response.status === 'liked')
                    ? '❤️ 좋아요'
                    : '🤍 좋아요';

                $btn.find('.like-icon').text(iconText); // ← 버튼 안 이모지만 바꿔줌

                // 댓글 + 좋아요 숫자만 교체
                $('#like-num').text(count);
            },
            error: function () {
                alert('좋아요 처리 중 오류가 발생했습니다.');
            }
        });
    }

</script>
</body>
</html>