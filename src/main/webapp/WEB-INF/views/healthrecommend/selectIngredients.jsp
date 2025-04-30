<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>추천 재료 선택</title>
</head>
<body>
    <h2>"${condition}" 관련 추천 재료 목록</h2>

    <form action="recommendRecipes.do" method="post">
        <input type="hidden" name="condition" value="${condition}" />

        <p>싫어하는 재료를 선택하세요 (선택한 재료는 제외됩니다):</p>
        <c:forEach var="ingredient" items="${ingredients}">
            <label>
                <input type="checkbox" name="excludedIngredients" value="${ingredient}" />
                ${ingredient}
            </label><br/>
        </c:forEach>

        <br/>
        <button type="submit">레시피 추천받기</button>
    </form>
</body>
</html>