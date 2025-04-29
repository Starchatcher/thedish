<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>음료 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-form {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-form input[type="search"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-form input[type="submit"] {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
        }
        .search-form input[type="submit"]:hover {
            background-color: #0056b3;
        }
     .grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* 4열로 설정 */
    gap: 20px; /* 카드들 사이의 간격을 고정 */
    margin-top: 20px;
    justify-items: center; /* 카드들을 가운데 정렬 */
}
        .drink-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
            padding: 10px;
            margin: 10px;
            width: 200px; /* 고정된 너비 */
            height: 300px; /* 고정된 높이 */
        }
        .drink-card img {
            width: 100%; /* 카드 너비에 맞게 이미지 크기 조정 */
            height: 150px; /* 고정된 이미지 높이 */
            object-fit: cover; /* 이미지 비율 유지 */
        }
        .drink-card h3 {
            font-size: 18px;
            margin: 10px 0;
        }
        .drink-card p {
            color: #666;
            font-size: 14px;
            margin: 5px 0;
        }
        .view-count {
            color: #ff5722; /* 조회수를 강조하는 색상 */
            font-weight: bold;
        }
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

    <form action="drinkSearch.do" id="titleform" class="sform" method="get">
        <input type="hidden" name="action" value="title">
        <fieldset>
            <legend>검색할 제목을 입력하세요.</legend>
            <input type="search" name="keyword" size="50"> &nbsp; 
            <input type="submit" value="검색">
        </fieldset>
    </form>

    <a href="moveInsertDrink.do">등록</a>
    
    <div class="grid"> <!-- 그리드 레이아웃을 위한 div -->
        <c:forEach items="${ requestScope.list }" var="drink" varStatus="status">
            <c:if test="${status.index < 12}"> <!-- 12개 항목만 출력 -->
                <div class="drink-card"> <!-- 각 음료 항목을 카드 형태로 -->
                    <a href="drinkDetail.do?no=${ drink.drinkId }">
                        <c:choose>
                            <c:when test="${not empty drink.imageUrl}">
                                <img src="${drink.imageUrl}" alt="이미지" />
                            </c:when>
                            <c:when test="${not empty drink.imageId and drink.imageId != 0}">
                                <img src="${pageContext.request.contextPath}/image/view.do?imageId=${drink.imageId}" alt="이미지" />
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/resources/images/default-image.png" alt="기본 이미지" />
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <h3>${ drink.name }</h3>
                    <p>${ drink.description }</p>
                    <p class="view-count">조회수: ${ drink.viewCount }</p>
                    <p>알콜도수: ${ drink.alcoholContent }</p>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <br>
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
