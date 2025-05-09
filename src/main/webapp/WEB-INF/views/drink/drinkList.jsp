<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>음료 목록</title>
     <style>

/* body 배경 스타일 (이전 예시와 동일) */
body {
    font-family: 'Arial', sans-serif;
    /* 이전 예시의 그라디언트 배경 적용 */
    background: linear-gradient(120deg, #f8d5dc, #d3eaf2);
    margin: 0;
    padding: 20px;
}

/* 주요 콘텐츠를 감싸는 컨테이너 (스타일 적용을 위해 추가) */
/* 이 div로 <h1>, #search-area, .grid, .paging 전체를 감싸주세요. */
.content-container {
    background-color: rgba(255, 255, 255, 0.8); /* 투명한 흰색 배경 */
    padding: 30px; /* 내부 여백 */
    border-radius: 15px; /* 둥근 모서리 */
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    max-width: 1200px; /* 전체 컨테이너 최대 너비 설정 (그리드 고려) */
    margin: 50px auto; /* 페이지 중앙 배치 및 상하 마진 */
}

/* 컨테이너 내부 요소들에 대한 스타일 조정 */

.content-container h1 { /* 컨테이너 내부의 h1 */
    text-align: center;
    margin-bottom: 20px;
    color: #333; /* 글자색 조정 */
}

/* 검색 폼 컨테이너 */
/* fieldset 또는 #search-area는 .content-container 내부에 위치한다고 가정 */
#search-area, fieldset { /* 둘 다 사용 가능, 또는 하나로 통일 */
    max-width: 800px; /* 검색 영역 최대 너비 (필요시 조정) */
    width: 100%;
    margin: 0 auto 30px; /* 가운데 정렬 + 아래 여백 증가 */
    display: flex; /* flexbox 유지 */
    justify-content: center; /* 내부 요소 가운데 정렬 */
    align-items: center;
    padding: 15px 20px; /* 패딩 조정 */
    background-color: #ffffff; /* 흰색 배경 */
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* 부드러운 그림자 */
    border: none; /* 테두리 제거 */
    box-sizing: border-box; /* 패딩 포함 너비 계산 */
}

#titleform { /* 검색 입력 필드 및 버튼 묶음 */
    display: flex; /* flexbox 유지 */
    align-items: center; /* 수직 가운데 정렬 */
    gap: 10px; /* 요소들 사이 간격 */
    width: 100%; /* 부모 너비에 맞춤 */
    justify-content: center; /* 내부 요소 가운데 정렬 */
}


#titleform select, /* 검색 입력 필드 및 버튼 */
#titleform input[type="search"],
#titleform input[type="submit"] {
    height: 38px; /* 높이 조정 */
    padding: 0 12px; /* 좌우 패딩 조정 */
    font-size: 15px; /* 글자 크기 조정 */
    border: 1px solid #ddd; /* 테두리 추가 (구분감) */
    border-radius: 8px;
    box-sizing: border-box;
}

#titleform select { /* 검색 폼 select */
    min-width: 100px; /* 최소 너비 조정 */
    border: 1px solid #ddd; /* select 박스 테두리 추가 */
}


#titleform input[type="search"] { /* 검색 입력 필드 */
    width: 250px; /* 너비 조정 */
}

#titleform input[type="submit"] { /* 검색 버튼 */
    /* 이전 예시 버튼 색상 계열 적용 */
    background-color: #f29abf;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
    padding: 0 15px; /* 패딩 조정 */
}

#titleform input[type="submit"]:hover { /* 검색 버튼 호버 */
    /* 이전 예시 호버 색상 계열 적용 */
    background-color: #e089a8;
}

.sort-options {
    display: flex; /* 정렬 버튼들(input 태그)을 가로로 나열 */
    align-items: center; /* 정렬 버튼들 세로 가운데 정렬 */
    gap: 8px; /* 정렬 버튼들 사이의 간격 */
    flex-shrink: 0;
    /* --- 추가: 이 요소를 가능한 오른쪽으로 밀어냅니다. --- */
    margin-left: auto;
    /* --- 추가 끝 --- */
}

