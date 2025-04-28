<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
<a href="moveUpdateDrinkPage.do?drinkId=${drink.drinkId}&page=${currentPage != null ? currentPage : 1}">수정</a>

<form action="deleteDrink.do" method="post" style="display:inline;">
    <input type="hidden" name="drinkId" value="${drink.drinkId}" />
    <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
</form>

<div class="container">
    <h2>${drink.name}</h2>

    <span class="label">페어링 음식:</span>
    <p class="info">${drink.pairingFood}</p>

    <span class="label">설명:</span>
    <p class="info">${drink.description}</p>

    <span class="label">도수:</span>
    <p class="info">${drink.alcoholContent}%</p>

    <span class="label">가격:</span>
    <p class="info">${drink.price}원</p>

    <c:choose>
        <c:when test="${not empty drink.imageUrl}">
            <img src="${drink.imageUrl}" alt="${drink.drinkId} 이미지" width="300" />
        </c:when>
        <c:when test="${not empty drink.imageId and drink.imageId != 0}">
            <img src="${pageContext.request.contextPath}/image/view.do?imageId=${drink.imageId}" alt="${drink.drinkId} 이미지" width="300" />
        </c:when>
        <c:otherwise>
            <p>이미지가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>


<div class="stats">
    <span>조회수: ${drink.viewCount}</span>
    <span>추천수: <span id="recommendCount">${drink.recommendNumber}</span></span>
    <button id="recommendBtn" type="button">추천하기 👍</button>
    <span>평균 평점: ${drink.avgRating}</span>           
</div>

<!-- 댓글 리스트 -->
<div class="comments-section">
    <h3>댓글</h3>

    <c:if test="${not empty comments}">
        <ul>
            <c:forEach var="comment" items="${comments}">
                <li>
                    <strong>${comment.loginId}</strong>
                    <span>(${comment.createdAt})</span>
                    <p>${comment.content}</p>

                    <p>댓글 ID: ${comment.commentId}</p>

                    <!-- 삭제 버튼 추가 -->
                    <form action="deleteDrinkComment.do" method="post" style="display:inline;">
                        <input type="hidden" name="commentId" value="${comment.commentId}" />
                        <input type="hidden" name="drinkId" value="${drink.drinkId}" />
                        <input type="hidden" name="targetType" value="drink" />
                        <input type="hidden" name="page" value="${page}" />
                        <button type="submit" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</button>
                    </form>
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
            <a href="drinkDetail.do?no=${drink.drinkId}&page=${page - 1}">이전</a>
        </c:if>

        <c:forEach begin="1" end="${totalPages}" var="i">
            <c:choose>
                <c:when test="${i == page}">
                    <span>${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="drinkDetail.do?no=${drink.drinkId}&page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${page < totalPages}">
            <a href="drinkDetail.do?no=${drink.drinkId}&page=${page + 1}">다음</a>
        </c:if>
    </div>
</div>

<!-- 댓글 작성 폼 -->
<form action="insertDrinkComment.do" method="post">
    <input type="hidden" name="drinkId" value="${drink.drinkId}" />
    <textarea name="content" rows="4" cols="50" placeholder="댓글을 입력하세요" required></textarea><br/>
    <input type="text" name="writer" placeholder="작성자 이름" required /><br/>
    <button type="submit">댓글 작성</button>
</form>

</body>
</body>
</html>