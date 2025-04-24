<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

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
            
            
              <c:if test="${not empty recipe.imageUrl}">
    <img src="${recipe.imageUrl}" alt="${recipe.recipeId} 이미지" width="300" />
		</c:if>
            
        </div>
    </div>

</body>
</html>