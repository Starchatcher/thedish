<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성 페이지</title>

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

/* 드롭다운 + 제목 입력 공통 */
.title-row select,
.title-row .title-input {
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

.title-row select:focus,
.title-row .title-input:focus {
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

/* 파일 선택 영역 */
.file-upload {
  display: flex;
  justify-content: flex-start;
  margin-bottom: 30px;
}

/* 파일 선택 버튼 */
.file-upload input[type="file"] {
  padding: 8px 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 13px;
  background-color: #fff;
  color: #444;
}

/* 버튼 영역 */
.button-row {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-bottom: 50px;
}

/* 등록/취소 버튼 */
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
function checkByteLimit(textarea, maxByte, countDisplayId) {
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

  if (countDisplayId) {
    document.getElementById(countDisplayId).innerText = byteCount;
  }
}
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

	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<form action="boardInsert.do" method="post"
		enctype="multipart/form-data">
	<input type="hidden" name="source" value="${param.source}" />
		<!-- 게시판 선택 + 제목 입력 -->
		<div class="title-row">
			<input type="text" name="title" class="title-input"
		       placeholder="제목을 입력해 주세요."
		       oninput="limitByte(this, 100)" required>
		
		
			<select name="boardType" required>
				<option value="">게시판을 선택해 주세요.</option>
				<option value="free">자유게시판</option>
				<option value="review">후기게시판</option>
				<option value="tip">팁공유게시판</option>
			</select> 
		</div>

		<!-- 내용 입력 -->
		<textarea name="content" class="editor" placeholder="내용을 입력해 주세요."
          oninput="checkByteLimit(this, 4000, 'boardByteCount')" required></textarea>
		<div><span id="boardByteCount">0</span> / 4000 byte</div>

		<!-- 파일 선택 -->
		<div class="file-upload">
			<input type="file" name="ofile">
		</div>

		<!-- 등록/취소 버튼 -->
		<div class="button-row">
			<button type="submit">등록하기</button>
			<button type="button" onclick="history.back()">등록취소</button>
		</div>

	</form>

	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
