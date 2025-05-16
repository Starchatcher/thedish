<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setTimeZone value="Asia/Seoul" />

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
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
}

.container:last-of-type {
  margin-bottom: 60px; /* footer와의 간격 확보 */
}

.title {
   font-size: 24px;
   font-weight: 600;
   margin-bottom: 10px;
   color: #2e2e2e;
}

.meta-info {
   font-size: 13px;
   color: #777;
   margin-bottom: 20px;
}

.content {
   font-size: 15px;
   margin-bottom: 30px;
   line-height: 1.7;
   background-color: #fafafa;
   padding: 16px;
   border-radius: 8px;
   color: #2e2e2e;
   box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
}

/* 첨부파일 영역 */
.attachment {
   margin-bottom: 20px;
   background: #f5f5f5;
   padding: 10px;
   border-radius: 8px;
   color: #444;
}

.button-row {
   display: flex;
   justify-content: flex-end;
   gap: 10px;
   margin-top: 30px;
}

.button-row button {
   padding: 8px 16px;
   background-color: #888;
   border: none;
   border-radius: 6px;
   color: white;
   font-size: 14px;
   cursor: pointer;
   transition: background-color 0.2s ease;
}

.button-row button:hover {
   background-color: #555;
}

hr {
   margin: 20px 0;
   border: 0;
   border-top: 1px solid #ddd;
}

/* 댓글 영역 */
.comment-section {
   max-width: 800px;
   margin: 0 auto;
   background-color: transparent;
   padding: 15px;
   border-radius: 8px;
   box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
   box-sizing: border-box;
}

.comment-title {
   font-size: 14px;
   font-weight: 600;
   margin-bottom: 15px;
   color: #2e2e2e;
}

.comment-box {
   padding: 12px 16px;
   background-color: #ffffff; /* 순수 흰색 */
   border-radius: 10px;
   margin-bottom: 14px;
   border: 1px solid #e0e0e0;
   width: 100%;
    box-sizing: border-box;
   
}

.comment-box.reply {
   margin-left: 24px;
   background-color: #ffffff; /* 순수 흰색 */
   border-left: 3px solid #d0d0d0;
}

.comment-meta {
   font-size: 13px;
   color: #888;
   margin-bottom: 6px;
}

.comment-content {
   font-size: 15px;
   line-height: 1.6;
   color: #2e2e2e;
   padding: 6px 0;
   word-break: break-word;
}

.comment-form {
   margin: 30px auto 20px auto;
   background-color: #f8f8f8;
   padding: 20px;
   border-radius: 8px;
   max-width: 800px;
   box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
   box-sizing: border-box;
   position: relative;
}

.comment-form textarea {
   width: 100%;
   height: 100px;
   padding: 12px 90px 12px 12px;
   border-radius: 8px;
   border: 1px solid #ccc;
   font-size: 14px;
   background-color: #fdfdfd;
   transition: border-color 0.2s, box-shadow 0.2s;
   box-sizing: border-box;
   resize: none;
}

.comment-form textarea:focus {
   outline: none;
   border-color: #aaa;
   box-shadow: 0 0 0 3px rgba(160, 160, 160, 0.2);
}

textarea {
   width: 100%;
   max-width: 100%;
   height: 80px;
   padding: 10px;
   border: 1px solid #ccc;
   border-radius: 6px;
   font-size: 14px;
   resize: none;
   box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
   box-sizing: border-box;
}

textarea:focus {
   outline: none;
   border-color: #aaa;
   box-shadow: 0 0 0 3px rgba(160, 160, 160, 0.2);
}

/* 공통 버튼 그룹 */
.comment-buttons,
.edit-buttons {
   display: flex;
   gap: 6px;
   flex-wrap: wrap;
   margin-top: 8px;
}

.comment-buttons button,
.comment-buttons form button,
.edit-buttons button {
   background-color: #e0e0e0;
   border: none;
   border-radius: 6px;
   padding: 5px 12px;
   font-size: 13px;
   cursor: pointer;
   transition: background-color 0.2s;
   color: #333;
}

