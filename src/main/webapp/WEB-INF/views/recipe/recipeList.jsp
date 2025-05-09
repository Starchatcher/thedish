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
        font-family: 'Arial', sans-serif; /* 폰트 스타일 유지 */
        /* 이전 예시의 그라디언트 배경 적용 */
        background: linear-gradient(120deg, #f8d5dc, #d3eaf2);
        margin: 0; /* body 기본 마진 제거 */
        padding: 20px; /* 전체 페이지 여백 유지 */
    }

    /* 주요 콘텐츠를 감싸는 컨테이너 추가 (스타일 적용을 위해) */
    .content-container {
        background-color: rgba(255, 255, 255, 0.8); /* 투명한 흰색 배경 */
        padding: 30px; /* 내부 여백 */
        border-radius: 15px; /* 둥근 모서리 */
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        max-width: 1200px; /* 전체 컨테이너 최대 너비 설정 (그리드 고려) */
        margin: 50px auto; /* 페이지 중앙 배치 및 상하 마진 */
    }

    .content-container h1 { /* 컨테이너 내부의 h1 */
        text-align: center;
        margin-bottom: 20px;
        color: #333; /* 글자색 조정 */
    }

    /* 검색 폼 스타일 */
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
        /* 이전 예시 버튼 색상 계열 적용 */
        background-color: #f29abf;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-left: 10px;
        transition: background-color 0.3s ease;
    }

    .search-form input[type="submit"]:hover {
        /* 이전 예시 호버 색상 계열 적용 */
        background-color: #e089a8;
    }
.sort-options {
    display: flex; /* 정렬 버튼들(input 태그)을 가로로 나열 */
    align-items: center; /* 정렬 버튼들 세로 가운데 정렬 */
    gap: 8px; /* 정렬 버튼들 사이의 간격 */
    flex-shrink: 0;
    /* --- 여기를 추가 또는 수정합니다 --- */
    margin-left: auto; /* 이 요소를 가능한 오른쪽으로 밀어냅니다. */
    /* --- 추가/수정 끝 --- */
}

