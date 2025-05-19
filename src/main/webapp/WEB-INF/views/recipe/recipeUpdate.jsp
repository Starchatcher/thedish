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
    font-family: 'Segoe UI', Roboto, Arial, sans-serif;
    background-color: #f8f8f8;
    margin: 0;
    padding: 20px;
    line-height: 1.6;
    color: #333;
}

h2 {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
}

form {
    max-width: 720px;
    margin: 0 auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

label {
    display: block;
    margin-top: 20px;
    margin-bottom: 8px;
    font-weight: bold;
    color: #444;
}

/* 입력 필드 스타일 */
input[type="text"],
textarea,
select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    box-sizing: border-box;
    background-color: #fafafa;
}

textarea {
    resize: vertical;
    min-height: 100px;
}

select {
    background-color: #fafafa;
}

/* 이미지 미리보기 */
#imagePreview {
    display: block;
    margin-top: 10px;
    width: 200px;
    height: auto;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

/* 파일 업로드 input 숨기고 라벨 커스터마이징 */
input[type="file"] {
    display: none;
}

.custom-file-label {
    display: inline-block;
    margin-top: 10px;
    padding: 10px 18px;
    background-color: #444;
    color: #fff;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.custom-file-label:hover {
    background-color: #666;
}

/* 제출 버튼 */
button[type="submit"] {
    display: block;
    margin: 30px auto 0;
    padding: 12px 30px;
    font-size: 16px;
    font-weight: bold;
    color: white;
    background-color: #444;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
    background-color: #777;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

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

<label for="imageFile">이미지 변경:</label>
<label for="imageFile" class="custom-file-label">파일 선택</label>
<input type="file" id="imageFile" name="imageFile" accept="image/*" onchange="previewImage(event)" />

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

document.getElementById('imageFile').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        const label = document.querySelector('.custom-file-label');
        label.textContent = '📁 ' + file.name;
    }
});
</script>

    <button type="submit">수정 완료</button>
</form>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
