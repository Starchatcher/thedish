<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
<style>
body {
  font-family: 'Pretendard', sans-serif;
  background-color: #f9f9f9;
  margin: 0;
  padding: 0;
}

.container {
  max-width: 800px;
  margin: 50px auto;
  background: #fff;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
}

h2 {
  font-size: 24px;
  margin-bottom: 10px;
  color: #2e2e2e;
}

hr {
  margin: 24px 0;
  border: none;
  border-top: 1px solid #ddd;
}

p {
  font-size: 15px;
  color: #333;
  line-height: 1.6;
}

.qna-attachment {
  margin-top: 24px;
  padding: 14px 18px;
  background-color: #f4f4f4;
  border-left: 4px solid #ccc;
  border-radius: 8px;
  font-size: 15px;
  color: #333;
  box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

.qna-attachment a {
  color: #007bff;
  text-decoration: none;
  font-weight: 500;
}
.qna-attachment a:hover {
  text-decoration: underline;
}

.qna-answer {
  margin-top: 40px;
  background-color: #f2f2f2;     /* ✅ 밝은 회색 */
  border-left: 4px solid #888;
  padding: 18px 20px;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

.qna-answer-title {
  font-size: 16px;
  font-weight: bold;
  color: #222;
  margin-bottom: 10px;
}

.qna-answer-content {
  font-size: 15px;
  line-height: 1.6;
  color: #333;
  white-space: pre-wrap;
}

.qna-action-buttons {
  margin-top: 30px;
  display: flex;
  gap: 10px;
  align-items: center;
  flex-wrap: wrap;
}

.qna-btn {
  padding: 10px 18px;
  font-size: 14px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.05);
  transition: background-color 0.25s;
}

.qna-btn.back {
  padding: 5px 12px;
  font-size: 13px;
  height: 32px;
  min-height: unset;
  background-color: #444;
  color: #eee;
}
.qna-btn.back:hover {
  background-color: #555;
}

.qna-btn.update {
  background-color: #f0f0f0;
}
.qna-btn.update:hover {
  background-color: #ddd;
}

.qna-btn.delete {
  background-color: #ffecec;
  color: #d32f2f;
}
.qna-btn.delete:hover {
  background-color: #ffd4d4;
}

.qna-btn.submit {
  background-color: #444;
  color: #fff;
}
.qna-btn.submit:hover {
  background-color: #555;
}
</style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
  <h2>${qna.title}</h2>
  <p><strong>작성자:</strong>
    <c:choose>
      <c:when test="${sessionScope.loginUser.role eq 'ADMIN'}">
        <c:if test="${not empty writer}">
          ${writer.nickName}
        </c:if>
      </c:when>
      <c:otherwise>
        ${sessionScope.loginUser.nickName}
      </c:otherwise>
    </c:choose>
  </p>

  <p><strong>작성일:</strong> <fmt:formatDate value="${qna.createdAt}" pattern="yyyy-MM-dd" /></p>
  <hr>
  <p>${qna.content}</p>

  <c:if test="${not empty qna.originalFileName}">
    <div class="qna-attachment">
      첨부파일:
      <a href="${pageContext.request.contextPath}/qnaFileDown.do?ofile=${qna.originalFileName}&rfile=${qna.renameFileName}">
        ${qna.originalFileName}
      </a>
    </div>
  </c:if>

  <c:if test="${not empty qna.answer}">
    <div class="qna-answer">
      <div class="qna-answer-title">💬 관리자 답변</div>
      <p style="font-size: 13px; color: #888;">
        <fmt:formatDate value="${qna.answeredAt}" pattern="yyyy-MM-dd HH:mm"/>
      </p>
      <div class="qna-answer-content">${qna.answer}</div>
    </div>
  </c:if>

  <c:if test="${empty qna.answer}">
    <div class="qna-answer">
      <div class="qna-answer-title">💬 아직 답변이 등록되지 않았습니다.</div>
    </div>
  </c:if>

  <div class="qna-action-buttons">
    <button type="button" class="qna-btn back" onclick="history.back()">🔙 목록</button>

    <!-- ✅ 관리자일 경우 수정/삭제 버튼 표시하지 않음 -->
    <c:if test="${qna.isAnswered eq 'N' and sessionScope.loginUser.role ne 'ADMIN'}">
      <form action="qnaUpdateForm.do" method="get">
        <input type="hidden" name="qnaId" value="${ qna.qnaId }" />
        <button type="submit" class="qna-btn update">✏️ 수정</button>
      </form>
      <form action="qnaDelete.do" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
        <input type="hidden" name="qnaId" value="${ qna.qnaId }" />
        <button type="submit" class="qna-btn delete">🗑️ 삭제</button>
      </form>
    </c:if>

    <c:if test="${empty qna.answer and sessionScope.loginUser.role eq 'ADMIN'}">
      <form action="qnaAnswer.do" method="post" style="margin-top: 20px;">
        <input type="hidden" name="qnaId" value="${qna.qnaId}" />
        <label for="answer" style="font-weight: bold; display: block; margin-bottom: 6px;">답변 내용:</label>
        <textarea name="answer" rows="5" cols="80" style="width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc;" required></textarea>
        <br>
        <button type="submit" class="qna-btn submit">답변 등록</button>
      </form>
    </c:if>
  </div>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
