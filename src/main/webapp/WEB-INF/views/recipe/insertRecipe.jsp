<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>레시피 등록</title>
    <style>
        label { display: block; margin-top: 10px; font-weight: bold; }
        input[type="text"], textarea, select {
            width: 100%; max-width: 600px; padding: 8px; box-sizing: border-box;
        }
        textarea { resize: vertical; }
        .submit-btn {
            margin-top: 20px;
            padding: 12px 24px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>레시피 등록</h1>
    <form action="${pageContext.request.contextPath}/insertRecipe.do" method="post" enctype="multipart/form-data">
	
        <!-- 기존 입력 필드들 (생략 가능) -->
        <label for="name">레시피명 (NAME) <span style="color:red">*</span>:</label>
        <input type="text" id="name" name="name" maxlength="200" required />

        <label for="category">카테고리 (RECIPE_CATEGORY) <span style="color:red">*</span>:</label>
        <select id="category" name="recipeCategory" required>
            <option value="">-- 선택하세요 --</option>
            <option value="한식">한식</option>
            <option value="중식">중식</option>
            <option value="일식">일식</option>
            <option value="양식">양식</option>
            <option value="디저트">디저트</option>
        </select>

        <label for="description">설명 (DESCRIPTION):</label>
        <textarea id="description" name="description" maxlength="500" rows="3"></textarea>

        <label for="createBy">작성자 (CREATED_BY) <span style="color:red">*</span>:</label>
        <input type="text" id="createBy" name="createBy" maxlength="50" required />

        <label for="instructions">조리 방법 (INSTRUCTIONS) <span style="color:red">*</span>:</label>
        <textarea id="instructions" name="instructions" maxlength="4000" rows="6" required></textarea>

        <label for="ingredientName">재료명 (INGREDIENT_NAME) <span style="color:red">*</span>:</label>
        <textarea id="ingredientName" name="ingredientName" maxlength="2000" rows="4" required></textarea>

        <!-- 이미지 업로드 필드 -->
        <label for="images">이미지 업로드:</label>
        <input type="file" id="images" name="imageFile" accept="image/*"  />

        <button type="submit" class="submit-btn">등록하기</button>
    </form>
</body>
</html>