/* 개별 정렬 버튼 (input type="button" 태그) 스타일 */
.sort-options input[type="button"] {
    /* 브라우저 기본 input 버튼 스타일 초기화 */
    appearance: none; /* 기본 OS/브라우저 스타일 제거 */
    -webkit-appearance: none; /* 웹킷 기반 브라우저용 */
    -moz-appearance: none; /* 파이어폭스용 */
    background: none;
    color: inherit;
    border: none; /* 초기화 */
    padding: 0; /* 초기화 */
    font: inherit;
    cursor: pointer;
    outline: inherit;
    margin: 0; /* 기본 마진 제거 */

    /* 원하는 버튼 스타일 적용 */
    display: inline-block;
    padding: 8px 12px; /* 버튼 형태를 위한 패딩 */
    color: #333;
    border: 1px solid #ccc; /* 테두리 다시 설정 */
    border-radius: 8px; /* 버튼 모서리 둥글게 */
    transition: background-color 0.3s ease, border-color 0.3s ease, color 0.3s ease;
    font-size: 14px; /* 글자 크기 */
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    height: 34px; /* 필드셋 내부 세로 가운데 정렬을 위해 높이 조정 (패딩 고려) */
    box-sizing: border-box; /* 패딩과 보더가 높이에 포함되도록 */
    text-align: center; /* 텍스트 가운데 정렬 */
}

/* 현재 선택된 정렬 버튼 (input type="button" 태그) 스타일 */
.sort-options input[type="button"].active {
    font-weight: bold;
    color: #fff; /* 활성화된 버튼 글자색 */
    background-color: #f29abf; /* 활성화된 버튼 배경색 */
    border-color: #f29abf; /* 활성화된 버튼 테두리색 */
}

/* 정렬 버튼 호버 스타일 (활성화되지 않은 버튼만) */
.sort-options input[type="button"]:hover:not(.active) {
    background-color: #f0f0f0;
    border-color: #bbb;
    color: #000;
}


/* 그리드 컨테이너 */
  .grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* 4열 고정 설정 */
    gap: 20px; /* 카드들 사이의 간격 */
    margin: 20px auto; /* 상하 여백 및 중앙 정렬 */
    max-width: 1200px; /* 최대 너비 설정 (필요에 따라 조정) */
}

/* 음료 카드 스타일 */
.drink-card {
    background-color: #fff; /* 카드 배경은 흰색 유지 (구분감을 위해) */
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    text-align: center;
    padding: 10px;
    height: 380px; /* 고정된 높이 조정 (내용 길이에 따라 조절 필요) */
    display: flex; /* 카드 내용을 위한 flexbox */
    flex-direction: column; /* 세로 방향 정렬 */
    justify-content: space-between; /* 내용 간격 벌리기 */
    cursor: pointer; /* 클릭 가능한 느낌 */
    transition: transform 0.2s ease; /* 호버 애니메이션 */
}

/* 카드 내용이 넘칠 경우 스크롤 가능하도록 설정 */
.drink-card-content {
    overflow-y: auto; /* 세로 방향 스크롤 */
    flex-grow: 1; /* 남은 공간을 채우도록 설정 */
}


.drink-card:hover {
    transform: translateY(-5px); /* 호버 시 살짝 위로 */
}

/* 카드 내 이미지 스타일 (음료 목록: .drink-card) */
.drink-card img {
    width: 100%;
    height: 180px; /* 이미지 높이 조정 (카드 높이에 따라) */
    object-fit: cover;
    border-radius: 4px; /* 이미지 모서리 둥글게 */
    margin-bottom: 10px;
    border-bottom: 1px solid #eee; /* 이미지 하단 구분선 유지 */
}

.drink-card h3 { /* 카드 내 제목 스타일 */
    font-size: 18px;
    margin: 0 0 5px 0; /* 간격 조정 */
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    flex-shrink: 0;
    color: #555; /* 글자색 조정 */
}
.drink-card h3 a { /* 제목 링크 스타일 */
    text-decoration: none;
    color: inherit;
}

.drink-card p { /* 카드 내 p 태그 스타일 */
     color: #666;
     font-size: 14px;
     margin: 5px 0;
     /* 설명에 여러 줄 말줄임표 필요시 추가 스타일링 */
     flex-grow: 1; /* 남은 공간 채우기 */
     overflow: hidden; /* 넘치는 내용 숨김 */
     text-overflow: ellipsis; /* 말줄임표 */
     display: -webkit-box;
     -webkit-line-clamp: 4; /* 2줄까지만 표시 */
     -webkit-box-orient: vertical;
     word-wrap: break-word; /* 단어 단위 줄바꿈 */
     line-height: 1.4; /* 줄 간격 */
     
}


/* 음료에 특화된 정보 (가격, 도수) 스타일 */
.drink-card .drink-info {
    font-size: 14px;
    color: #333;
    margin-top: 5px;
    margin-bottom: 20px; /* 하단 푸터와의 간격 */
    flex-shrink: 0;
}
.drink-card .drink-info strong {
    color: #555;
}

