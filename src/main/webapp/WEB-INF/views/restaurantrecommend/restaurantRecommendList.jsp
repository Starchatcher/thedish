<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setTimeZone value="Asia/Seoul" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 추천 게시판</title>
<style type="text/css">
/* 게시판 테이블 */
table#boardTable {
	width: 80%;
	margin: 30px auto;
	border-collapse: collapse;
	text-align: left;
	font-size: 14px;
	background-color: #ffffff;
	border: 1px solid #e0e0e0;
	border-radius: 6px;
	overflow: hidden;
}

table#boardTable th, table#boardTable td {
	padding: 14px;
	border-bottom: 1px solid #e0e0e0;
	color: #333333;
	text-align: center;
}

table#boardTable th {
	background-color: #f5f5f5;
	font-weight: 600;
	color: #222;
}

.board-title a {
	display: inline-block;
	max-width: 100%;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	text-decoration: none;
	color: #333333;
	cursor: pointer;
}

.board-title a:hover {
	text-decoration: underline;
}

tr.clickable-row:hover {
	background-color: #fafafa;
	cursor: pointer;
}

/* 이미지 크기 고정 스타일 */
.item-image img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 5px;
	display: block; /* 이미지를 블록 요소로 만들어 여백 문제 방지 */
	margin: 0 auto; /* td 중앙 정렬 */
}

/* 제목 */
h1#boardTitle {
	font-size: 24px;
	font-weight: 600;
	width: 80%;
	margin: 40px auto 24px;
	text-align: center;
	color: #333333;
	border-bottom: 1px solid #e0e0e0;
	padding-bottom: 8px;
}

/* 검색 영역 */
#search-area {
	width: 80%;
	margin: 0 auto 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

#searchForm select, #searchForm input[type="text"], #searchForm input[type="submit"]
	{
	height: 36px;
	padding: 0 12px;
	font-size: 13px;
	border: 1px solid #dcdcdc;
	border-radius: 6px;
	background-color: #ffffff;
	color: #333333;
	transition: border 0.2s ease;
	outline: none;
}

#searchForm select:focus, #searchForm input[type="text"]:focus {
	border-color: #bbb;
}

#searchForm input[type="text"] {
	width: 220px;
}

#searchForm input[type="submit"] {
	background-color: #888;
	color: white;
	border: none;
	cursor: pointer;
	transition: background-color 0.2s ease;
}

#searchForm input[type="submit"]:hover {
	background-color: #555;
}

/* 글쓰기 버튼 */
#writeBtn {
	padding: 8px 14px;
	background-color: #888;
	color: white;
	border: none;
	font-size: 13px;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.2s ease;
}

#writeBtn:hover {
	background-color: #555;
}
</style>
<script>
        // 행 클릭 시 상세 페이지로 이동하는 함수
        function redirectToDetail(recommendId) {
            // 이동할 URL 생성
            var detailUrl = 'restaurantRecommendDetail.do?no=' + recommendId;
            // 페이지 이동
            window.location.href = detailUrl;
        }
    </script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<h1 id="boardTitle">맛집 추천 목록</h1>

	<div id="search-area">
		<form id="searchForm" action="restaurantRecommendSearch.do"
			method="get">
			<input type="text" name="keyword" placeholder="검색어를 입력하세요"
				value="${keyword}" />
			<%-- 검색어 입력 필드에 기존 검색어 유지 --%>
			<input type="submit" value="검색" />
		</form>
		<c:if test="${not empty loginUser}">
			<button id="writeBtn"
				onclick="location.href='moveRestaurantRecommendInsert.do'">글쓰기</button>
		</c:if>
	</div>

	<table id="boardTable">
		<thead>
			<%-- 테이블 헤더 부분을 thead로 감싸는 것이 좋습니다 (선택 사항) --%>
			<tr>
				<th>이미지</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>좋아요</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<%-- 테이블 본문 부분을 tbody로 감싸는 것이 좋습니다 (선택 사항) --%>
			<c:forEach items="${recommendList}" var="recommend">
				<%-- 각 행에 onclick 이벤트 추가하고, recommendId를 인자로 전달 --%>
				<tr class="clickable-row"
					onclick="redirectToDetail(${recommend.recommendId})">
					<td class="item-image"><c:choose>
							<c:when test="${not empty recommend.imageUrl}">
								<img src="${recommend.imageUrl}" alt="${recommend.name} 이미지"
									style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px;" />
							</c:when>
							<c:when
								test="${not empty recommend.imageId and recommend.imageId != 0}">
								<img
									src="${pageContext.request.contextPath}/image/view.do?imageId=${recommend.imageId}"
									alt="이미지"
									style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px;" />
							</c:when>
							<c:otherwise>
								<img
									src="${pageContext.request.contextPath}/resources/images/thedishlogo.jpg"
									alt="기본 이미지"
									style="width: 100px; height: 100px; object-fit: cover; border-radius: 5px;" />
							</c:otherwise>
						</c:choose></td>
					<td class="board-title">
						<%-- 제목 텍스트만 남기고 링크는 tr에서 처리 --%> <c:out value="${recommend.name}" />
						<%-- 기존 <a> 태그 제거 또는 주석 처리 --%> <%-- <a href="restaurantRecommendDetail.do?no=${recommend.recommendId}">
                             <c:out value="${recommend.name}"/>
                         </a> --%>
					</td>
					<td>${recommend.nickname}</td>
					<!-- 작성자 -->
					<td>${recommend.createdAtKst}</td>
					<!-- 작성일 -->

					<td>${recommend.likeCount}</td>
					<!-- 좋아요 수 -->
					<td>${recommend.viewCount}</td>
					<!-- 조회수 -->
				</tr>
			</c:forEach>
			<c:if test="${empty recommendList}">
				<tr>
					<td colspan="6">맛집 추천 정보가 없습니다.</td>
					<!-- colspan 값은 컬럼 수에 맞게 조정 -->
				</tr>
			</c:if>
		</tbody>
	</table>

	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
