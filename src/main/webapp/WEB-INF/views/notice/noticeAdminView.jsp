<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>The Dish - 공지 상세 (관리자)</title>

    <!-- 수정/삭제/다운로드용 URL 정의 -->
    <c:url var="nup" value="nmoveup.do">
        <c:param name="no" value="${notice.noticeId}" />
    </c:url>

    <c:url var="ndel" value="ndelete.do">
        <c:param name="no" value="${notice.noticeId}" />
        <c:param name="rfile" value="${notice.renameFileName}" />
    </c:url>

    <c:url var="nfdown" value="nfdown.do">
        <c:param name="ofile" value="${notice.originalFileName}" />
        <c:param name="rfile" value="${notice.renameFileName}" />
    </c:url>

    <script type="text/javascript">
        function moveUpdatePage() {
            location.href = "${nup}";
        }
        function requestDelete() {
            if (confirm("정말 이 공지글을 삭제하시겠습니까?")) {
                location.href = "${ndel}";
            }
        }
    </script>

    <style>
        body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  padding: 20px;
  background: #f8f8f8;
}

.container {
  max-width: 900px;
  margin: 40px auto;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 40px;
}

.section-title {
  font-size: 22px;
  font-weight: 600;
  color: #2c3e50;
  border-bottom: 1px solid #aaa;
  padding-bottom: 10px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.notice-title {
  font-size: 28px;
  font-weight: bold;
  margin: 20px 0;
}

.attachment-btn {
  background-color: #2c3e50;
  color: white;
  border: none;
  padding: 10px 20px;
  font-size: 15px;
  border-radius: 6px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  text-decoration: none;
}
.attachment-btn:hover {
  background-color: #1b2e3c;
}

.attachment-wrapper {
  margin: 24px 0;
}

.attachment-toggle {
  cursor: pointer;
  display: inline-block;
  background-color: #2c3e50;
  color: #fff;
  padding: 10px 18px;
  border-radius: 6px;
  font-size: 15px;
  user-select: none;
}

.attachment-toggle:hover {
  background-color: #1e2e3c;
}

.attachment-list {
  margin-top: 10px;
  padding: 12px;
  background-color: #f4f4f4;
  border-left: 4px solid #2c3e50;
  border-radius: 6px;
}

.attachment-link {
  font-size: 15px;
  color: #1a0dab;
  text-decoration: none;
}

.attachment-link:hover {
  text-decoration: underline;
}

.hidden {
  display: none;
}
.notice-meta {
  margin-top: 20px;
  color: #666;
  font-size: 14px;
  display: flex;
  align-items: center;
  gap: 16px;
}

.notice-meta i {
  margin-right: 5px;
}

.notice-content {
  margin-top: 30px;
  font-size: 16px;
  color: #333;
  white-space: pre-line;
}

.btn-group {
  margin-top: 40px;
  text-align: right;
}

.btn-group button {
  background-color: black;
  color: white;
  border: none;
  padding: 10px 20px;
  margin-left: 10px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
}
.btn-group button:hover {
  background-color: #333;
}
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<script>
  function toggleAttachment() {
    const list = document.getElementById('attachment-list');
    list.classList.toggle('hidden');
  }
</script>
<div class="container">
  <div class="section-title">📢 공지사항</div>

  <div class="notice-title">${notice.title}</div>

  <c:if test="${not empty notice.originalFileName}">
  <div class="attachment-wrapper">
    <div class="attachment-toggle" onclick="toggleAttachment()">
      <i class="fas fa-download"></i> 첨부파일
    </div>
    <div id="attachment-list" class="attachment-list hidden">
      <a href="${nfdown}" class="attachment-link">
        <i class="fas fa-paperclip"></i> ${notice.originalFileName}
      </a>
    </div>
  </div>
</c:if>

  <div class="notice-meta">
    <span><i class="fas fa-user"></i> ${notice.createdBy}</span>
    <span><i class="fas fa-calendar-alt"></i> <fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd" /></span>
    <span><i class="fas fa-eye"></i> ${notice.readCount}</span>
  </div>

  <div class="notice-content">${notice.content}</div>

  <div class="btn-group">
    <button onclick="location.href='noticeList.do?page=1';">목록</button>
    <button onclick="history.back();">이전 페이지</button>

    <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'ADMIN'}">
      <button onclick="moveUpdatePage();">수정</button>
      <button onclick="requestDelete();">삭제</button>
    </c:if>
  </div>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
