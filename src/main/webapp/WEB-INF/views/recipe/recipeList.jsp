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

    /* 검색 폼 스타일 */
.search-form {
    text-align: center;
    margin-bottom: 20px;
}

.search-form input[type="search"] {
    padding: 10px;
    width: 300px;
    border: 1px solid #ccc; /* 경계선 색상 변경 */
    border-radius: 4px;
    box-sizing: border-box; /* 패딩과 보더 포함 */
    font-size: 1rem;
    color: #333;
}

.search-form input[type="search"]:focus {
    border-color: #888; /* 포커스 시 경계선 색상 변경 */
    outline: none;
    box-shadow: 0 0 5px rgba(136, 136, 136, 0.3);
}


.search-form input[type="submit"] {
    padding: 10px 15px;
    /* 흑백 모던 스타일 버튼 색상: 중간 회색 계열 */
    background-color: #555; /* 중간 회색 */
    color: white; /* 글자색 흰색 유지 */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-left: 10px;
    transition: background-color 0.3s ease;
    font-size: 1rem;
}

.search-form input[type="submit"]:hover {
    /* 호버 시 배경색 더 어둡게 */
    background-color: #333;
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
        height: 360px; /* 고정된 높이 조정 (내용 길이에 따라 조절 필요) */
        display: flex; /* 카드 내용을 위한 flexbox */
        flex-direction: column; /* 세로 방향 정렬 */
        justify-content: space-between; /* 내용 간격 벌리기 */
        cursor: pointer; /* 클릭 가능한 느낌 */
        transition: transform 0.2s ease; /* 호버 애니메이션 */
        overflow-y: auto;
    }
    
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

/* 등록 버튼 스타일 */
.register-button {
    display: inline-block; /* 링크를 인라인 블록 요소로 만들어 패딩과 너비/높이 적용 가능하게 함 */
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

/* 등록 버튼 호버 스타일 */
.register-button:hover {
    background-color: #333; /* 마우스 오버 시 배경색 더 어둡게 */
    color: white; /* 호버 시 글자색 유지 (필요에 따라 변경 가능) */
}

/* 등록 버튼 클릭 시 스타일 */
.register-button:active {
    background-color: #222; /* 클릭 중일 때 배경색 더 어둡게 */
}
.search-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
  padding: 0 10px;
  margin-bottom: 20px;
  flex-wrap: wrap;
}

</style>
</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />
<!-- ✅ 검색 + 정렬 + 등록 버튼 한 줄에 정렬 (기존 스타일 유지) -->
<div class="search-toolbar">
  <form action="recipeSearch.do" id="titleform" class="sform" method="get">
    <input type="hidden" name="action" value="title">
    <input type="hidden" name="sortType" id="sortType" value="${param.sortType}">
    <input type="hidden" name="sortDirection" id="sortDirection" value="${param.sortDirection == null ? 'DESC' : param.sortDirection}">

    <fieldset>
      <input type="search" name="keyword" size="50" value="${param.keyword}">
      <input type="submit" value="검색">

      <div class="sort-options">
        <input type="button" onclick="sortRecipes(event, 'latest');" class="${param.sortType == 'latest' || param.sortType == null ? 'active' : ''}" value="최신순">
        <input type="button" onclick="sortRecipes(event, 'viewCount');" class="${param.sortType == 'viewCount' ? 'active' : ''}" value="조회수 순">
        <input type="button" onclick="sortRecipes(event, 'rating');" class="${param.sortType == 'rating' ? 'active' : ''}" value="평점 순">
      </div>

      <!-- ✅ 등록 버튼을 오른쪽으로 밀기 위해 margin-left: auto 적용 -->
      <c:if test="${loginUser.role eq 'ADMIN'}">
        <a href="moveInsertRecipePage.do" class="register-button" style="margin-left: auto;">등록</a>
      </c:if>
    </fieldset>
  </form>
</div>

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
                <h3>${ recipe.name }</h3>
                <p>${ recipe.description }</p>
                <p class="view-count">조회수: ${ recipe.viewCount }</p>
            </div>
            </c:if>
        </c:forEach>
        
    </div>
    <br>
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
    <c:import url="/WEB-INF/views/common/footer.jsp" />
    
    <%-- 정렬 기준 변경 및 폼 제출을 위한 JavaScript 함수 --%>
 <script type="text/javascript">
    // 현재 정렬 기준과 방향을 저장할 변수 선언
    // 페이지 로드 시 초기값 설정이 필요합니다.
    // 예를 들어, JSP에서 서버로부터 받은 초기 정렬 정보를 사용합니다.
    // 초기 sortType은 URL 파라미터나 모델에서 받아와서 설정하고,
    // 초기 sortDirection도 함께 받아오거나 기본값 'DESC'로 설정합니다.
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

            if (sortTypeInput && sortDirectionInput) { // *** 수정: sortDirectionInput도 찾았는지 확인 ***
                console.log("찾은 sortType input 요소:", sortTypeInput); // 디버깅 로그 추가
                console.log("찾은 sortDirection input 요소:", sortDirectionInput); // 디버깅 로그 추가

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

                // 페이지 번호는 1페이지로 리셋하는 것이 일반적입니다.
                // 페이징 관련 input 필드도 있다면 함께 수정해야 합니다.
                const pageInput = form.querySelector('#page'); // 페이지 번호 input ID가 'page'라고 가정
                if (pageInput) {
                    pageInput.value = 1;
                    console.log("페이지 번호 1로 리셋.");
                }


                // 폼 제출
                console.log("폼 제출 시도..."); // 디버깅 로그 추가
                form.submit();
            } else {
                console.error("오류: id가 'sortType' 또는 'sortDirection'인 숨겨진 입력 필드를 폼 내에서 찾을 수 없습니다.");
            }
        } else {
            console.error("오류: 클릭된 버튼의 상위 form 요소를 찾을 수 없습니다.");
        }
    }
</script>
    
</body>
</html>