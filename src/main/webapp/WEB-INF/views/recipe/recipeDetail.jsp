<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${recipe.name} 상세페이지</title>
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
        margin-bottom: 20px;
        font-size: 14px;
        color: #888;
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
    background-color: #ff7043;
    border: none;
    border-radius: 5px;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s;
}

#recommendBtn:hover {
    background-color: #e64a19;
}
    
    
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('#recommendBtn').click(function() {
        $.ajax({
            url: 'recipe/recommend.do',
            type: 'POST',
            data: { recipeId: ${recipe.recipeId} },
            success: function(data) {
                $('#recommendCount').text(data.recommendNumber);
                alert('추천해 주셔서 감사합니다!');
            },
            error: function() {
                alert('추천 처리 중 오류가 발생했습니다.');
            }
        });
    });
</script>


</head>
<body>
<a href="moveUpdateRecipePage.do?recipeId=${recipe.recipeId}&page=${currentPage != null ? currentPage : 1}">수정</a>

<form action="deleteRecipe.do" method="post" style="display:inline;">
    <input type="hidden" name="recipeId" value="${recipe.recipeId}" />
    <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
</form>



   <div class="container">
        <h2>${recipe.name}</h2>
        
        <span class="label">재료:</span>
        <p class="info">${recipe.ingredientName}</p>
        
        <span class="label">설명:</span>
        <p class="info">${recipe.description}</p>
        
        <span class="label">조리법:</span>
        <p class="info">${recipe.instructions}</p>
        
             
            
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
    <c:if test="${not empty allergyList}">
    <div class="allergy-info">
        <h3>알러지 정보</h3>
        <ul>
            <c:forEach var="allergy" items="${allergyList}">
                <li><strong>${allergy.allergy_name}</strong>: ${allergy.description}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>
    


<div class="stats">
    <span>조회수: ${recipe.viewCount}</span>
    <span>추천수: <span id="recommendCount">${recipe.recommendNumber}</span></span>
    <button id="recommendBtn" type="button">추천하기 👍</button>
    <span>평균 평점: ${recipe.avgRating}</span>           
</div>

<!-- 댓글 리스트 -->
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
                    <form action="deleteComment.do" method="post" style="display:inline;">
                        <input type="hidden" name="commentId" value="${comment.commentId}" />
                        <input type="hidden" name="recipeId" value="${recipe.recipeId}" />
                        <input type="hidden" name="targetType" value="recipe" />
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
    <form action="insertComment.do" method="post">
        <input type="hidden" name="recipeId" value="${recipe.recipeId}" />
        <textarea name="content" rows="4" cols="50" placeholder="댓글을 입력하세요" required></textarea><br/>
        <input type="text" name="writer" placeholder="작성자 이름" required /><br/>
        <button type="submit">댓글 작성</button>
    </form>
  
</div>

</body>
</html>
