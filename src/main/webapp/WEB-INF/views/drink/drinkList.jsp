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
    font-family: 'Arial', sans-serif; /* 폰트 스타일 유지 */
    /* 흑백 모던 스타일 배경: 밝은 회색 계열 또는 미세한 패턴 */
    background: #f0f0f0; /* 밝은 회색 배경 */
    /* 또는 background: url('path/to/subtle-pattern.png'); 배경 패턴 사용 */
    margin: 0; /* body 기본 마진 제거 */
    padding: 20px; /* 전체 페이지 여백 유지 */
    color: #333; /* 기본 글자색: 어두운 회색 */
}

/* 주요 콘텐츠를 감싸는 컨테이너 스타일 */
.content-container {
    background-color: #ffffff; /* 흰색 배경 */
    padding: 30px; /* 내부 여백 */
    border-radius: 8px; /* 둥근 모서리 (모던한 느낌을 위해 너무 둥글지 않게) */
    /* 그림자 효과: 부드럽고 은은하게 */
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    max-width: 1200px; /* 전체 컨테이너 최대 너비 설정 */
    margin: 50px auto; /* 페이지 중앙 배치 및 상하 마진 */
    border: 1px solid #ddd; /* 얇은 경계선 추가 (선택 사항) */
}

.content-container h1 { /* 컨테이너 내부의 h1 */
    text-align: center;
    margin-bottom: 30px; /* 제목 아래 여백 증가 */
    color: #222; /* 글자색: 더 진한 회색 */
    font-weight: normal; /* 제목 굵기 조정 (선택 사항) */
    letter-spacing: 1px; /* 글자 간격 조정 (선택 사항) */
}

/* 검색 폼 컨테이너 */
/* fieldset 또는 #search-area는 .content-container 내부에 위치한다고 가정 */
#search-area, fieldset { /* fieldset 사용 시 이 규칙이 적용됨 */
    max-width: 800px; /* 검색 영역 최대 너비 (필요시 조정) */
    width: 100%; /* 너비를 100%로 설정 */
    margin: 0 auto 30px; /* 상하 마진 + 좌우 자동 마진 (가운데 정렬) */
    display: flex; /* flexbox 사용 */
    /* 내부 요소 가운데 정렬은 그대로 유지 */
    justify-content: center; 
    align-items: center; /* 세로 가운데 정렬 */
    padding: 15px 20px; /* 패딩 조정 */
    /* 흑백 모던 스타일 배경: 흰색 유지 */
    background-color: #ffffff; /* 흰색 배경 */
    border-radius: 8px; /* 둥근 모서리 유지 */
    /* 흑백 모던 스타일 그림자: 부드럽고 은은한 회색 그림자 유지 */
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    border: none; /* 테두리 제거 유지 */
    box-sizing: border-box; /* 패딩 포함 너비 계산 유지 */
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

#titleform input[type="submit"] {
    /* 흑백 모던 스타일 버튼 색상 적용 */
    background-color: #444; /* 어두운 회색 */
    color: white; /* 글자색 흰색 유지 */
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
    padding: 0 15px; /* 패딩 조정 유지 */
    /* 버튼 높이 또는 라인 높이 조정 (필요시) */
    /* line-height: [적절한 높이]; */
    /* height: [적절한 높이]; */
    /* display: inline-block; (패딩 적용을 위해 필요할 수 있습니다) */
}

#titleform input[type="submit"]:hover {
    /* 호버 시 배경색 더 어둡게 */
    background-color: #222;
}

/* 정렬 옵션 컨테이너 스타일 */
.sort-options {
    display: flex; /* 정렬 버튼들(input 태그)을 가로로 나열 */
    align-items: center; /* 정렬 버튼들 세로 가운데 정렬 */
    gap: 8px; /* 정렬 버튼들 사이의 간격 */
    flex-shrink: 0;
    margin-left: auto; /* 이 요소를 가능한 오른쪽으로 밀어냅니다. */
}