.comment-buttons button:hover,
.comment-buttons form button:hover,
.edit-buttons button:hover {
   background-color: #ccc;
}

/* 댓글 전용 작성 버튼 */
.comment-submit-btn {
   position: absolute;
   bottom: 40px;
   right: 27px;
   padding: 6px 14px;
   background-color: #888;
   border: none;
   border-radius: 6px;
   color: white;
   font-size: 13px;
   cursor: pointer;
   transition: background-color 0.2s ease;
}

.comment-submit-btn:hover {
   background-color: #555;
}

.post-actions {
   text-align: center;
   margin-top: 20px;
   margin-bottom: 20px;
}

/* 좋아요 버튼 (기존 그대로 유지) */
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

/* 신고 버튼 – 스타일 통일, 색상만 다르게 */
.report-btn {
   background-color: #fff5e6;     /* 연한 주황 배경 */
   color: #d35400;                /* 주황 텍스트 */
   font-size: 15px;
   border: none;
   border-radius: 6px;
   padding: 6px 14px;
   cursor: pointer;
   transition: background-color 0.2s ease;
}

.report-btn:hover {
   background-color: #ffe3c6;
}

/* 리스트로 돌아가기 */
.go-list-btn-wrap {
  max-width: 800px;         /* 본문 영역과 폭 통일 */
  margin: 20px auto 0 auto; /* 가운데 정렬 */
  text-align: right;        /* 내부 버튼 우측 정렬 */
  margin-bottom: 30px;
}

.go-list-btn {
  background-color: #fff;
  border: 1px solid #ccc;
  color: #333;
  font-size: 14px;
  padding: 8px 18px;
  border-radius: 6px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
  transition: all 0.2s ease;
  cursor: pointer;
}

.go-list-btn:hover {
   background-color: #f9f9f9;
   border-color: #999;
}

#like-count-display {
   margin-bottom: 10px;
}

.comment-pagination {
  display: flex;
  justify-content: center;
  gap: 6px;
  margin-top: 20px;
}

.comment-pagination .page-link {
  padding: 6px 12px;
  background-color: #f1f1f1;
  color: #333;
  border: 1px solid #ccc;
  border-radius: 5px;
  text-decoration: none;
  font-size: 14px;
  transition: background-color 0.2s ease;
}

.comment-pagination .page-link:hover {
  background-color: #ddd;
}

.comment-pagination .page-link.active {
  background-color: #4A5568;
  color: #fff;
  font-weight: bold;
  pointer-events: none;
  border-color: #4A5568;
}

.hidden-reply {
    display: none;
}
.more-reply-btn {
    margin: 6px 0 10px 40px;
    padding: 4px 8px;
    font-size: 0.85em;
    cursor: pointer;
}

.more-reply-btn {
    background-color: #e0e0e0;
    border: none;
    border-radius: 6px;
    padding: 5px 12px;
    font-size: 13px;
    cursor: pointer;
    color: #333;
    transition: background-color 0.2s;
    margin: 6px 0 10px 40px;
}