/* 카드 하단 정보 (조회수 등) 컨테이너 스타일 */
.drink-card .card-footer {
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
     color: #ff5722; /* 조회수 색상 유지 */
     font-weight: bold;
}


/* 페이징 영역 스타일 */
/* .paging는 .content-container 내부에 위치한다고 가정 */
.paging {
    margin: 30px auto; /* 상하 마진 및 중앙 정렬 */
    /* width는 .content-container에 맞춰지므로 여기서 고정 너비 제거 */
    /* width: 650px; */
    text-align: center;
}

.paging a, .paging span { /* 페이징 링크/숫자 스타일 */
    display: inline-block;
    width: 35px; /* 너비 조정 */
    height: 35px; /* 높이 조정 */
    line-height: 35px;
    margin: 0 4px; /* 간격 조정 */
    text-align: center;
    font-size: 15px; /* 글자 크기 조정 */
    /* 페이징 색상 이전 예시 계열로 변경 */
    border: 1px solid #f29abf;
    border-radius: 6px;
    color: #f29abf;
    text-decoration: none;
    transition: all 0.3s ease;
    background-color: #fff;
}

.paging a:hover { /* 페이징 링크 호버 */
    /* 페이징 호버 색상 이전 예시 계열로 변경 */
    background-color: #f29abf;
    color: #fff;
}

.paging .current-page { /* 현재 페이지 스타일 */
    /* 현재 페이지 색상 이전 예시 계열로 변경 */
    background-color: #f29abf;
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

/* 반응형 디자인을 위한 미디어 쿼리 */
@media (max-width: 1200px) {
    .content-container {
        max-width: 960px; /* 더 작은 화면에서는 최대 너비 줄이기 */
    }
    .grid {
         grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); /* 카드 너비 조정 */
    }
}

@media (max-width: 992px) {
    .content-container {
        max-width: 720px;
        padding: 25px;
        margin: 40px auto;
    }
     .grid {
         grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
         gap: 15px;
     }
     #search-area, fieldset {
         max-width: 100%; /* 전체 너비 사용 */
         flex-direction: column; /* 세로 정렬 */
         align-items: stretch; /* 전체 너비 사용 */
         padding: 15px;
     }
     #titleform {
         flex-direction: column; /* 세로 정렬 */
         align-items: stretch; /* 전체 너비 사용 */
         gap: 8px; /* 간격 조정 */
     }
     #titleform select,
     #titleform input[type="search"],
     #titleform input[type="submit"] {
         width: 100%; /* 전체 너비 사용 */
         margin: 0; /* 마진 제거 */
     }
     .paging {
        margin: 20px auto;
     }
     .paging a, .paging span {
         width: 30px;
         height: 30px;
         line-height: 30px;
         font-size: 14px;
         margin: 0 3px;
     }
     .drink-card {
         height: 320px; /* 카드 높이 조정 */
         padding-bottom: 55px;
     }
      .drink-card img {
         height: 150px; /* 이미지 높이 조정 */
     }

}

@media (max-width: 768px) {
     .grid {
         grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); /* 태블릿 세로 등 */
         gap: 15px;
     }
     .content-container {
         padding: 20px;
     }
      .drink-card {
         height: 300px; /* 카드 높이 조정 */
         padding-bottom: 50px;
     }
     .drink-card img {
         height: 140px; /* 이미지 높이 조정 */
     }
}

@media (max-width: 576px) {
     .grid {
         grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); /* 모바일 */
         gap: 10px;
     }
     .content-container {
         padding: 15px;
         margin: 20px auto;
         border-radius: 10px; /* 모서리 덜 둥글게 */
     }
      .drink-card {
         height: 280px; /* 카드 높이 조정 */
         padding-bottom: 45px;
         padding: 8px;
     }
     .drink-card img {
         height: 120px; /* 이미지 높이 조정 */
         margin-bottom: 8px;
     }
     .drink-card h3 {
         font-size: 16px;
     }
     .drink-card p, .drink-card .drink-info, .drink-card .card-footer {
         font-size: 12px;
     }
     .paging a, .paging span {
         width: 25px;
         height: 25px;
         line-height: 25px;
         font-size: 12px;
         margin: 0 2px;
     }
     #search-area, fieldset {
          padding: 10px;
          margin-bottom: 20px;
     }
     #titleform select,
     #titleform input[type="search"],
     #titleform input[type="submit"] {
         height: 32px;
         font-size: 13px;
         padding: 0 8px;
     }
}

