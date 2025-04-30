<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>추천 재료 선택</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f7fdf8;
            color: #333;
        }

        .main-container {
            max-width: 900px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #2e7d32;
            margin-bottom: 30px;
        }

        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }

        /* 회전 접시 구조 */
        .plate-wrapper {
            position: relative;
            width: 420px;
            height: 400px;
            margin: 0 auto 30px;
        }

        .plate-rotate-bg {
            position: absolute;
            width: 100%;
            height: 100%;
            background-image: url('<c:url value="/resources/images/plate.jpg"/>'); /* 천 없이 접시만! */
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            border-radius: 50%;
            animation: spin 20s linear infinite;
            z-index: 1;
        }

        .plate-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .ingredient-item {
            background-color: rgba(255, 255, 255, 0.92);
            padding: 4px 8px;
            border-radius: 999px;
            font-size: 13px;
            min-width: 160px;
            max-width: 200px;
            white-space: nowrap;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            transition: opacity 0.3s ease;
        }

        .ingredient-item:hover {
            transform: scale(1.05);
            background-color: #f1f8e9;
        }

        /* 체크된 재료 반투명 처리 */
        .ingredient-item input[type="checkbox"]:checked + span {
            opacity: 0.5;
        }

        button[type="submit"] {
            padding: 14px 40px;
            background-color: #66bb6a;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #43a047;
        }
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="main-container">
    <h2>"${condition}" 관련 추천 재료 목록</h2>

    <form action="recommendRecipes.do" method="post">
        <input type="hidden" name="condition" value="${condition}" />
        <p>싫어하는 재료를 선택하세요 (선택한 재료는 제외됩니다):</p>

        <div class="plate-wrapper">
            <div class="plate-rotate-bg"></div> <!-- 회전 접시 -->
            <div class="plate-content"> <!-- 고정된 재료들 -->
                <c:forEach var="ingredient" items="${ingredients}">
                    <div class="ingredient-item">
                        <label>
                            <input type="checkbox" name="excludedIngredients" value="${ingredient}" />
                            <span>${ingredient}</span>
                        </label>
                    </div>
                </c:forEach>
            </div>
        </div>

        <button type="submit">레시피 추천받기</button>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