.sort-options input[type="button"] {
    /* 브라우저 기본 input 버튼 스타일 초기화 */
    appearance: none; /* 기본 OS/브라우저 스타일 제거 */
    -webkit-appearance: none; /* 웹킷 기반 브라우저용 */
    -moz-appearance: none; /* 파이어폭스용 */
    background: none;
    color: inherit;
    /* border: none; 제거 (아래에서 다시 설정할 것이므로) */
    /* padding: 0; 제거 (아래에서 다시 설정할 것이므로) */
    font: inherit;
    cursor: pointer;
    outline: inherit;
    margin: 0; /* 기본 마진 제거 */

    /* 원하는 버튼 스타일 적용 (이전 button 태그 스타일 참고) */
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
    text-align: center; /* 텍스트 가운데 정렬 (input 버튼의 기본 정렬은 다를 수 있음) */
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
    /* 그리드 스타일 */
.grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* 4열 고정 설정 */
    gap: 20px; /* 카드들 사이의 간격 */
    margin: 20px auto; /* 상하 여백 및 중앙 정렬 */
    max-width: 1200px; /* 최대 너비 설정 (필요에 따라 조정) */
}
/* 레시피 카드 스타일 */
.recipe-card {
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
.recipe-card-content {
    overflow-y: auto; /* 세로 방향 스크롤 */
    flex-grow: 1; /* 남은 공간을 채우도록 설정 */
}

/* 호버 효과 */
.recipe-card:hover {
    transform: translateY(-5px); /* 호버 시 살짝 위로 */
}

.recipe-card img {
    width: 100%;
    height: 160px; /* 고정된 이미지 높이 조정 */
    object-fit: cover;
    border-radius: 4px; /* 이미지 모서리 살짝 둥글게 */
    margin-bottom: 10px;
}

.recipe-card h3 {
    font-size: 18px;
    margin: 0 0 5px 0; /* 간격 조정 */
    color: #555; /* 글자색 조정 */
}

.recipe-card h3 a { /* 제목 링크 스타일 */
    text-decoration: none;
    color: inherit;
}

.recipe-card p {
    color: #666;
    font-size: 14px;
    margin: 0 0 5px 0; /* 간격 조정 */
    flex-grow: 1; /* 남은 공간 채우기 (조회수 아래로 밀기) */
}

.view-count {
    color: #ff5722; /* 조회수 색상 유지 (강조) */
    font-weight: bold;
    font-size: 14px;
    margin-top: auto; /* 항상 하단에 위치 */
}
    
   #search-area, fieldset { /* fieldset 사용 시 이 규칙이 적용됨 */
    max-width: 800px; /* 검색 영역 최대 너비 (필요시 조정) */
    width: 100%; /* 너비를 100%로 설정 */
    margin: 0 auto 30px; /* 상하 마진 + 좌우 자동 마진 (가운데 정렬) */
    display: flex; /* flexbox 사용 */
    justify-content: center; /* 내부 요소 가운데 정렬 */
    align-items: center; /* 세로 가운데 정렬 */
    padding: 15px 20px; /* 패딩 조정 */
    background-color: #ffffff; /* 흰색 배경 */
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* 부드러운 그림자 */
    border: none; /* 테두리 제거 */
    box-sizing: border-box; /* 패딩 포함 너비 계산 */
}


    /* titleform 스타일 */
    #titleform {
         display: flex;
         align-items: center;
         gap: 10px;
         width: 100%;
         justify-content: center; /* 내부 요소 가운데 정렬 */
    }

    #titleform select,
    #titleform input[type="search"],
    #titleform input[type="submit"] {
        height: 38px; /* 높이 조정 */
        padding: 0 12px; /* 좌우 패딩 조정 */
        font-size: 15px; /* 글자 크기 조정 */
        border: 1px solid #ddd; /* 테두리 추가 (구분감) */
        border-radius: 8px;
        box-sizing: border-box;
    }
     #titleform select {
         border: 1px solid #ddd; /* select 박스 테두리 추가 */
     }


    #titleform input[type="search"] {
        width: 250px; /* 검색 입력 필드 너비 조정 */
    }

    #titleform input[type="submit"] {
        /* 이전 예시 버튼 색상 계열 적용 */
        background-color: #f29abf;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
        padding: 0 15px; /* 패딩 조정 */
    }

    #titleform input[type="submit"]:hover {
        /* 이전 예시 호버 색상 계열 적용 */
        background-color: #e089a8;
    }

    /* 반응형 디자인을 위한 미디어 쿼리 */
    @media (max-width: 768px) {
        .grid {
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); /* 작은 화면에서는 2열로 */
        }
        .content-container {
            padding: 20px;
            margin: 30px auto;
        }
         #search-area, fieldset {
             flex-direction: column; /* 세로 정렬 */
             align-items: stretch; /* 전체 너비 사용 */
             padding: 15px;
         }
         #titleform {
             flex-direction: column; /* 세로 정렬 */
             align-items: stretch; /* 전체 너비 사용 */
         }
         #titleform select,
         #titleform input[type="search"],
         #titleform input[type="submit"] {
             width: 100%; /* 전체 너비 사용 */
             margin: 5px 0; /* 간격 추가 */
         }
         #titleform input[type="submit"] {
             margin-left: 0; /* 마진 제거 */
         }
    }
    
    @media (max-width: 480px) {
        .grid {
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); /* 더 작은 화면에서는 1열에 가깝게 */
        }
         .recipe-card {
             height: auto; /* 높이 자동 조절 */
         }
    }

</style>
</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

    <%-- 기존 검색 폼을 확장하여 정렬 기능 통합 --%>
    <form action="recipeSearch.do" id="titleform" class="sform" method="get">
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
    <a href="moveInsertRecipePage.do">등록</a>
  </c:if>  
    <div class="grid"> <!-- 그리드 레이아웃을 위한 div -->
    <c:forEach items="${ requestScope.list }" var="recipe" varStatus="status">
        <c:if test="${status.index < 12}">
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
                            <img src="${pageContext.request.contextPath}/resources/images/thedishlogo.jpg" alt="기본 이미지" />
                        </c:otherwise>
                    </c:choose>
                </a>
                <div class="recipe-card-content"> <!-- 카드 내용 감싸기 -->
                    <h3>${ recipe.name }</h3>
                    <p>${ recipe.description }</p>
                    <p class="view-count">조회수: ${ recipe.viewCount }</p>
                </div>
            </div>
        </c:if>
    </c:forEach>
</div>
    <br>
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
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