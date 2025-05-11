<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${recipe.name}상세페이지</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 20px;
}

.container {
	max-width: 800px;
	margin: auto;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	line-height: 1.6;
}

h2 {
	color: #e67e22;
	margin-bottom: 10px;
}

.label {
	font-weight: bold;
	color: #333;
}

.info {
	margin: 5px 0 20px;
	color: #555;
}

.stats {
	margin-top: 20px;
	text-align: center;
}

.comments-section {
	margin-top: 20px;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.comments-section h3 {
	margin-bottom: 15px;
	font-size: 24px;
	color: #333;
}

.comments-section ul {
	list-style-type: none;
	padding: 0;
}

.comments-section li {
	margin-bottom: 15px;
	padding: 10px;
	border: 1px solid #eaeaea;
	border-radius: 5px;
	background-color: #fafafa;
}

.comments-section li strong {
	display: block;
	font-size: 16px;
	color: #007bff;
}

.comments-section li span {
	font-size: 12px;
	color: #888;
}

.comments-section li p {
	margin: 5px 0 0;
	color: #555;
}

.pagination {
	margin-top: 20px;
	text-align: center;
}

.pagination a {
	margin: 0 5px;
	text-decoration: none;
	padding: 8px 12px;
	border: 1px solid #007bff;
	border-radius: 5px;
	color: #007bff;
	transition: background-color 0.3s;
}

.pagination a:hover {
	background-color: #007bff;
	color: white;
}

.pagination span {
	margin: 0 5px;
	padding: 8px 12px;
	border-radius: 5px;
	background-color: #e9ecef;
}

form {
	margin-top: 20px;
}

form textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	resize: vertical;
}

form input[type="text"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-top: 10px;
}

form button {
	margin-top: 10px;
	padding: 10px 15px;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s;
}

form button:hover {
	background-color: #0056b3;
}

#recommendBtn {
	margin-left: 10px;
	padding: 5px 12px;
	background-color: #8FBC8F;
	border: none;
	border-radius: 5px;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s;
}

#recommendBtn:hover {
	background-color: green;
}

.map-container {
	margin-top: 40px;
	height: 400px; /* 지도 높이 설정 */
	border: 1px solid #ddd; /* 지도 테두리 */
	border-radius: 8px; /* 테두리 둥글게 */
	overflow: hidden; /* 내용이 넘칠 경우 숨김 */
}

form {
	display: inline; /* 인라인으로 설정하여 버튼과 나란히 배치 */
	margin: 0; /* 기본 마진 제거 */
	padding: 0; /* 기본 패딩 제거 */
	height: 60px; /* 높이 자동 조정 */
}

/* 버튼 스타일 공통 */
.modify-button, .delete-button {
	display: inline-block; /* 인라인 블록 요소로 설정 */
	padding: 10px 20px; /* 버튼 내부 여백 */
	background-color: #555; /* 배경색: 중간 회색 */
	color: white; /* 글자색: 흰색 */
	border: none; /* 테두리 없음 */
	border-radius: 4px; /* 둥근 모서리 */
	text-decoration: none; /* 링크 밑줄 제거 */
	font-size: 0.9rem; /* 글자 크기 */
	cursor: pointer; /* 마우스 오버 시 커서 모양 */
	transition: background-color 0.3s ease; /* 배경색 변경 시 부드러운 전환 */
	margin-right: 5px; /* 버튼 간 간격 */
	height: 40px; /* 버튼 높이 통일 */
	line-height: 20px; /* 텍스트 세로 정렬을 위한 라인 높이 */
}

/* 수정 버튼 호버 스타일 */
.modify-button:hover {
	background-color: #333; /* 마우스 오버 시 배경색 더 어둡게 */
}

/* 삭제 버튼 호버 스타일 */
.delete-button:hover {
	background-color: #0056b3; /* 마우스 오버 시 배경색 더 어둡게 */
}

/* 버튼 클릭 시 스타일 */
.modify-button:active, .delete-button:active {
	background-color: #444; /* 클릭 중일 때 배경색 더 어둡게 */
}

/* 부모 요소 스타일 */
.button-container {
	display: flex; /* 플렉스 박스 사용 */
	align-items: center; /* 세로 중앙 정렬 */
	justify-content: flex-start; /* 수평 정렬 (왼쪽 정렬) */
}

.starpoint_wrap {
	display: inline-block;
}

.starpoint_box {
	position: relative;
	background:
		url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0
		no-repeat;
	font-size: 0;
}

.starpoint_box .starpoint_bg {
	display: block;
	position: absolute;
	top: 0;
	left: 0;
	height: 18px;
	background:
		url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0
		-20px no-repeat;
	pointer-events: none;
}

.starpoint_box .label_star {
	display: inline-block;
	width: 10px;
	height: 18px;
	box-sizing: border-box;
}

