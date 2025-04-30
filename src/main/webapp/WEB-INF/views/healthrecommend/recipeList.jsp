<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>추천 레시피 결과</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />


<c:import url="/WEB-INF/views/common/sidebar.jsp" />
    <h2>당신을 위한 건강 맞춤형 레시피</h2>

    <c:if test="${empty recipes}">
        <p>조건에 맞는 레시피가 없습니다.</p>
    </c:if>

    <c:forEach var="recipe" items="${recipes}">
        <div style="border:1px solid #ccc; padding:10px; margin:10px;">
            <h3>${recipe.name}</h3>
            <p><strong>설명:</strong> ${recipe.description}</p>
            <p><strong>재료:</strong> ${recipe.ingredientName}</p>
            <p><strong>추천 수:</strong> ${recipe.recommendNumber} / <strong>평점:</strong> ${recipe.avgRating}</p>
        </div>
    </c:forEach>
     <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
