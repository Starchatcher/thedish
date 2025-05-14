<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>문의글 수정 페이지</title>
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
}

.custom-file-button:hover {
  background-color: #444; 
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
  background-color: #333;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.button-row button:hover {
  background-color: #444;
}

.button-row button.cancel {
  background-color: #e2e8f0;
  color: #333;
}

.button-row button.cancel:hover {
  background-color: #cbd5e1;
}
</style>


<script>
  function updateFileName(input) {
    const fileNameDisplay = document.getElementById("fileNameDisplay");
    const fileName = input.files.length > 0 ? input.files[0].name : "선택된 파일 없음";
    fileNameDisplay.textContent = fileName;
  }
  
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
  
  function limitByte(input, maxByte) {
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
	}
  window.addEventListener("DOMContentLoaded", function () {
	    const contentTextarea = document.querySelector("textarea[name='content']");
	    if (contentTextarea) {
	      checkByteWithLimit(contentTextarea, 4000, 'qnaByteCount');
	    }
	  });
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div class="container">
  <h2>문의글 수정</h2>
	<form action="qnaUpdate.do" method="post"
		enctype="multipart/form-data">

		<input type="hidden" name="qnaId" value="${qna.qnaId}">

		<div class="title-row">
			<input type="text" name="title" class="title-input"
				value="${ qna.title }" placeholder="제목을 입력해 주세요."
				oninput="limitByte(this, 200)" required>
		</div>

		<!-- 내용 입력 -->
		<textarea name="content" class="editor" placeholder="내용을 입력해 주세요."
			oninput="checkByteWithLimit(this, 4000, 'qnaByteCount')" required>${ qna.content }</textarea>
		<div><span id="qnaByteCount">0</span> / 4000 byte</div>

		<!-- 파일 선택 -->
		<div class="file-upload">
			<!-- 숨겨진 실제 파일 input -->
			<input type="file" id="fileInput" name="ofile" style="display: none;"
				onchange="updateFileName(this)">

			<!-- 사용자 클릭 가능한 라벨 버튼 -->
			<label for="fileInput" class="custom-file-button">파일 선택</label>

			<!-- 파일 이름 표시 영역 -->
			<span id="fileNameDisplay"> 
				<c:choose>
						<c:when test="${not empty qna.originalFileName}">
				       	 	${qna.originalFileName}
				      	</c:when>
				<c:otherwise>
	        		선택된 파일 없음
	      		</c:otherwise>
				</c:choose>
			</span>
			
			<!-- 기존 파일 삭제 체크박스 -->
			  <c:if test="${not empty qna.originalFileName}">&nbsp;&nbsp;
			    <label>
			      <input type="checkbox" name="deleteFile" value="yes"> 기존 첨부파일 삭제
			    </label>
				     <input type="hidden" name="originalFileName" value="${qna.originalFileName}">
 					 <input type="hidden" name="renameFileName" value="${qna.renameFileName}">
			  </c:if>
		</div>

		<!-- 등록/취소 버튼 -->
		<div class="button-row">
			<button type="submit">수정</button>
			<button type="button" onclick="history.back()">취소</button>
		</div>
	</form>
</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>