.starpoint_box .star_radio {
	opacity: 0;
	width: 0;
	height: 0;
	position: absolute;
}

.starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg {
	width: 10%;
}

.starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg {
	width: 20%;
}

.starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg {
	width: 30%;
}

.starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg {
	width: 40%;
}

.starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg {
	width: 50%;
}

.starpoint_box .star_radio:nth-of-type(6):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(6):checked ~ .starpoint_bg {
	width: 60%;
}

.starpoint_box .star_radio:nth-of-type(7):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(7):checked ~ .starpoint_bg {
	width: 70%;
}

.starpoint_box .star_radio:nth-of-type(8):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(8):checked ~ .starpoint_bg {
	width: 80%;
}

.starpoint_box .star_radio:nth-of-type(9):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(9):checked ~ .starpoint_bg {
	width: 90%;
}

.starpoint_box .star_radio:nth-of-type(10):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(10):checked ~ .starpoint_bg {
	width: 100%;
}

.blind {
	position: absolute;
	clip: rect(0, 0, 0, 0);
	margin: -1px;
	width: 1px;
	height: 1px;
	overflow: hidden;
}
</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script>
	
</script>


</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:if test="${  loginUser.role eq 'ADMIN' }">
		<div class="button-container">
			<!-- 버튼을 감싸는 부모 요소 -->
			<button
				onclick="location.href='moveUpdateRecipePage.do?recipeId=${recipe.recipeId}&page=${currentPage != null ? currentPage : 1}'"
				class="modify-button">수정</button>

			<form action="deleteRecipe.do" method="post" style="display: inline;">
				<input type="hidden" name="recipeId" value="${recipe.recipeId}" />
				<input type="hidden" name="page"
					value="${currentPage != null ? currentPage : 1}" />
				<button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');"
					class="delete-button">삭제</button>
			</form>
		</div>
	</c:if>

	<%-- 줄바꿈 처리를 위한 자바 코드 블록 --%>
	<%
    com.thedish.recipe.model.vo.Recipe recipeObj = 
        (com.thedish.recipe.model.vo.Recipe) request.getAttribute("recipe");

    // 문자열 "\n"을 <br>로 치환
    String formattedIngredient = recipeObj.getIngredientName().replace("\\n", "<br>");
    String formattedDescription = recipeObj.getDescription().replace("\\n", "<br>");
    String formattedInstructions = recipeObj.getInstructions().replace("\\n", "<br>");
