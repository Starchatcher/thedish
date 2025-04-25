<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 수정</title>
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
        <option value="한식" ${recipe.recipeCategory == '한식' ? 'selected' : ''}>한식</option>
        <option value="양식" ${recipe.recipeCategory == '양식' ? 'selected' : ''}>양식</option>
        <option value="중식" ${recipe.recipeCategory == '중식' ? 'selected' : ''}>중식</option>
        <option value="일식" ${recipe.recipeCategory == '일식' ? 'selected' : ''}>일식</option>
        <option value="디저트" ${recipe.recipeCategory == '디저트' ? 'selected' : ''}>디저트</option>
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

</body>
</html>