/* 정렬 버튼 스타일 (input type="button" 태그) */
.sort-options input[type="button"] {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    background: none;
    color: inherit;
    font: inherit;
    cursor: pointer;
    outline: inherit;
    margin: 0;

    display: inline-block;
    padding: 8px 12px;
    color: #555; /* 기본 버튼 글자색: 중간 회색 */
    border: 1px solid #ccc; /* 기본 버튼 테두리 색상 */
    border-radius: 8px;
    transition: background-color 0.3s ease, border-color 0.3s ease, color 0.3s ease;
    font-size: 14px;
    white-space: nowrap;
    height: 34px; /* 높이 유지 */
    box-sizing: border-box;
    text-align: center;
}

/* 현재 선택된 정렬 버튼 (input type="button" 태그) 스타일 */
.sort-options input[type="button"].active {
    font-weight: bold;
    color: white; /* 활성화된 버튼 글자색: 흰색 */
    background-color: #333; /* 활성화된 버튼 배경색: 어두운 회색 */
    border-color: #333; /* 활성화된 버튼 테두리색: 어두운 회색 */
}

/* 정렬 버튼 호버 스타일 (활성화되지 않은 버튼만) */
.sort-options input[type="button"]:hover:not(.active) {
    background-color: #eee; /* 호버 시 배경색: 아주 밝은 회색 */
    border-color: #bbb; /* 호버 시 테두리색: 약간 어두운 회색 */
    color: #000; /* 호버 시 글자색: 검정색 */
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
/* 음료 등록 버튼 스타일 (링크를 버튼처럼 꾸밈) */
.register-drink-button {
    display: inline-block; /* 인라인 블록 요소로 만들어 패딩과 너비/높이 적용 가능하게 함 */
    padding: 10px 20px; /* 버튼 내부 여백 */
    background-color: #555; /* 배경색: 중간 회색 */
    color: white; /* 글자색: 흰색 */
    border: none; /* 테두리 없음 */
    border-radius: 4px; /* 둥근 모서리 */
    text-decoration: none; /* 링크의 기본 밑줄 제거 */
    font-size: 1rem; /* 글자 크기 */
    cursor: pointer; /* 마우스 오버 시 커서 모양 변경 */
    transition: background-color 0.3s ease; /* 배경색 변경 시 부드러운 전환 효과 */
    margin-left: 10px; /* 필요한 경우 다른 요소와의 간격 조정 */
    /* 세로 중앙 정렬 등 필요한 레이아웃 속성은 부모 요소에서 조정 */
}

/* 음료 등록 버튼 호버 스타일 */
.register-drink-button:hover {
    background-color: #333; /* 마우스 오버 시 배경색 더 어둡게 */
    color: white; /* 호버 시 글자색 유지 (필요에 따라 변경 가능) */
}

/* 음료 등록 버튼 클릭 시 스타일 */
.register-drink-button:active {
    background-color: #222; /* 클릭 중일 때 배경색 더 어둡게 */
}
</style>

</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

       <form action="drinkSearch.do" id="titleform" class="sform" method="get">
    <input type="hidden" name="action" value="title">

    <%-- 정렬 기준을 저장할 숨겨진 필드 --%>
    <%-- value="${param.sortType}" 를 사용하여 현재 정렬 기준을 유지합니다. --%>
    <input type="hidden" name="sortType" id="sortType" value="${param.sortType}">

    <%-- *** 추가: 정렬 방향을 저장할 숨겨진 필드 *** --%>
    <%-- value="${param.sortDirection}" 를 사용하여 현재 정렬 방향을 유지합니다. --%>
    <%-- 초기 로딩 시 param.sortDirection이 null이면 기본값 'DESC'로 설정할 수 있습니다. --%>
    <input type="hidden" name="sortDirection" id="sortDirection" value="${param.sortDirection == null ? 'DESC' : param.sortDirection}">


    <%-- fieldset 안에 검색 입력, 버튼, 정렬 옵션을 함께 배치합니다. --%>
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
    <a href="moveInsertDrink.do" class="register-drink-button">등록</a>
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
    // 현재 정렬 기준과 방향을 저장할 변수 선언 및 초기화
    // 페이지 로드 시 초기값 설정이 필요합니다.
    // JSP에서 서버로부터 받은 초기 정렬 정보를 사용합니다.
    let currentSortType = '<%= request.getParameter("sortType") == null ? "latest" : request.getParameter("sortType") %>'; // 초기 sortType 설정 (기본값: latest)
    let currentSortDirection = '<%= request.getParameter("sortDirection") == null ? "DESC" : request.getParameter("sortDirection") %>'; // 초기 sortDirection 설정 (기본값: DESC)

    function sortRecipes(event, sortType) {
        console.log("sortRecipes 함수 호출됨. 클릭된 sortType:", sortType); // 디버깅 로그 추가

        // 클릭된 버튼 요소를 가져옵니다.
        const clickedButton = event.target;
        console.log("클릭된 요소:", clickedButton); // 디버깅 로그 추가

        // 클릭된 버튼의 가장 가까운 부모 form 요소를 찾습니다.
        const form = clickedButton.closest('form');
        console.log("찾은 form 요소:", form); // 디버깅 로그 추가

        if (form) {
            // 해당 form 내부에서 id가 'sortType'인 hidden input을 찾습니다.
            const sortTypeInput = form.querySelector('#sortType');
            // 해당 form 내부에서 id가 'sortDirection'인 hidden input을 찾습니다.
            const sortDirectionInput = form.querySelector('#sortDirection'); // *** 추가: sortDirection input 찾기 ***
            // 페이지 번호 input 필드도 찾습니다 (ID가 'page'라고 가정)
            const pageInput = form.querySelector('#page'); // *** 추가: 페이지 번호 input 찾기 ***


            if (sortTypeInput && sortDirectionInput) { // *** 수정: sortDirectionInput도 찾았는지 확인 ***
                console.log("찾은 sortType input 요소:", sortTypeInput); // 디버깅 로그 추가
                console.log("찾은 sortDirection input 요소:", sortDirectionInput); // 디버깅 로그 추가
                console.log("찾은 page input 요소:", pageInput); // 디버깅 로그 추가


                // 현재 클릭된 sortType과 저장된 currentSortType 비교
                if (currentSortType === sortType) {
                    // 같은 버튼을 다시 누른 경우, 정렬 방향 토글
                    currentSortDirection = (currentSortDirection === 'DESC') ? 'ASC' : 'DESC';
                    console.log("같은 버튼 다시 클릭. 정렬 방향 토글:", currentSortDirection);
                } else {
                    // 다른 버튼을 누른 경우, 새로운 sortType으로 변경하고 방향은 기본값(DESC)으로 설정
                    currentSortType = sortType;
                    currentSortDirection = 'DESC'; // 새로운 정렬 기준 선택 시 기본값은 내림차순
                    console.log("다른 버튼 클릭. 새로운 sortType 설정:", currentSortType, "방향:", currentSortDirection);
                }

                // hidden input의 값을 설정
                sortTypeInput.value = currentSortType;
                sortDirectionInput.value = currentSortDirection; // *** 추가: sortDirection input value 설정 ***

                console.log("sortType input value 설정:", sortTypeInput.value); // 디버깅 로그 추가
                console.log("sortDirection input value 설정:", sortDirectionInput.value); // 디버깅 로그 추가

                // 정렬 기준이 변경되면 페이지 번호는 1페이지로 리셋
                if (pageInput) {
                    pageInput.value = 1;
                    console.log("페이지 번호 1로 리셋.");
                }


                // 폼 제출
                console.log("폼 제출 시도..."); // 디버깅 로그 추가
                form.submit();
            } else {
                console.error("오류: 필수 숨김 입력 필드(sortType, sortDirection)를 폼 내에서 찾을 수 없습니다."); // *** 오류 메시지 수정 ***
            }
        } else {
            console.error("오류: 클릭된 버튼의 상위 form 요소를 찾을 수 없습니다.");
        }
    }
</script>
</body>
</html>