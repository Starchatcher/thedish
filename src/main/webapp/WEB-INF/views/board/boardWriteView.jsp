<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성 페이지</title>
<script>
  function beforeSubmit() {
    const editorContent = document.querySelector('.editor').innerHTML;
    document.getElementById('contentHidden').value = editorContent;
  }
</script>
<style>
.select-row select {
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-left:30px;
  
}

.title-input {
  width: 100%;
  padding: 12px;   /* 좌우 여백 크게 */
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-bottom: 15px;
  background-color: #f9f9f9;
  font-size: 16px;
  box-sizing: border-box;
  margin-left:30px;
  width:970px;
}

.editor {
  width: 100%;
  min-height: 250px;
  border: 1px solid #ccc;
  background-color: #fff;
  padding: 12px;
  font-size: 15px;
  border-radius: 4px;
  line-height: 1.6;
  margin-left:30px;
  width:970px;
}
</style>

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<h1 align="center">게시글을 작성하세요.</h1>
<br>

<!-- form 에서 파일이 첨부되어서 전송될 경우에는 반드시 enctype="multipart/form-data" 속성을 추가해야 함
	  전송방식은 post 로 지정함
-->
<!-- 게시글 등록 Form -->
<form action="boardInsert.do" method="post" enctype="multipart/form-data">

  <!-- 상단 선택 박스 (게시판 / 말머리) -->
  <div class="select-row">
    <select name="boardType" required>
      <option value="">게시판을 선택해 주세요.</option>
      <option value="free">자유게시판</option>
      <option value="review">후기게시판</option>
      <option value="tip">팁공유게시판</option>
    </select>
  </div>	
  <!-- 제목 입력 -->
  <input type="text" name="title" class="title-input" placeholder="제목을 입력해 주세요." required />

  <!-- 리치 텍스트 에디터 -->
  <div class="editor" contenteditable="true">
  </div>
  <input type="hidden" name="content" id="contentHidden">

  <!-- 파일 업로드 -->
  <div style="margin-top: 10px;margin-left:30px;">
    <label> <input type="file" name="ofile"></label>
  </div>

  <!-- 버튼 -->
  <div style="margin-top: 20px;margin-left:30px;">
    <button type="submit" onclick="beforeSubmit()">  등록하기</button>
    <button type="button" onclick="history.back()">  등록취소</button>
  </div>

</form>



<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>