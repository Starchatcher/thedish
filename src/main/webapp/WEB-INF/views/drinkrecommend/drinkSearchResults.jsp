<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색 결과</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            /* 두 번째 페이지의 배경 그라디언트 적용 */
            background: linear-gradient(120deg, #f8d5dc, #d3eaf2);
            /* 전체 페이지 중앙 정렬 스타일은 menubar, footer와 함께 사용하기 어려워 제외 */
            /* height: 100vh; display: flex; align-items: center; justify-content: center; */
        }

        /* 검색 결과 컨테이너 스타일 적용 (로그인 컨테이너 스타일 참고) */
        .results-container {
            background-color: rgba(255, 255, 255, 0.8); /* 투명한 배경 */
            padding: 30px; /* 내부 여백 */
            border-radius: 15px; /* 둥근 모서리 */
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
            max-width: 900px; /* 컨테이너 최대 너비 설정 (테이블 포함 고려) */
            margin: 50px auto; /* 페이지 중앙에 배치 및 상하 마진 추가 */
            text-align: center; /* 컨테이너 내 내용 중앙 정렬 */
        }

        /* 테이블 스타일 유지 및 조정 */
        .results-container table { /* 컨테이너 내부 테이블 */
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px; /* 제목과의 간격 */
        }
        
        .results-container th,
        .results-container td { /* 컨테이너 내부 테이블 셀 */
            border: 1px solid #ddd;
            padding: 10px; /* 패딩 조정 */
            text-align: center;
        }
        
        .results-container th { /* 컨테이너 내부 테이블 헤더 */
            background-color: #f2f2f2;
        }
        
        .results-container img { /* 컨테이너 내부 이미지 */
            width: 80px; /* 이미지 크기 조정 */
            height: auto;
            border-radius: 5px; /* 이미지 모서리 살짝 둥글게 */
        }
        
        /* 이미지 없는 경우 텍스트 스타일 */
        .results-container td span {
             display: block;
             width: 80px;
             margin: 0 auto; /* 중앙 정렬 */
             font-size: 0.9em;
             color: #666;
        }
        
        /* 제목 스타일 조정 */
        .results-container h2 {
            text-align: center; /* 중앙 정렬 */
            color: #333; /* 글자 색상 */
            margin-bottom: 20px;
        }

        /* 링크 스타일 (이미지, 텍스트 링크) */
        .results-container a {
            text-decoration: none; /* 밑줄 제거 */
            color: inherit; /* 부모 요소 색상 상속 */
            display: inline-block; /* 이미지/텍스트 블록으로 만들어 클릭 영역 확대 */
        }
    </style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="results-container">
    <h2>검색 결과</h2>
    <table>
        <thead>
            <tr>
                <th>음료 이름</th>
                <th>가격</th>
                <th>알코올 도수</th>
                <th>이미지</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="drink" items="${drinks}">
                <tr>
                    <td><a href="drinkDetail.do?no=${drink.drinkId}">${drink.name}</a></td>
                    <td><a href="drinkDetail.do?no=${drink.drinkId}">${drink.price}원</a></td>
                    <td><a href="drinkDetail.do?no=${drink.drinkId}">${drink.alcoholContent}%</a></td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty drink.imageUrl}">
                                <a href="drinkDetail.do?no=${drink.drinkId}">
                                    <img src="${drink.imageUrl}" alt="${drink.name}">
                                </a>
                            </c:when>
                            <c:when test="${not empty drink.imageData}">
                               <a href="drinkDetail.do?no=${drink.drinkId}">
                                    <img src="${pageContext.request.contextPath}/image/view.do?imageId=${drink.imageId}" alt="이미지" />
                                </a>
                            </c:when>
                            <c:otherwise>
                            <a href="drinkDetail.do?no=${drink.drinkId}">
                                <span>이미지 없음</span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
