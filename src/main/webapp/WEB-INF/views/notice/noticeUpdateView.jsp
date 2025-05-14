<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>The Dish - 공지 수정</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: white;
      color: #1a1a1a;
    }

    .container {
      max-width: 800px;
      margin: 60px auto;
      background: #fff;
      padding: 40px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.1);
      border-radius: 12px;
    }

    h1 {
      text-align: center;
      color: #2c3e50;
      margin-bottom: 40px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      font-weight: bold;
      margin-bottom: 8px;
    }

    .form-group input[type="text"],
    .form-group textarea {
      width: 100%;
      padding: 10px;
      font-size: 15px;
      border: 1px solid #aaa;
      border-radius: 6px;
      background-color: #f9f9f9;
      color: #1a1a1a;
    }

    .form-group input[readonly] {
      background-color: #eaeaea;
    }

    .file-info {
      font-size: 14px;
      margin-bottom: 8px;
    }

    .custom-file-wrapper {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-top: 10px;
    }

    .custom-file-label {
      background-color: #2c3e50;
      color: white !important;
      padding: 10px 18px;
      border-radius: 6px;
      font-size: 14px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      display: inline-block;
      font-weight: 500;
    }

    .custom-file-label input[type="file"] {
      position: absolute;
      left: 0;
      top: 0;
      opacity: 0;
      cursor: pointer;
      width: 100%;
      height: 100%;
    }

    #file-name {
      font-size: 14px;
      color: #444;
    }

    .form-actions {
      text-align: center;
      margin-top: 30px;
    }

    .form-actions input[type="submit"],
    .form-actions input[type="reset"],
    .form-actions input[type="button"] {
      padding: 10px 25px;
      margin: 6px;
      border: none;
      border-radius: 8px;
      font-size: 15px;
      background-color: #2c3e50;
      color: white;
      cursor: pointer;
    }

    .form-actions input:hover {
      opacity: 0.9;
    }
  </style>
</head>
<body>

  <c:import url="/WEB-INF/views/common/menubar.jsp" />

  <div class="container">
    <h1>📢 ${requestScope.notice.noticeId}번 공지글 수정 (관리자)</h1>

    <form action="nupdate.do" method="post" enctype="multipart/form-data">
      <input type="hidden" name="noticeId" value="${notice.noticeId}">
      <input type="hidden" name="originalFileName" value="${notice.originalFileName}">
      <input type="hidden" name="renameFileName" value="${notice.renameFileName}">

      <div class="form-group">
        <label for="title">제목</label>
        <input type="text" name="title" id="title" value="${notice.title}" required>
      </div>

      <div class="form-group">
        <label for="noticeBy">작성자</label>
        <input type="text" name="noticeBy" id="noticeBy" readonly value="${sessionScope.loginUser.loginId}">
      </div>

      <div class="form-group">
        <label>첨부파일</label>
        <c:choose>
          <c:when test="${!empty notice.originalFileName}">
            <div class="file-info">
              📎 현재 파일: <strong>${notice.originalFileName}</strong><br>
              <label><input type="checkbox" name="deleteFlag" value="yes"> 파일 삭제</label>
            </div>
          </c:when>
          <c:otherwise>
            <div class="file-info">📎 첨부파일 없음</div>
          </c:otherwise>
        </c:choose>

        <!-- 모던한 파일 업로드 영역 -->
        <div class="custom-file-wrapper">
          <label class="custom-file-label">
            📎 파일 선택
            <input type="file" name="ofile" id="ofile" onchange="updateFileName(this)">
          </label>
          <span id="file-name">선택된 파일 없음</span>
        </div>
      </div>

      <div class="form-group">
        <label for="content">내용</label>
        <textarea name="content" id="content" rows="6" required>${notice.content}</textarea>
      </div>

      <div class="form-actions">
        <input type="submit" value="수정하기">
        <input type="reset" value="수정취소">
        <input type="button" value="이전 페이지로 이동" onclick="history.back(); return false;">
        <input type="button" value="목록" onclick="location.href='noticeList.do'; return false;">
      </div>
    </form>
  </div>

  <c:import url="/WEB-INF/views/common/footer.jsp" />

  <script>
    function updateFileName(input) {
      const fileName = input.files.length > 0 ? input.files[0].name : '선택된 파일 없음';
      document.getElementById('file-name').textContent = fileName;
    }
  </script>
</body>
</html>
