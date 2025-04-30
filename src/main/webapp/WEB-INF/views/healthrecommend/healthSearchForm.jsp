<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>건강 맞춤형 추천 검색</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />


<c:import url="/WEB-INF/views/common/sidebar.jsp" />
    <h2>예방하고 싶은 질병을 입력하세요</h2>
    <form action="recommendIngredients.do" method="get">
        <input type="text" name="condition" placeholder="예: 고혈압, 당뇨" required />
        <button type="submit">추천 재료 보기</button>
    </form>
 <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>