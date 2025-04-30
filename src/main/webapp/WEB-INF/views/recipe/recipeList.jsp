<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>레시피 목록</title>
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
            gap: 20px; /* 카드들 사이의 간격 */
            margin-top: 20px;
        }
        .recipe-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
            padding: 10px;
            height: 300px; /* 고정된 높이 */
        }
        .recipe-card img {
            width: 100%; /* 카드 너비에 맞게 이미지 크기 조정 */
            height: 150px; /* 고정된 이미지 높이 */
            object-fit: cover; /* 이미지 비율 유지 */
        }
        .recipe-card h3 {
            font-size: 18px;
            margin: 10px 0;
        }
        .recipe-card p {
            color: #666;
            font-size: 14px;
            margin: 5px 0;
        }
        .view-count {
            color: #ff5722; /* 조회수를 강조하는 색상 */
            font-weight: bold;
        }
        
     #search-area {
    width: 650px; /* 게시판 테이블과 같은 폭으로 맞추기 */
    margin: 0 auto 20px; /* 가운데 정렬 + 아래 여백 */
    display: flex;
    justify-content: space-between; /* 좌우로 양쪽 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
}

#titleform select,
#titleform input[type="search"],
#titleform input[type="submit"] {
    height: 36px; /* 높이 설정 */
    padding: 0 10px; /* 좌우 패딩 */
    font-size: 14px; /* 글자 크기 */
    border: 1px solid #ccc; /* 테두리 설정 */
    border-radius: 8px; /* 둥근 모서리 */
}

#titleform select {
    min-width: 80px; /* 최소 너비 설정 */
}

#titleform input[type="search"] {
    width: 220px; /* 검색 입력 필드 너비 설정 */
}

#titleform input[type="submit"] {
    background-color: #8FBC8F; /* 버튼 배경색 */
    color: white; /* 글자색 */
    border: none; /* 테두리 제거 */
    cursor: pointer; /* 커서 포인터로 변경 */
    transition: background-color 0.3s ease; /* 배경색 변화 애니메이션 */
    padding: 12px 8px; /* 패딩 설정 */
}

#titleform input[type="submit"]:hover {
    background-color: #7aa97a; /* 호버 시 배경색 변경 */
}

        
        
        
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

    <form action="recipeSearch.do" id="titleform" class="sform" method="get">
        <input type="hidden" name="action" value="title">
        <fieldset>
            <legend>검색할 제목을 입력하세요.</legend>
            <input type="search" name="keyword" size="50"> &nbsp; 
            <input type="submit" value="검색">
        </fieldset>
    </form>

    <a href="moveInsertRecipePage.do">등록</a>
    
    <div class="grid"> <!-- 그리드 레이아웃을 위한 div -->
        <c:forEach items="${ requestScope.list }" var="recipe">
            <div class="recipe-card"> <!-- 각 레시피 항목을 카드 형태로 -->
                <a href="recipeDetail.do?no=${ recipe.recipeId }">
                    <c:choose>
                        <c:when test="${not empty recipe.imageUrl}">
                            <img src="${recipe.imageUrl}" alt="이미지" />
                        </c:when>
                        <c:when test="${not empty recipe.imageId and recipe.imageId != 0}">
                            <img src="${pageContext.request.contextPath}/image/view.do?imageId=${recipe.imageId}" alt="이미지" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/images/default-image.png" alt="기본 이미지" />
                        </c:otherwise>
                    </c:choose>
                </a>
                <h3>${ recipe.name }</h3>
                <p>${ recipe.description }</p>
                <p class="view-count">조회수: ${ recipe.viewCount }</p>
            </div>
        </c:forEach>
    </div>
    <br>

    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>