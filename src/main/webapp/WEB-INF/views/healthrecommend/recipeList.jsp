<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="queryParams" value="condition=${condition}" />
<c:if test="${empty condition}">
    <c:redirect url="healthSearchForm.do" />
</c:if>

<html>
<head>
    <title>추천 레시피 결과</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .main-container {
            max-width: 1100px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }

        h2 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
        }

        .recipe-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 28px;
        }

        .recipe-card {
            background-color: #f9fbfd;
            border: 1px solid #b0bec5;
            border-radius: 16px;
            padding: 20px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .recipe-card:hover {
            transform: scale(1.015);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }

        .recipe-card h3 {
            font-size: 20px;
            margin-bottom: 12px;
            color: #2c3e50;
        }

        .recipe-card h3 a {
            text-decoration: none;
            color: #2c3e50;
        }

        .recipe-card h3 a:hover {
            text-decoration: underline;
        }

        .recipe-card p {
            font-size: 14px;
            line-height: 1.6;
            margin: 4px 0;
        }

        .no-result {
            text-align: center;
            color: #999;
            font-size: 16px;
            margin-top: 30px;
        }

        strong {
            color: #37474f;
        }
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="main-container">
    <h2>🥕 "${condition}" 건강 맞춤형 레시피 목록</h2>

    <c:if test="${empty recipes}">
        <p class="no-result">조건에 맞는 레시피가 없습니다.</p>
    </c:if>

    <div class="recipe-list">
        <c:forEach var="recipe" items="${recipes}">
            <div class="recipe-card">
                <h3>
                    <a href="${pageContext.request.contextPath}/recipeDetail.do?no=${recipe.recipeId}">
                        ${recipe.name}
                    </a>
                </h3>
                <p><strong>설명:</strong> ${recipe.description}</p>
                <p><strong>재료:</strong> ${recipe.ingredientName}</p>
                <p><strong>추천 수:</strong> ${recipe.recommendNumber} / <strong>평점:</strong> ${recipe.avgRating}</p>
            </div>
        </c:forEach>
    </div>

    <c:import url="/WEB-INF/views/common/pagingView.jsp" />
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