%>

	<div class="container">
		<h2>${recipe.name}</h2>

		<span class="label">재료:</span>
		<p class="info"><%= formattedIngredient %></p>

		<span class="label">설명:</span>
		<p class="info"><%= formattedDescription %></p>

		<span class="label">조리법:</span>
		<p class="info"><%= formattedInstructions %></p>

		<c:choose>
			<c:when test="${not empty recipe.imageUrl}">
				<img src="${recipe.imageUrl}" alt="${recipe.recipeId} 이미지"
					width="300" />
			</c:when>
			<c:when test="${not empty recipe.imageId and recipe.imageId != 0}">
				<img
					src="${pageContext.request.contextPath}/image/view.do?imageId=${recipe.imageId}"
					alt="${recipe.recipeId} 이미지" width="300" />
			</c:when>
			<c:otherwise>
				<p>이미지가 없습니다.</p>
			</c:otherwise>
		</c:choose>
	</div>


	<c:if test="${not empty allergyList}">
		<div class="allergy-info">
			<h3>알러지 정보</h3>
			<ul>
				<c:forEach var="allergy" items="${allergyList}">
					<li><strong>${allergy.name}</strong>: ${allergy.description}</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	<c:if test="${empty allergyList}">
		<p>알러지 정보가 없습니다.</p>
	</c:if>



	<div class="stats">
		<span>조회수: ${recipe.viewCount}</span> <span>평균 평점:
			${recipe.avgRating}</span>

		<%-- 로그인한 사용자에게만 평점 입력 폼 표시 --%>
		<c:if test="${loginUser != null}">
			<div class="rating-form-area">
				<h4>내 평점 부여/수정</h4>
				<%-- 평점 부여 폼 --%>
				<form id="ratingForm" action="rateRecipe.do" method="post">
					<input type="hidden" name="recipeId" value="${recipe.recipeId}" />

					<div class="starpoint_wrap">
						<div class="starpoint_box">
							<label for="starpoint_1" class="label_star" title="0.5"><span
								class="blind">0.5점</span></label> <label for="starpoint_2"
								class="label_star" title="1"><span class="blind">1점</span></label>
							<label for="starpoint_3" class="label_star" title="1.5"><span
								class="blind">1.5점</span></label> <label for="starpoint_4"
								class="label_star" title="2"><span class="blind">2점</span></label>
							<label for="starpoint_5" class="label_star" title="2.5"><span
								class="blind">2.5점</span></label> <label for="starpoint_6"
								class="label_star" title="3"><span class="blind">3점</span></label>
							<label for="starpoint_7" class="label_star" title="3.5"><span
								class="blind">3.5점</span></label> <label for="starpoint_8"
								class="label_star" title="4"><span class="blind">4점</span></label>
							<label for="starpoint_9" class="label_star" title="4.5"><span
								class="blind">4.5점</span></label> <label for="starpoint_10"
								class="label_star" title="5"><span class="blind">5점</span></label>
							<input type="radio" name="rating" id="starpoint_1"
								class="star_radio" value="0.5"> <input type="radio"
								name="rating" id="starpoint_2" class="star_radio" value="1.0">
							<input type="radio" name="rating" id="starpoint_3"
								class="star_radio" value="1.5"> <input type="radio"
								name="rating" id="starpoint_4" class="star_radio" value="2.0">
							<input type="radio" name="rating" id="starpoint_5"
								class="star_radio" value="2.5"> <input type="radio"
								name="rating" id="starpoint_6" class="star_radio" value="3.0">
							<input type="radio" name="rating" id="starpoint_7"
								class="star_radio" value="3.5"> <input type="radio"
								name="rating" id="starpoint_8" class="star_radio" value="4.0">
							<input type="radio" name="rating" id="starpoint_9"
								class="star_radio" value="4.5"> <input type="radio"
								name="rating" id="starpoint_10" class="star_radio" value="5.0">
							<span class="starpoint_bg"></span>
						</div>
					</div>

					<button type="submit">평점 제출</button>
				</form>

			</div>
		</c:if>


		<%-- 로그인하지 않은 사용자에게 안내 메시지 표시 --%>
		<c:if test="${loginUser == null}">
			<div class="rating-form-area">
				<p>
					평점을 부여하려면 <a href="loginPage.do">로그인</a>해주세요.
				</p>
				<%-- 예시: 로그인 페이지 URL --%>
			</div>
		</c:if>
	</div>

	<!-- 댓글 리스트 -->
	<div class="comments-section">
		<h3>댓글</h3>

		<c:if test="${not empty comments}">
			<ul>
				<c:forEach var="comment" items="${comments}">
					<p>현재 사용자 ID: ${loginUser.loginId}, 게시글 작성자: ${comment.loginId}</p>
					<li><strong>${comment.nickName}</strong> <span>(${comment.createdAt})</span>
						<p>${comment.content}</p> <!-- 삭제 버튼 추가 --> <c:if
							test="${ loginUser.loginId eq comment.loginId or loginUser.role eq 'ADMIN' }">
							<form action="deleteComment.do" method="post"
								style="display: inline;">
								<input type="hidden" name="commentId"
									value="${comment.commentId}" /> <input type="hidden"
									name="recipeId" value="${recipe.recipeId}" /> <input
									type="hidden" name="targetType" value="recipe" /> <input
									type="hidden" name="page" value="${page}" />
								<button type="submit" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</button>
							</form>
						</c:if></li>
				</c:forEach>
			</ul>
		</c:if>
		<c:if test="${empty comments}">
			<p>댓글이 없습니다.</p>
		</c:if>

		<!-- 페이지 네비게이션 -->
		<div class="pagination">
			<c:if test="${page > 1}">
				<a href="recipeDetail.do?no=${recipe.recipeId}&page=${page - 1}">이전</a>
			</c:if>

			<c:forEach begin="1" end="${totalPages}" var="i">
				<c:choose>
					<c:when test="${i == page}">
						<span>${i}</span>
					</c:when>
					<c:otherwise>
						<a href="recipeDetail.do?no=${recipe.recipeId}&page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${page < totalPages}">
				<a href="recipeDetail.do?no=${recipe.recipeId}&page=${page + 1}">다음</a>
			</c:if>
		</div>
	</div>


	<!-- 댓글 작성 폼 -->
	<%-- 필요한 경우 JSTL 태그 라이브러리 선언 --%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%-- 로그인한 사용자에게만 댓글 작성 폼을 표시 --%>
	<c:if test="${loginUser != null}">
		<!-- 댓글 작성 폼 -->
		<form action="insertComment.do" method="post">
			<input type="hidden" name="recipeId" value="${recipe.recipeId}" />
			<textarea name="content" rows="4" cols="50" placeholder="댓글을 입력하세요"
				required></textarea>
			<br />



			<button type="submit">댓글 작성</button>
		</form>
	</c:if>
	<%-- 로그인하지 않은 사용자에게는 댓글 작성 폼이 보이지 않음 --%>
	<c:if test="${loginUser == null}">
		<p>
			댓글을 작성하려면 <a href="loginPage.do">로그인</a>해주세요.
		</p>
		<%-- 예시: 로그인 페이지 URL. 실제 사용하시는 URL로 변경하세요. --%>
	</c:if>

	</div>
	<c:import url="/WEB-INF/views/common/sidebar.jsp" />
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
