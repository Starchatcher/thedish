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
  margin-bottom: 20px;
  margin-top:20px;
}

/* 게시판 선택 드롭다운과 제목 입력 공통 */
.title-row select,
.title-row .title-input {
  flex: 1;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 16px;
  box-sizing: border-box;
}

/* 내용 작성 textarea */
.editor {
  width: 100%;
  min-height: 250px;
  border: 1px solid #ccc;
  border-radius: 6px;
  background-color: #fff;
  padding: 12px;
  font-size: 15px;
  line-height: 1.6;
  box-sizing: border-box;
  margin-bottom: 20px;
  height: 400px;
}

/* 파일 선택 버튼 영역 (왼쪽 정렬) */
.file-upload {
  display: flex;
  justify-content: flex-start; /* 왼쪽 정렬 */
  margin-bottom: 30px;
}

/* 파일 선택 버튼 */
.file-upload input[type="file"] {
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 14px;
}

/* 등록/취소 버튼 영역 (오른쪽 정렬) */
.button-row {
  display: flex;
  justify-content: flex-end; /* 오른쪽 정렬 */
  gap: 10px;
  margin-bottom: 50px;
}

/* 등록/취소 버튼 스타일 */
.button-row button {
  background-color: #90bc90;
  border: none;
  border-radius: 6px;
  padding: 10px 20px;
  font-size: 16px;
  color: white;
  cursor: pointer;
  transition: background-color 0.3s;
}

/* 버튼 hover 효과 */
.button-row button:hover {
  background-color: #7da97d;
}
</style>


</head>
<body>

	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<form action="boardInsert.do" method="post"
		enctype="multipart/form-data">

		<!-- 게시판 선택 + 제목 입력 -->
		<div class="title-row">
			<input type="text" name="title" class="title-input"
				placeholder="제목을 입력해 주세요." required>
		
			<select name="boardType" required>
				<option value="">게시판을 선택해 주세요.</option>
				<option value="free">자유게시판</option>
				<option value="review">후기게시판</option>
				<option value="tip">팁공유게시판</option>
			</select> 
		</div>

		<!-- 내용 입력 -->
		<textarea name="content" class="editor" placeholder="내용을 입력해 주세요."
			required></textarea>

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
