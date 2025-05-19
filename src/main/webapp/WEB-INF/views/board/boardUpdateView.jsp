<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정 페이지</title>
<style>
/* 전체 form 크기 조절 */
form {
	width: 70%;
	margin: 0 auto;
}

/* 제목 + 게시판 선택 반반 정렬 */
.title-row {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	gap: 20px;
	margin: 20px 0;
}

/* 게시판 선택 드롭다운과 제목 입력 공통 */
.title-row select, .title-row .title-input {
	flex: 1;
	padding: 10px;
	border: 1px solid #d0d0d0;
	border-radius: 6px;
	font-size: 15px;
	box-sizing: border-box;
	background-color: #fff;
	color: #333;
	transition: border 0.2s ease;
}

.title-row select:focus, .title-row .title-input:focus {
	border-color: #aaa;
	outline: none;
}

/* 내용 작성 textarea */
.editor {
	width: 100%;
	min-height: 250px;
	height: 400px;
	border: 1px solid #d0d0d0;
	border-radius: 6px;
	background-color: #fff;
	padding: 12px;
	font-size: 14px;
	line-height: 1.6;
	box-sizing: border-box;
	margin-bottom: 20px;
	color: #333;
	resize: vertical;
}

/* 파일 선택 버튼 영역 (왼쪽 정렬) */
.file-upload {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	gap: 10px;
	margin-bottom: 30px;
}

/* 기본 파일 input */
.file-upload input[type="file"] {
	padding: 8px 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 13px;
	background-color: #fff;
	color: #444;
}

/* 커스텀 파일 버튼 */
.custom-file-button {
	display: inline-block;
	background-color: #888;
	color: white;
	padding: 8px 14px;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.2s ease;
	font-size: 13px;
	border: none;
}

.custom-file-button:hover {
	background-color: #555;
}

/* 등록/취소 버튼 영역 */
.button-row {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-bottom: 50px;
}

/* 등록/취소 버튼 스타일 */
.button-row button {
	background-color: #888;
	border: none;
	border-radius: 6px;
	padding: 10px 20px;
	font-size: 14px;
	color: white;
	cursor: pointer;
	transition: background-color 0.2s ease;
}

.button-row button:hover {
	background-color: #555;
}

</style>

<script>
  function updateFileName(input) {
    const fileNameDisplay = document.getElementById("fileNameDisplay");
    const fileName = input.files.length > 0 ? input.files[0].name : "선택된 파일 없음";
    fileNameDisplay.textContent = fileName;
  }
  
  function checkByteLimit(textarea, maxByte, counterId) {
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
	    alert(maxByte + "byte까지만 입력할 수 있습니다.");
	    textarea.value = text.substring(0, cutIndex);
	    byteCount = 0;
	    for (let i = 0; i < cutIndex; i++) {
	      const char = textarea.value.charAt(i);
	      byteCount += (char.match(/[ㄱ-ㅎㅏ-ㅣ가-힣]/)) ? 3 : (encodeURIComponent(char).length > 1 ? 2 : 1);
	    }
	  }

	  if (counterId) {
	    document.getElementById(counterId).innerText = byteCount;
	  }
	}
  
  window.addEventListener('DOMContentLoaded', function () {
	  const textarea = document.querySelector('textarea[name="content"]');
	  if (textarea) checkByteLimit(textarea, 4000, 'boardByteCount');
	});
  
  function limitByte(input, maxByte) {
	  let text = input.value;
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
	    alert("제목은 최대 " + maxByte + "byte까지 입력할 수 있습니다.");
	    input.value = text.substring(0, cutIndex);
	  }
	}
</script>
</head>
<body>
<c:set var="currentPage" value="${ requestScope.currentPage }" />
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<form action="boardUpdate.do" method="post"
		enctype="multipart/form-data">

		<input type="hidden" name="page" value="${ currentPage }">
		<input type="hidden" name="boardId" value="${board.boardId}" />
		<input type="hidden" name="source" value="${param.source}" />
		<!-- 게시판 선택 + 제목 입력 -->
		<div class="title-row">
			<input type="text" name="title" class="title-input"
				value="${ board.title }" placeholder="제목을 입력해 주세요." required   oninput="limitByte(this, 100)" >


			<select name="boardCategory" required>
				<option value="">게시판을 선택해 주세요.</option>
				<option value="free"
					${ board.boardCategory eq 'free' ? 'selected' : ' '}>자유게시판</option>
				<option value="review"
					${ board.boardCategory eq 'review' ? 'selected' : ' '}>후기게시판</option>
				<option value="tip"
					${ board.boardCategory eq 'tip' ? 'selected' : ' '}>팁공유게시판</option>
			</select>
		</div>

		<!-- 내용 입력 -->
		<textarea name="content" class="editor" placeholder="내용을 입력해 주세요."
          oninput="checkByteLimit(this, 4000, 'boardByteCount')" required>${ board.content }</textarea>
		<div><span id="boardByteCount">0</span> / 4000 byte</div>

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
						<c:when test="${not empty board.originalFileName}">
				       	 	${board.originalFileName}
				      	</c:when>
				<c:otherwise>
	        		선택된 파일 없음
	      		</c:otherwise>
				</c:choose>
			</span>
			
			<!-- 기존 파일 삭제 체크박스 -->
			  <c:if test="${not empty board.originalFileName}">&nbsp;&nbsp;
			    <label>
			      <input type="checkbox" name="deleteFile" value="yes"> 기존 첨부파일 삭제
			    </label>
				     <input type="hidden" name="originalFileName" value="${board.originalFileName}">
 					 <input type="hidden" name="renameFileName" value="${board.renameFileName}">
			  </c:if>
		</div>

		<!-- 등록/취소 버튼 -->
		<div class="button-row">
			<button type="submit">수정</button>
			<button type="button" onclick="history.back()">취소</button>
		</div>

	</form>

	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>