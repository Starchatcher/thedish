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
  background-color: #333; /* 연한 회색 */
  color: #fff;               /* 어두운 글자색 */
}

.button-row button.cancel:hover {
  background-color: #444;
}

.custom-file-button {
  display: inline-block;
  padding: 10px 16px;
  font-size: 14px;
  font-weight: 500;
  color: #ffffff;
  background-color: #333;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-right: 10px;
}

.custom-file-button:hover {
  background-color: #444;
}

</style>

<script>
function checkByteWithLimit(textarea, maxByte, counterId) {
	const text = textarea.value;
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
		alert(maxByte + "byte를 초과할 수 없습니다.");
		textarea.value = text.substring(0, cutIndex);
		byteCount = 0;
		for (let i = 0; i < cutIndex; i++) {
			const char = textarea.value.charAt(i);
			byteCount += (char.match(/[ㄱ-ㅎㅏ-ㅣ가-힣]/)) ? 3 : (encodeURIComponent(char).length > 1 ? 2 : 1);
		}
	}

	document.getElementById(counterId).innerText = byteCount;
}

function checkByteLimitOnly(input, maxByte) {
	const text = input.value;
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
		alert(maxByte + "byte를 초과할 수 없습니다.");
		input.value = text.substring(0, cutIndex);
	}
	
	function updateFileName(input) {
		  const fileNameDisplay = document.getElementById("fileNameDisplay");
		  const fileName = input.files.length > 0 ? input.files[0].name : "선택된 파일 없음";
		  fileNameDisplay.textContent = fileName;
		}
}
</script>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
  <h2>문의글 작성</h2>

  <form action="qnaInsert.do" method="post" enctype="multipart/form-data">
 
	<input type="text" name="title" placeholder="제목을 입력해 주세요." 
		oninput="checkByteLimitOnly(this, 200)" required>
	
	
	<textarea name="content" class="editor" placeholder="내용을 입력해 주세요." 
		oninput="checkByteWithLimit(this, 4000, 'contentByteCount')" required></textarea>
	<div><span id="contentByteCount">0</span> / 4000 byte</div>

    <div class="file-upload">
	  <input type="file" name="ofile" id="ofile" style="display: none;" onchange="updateFileName(this)">
	  <label for="ofile" class="custom-file-button">파일 선택</label>
	  <span id="fileNameDisplay">선택된 파일 없음</span>
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