.more-reply-btn:hover {
    background-color: #ccc;
}
</style>

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />


   <div class="container">

      <div class="title">${board.title}</div>

      <div class="meta-info">
        ${board.nickname} &nbsp; | &nbsp;
        <fmt:formatDate value="${board.createdAt}" pattern="yyyy.MM.dd HH:mm" />
        <c:if test="${not empty board.updatedAt}">
          &nbsp;<span style="color: #999;">(수정됨: 
            <fmt:formatDate value="${board.updatedAt}" pattern="yyyy.MM.dd HH:mm" />
          )</span>
        </c:if>
      </div>

      <hr>
      
      <div class="content">
         ${board.content}
         <c:if test="${not empty board.originalFileName}">
            <div class="attachment">
               <a href="${pageContext.servletContext.contextPath}/boardFileDown.do?ofile=${board.originalFileName}&rfile=${board.renameFileName}">
                  ${board.originalFileName}
               </a>
            </div>
         </c:if>
      </div>
      
      <div class="post-actions">
          <button class="like-btn" data-id="${board.boardId}">
             <span class="like-icon">${liked ? '❤️ 좋아요' : '🤍 좋아요'}</span>
         </button>
         
         <c:if test="${ loginUser.role ne 'ADMIN' and loginUser.loginId ne board.writer }">
            <form id="reportForm" action="boardReportPage.do" method="get" style="display: inline;">
			   <input type="hidden" name="targetId" value="${board.boardId}">
			   <input type="hidden" name="category" value="${param.category}">
			   <button type="submit" class="report-btn" onclick="return checkLogin()">🚨 신고</button>
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
        <c:choose>
          <c:when test="${not empty c.updatedAt}">
            <fmt:formatDate value="${c.updatedAt}" pattern="MM.dd HH:mm" />
            &nbsp;<span style="color:#aaa;">수정됨</span>
          </c:when>
          <c:otherwise>
            <fmt:formatDate value="${c.createdAt}" pattern="MM.dd HH:mm" />
          </c:otherwise>
        </c:choose>
      </div>

      <div class="comment-content">
        <c:choose>
          <c:when test="${not empty editCommentId and editCommentId eq c.commentId}">
            <form action="boardCommentUpdate.do" method="post">
              <input type="hidden" name="commentId" value="${c.commentId}" />
              <input type="hidden" name="boardId" value="${board.boardId}" />
              <input type="hidden" name="category" value="${param.category}" />
              <input type="hidden" name="page" value="${currentPage}" />
              <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
              <textarea name="content" required style="width:100%; height:80px;">${c.content}</textarea>
              <div class="edit-buttons" style="margin-top:8px;">
                <button type="submit">저장</button>
                <button type="button"
               onclick="location.href='boardDetail.do?boardId=${board.boardId}&category=${param.category}&page=${currentPage}&cpage=${commentPaging.currentPage}'">
               취소
             </button>

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
          <c:if test="${ !empty loginUser.loginId }">
            <form action="boardDetail.do" method="get" style="display:inline;">
              <input type="hidden" name="boardId" value="${board.boardId}" />
              <input type="hidden" name="category" value="${param.category}" />
              <input type="hidden" name="replyTargetId" value="${c.commentId}" />
              <input type="hidden" name="page" value="${currentPage}" />
              <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
              <button type="submit">답글달기</button>
            </form>
          </c:if>

          <c:if test="${loginUser.loginId eq c.loginId || loginUser.role eq 'ADMIN'}">
            <form action="boardDetail.do" method="get" style="display:inline;">
              <input type="hidden" name="boardId" value="${board.boardId}" />
              <input type="hidden" name="category" value="${param.category}" />
              <input type="hidden" name="editCommentId" value="${c.commentId}" />
              <input type="hidden" name="page" value="${currentPage}" />
              <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
              <button type="submit">수정</button>
            </form>
            <form action="boardCommentDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
              <input type="hidden" name="commentId" value="${c.commentId}" />
              <input type="hidden" name="boardId" value="${board.boardId}" />
              <input type="hidden" name="category" value="${param.category}" />
              <input type="hidden" name="page" value="${currentPage}" />
              <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
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
          <input type="hidden" name="page" value="${currentPage}" />
          <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
          <textarea name="content" class="editor" placeholder="내용을 입력해 주세요."
          oninput="limitByte(this, 4000)" required></textarea>
          <div class="edit-buttons" style="margin-top:8px;">
            <button type="submit">등록</button>
            <button type="button" onclick="location.href='boardDetail.do?boardId=${board.boardId}&category=${param.category}'">취소</button>
          </div>
        </form>
      </c:if>
    </div>

    <!-- 대댓글 전체 출력 (JS로 3개만 보이게) -->
   <c:forEach var="r" items="${replyList}">
     <c:if test="${r.parentId eq c.commentId}">
       <c:set var="visibleReplyCount" value="${visibleReplyCount + 1}" />
       <c:choose>
         <c:when test="${visibleReplyCount > 3 and (empty editCommentId or editCommentId ne r.commentId)}">
           <div class="comment-box reply hidden-reply" data-parent="${r.parentId}" data-comment-id="${r.commentId}">
         </c:when>
         <c:otherwise>
           <div class="comment-box reply" data-parent="${r.parentId}" data-comment-id="${r.commentId}">
         </c:otherwise>
       </c:choose>
        
       
          <div class="comment-meta">
           <strong>${r.nickName}</strong> |
           <c:choose>
             <c:when test="${not empty r.updatedAt}">
               <fmt:formatDate value="${r.updatedAt}" pattern="MM.dd HH:mm" />
               &nbsp;<span style="color:#aaa;">수정됨</span>
             </c:when>
             <c:otherwise>
               <fmt:formatDate value="${r.createdAt}" pattern="MM.dd HH:mm" />
             </c:otherwise>
           </c:choose>
         </div>

          <div class="comment-content">
            <c:choose>
              <c:when test="${not empty editCommentId and editCommentId eq r.commentId}">
                <form action="boardCommentUpdate.do" method="post">
                  <input type="hidden" name="commentId" value="${r.commentId}" />
                  <input type="hidden" name="boardId" value="${board.boardId}" />
                  <input type="hidden" name="category" value="${param.category}" />
                  <input type="hidden" name="page" value="${currentPage}" />
                  <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
                  <textarea name="content" oninput="limitByte(this, 4000)" required style="width:100%; height:80px;">${r.content}</textarea>
                  <div class="edit-buttons" style="margin-top:8px;">
                    <button type="submit">저장</button>
                    <a href="boardDetail.do?boardId=${board.boardId}&category=${param.category}&page=${currentPage}&cpage=${commentPaging.currentPage}">
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
      <c:if test="${empty editCommentId or editCommentId ne r.commentId}">
          <c:if test="${loginUser.loginId eq r.loginId || loginUser.role eq 'ADMIN'}">
            <div class="comment-buttons" style="margin-top: 8px;">
              <form action="boardDetail.do" method="get" style="display:inline;">
                <input type="hidden" name="boardId" value="${board.boardId}" />
                <input type="hidden" name="category" value="${param.category}" />
                <input type="hidden" name="editCommentId" value="${r.commentId}" />
                <input type="hidden" name="page" value="${currentPage}" />
                <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
                <button type="submit">수정</button>
              </form>
              <form action="boardCommentDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="commentId" value="${r.commentId}" />
                <input type="hidden" name="boardId" value="${board.boardId}" />
                <input type="hidden" name="category" value="${param.category}" />
                <input type="hidden" name="page" value="${currentPage}" />
                <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
                <button type="submit">삭제</button>
              </form>
            </div>
          </c:if>
         </c:if>
        </div>
      </c:if>

    </c:forEach>
    <c:set var="replyCount" value="0" />
   <c:forEach var="r" items="${replyList}">
     <c:if test="${r.parentId eq c.commentId}">
       <c:set var="replyCount" value="${replyCount + 1}" />
     </c:if>
   </c:forEach>
   
   <c:if test="${visibleReplyCount > 3}">
     <button class="more-reply-btn" data-parent-id="${c.commentId}" data-expanded="false">더보기</button>
   </c:if>
  </c:if>