</style>

</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

       <form action="drinkSearch.do" id="titleform" class="sform" method="get">
        <input type="hidden" name="action" value="title">
        <%-- 정렬 기준을 저장할 숨겨진 필드 추가 (폼 안에 있어야 합니다) --%>
        <%-- value="${param.sortType}" 를 사용하여 현재 정렬 기준을 유지합니다. --%>
        <input type="hidden" name="sortType" id="sortType" value="${param.sortType}">

        <%-- fieldset 안에 검색 입력, 버튼, 정렬 옵션을 함께 배치합니다. --%>
        <%-- fieldset에 display: flex가 적용되어 요소들이 가로로 나열될 것입니다. --%>
        <fieldset>
            <%-- 검색어 입력 필드: value="${param.keyword}" 를 사용하여 검색어 유지 --%>
            <input type="search" name="keyword" size="50" value="${param.keyword}"> &nbsp;
            <input type="submit" value="검색">

            <!-- 정렬 옵션 버튼 추가 - fieldset 안에 배치 -->
            <div class="sort-options">
                <%-- 정렬 옵션을 INPUT type="button" 태그로 변경 --%>
                <%-- 버튼 텍스트는 value 속성에 지정합니다. --%>
                <%-- onclick 이벤트로 sortRecipes 함수 호출 --%>
                 <input type="button" onclick="sortRecipes(event, 'latest');" class="${param.sortType == 'latest' || param.sortType == null ? 'active' : ''}" value="최신순">
                <input type="button" onclick="sortRecipes(event, 'viewCount');" class="${param.sortType == 'viewCount' ? 'active' : ''}" value="조회수 순">
                <input type="button" onclick="sortRecipes(event, 'rating');" class="${param.sortType == 'rating' ? 'active' : ''}" value="평점 순">
            </div>
        </fieldset>
    </form>
<c:if test="${  loginUser.role eq 'ADMIN' }">
    <a href="moveInsertDrink.do">등록</a>
    </c:if>
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
                            <img src="${pageContext.request.contextPath}/resources/images/thedishlogo.jpg" alt="기본 이미지" />
                        </c:otherwise>
                    </c:choose>
                </a>
                <div class="drink-card-content"> <!-- 카드 내용 감싸기 -->
                    <h3>${ drink.name }</h3>
                    <p>${ drink.description }</p>
                    <p class="view-count">조회수: ${ drink.viewCount }</p>
                    <p>알콜도수: ${ drink.alcoholContent }</p>
                </div>
            </div>
        </c:if>
    </c:forEach>
</div>
    <br>
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
	<c:import url="/WEB-INF/views/common/sidebar.jsp" />
    <c:import url="/WEB-INF/views/common/footer.jsp" />
        <%-- 정렬 기준 변경 및 폼 제출을 위한 JavaScript 함수 --%>
 <script type="text/javascript">
    // 함수 시그니처에 event 객체를 받도록 수정
    function sortRecipes(event, sortType) {
        console.log("sortRecipes 함수 호출됨. sortType:", sortType); // 디버깅 로그 추가

        // 클릭된 버튼 요소를 가져옵니다.
        const clickedButton = event.target;
        console.log("클릭된 요소:", clickedButton); // 디버깅 로그 추가

        // 클릭된 버튼의 가장 가까운 부모 form 요소를 찾습니다.
        const form = clickedButton.closest('form');
        console.log("찾은 form 요소:", form); // 디버깅 로그 추가

        if (form) {
            // 해당 form 내부에서 id가 'sortType'인 hidden input을 찾습니다.
            const sortTypeInput = form.querySelector('#sortType');
             console.log("찾은 sortType input 요소:", sortTypeInput); // 디버깅 로그 추가

            if (sortTypeInput) {
                // hidden input의 값을 설정
                sortTypeInput.value = sortType;
                console.log("sortType input value 설정:", sortTypeInput.value); // 디버깅 로그 추가

                // 폼 제출
                console.log("폼 제출 시도..."); // 디버깅 로그 추가
                form.submit();
            } else {
                console.error("오류: id가 'sortType'인 숨겨진 입력 필드를 폼 내에서 찾을 수 없습니다.");
            }
        } else {
            console.error("오류: 클릭된 버튼의 상위 form 요소를 찾을 수 없습니다.");
        }
    }
    </script>
</body>
</html>
