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

/* 제목 스타일 (예시) */
h1 {
    text-align: center;
    margin-bottom: 20px;
}

/* 검색 폼 스타일 (recipeList.jsp와 동일하게 적용) */
#search-area { /* 검색 폼 컨테이너 */
    width: 650px; /* 너비 조정 필요시 */
    margin: 0 auto 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

  fieldset {
        border: none; /* 테두리 제거 */
        padding: 8px; /* 내부 여백 */
        background-color: #ffffff; /* 흰색 배경 */
        border-radius: 8px; /* 둥근 모서리 */
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* 부드러운 그림자 */
    }


#titleform select, /* 검색 입력 필드 및 버튼 */
#titleform input[type="search"],
#titleform input[type="submit"] {
    height: 36px;
    padding: 0 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 8px;
}

#titleform select { /* 검색 폼 select */
    min-width: 80px;
}

#titleform input[type="search"] { /* 검색 입력 필드 */
    width: 220px; /* 너비 조정 필요시 */
}

#titleform input[type="submit"] { /* 검색 버튼 */
    background-color: #8FBC8F; /* 색상 조정 필요시 */
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
    padding: 12px 8px;
}

#titleform input[type="submit"]:hover { /* 검색 버튼 호버 */
    background-color: #7aa97a; /* 색상 조정 필요시 */
}

/* 그리드 컨테이너 */
.grid {
    display: grid;
 
     grid-template-columns: repeat(4, 1fr);
    gap: 20px; /* 카드들 사이의 간격 */
    margin-top: 20px;
    padding: 0 20px; /* 좌우 여백 (필요시 조정) */
    max-width: 1200px; /* 그리드 최대 너비 지정 (선택 사항, 가운데 정렬 시 유용) */
    margin-left: auto;  /* 가운데 정렬 */
    margin-right: auto; /* 가운데 정렬 */
}

/* 각 항목 카드 스타일 (음료 목록: .drink-card) */
.drink-card {
    /* ... (이전 .drink-card 스타일 유지: 배경, 그림자, 패딩, 높이, flex 설정 등) ... */
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    text-align: center;
    padding: 10px;
    height: 350px; /* 카드 높이 (콘텐츠 양에 따라 조정) */
    position: relative;
    padding-bottom: 60px;
    display: flex;
    flex-direction: column;
}

/* 카드 내 이미지 스타일 (음료 목록: .drink-card) */
.drink-card img { /* <-- 클래스 선택자 수정 */
    width: 100%; /* 카드 너비에 맞게 이미지 크기 조정 */
    height: 150px; /* 고정된 이미지 높이 */
    object-fit: cover; /* 이미지 비율 유지 (잘리지 않고 꽉 채움) */
    border-bottom: 1px solid #eee; /* 이미지 하단 구분선 */
}

.drink-card h3 { /* 카드 내 제목 스타일 */
    font-size: 18px;
    margin: 10px 0 5px 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    flex-shrink: 0;
}

.drink-card p { /* 카드 내 p 태그 스타일 */
     color: #666;
     font-size: 14px;
     margin: 5px 0;
     /* 설명에 여러 줄 말줄임표 필요시 추가 스타일링 */
}

/* 음료에 특화된 정보 (가격, 도수) 스타일 */
.drink-card .drink-info { /* HTML에서 <p class="drink-info">... </p> 로 감쌌다고 가정 */
    font-size: 14px;
    color: #333;
    margin-top: 5px;
    flex-shrink: 0;
}
.drink-card .drink-info strong {
    color: #555;
}

/* 카드 하단 정보 (조회수 등) 컨테이너 스타일 */
.drink-card .card-footer { /* HTML에서 <div class="card-footer">...</div> 로 감쌌다고 가정 */
    position: absolute;
    bottom: 10px;
    left: 0;
    right: 0;
    padding: 0 10px;
    font-size: 13px;
    color: #555;
    display: flex;
    justify-content: space-between;
    flex-shrink: 0;
}

/* 조회수 등 특정 정보 강조 스타일 */
.drink-card .view-count {
     color: #ff5722;
     font-weight: bold;
}


/* 페이징 영역 스타일 (recipeList.jsp와 동일하게 적용) */
.paging {
    margin: 30px auto;
    width: 650px; /* 너비 조정 필요시 */
    text-align: center;
}

.paging a, .paging span { /* 페이징 링크/숫자 스타일 */
    display: inline-block;
    width: 30px; /* 너비 조정 필요시 */
    height: 30px; /* 높이 조정 필요시 */
    line-height: 30px;
    margin: 0 2px;
    text-align: center;
    font-size: 14px; /* 글자 크기 조정 필요시 */
    border: 1px solid #8FBC8F; /* 테두리 색상 조정 필요시 */
    border-radius: 6px;
    color: #8FBC8F; /* 글자 색상 조정 필요시 */
    text-decoration: none;
    transition: all 0.3s ease;
    background-color: #fff;
}

.paging a:hover { /* 페이징 링크 호버 */
    background-color: #8FBC8F; /* 색상 조정 필요시 */
    color: #fff;
}

.paging .current-page { /* 현재 페이지 스타일 */
    background-color: #8FBC8F; /* 색상 조정 필요시 */
    color: #fff;
    font-weight: bold;
    cursor: default;
}

/* 비활성화된 페이징 스팬 스타일 */
.paging .disabled {
    color: #ccc;
    border-color: #ccc;
    cursor: default;
    background-color: #f9f9f9;
}

        
        
        
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

    <form action="drinkSearch.do" id="titleform" class="sform" method="get">
        <input type="hidden" name="action" value="title">
        <fieldset>
           
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
