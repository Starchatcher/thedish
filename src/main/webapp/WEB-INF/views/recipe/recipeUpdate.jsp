<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 수정</title>
<style>
/* insertRecipe.jsp 파일 내 <style> 태그 안에 추가 */

body {
    font-family: Arial, sans-serif;
    background-color: #f8f8f8; /* 목록 페이지와 동일한 배경색 */
    margin: 0;
    padding: 20px;
    line-height: 1.6; /* 가독성을 위한 줄 간격 */
}

h1 {
    text-align: center;
    margin-bottom: 30px; /* 제목 아래 여백 */
    color: #333; /* 제목 색상 */
}

/* 폼 컨테이너 역할을 할 form 태그 자체 스타일 */
form {
    max-width: 700px; /* 폼 전체의 최대 너비 지정 */
    margin: 0 auto; /* 가운데 정렬 */
    padding: 30px; /* 폼 내부 여백 */
    background-color: #fff; /* 흰색 배경 */
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

label {
    display: block; /* 라벨을 블록 레벨 요소로 만들어 줄바꿈 */
    margin-top: 15px; /* 라벨 위쪽 여백 */
    margin-bottom: 5px; /* 라벨 아래쪽 여백 */
    font-weight: bold;
    color: #555; /* 라벨 글자색 */
}

/* 텍스트 입력, 텍스트 영역, 드롭다운 메뉴 */
input[type="text"],
textarea,
select {
    width: 100%; /* 부모 요소(form 또는 감싸는 div) 너비에 꽉 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 둥근 모서리 */
    box-sizing: border-box; /* 패딩과 보더를 너비에 포함 */
    font-size: 14px; /* 글자 크기 */
}

textarea {
    resize: vertical; /* 세로 방향으로만 크기 조절 허용 */
    min-height: 100px; /* 최소 높이 지정 */
}

select {
    /* select 태그의 기본 스타일은 브라우저마다 다를 수 있습니다. */
    /* 필요에 따라 추가 스타일링 (예: 화살표 모양 변경) 필요 */
}

/* 파일 업로드 필드 */
input[type="file"] {
    display: block; /* 블록 요소로 만들고 */
    margin-top: 10px; /* 위쪽 여백 */
    font-size: 14px; /* 글자 크기 */
}


/* 필수 입력 표시 (*) 스타일 */
span[style="color:red"] { /* HTML에 직접 style로 지정된 색상을 타겟팅 */
    margin-left: 4px; /* 앞의 텍스트와 간격 */
}


/* 버튼 스타일 */
.submit-btn {
    display: block; /* 버튼을 블록 요소로 만들고 */
    width: auto; /* 너비 자동 (텍스트 내용에 맞게) */
    margin: 30px auto 0; /* 위쪽 여백, 좌우 auto로 가운데 정렬 */
    padding: 12px 30px; /* 내부 여백 */
    font-size: 16px;
    font-weight: bold;
    color: white; /* 글자색 */
    background-color: #8FBC8F; /* 목록 페이지 검색 버튼 색상 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 커서 모양 변경 */
    transition: background-color 0.3s ease; /* 호버 시 부드러운 전환 */
}

.submit-btn:hover {
    background-color: #7aa97a; /* 호버 시 색상 변경 */
}

/* 필드셋 스타일 (선택 사항) */
fieldset {
    border: 1px solid #ddd;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 8px;
}

legend {
    font-size: 1.1em;
    font-weight: bold;
    color: #333;
    padding: 0 10px;
}
</style>
</head>
<body>

<h2>레시피 수정</h2>

<form action="${pageContext.request.contextPath}/recipeUpdate.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="recipeId" value="${recipe.recipeId}" />
    
    <label for="name">레시피 이름:</label><br/>
    <input type="text" id="name" name="name" value="${recipe.name}" required /><br/><br/>
    
     <label for="recipeCategory">카테고리:</label><br/>
    <select id="recipeCategory" name="recipeCategory" required>
        <option value="">-- 선택하세요 --</option>
        <option value="일품" ${recipe.recipeCategory == '일품' ? 'selected' : ''}>일품</option>
        <option value="찌개" ${recipe.recipeCategory == '찌개' ? 'selected' : ''}>찌개</option>
        <option value="반찬" ${recipe.recipeCategory == '반찬' ? 'selected' : ''}>반찬</option>
        <option value="스프" ${recipe.recipeCategory == '스프' ? 'selected' : ''}>스프</option>
        <option value="후식" ${recipe.recipeCategory == '후식' ? 'selected' : ''}>후식</option>
        <option value="국" ${recipe.recipeCategory == '국' ? 'selected' : ''}>국</option>
        <option value="밥" ${recipe.recipeCategory == '밥' ? 'selected' : ''}>밥</option>
         <option value="기타" ${recipe.recipeCategory == '기타' ? 'selected' : ''}>기타</option>
        
        <!-- 필요에 따라 카테고리 추가 -->
    </select><br/><br/>
    
    <label for="ingredientName">재료:</label><br/>
    <textarea id="ingredientName" name="ingredientName" rows="3" required>${recipe.ingredientName}</textarea><br/><br/>
    
    <label for="description">설명:</label><br/>
    <textarea id="description" name="description" rows="3" required>${recipe.description}</textarea><br/><br/>
    
    <label for="instructions">조리법:</label><br/>
    <textarea id="instructions" name="instructions" rows="5" required>${recipe.instructions}</textarea><br/><br/>
    
    <label>현재 이미지:</label><br/>
<img id="imagePreview" 
     src="<c:choose>
             <c:when test='${not empty recipe.imageUrl}'>${recipe.imageUrl}</c:when>
             <c:when test='${empty recipe.imageUrl and not empty recipe.imageId}'>
                 ${pageContext.request.contextPath}/image/view.do?imageId=${recipe.imageId}
             </c:when>
             <c:otherwise></c:otherwise>
          </c:choose>" 
     alt="현재 이미지" width="200" /><br/>

<label for="imageFile">이미지 변경:</label><br/>
<input type="file" id="imageFile" name="imageFile" accept="image/*" onchange="previewImage(event)" /><br/><br/>

<script>
function previewImage(event) {
    const input = event.target;
    const preview = document.getElementById('imagePreview');
    
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        
        reader.onload = function(e) {
            preview.src = e.target.result;
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}
</script>

    <button type="submit">수정 완료</button>
</form>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
