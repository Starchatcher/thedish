<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 작성</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">

<style>
body {
  font-family: 'Pretendard', sans-serif;
  background-color: #f4f6f8;
  margin: 0;
  padding: 0;
}

.container {
  max-width: 780px;
  margin: 60px auto;
  padding: 40px;
  background-color: #ffffff;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
}

h2 {
  text-align: center;
  margin-bottom: 40px;
  font-size: 24px;
  color: #333;
}

input[type="text"],
textarea {
  width: 100%;
  padding: 14px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: #fafafa;
  margin-bottom: 20px;
  box-sizing: border-box;
  transition: all 0.2s ease-in-out;
}

input[type="text"]:focus,
textarea:focus {
  border-color: #3182ce;
  background-color: #ffffff;
  outline: none;
}

textarea.editor {
  min-height: 280px;
  resize: vertical;
}

.file-upload {
  margin-bottom: 24px;
}

.file-upload input[type="file"] {
  display: inline-block;
  padding: 10px;
  font-size: 14px;
  border: 1px solid #ccc;
  border-radius: 6px;
  background-color: #f9f9f9;
}

.button-row {
  display: flex;
  justify-content: center;
  gap: 14px;
  margin-top: 30px;
}

.button-row button {
  padding: 12px 26px;
  font-size: 15px;
  background-color: #333; /* ✅ 진한 회색 */
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.button-row button:hover {
  background-color: #444; /* ✅ 약간 밝은 회색으로 hover */
}

.button-row button.cancel {
  background-color: #e2e8f0;
  color: #333;
}

.button-row button.cancel:hover {
  background-color: #cbd5e1;
}
</style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
  <h2>문의글 작성</h2>

  <form action="qnaInsert.do" method="post" enctype="multipart/form-data">
    <input type="text" name="title" placeholder="제목을 입력해 주세요." required>

    <textarea name="content" class="editor" placeholder="내용을 입력해 주세요." required></textarea>

    <div class="file-upload">
      <label for="ofile">첨부 파일:</label><br>
      <input type="file" name="ofile" id="ofile">
    </div>

    <div class="button-row">
      <button type="submit">등록하기</button>
      <button type="button" class="cancel" onclick="history.back()">취소</button>
    </div>
  </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
