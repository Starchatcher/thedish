<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>The Dish - 공지 등록</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: white; /* 배경 흰색으로 */
      color: #1a1a1a;
    }

    .container {
      max-width: 800px;
      margin: 60px auto;
      background: #ffffff;
      padding: 40px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.1);
      border-radius: 12px;
    }

    h1 {
      text-align: center;
      margin-bottom: 40px;
      color: #2c3e50;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      font-weight: bold;
      margin-bottom: 8px;
      color: #2c2c2c;
    }

    .form-group input[type="text"],
    .form-group input[type="file"],
    .form-group textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #999;
      border-radius: 6px;
      font-size: 15px;
      background-color: #f9f9f9;
      color: #1a1a1a;
    }

    .form-group input[readonly] {
      background-color: #efefef;
    }

    .form-actions {
      text-align: center;
      margin-top: 30px;
    }

    .form-actions input[type="submit"],
    .form-actions input[type="reset"],
    .form-actions input[type="button"] {
      padding: 10px 25px;
      margin: 0 8px;
      border: none;
      border-radius: 8px;
      font-size: 15px;
      cursor: pointer;
      color: white;
      background-color: #2c3e50; /* 모든 버튼 색 통일 */
    }

    .form-actions input:hover {
      opacity: 0.9;
    }
    
    .custom-file-wrapper {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 8px;
}

.custom-file-label {
  background-color: #2c3e50;
 color: white !important; /* ← 글씨를 확실히 흰색으로 고정 */
  padding: 10px 20px;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  display: inline-block;
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
  color: #555;
}
  </style>
</head>
<body>

  <c:import url="/WEB-INF/views/common/menubar.jsp" />

  <div class="container">
    <h1>📢 새 공지글 등록</h1>
    <form action="ninsert.do" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="title">제목</label>
        <input type="text" name="title" id="title" required>
      </div>

      <div class="form-group">
        <label for="createdBy">작성자</label>
        <input type="text" name="createdBy" id="createdBy" readonly value="${sessionScope.loginUser.loginId}">
      </div>

      <div class="form-group">
  <label for="ofile">첨부파일</label>
  <div class="custom-file-wrapper">
    <label class="custom-file-label">
       파일 선택
      <input type="file" name="ofile" id="ofile" onchange="updateFileName(this)">
    </label>
    <span id="file-name">선택된 파일 없음</span>
  </div>
</div>

      <div class="form-group">
        <label for="content">내용</label>
        <textarea name="content" id="content" rows="6" required></textarea>
      </div>

      <div class="form-actions">
        <input type="submit" value="등록하기">
        <input type="reset" value="등록취소">
        <input type="button" value="목록" onclick="history.back(); return false;">
      </div>
    </form>
  </div>

<script>
  function updateFileName(input) {
    const fileName = input.files.length > 0 ? input.files[0].name : '선택된 파일 없음';
    document.getElementById('file-name').textContent = fileName;
  }
</script>
  <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
