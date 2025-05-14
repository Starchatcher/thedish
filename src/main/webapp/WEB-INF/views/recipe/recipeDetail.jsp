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
	max-width: 850px;
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
	width: 850px; /* 댓글 섹션 전체 너비 */
	margin: 10px auto; /* 가운데 정렬 */
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

/* 일반 form 스타일 (다른 곳에서 사용되는 부분) */
form {
	margin-top: 20px;
    /* 다른 form에 영향을 줄 수 있는 width, margin:auto 등은 여기에 추가하지 않음 */
}

/* 댓글 작성 폼에만 적용되는 스타일 (.comment-form 클래스를 사용) */
.comments-container {
    width: 900px; /* 컨테이너의 너비를 850px로 설정 */
    margin: 20px auto; /* 위쪽 여백은 20px, 좌우 여백은 자동으로 설정하여 가운데 정렬 */
    background-color: #fff; /* 배경색 */
    border-radius: 8px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    padding: 20px; /* 내부 여백 */
}

.comments-section {
    margin-bottom: 20px; /* 댓글 출력 섹션과 등록 폼 간의 간격 */
    padding: 20px; /* 내부 여백 추가 */
    border: 1px solid #ddd; /* 테두리 추가 */
    border-radius: 8px; /* 모서리 둥글게 */
}

.textarea-button-container {
    display: flex; /* Flexbox를 사용하여 가로로 정렬 */
    align-items: flex-start; /* 세로 정렬을 상단으로 설정 */
    margin-top: 10px; /* 상단 여백 추가 */
}

.textarea-button-container textarea {
    width: 100%; /* 부모(.textarea-button-container)의 너비에 맞게 100%로 설정 */
    box-sizing: border-box; /* 패딩과 보더가 width에 포함되도록 설정 */
   
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    resize: vertical; /* 세로 크기 조정 가능 */
    margin-right: 10px; /* 버튼과의 간격을 위해 오른쪽 여백 추가 */
}

.textarea-button-container button {
    padding: 10px 15px; /* 버튼 내부 여백 */
  	
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 모서리 둥글게 */
    background-color: #007bff; /* 배경색 */
    color: white; /* 글자색 */
    cursor: pointer; /* 커서 모양 */
    transition: background-color 0.3s; /* 배경색 변경 시 부드러운 전환 */
}

.textarea-button-container button:hover {
    background-color: #0056b3; /* 마우스 오버 시 배경색 변경 */
}







/* 추천 버튼 스타일 */
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

/* 다른 form 스타일 (inline으로 설정되어 있을 수 있는 부분) */
/* 이 부분은 댓글 작성 폼이 아닌 다른 곳의 form에 적용될 가능성이 높습니다. */
/* .comment-form 스타일이 더 구체적이므로 댓글 작성 폼에는 이 스타일이 적용되지 않습니다. */
form {
	display: inline; /* 인라인으로 설정하여 버튼과 나란히 배치 */
	margin: 0; /* 기본 마진 제거 */
	padding: 0; /* 기본 패딩 제거 */
	height: auto; /* 높이 자동 조정 */
    /* 중복되는 button 스타일은 제거했습니다. */
}


/* 버튼 스타일 공통 (.modify-button, .delete-button 등) */
/* 이 부분은 댓글 작성 폼 버튼이 아닌 다른 버튼에 적용될 가능성이 높습니다. */
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
	background-color: #333; /* 마우스 오버 시 배경색 더 어둡게 */
}

/* 버튼 클릭 시 스타일 */
.modify-button:active, .delete-button:active {
	background-color: #444; /* 클릭 중일 때 배경색 */
    
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
  .content {
        display: flex;
        align-items: flex-start; /* 이미지와 알러지 정보를 상단 정렬 */
    }
    .image-container {
        margin-right: 20px; /* 이미지와 알러지 정보 사이의 간격 */
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

    <div class="content">
        <div class="image-container">
            <c:choose>
                <c:when test="${not empty recipe.imageUrl}">
                    <img src="${recipe.imageUrl}" alt="${recipe.recipeId} 이미지" width="300" />
                </c:when>
                <c:when test="${not empty recipe.imageId and recipe.imageId != 0}">
                    <img src="${pageContext.request.contextPath}/image/view.do?imageId=${recipe.imageId}" alt="${recipe.recipeId} 이미지" width="300" />
                </c:when>
                <c:otherwise>
                    <p>이미지가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="allergy-info">
            <c:if test="${not empty allergyList}">
                <h3>알러지 정보</h3>
                <ul>
                    <c:forEach var="allergy" items="${allergyList}">
                        <li><strong>${allergy.name}</strong>: ${allergy.description}</li>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${empty allergyList}">
                <p>알러지 정보가 없습니다.</p>
            </c:if>
        </div>
    </div>
</div>

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

					<button type="submit"  class="modify-button">평점 제출</button>
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
<div class="comments-container"> <!-- 댓글 출력 및 작성 컨테이너 -->
    <div class="comments-section">
        <h3>댓글</h3>

        <c:if test="${not empty comments}">
            <ul>
                <c:forEach var="comment" items="${comments}">
                    <li>
                        <strong>${comment.nickName}</strong> <span>(${comment.createdAt})</span>
                        <p>${comment.content}</p>
                        <c:if test="${loginUser.loginId eq comment.loginId or loginUser.role eq 'ADMIN'}">
                            <form action="deleteComment.do" method="post" style="display: inline;">
                                <input type="hidden" name="commentId" value="${comment.commentId}" />
                                <input type="hidden" name="recipeId" value="${recipe.recipeId}" />
                                <input type="hidden" name="targetType" value="recipe" />
                                <input type="hidden" name="page" value="${page}" />
                                <button type="submit" onclick="return confirm('댓글을 삭제하시겠습니까?');" class="modify-button">삭제</button>
                            </form>
                        </c:if>
                    </li>
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
    <form action="insertComment.do" method="post" class="comment-form">
        <input type="hidden" name="recipeId" value="${recipe.recipeId}" />
        <div class="textarea-button-container">
            <textarea name="content" rows="2" 
                placeholder="<c:if test='${loginUser == null}'>로그인 후 댓글을 작성하세요</c:if><c:if test='${loginUser != null}'>댓글을 입력하세요</c:if>" 
                required></textarea>
            <button type="submit" >등록</button>
        </div>
    </form>  
</div>










	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
