<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>추천 재료 선택</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff9f0; /* 검색창과 같은 톤 */
            color: #333;
        }

        .main-container {
            max-width: 1000px;
            margin: 60px auto;
            padding: 40px;
            background-color: #fffdf7;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        }

        h2 {
            font-size: 26px;
            color: #d84315;
            margin-bottom: 24px;
            text-align: center;
        }

        .dual-box {
            display: flex;
            gap: 40px;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .include-box, .exclude-box {
            flex: 1;
            min-width: 300px;
            padding: 20px;
            border-radius: 12px;
            background-color: #fffaf2;
            box-shadow: 0 2px 6px rgba(255, 138, 101, 0.1);
            max-height: 500px;
            display: flex;
            flex-direction: column;
        }

        .include-box h3,
        .exclude-box h3 {
            font-size: 18px;
            margin-bottom: 14px;
            color: #ff7043;
        }

        .ingredient-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow-y: auto;
            max-height: 400px; /* 추천 재료 10개 이상 시 스크롤 */
            padding-right: 6px;
        }

        .ingredient-item {
            background-color: #fff;
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            transition: all 0.3s ease;
            border: 1px solid #ffe0b2;
        }

        .ingredient-item:hover {
            background-color: #fff3e0;
        }

        .ingredient-item input[type="checkbox"]:checked + span {
            opacity: 0.5;
        }

        .bad-list {
            list-style: disc;
            padding-left: 20px;
            color: #e53935;
            font-size: 14px;
            overflow-y: auto;
            max-height: 360px; /* 금기 재료 20개 이상 시 스크롤 */
        }

        .bad-list li {
            margin-bottom: 6px;
        }

        /* 스크롤바 커스터마이징 */
        .ingredient-list::-webkit-scrollbar,
        .bad-list::-webkit-scrollbar {
            width: 6px;
        }

        .ingredient-list::-webkit-scrollbar-thumb,
        .bad-list::-webkit-scrollbar-thumb {
            background-color: #ffab91;
            border-radius: 3px;
        }

        button[type="submit"] {
            display: block;
            margin: 30px auto 0;
            padding: 14px 40px;
            background-color: #ff7043;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #bf360c;
        }
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="main-container">
    <h2>"${condition}"에 대한 건강 맞춤 재료 선택</h2>

    <form action="recommendRecipes.do" method="post">
        <input type="hidden" name="condition" value="${condition}" />

        <div class="dual-box">
            <!-- 추천 재료 (체크박스) -->
            <div class="include-box">
                <h3>🥗 좋은 재료 <br> 
                (싫어하는 재료는 체크해서 제외!)</h3>
                <div class="ingredient-list">
                    <c:forEach var="ingredient" items="${recommendedIngredients}">
                        <div class="ingredient-item">
                            <label>
                                <input type="checkbox" name="excludedIngredients" value="${ingredient}" />
                                <span>${ingredient}</span>
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 금기 재료 (표시만) -->
            <div class="exclude-box">
                <h3>🚫 금기 재료 (드시지 마세요!)</h3>
                <ul class="bad-list">
                    <c:forEach var="bad" items="${excludedIngredients}">
                        <li>${bad}</li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <button type="submit">레시피 추천받기</button>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
