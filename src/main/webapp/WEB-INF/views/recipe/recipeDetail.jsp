<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${recipe.name} 상세페이지</title>
</head>
<body>
<a href="moveUpdateRecipePage.do?recipeId=${recipe.recipeId}&page=${currentPage != null ? currentPage : 1}">수정</a>

<form action="deleteRecipe.do" method="post" style="display:inline;">
    <input type="hidden" name="recipeId" value="${recipe.recipeId}" />
    <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
</form>



   <div class="container">
        <h2>${recipe.name}</h2>
        
        <span class="label">재료:</span>
        <p class="info">${recipe.ingredientName}</p>
        
        <span class="label">설명:</span>
        <p class="info">${recipe.description}</p>
        
        <span class="label">조리법:</span>
        <p class="info">${recipe.instructions}</p>
        
        <div class="stats">
            <span>조회수: ${recipe.viewCount}</span>
            <span>추천수: ${recipe.recommendNumber}</span>
            <span>평균평점: ${recipe.avgRating}</span>           
            
            <c:choose>
    <c:when test="${not empty recipe.imageUrl}">
        <img src="${recipe.imageUrl}" alt="${recipe.recipeId} 이미지" width="300" />
    </c:when>
    <c:when test="${not empty recipe.imageId and recipe.imageId != 0}">
        <img src="${pageContext.request.contextPath}/image/view.do?imageId=${recipe.imageId}" alt="${recipe.recipeId} 이미지" width="300" />
    </c:when>
    <c:otherwise>
        <p>이미지가 없습니다.</p>
    </c:otherwise>
</c:choose>

            
        </div>
    </div>

</body>
</html>
