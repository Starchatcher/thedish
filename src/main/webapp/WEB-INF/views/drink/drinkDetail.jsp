<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${drink.name} 상세페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .map-container {
            margin-top: 40px;
            height: 400px; /* 지도 높이 설정 */
            border: 1px solid #ddd; /* 지도 테두리 */
            border-radius: 8px; /* 테두리 둥글게 */
            overflow: hidden; /* 내용이 넘칠 경우 숨김 */
        }
        .stats {
            margin-top: 20px;
            text-align: center;
        }
        .comments-section {
            margin-top: 40px;
        }
        .comments-section h3 {
            margin-bottom: 10px;
        }
        .comments-section ul {
            list-style-type: none;
            padding: 0;
        }
        .comments-section li {
            background-color: #f1f1f1;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
        }
        .label {
            font-weight: bold;
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
    </style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function() {
    $('#recommendBtn').click(function() {
        const $button = $(this); // 현재 클릭된 버튼을 $button으로 선언
        $button.prop('disabled', true); // 버튼 비활성화

        $.ajax({
            url: 'recommendDrink.do',
            type: 'POST',
            data: { drinkId: "${drink.drinkId}" },
            success: function(data) {
                $('#recommendCount').text(data.recommendNumber); // 추천수 업데이트
                alert('추천해 주셔서 감사합니다!');
            },
            error: function() {
                alert('추천 처리 중 오류가 발생했습니다.');
            },
            complete: function() {
                $button.prop('disabled', false); // 요청 완료 후 버튼 활성화
            }
        });
    });
});
  
</script>

</head>

<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:if test="${  loginUser.role eq 'ADMIN' }">
<a href="moveUpdateDrinkPage.do?drinkId=${drink.drinkId}&page=${currentPage != null ? currentPage : 1}">수정</a>

<form action="deleteDrink.do" method="post" style="display:inline;">
    <input type="hidden" name="drinkId" value="${drink.drinkId}" />
    <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
</form>
</c:if>

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

<h2>이 술과 잘 어울리는 레시피</h2>

<%-- 서버에서 전달받은 'pairingList'가 비어있지 않다면 --%>
<c:choose>
    <c:when test="${ not empty pairingList }">
        <table>
            <thead>
                <tr>
                    <th>레시피 이름</th>
                    <th>페어링 이유</th>
                    <%-- 필요하다면 추가 정보 컬럼 추가 (예: 이미지, 설명) --%>
                </tr>
            </thead>
            <tbody>
                <%-- pairingList의 각 항목(페어링 정보 객체)을 'pairing' 변수에 담아 반복 --%>
                <c:forEach var="pairing" items="${ pairingList }">
                    <tr>
                        <%-- 'pairing' 객체의 속성(예: recipeName, reason)을 EL 표현식으로 출력 --%>
                        <td>${ pairing.recipeName }</td>
                        <td>${ pairing.reason }</td>
                        <%-- 필요하다면 추가 정보 셀 추가 --%>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <%-- pairingList가 비어있다면 (페어링 정보가 없다면) --%>
    <c:otherwise>
        <p>아직 등록된 페어링 정보가 없습니다.</p>
    </c:otherwise>
</c:choose>




<div class="stats">
    <span>조회수: ${drink.viewCount}</span>
    <span>추천수: <span id="recommendCount">${drink.recommendNumber}</span></span>
    <button id="recommendBtn" type="button">추천하기 👍</button>
    <span>평균 평점: ${drink.avgRating}</span>           
</div>


    <!-- 지도 정보를 출력할 구역 -->
    <div class="map-container" id="map">
        <!-- 나중에 JavaScript로 지도를 삽입할 수 있는 영역 -->
        <p>지도 정보가 여기에 표시됩니다.</p>
    </div>

<!-- 댓글 리스트 -->
<div class="comments-section">
    <h3>댓글</h3>

    <c:if test="${not empty comments}">
        <ul>
            <c:forEach var="comment" items="${comments}">
                <li>
                   <strong>${comment.nickName}</strong> <span>(${comment.createdAt})</span>
                    <span>(${comment.createdAt})</span>
                    <p>${comment.content}</p>

                    
                    <!-- 삭제 버튼 추가 -->
                    <c:if test="${ loginUser.loginId eq comment.loginId or loginUser.role eq 'ADMIN' }">
                    <form action="deleteDrinkComment.do" method="post" style="display:inline;">
                        <input type="hidden" name="commentId" value="${comment.commentId}" />
                        <input type="hidden" name="drinkId" value="${drink.drinkId}" />
                        <input type="hidden" name="targetType" value="drink" />
                        <input type="hidden" name="page" value="${page}" />
                        <button type="submit" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</button>
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
<c:if test="${loginUser != null}">
    <!-- 댓글 작성 폼 -->
    <form action="insertDrinkComment.do" method="post">
        <input type="hidden" name="drinkId" value="${drink.drinkId}" />

        <%-- 작성자 닉네임 표시 및 수정 불가 설정 --%>
        <input type="text" name="writer" placeholder="작성자 이름" required 
               value="${loginUser.nickName}" readonly="readonly" /><br/>

        <textarea name="content" rows="4" cols="50" placeholder="댓글을 입력하세요" required></textarea><br/>

        <button type="submit">댓글 작성</button>
    </form>
</c:if>
<%-- 로그인하지 않은 사용자에게는 댓글 작성 폼이 보이지 않음 --%>
<c:if test="${loginUser == null}">
    <p>댓글을 작성하려면 <a href="loginPage.do">로그인</a>해주세요.</p> <%-- 예시: 로그인 페이지 링크 --%>
</c:if>


</body>
</html>