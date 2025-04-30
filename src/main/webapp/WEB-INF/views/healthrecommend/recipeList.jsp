<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>추천 레시피 결과</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f7fdf8;
            color: #333;
        }

        .main-container {
            max-width: 1000px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 28px;
            color: #2e7d32;
            margin-bottom: 30px;
            text-align: center;
        }

        .recipe-card {
            border: 1px solid #c8e6c9;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            background-color: #f1f8e9;
            transition: transform 0.2s ease;
        }

        .recipe-card:hover {
            transform: scale(1.01);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .recipe-card h3 {
            font-size: 22px;
            color: #388e3c;
            margin-bottom: 10px;
        }

        .recipe-card p {
            font-size: 15px;
            margin: 5px 0;
        }

        .no-result {
            text-align: center;
            color: #999;
            font-size: 16px;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="main-container">
    <h2>당신을 위한 건강 맞춤형 레시피</h2>

    <c:if test="${empty recipes}">
        <p class="no-result">조건에 맞는 레시피가 없습니다.</p>
    </c:if>

    <c:forEach var="recipe" items="${recipes}">
        <div class="recipe-card">
            <h3>${recipe.name}</h3>
            <p><strong>설명:</strong> ${recipe.description}</p>
            <p><strong>재료:</strong> ${recipe.ingredientName}</p>
            <p><strong>추천 수:</strong> ${recipe.recommendNumber} / <strong>평점:</strong> ${recipe.avgRating}</p>
        </div>
    </c:forEach>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