</c:forEach>
<!-- 댓글 페이징 -->
<c:if test="${commentPaging.maxPage > 1}">
  <div class="comment-pagination">
    <c:forEach var="p" begin="${commentPaging.startPage}" end="${commentPaging.endPage}">
      <a href="boardDetail.do?boardId=${board.boardId}&category=${category}&page=${currentPage}&cpage=${p}"
         class="page-link ${p == commentPaging.currentPage ? 'active' : ''}">
        ${p}
      </a>
    </c:forEach>
  </div>
</c:if>

<!-- 새 댓글 작성 폼 -->
<c:if test="${!empty sessionScope.loginUser}">
    <div class="comment-form" style="margin-top: 30px;">
        <form action="boardCommentInsert.do" method="post">
            <input type="hidden" name="boardId" value="${board.boardId}" />
            <input type="hidden" name="category" value="${param.category}" />
            <input type="hidden" name="page" value="${currentPage}" />
          <input type="hidden" name="cpage" value="${commentPaging.currentPage}" />
            <textarea name="content" class="editor" placeholder="내용을 입력해 주세요."
             oninput="limitByte(this, 4000)" required></textarea>
                <button class="comment-submit-btn" type="submit">작성</button>
            </div>
        </form>
    </div>
</c:if>

      <div class="go-list-btn-wrap">
          <button type="button" class="go-list-btn" onclick="goList();">📋 목록</button>
      </div>
   
   </div>
</div>

<c:if test="${param.reportSuccess eq 'true'}">
    <script type="text/javascript">
        alert('🚨 신고가 완료되었습니다.');
    </script>
</c:if>

<c:import url="/WEB-INF/views/common/footer.jsp" />   

<c:if test="${not empty alertMsg}">
    <script>
        alert('${alertMsg}');
    </script>
</c:if>

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
       const source = '${source}'.trim();
       const page = '${page}';
       const category = '${category}';
      
       console.log('source : ' + '${source}')
       
       if (source === 'my') {
           location.href = ctx + `/myBoardList.do?page=${page}`;
           return;
       }
       
       if (!category || category.trim() === '') {
           location.href = ctx + `/boardList.do?page=${page}`;
       } else {
           location.href = ctx + `/boardList.do?category=${category}&page=${page}`;
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
    
    

    document.addEventListener("DOMContentLoaded", function () {
         const replyMap = {};
         const editCommentId = "${editCommentId}";

         document.querySelectorAll(".comment-box.reply[data-parent]").forEach(el => {
           const parentId = el.dataset.parent;
           if (!replyMap[parentId]) replyMap[parentId] = [];
           replyMap[parentId].push(el);
         });

         Object.entries(replyMap).forEach(([parentId, replies]) => {
            replies.forEach((el, idx) => {
              const commentId = el.dataset.commentId;
              if (idx < 3 || commentId === editCommentId) {
                el.classList.remove("hidden-reply");
              } else {
                el.classList.add("hidden-reply");
              }
            });
          });

         document.addEventListener("click", function (e) {
           if (e.target.classList.contains("more-reply-btn")) {
             const parentId = e.target.dataset.parentId;
             const isExpanded = e.target.dataset.expanded === "true";
             const replies = replyMap[parentId] || [];

             if (!isExpanded) {
               replies.forEach(reply => reply.classList.remove("hidden-reply"));
               e.target.dataset.expanded = "true";
               e.target.textContent = "숨기기";
             } else {
               replies.forEach((reply, idx) => {
                 if (idx >= 3) reply.classList.add("hidden-reply");
               });
               e.target.dataset.expanded = "false";
               e.target.textContent = "더보기";
             }
           }
         });
       });
    function limitByte(textarea, maxByte) {
         let text = textarea.value;
         let byteCount = 0;
         let cutIndex = text.length;

         for (let i = 0; i < text.length; i++) {
           const char = text.charAt(i);
           byteCount += (char.match(/[ㄱ-ㅎㅏ-ㅣ가-힣]/)) ? 3 : (encodeURIComponent(char).length > 1 ? 2 : 1);
           if (byteCount > maxByte) {
             cutIndex = i;
             break;
           }
         }

         if (byteCount > maxByte) {
           alert("최대 " + maxByte + "byte까지만 입력할 수 있습니다.");
           textarea.value = text.substring(0, cutIndex);
         }
       }
    
    function checkLogin() {
        const loginId = '${sessionScope.loginUser.loginId}';

        if (!loginId) {
            alert("로그인이 필요합니다.");
            location.href = 'loginPage.do';
            return false; // form 제출 막기
        }

        return true; // 로그인 되어있으면 정상 제출
    }


</script>
</body>
</html>