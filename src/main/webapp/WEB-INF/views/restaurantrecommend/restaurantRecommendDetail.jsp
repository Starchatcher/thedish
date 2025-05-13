<%-- restaurantRecommendDetail.jsp 시작 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${recommend.name} 맛집 상세 정보</title>
    <style>
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin: 0;
    padding: 20px;
    background-color: #f8f8f8;
    color: #333;
}

.container {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

h2 {
    color: #0056b3; /* 제목 색상 */
    border-bottom: 2px solid #007bff; /* 제목 아래 밑줄 */
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.label {
    font-weight: bold; /* 라벨 텍스트 굵게 */
    display: inline-block; /* 라벨과 정보가 나란히 오도록 설정 */
    width: 100px; /* 라벨 너비 고정 (필요에 따라 조정) */
    margin-bottom: 5px;
    color: #555;
}

.info {
    margin-left: 10px; /* 라벨과 정보 사이 간격 */
    display: inline-block; /* 라벨과 정보가 나란히 오도록 설정 */
    margin-bottom: 5px;
}

.content {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid #eee; /* 내용 영역 구분선 */
}

.image-container {
    text-align: center; /* 이미지 가운데 정렬 */
    margin-bottom: 20px;
}

.image-container img {
    max-width: 100%; /* 이미지 크기 반응형 설정 */
    height: auto;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 5px;
    background-color: #fff;
}

.map-container {
    width: 900px; /* 지도가 표시될 영역 너비 */
    height: 400px; /* 지도가 표시될 영역 높이 */
    margin: 20px auto;
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden; /* 지도가 영역 밖으로 나가지 않도록 */
}

/* 좋아요, 수정, 삭제 버튼 영역 스타일 */
.post-actions {
    margin: 20px auto;
    padding-top: 15px;
    border-top: 1px solid #eee;
    text-align: center; 
}

.post-actions button,
.comments-container button {
    padding: 8px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1em;
    margin-left: 5px; /* 버튼 간 간격 */
}

.like-btn {
    background-color: #fff;
    color: #e74c3c; /* 하트 색상에 맞춤 */
    border: 1px solid #e74c3c;
}

.like-btn:hover {
    background-color: #f9e0df;
}

.report-btn, /* 수정/삭제 버튼 */
.modify-button /* 댓글 삭제 버튼 */ {
    background-color: #f39c12; /* 주황색 계열 */
    color: white;
}

.report-btn:hover,
.modify-button:hover {
    background-color: #e67e22;
}

/* 댓글 목록 스타일 */
.comments-container {
width: 900px; 
    margin: 30px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
    border-radius: 8px;
}

.comments-section h3 {
    margin-top: 0;
    color: #3498db;
    border-bottom: 1px dashed #bdc3c7;
    padding-bottom: 10px;
    margin-bottom: 15px;
}

.comments-section ul {
    list-style: none; /* 목록 기호 제거 */
    padding: 0;
    margin: 0;
}

.comments-section li {
    border-bottom: 1px solid #eee;
    padding: 15px 0;
    margin-bottom: 10px;
}

.comments-section li:last-child {
    border-bottom: none; /* 마지막 댓글 아래 구분선 제거 */
}

.comments-section li strong {
    color: #2c3e50;
}

.comments-section li span {
    font-size: 0.9em;
    color: #7f8c8d;
    margin-left: 10px;
}

.comments-section li p {
    margin-top: 8px;
    margin-bottom: 0;
}

/* 댓글 작성 폼 스타일 */
.comment-form {
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid #eee;
}

.textarea-button-container {
    display: flex; /* 텍스트area와 버튼을 가로로 배치 */
    align-items: flex-end; /* 버튼을 textarea 아래쪽에 정렬 */
}

.comment-form textarea {
    flex-grow: 1; /* 남은 공간을 모두 차지하도록 설정 */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    resize: vertical; /* 수직으로만 크기 조절 가능 */
    margin-right: 10px; /* 텍스트area와 버튼 사이 간격 */
    font-size: 1em;
    min-height: 50px; /* 최소 높이 설정 */
}

.comment-form button {
    background-color: #3498db; /* 파란색 계열 */
    color: white;
    padding: 10px 20px;
    height: fit-content; /* 내용에 맞게 높이 조절 */
}

.comment-form button:hover {
    background-color: #2980b9;
}

/* 페이지 네비게이션 스타일 */
.pagination {
    margin-top: 25px;
    text-align: center;
}

.pagination a,
.pagination span {
    display: inline-block;
    padding: 8px 12px;
    margin: 0 4px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-decoration: none;
    color: #337ab7;
}

.pagination a:hover {
    background-color: #f5f5f5;
}

.pagination span {
    background-color: #337ab7;
    color: white;
    border-color: #337ab7;
    font-weight: bold;
}

.pagination a:first-child,
.pagination span:first-child {
    margin-left: 0;
}

.pagination a:last-child,
.pagination span:last-child {
    margin-right: 0;
}

/* 댓글 답글 숨김/표시 관련 스타일 (만약 사용하신다면) */
.hidden-reply {
    display: none; /* 이 클래스가 적용된 요소는 숨겨집니다. */
}

.more-reply-btn {
     /* 답글 더보기 버튼 스타일 */
    background: none;
    border: none;
    color: #3498db;
    cursor: pointer;
    font-size: 0.9em;
    margin-top: 5px;
    padding: 0; /* 기본 패딩 제거 */
}

.more-reply-btn:hover {
    text-decoration: underline;
}

/* 로그인 후 좋아요 가능 메시지 스타일 (선택 사항) */
.like-info {
    font-size: 0.9em;
    color: #7f8c8d;
    vertical-align: middle; /* 버튼들과 높이 맞춤 */
}

 .info-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        padding: 5px 0;
        border-bottom: 1px solid #e0e0e0;
    }

    .label {
        font-weight: bold;
        color: #333;
        width: 30%; /* 라벨의 너비를 고정 */
    }

    .info {
        color: #555;
        width: 70%; /* 정보의 너비를 고정 */
        margin: 0; /* 기본 마진 제거 */
    }

</style>
    
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
	



<div class="container" style="max-width: 800px; margin: 20px auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px; background-color: #f9f9f9;">
    <h2 style="text-align: center; margin-bottom: 20px;">${recommend.name}</h2>

    <div class="info-row">
        <span class="label">전화번호:</span>
        <p class="info">${recommend.phone}</p>
    </div>

    <div class="info-row">
        <span class="label">주소:</span>
        <p class="info">${recommend.address}</p>
    </div>

    <div class="info-row">
        <span class="label">영업시간:</span>
        <p class="info">${recommend.openingHours}</p>
    </div>

    <div class="info-row">
        <span class="label">메뉴:</span>
        <p class="info">${recommend.menu}</p>
    </div>
	
	<div class="info-row">
        <span class="label">리뷰:</span>
        <p class="info">${recommend.review}</p>
    </div>
	
    <div class="content" style="text-align: center; margin-top: 20px;">
        <div class="image-container">
            <c:choose>
                <c:when test="${not empty recommend.imageUrl}">
                    <img src="${recommend.imageUrl}" alt="${recommend.recommendId} 이미지" width="300" style="border-radius: 5px;"/>
                </c:when>
                <c:when test="${not empty recommend.imageId and recommend.imageId != 0}">
                    <img src="${pageContext.request.contextPath}/image/view.do?imageId=${recommend.imageId}" alt="이미지" width="300" style="border-radius: 5px;"/>
                </c:when>
                <c:otherwise>
                    <p>이미지가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>    
    </div>
</div>

	<div class="map-container" id="map">
     
    </div>


<div class="post-actions">
		    <button class="like-btn" data-id="${recommend.recommendId}">
			    <span class="like-icon">${liked ? '❤️ 좋아요' : '🤍 좋아요'}</span>			</button>
			
		
			 <c:if test="${not empty loginUser && (loginUser.loginId eq recommend.loginId || loginUser.role eq 'ADMIN')}">
    <form action="moveRestaurantRecommendUpdate.do" method="get" style="display:inline;">
        <input type="hidden" name="recommendId" value="${recommend.recommendId}" />
        <input type="hidden" name="page" value="${currentPage}" />
        <button type="submit" class="report-btn">수정</button>
    </form>

    <form action="restaurantRecommendDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
        <input type="hidden" name="recommendId" value="${recommend.recommendId}" />	
        <input type="hidden" name="page" value="${currentPage}" />
        <button type="submit" class="report-btn">🗑️ 삭제</button>
    </form>
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
                            <form action="deleteRestaurantComment.do" method="post" style="display: inline;">
                                <input type="hidden" name="commentId" value="${comment.commentId}" />
                                <input type="hidden" name="recommendId" value="${recommend.recommendId}" />
                                <input type="hidden" name="targetType" value="restaurant" />
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
    <%-- 'page' 대신 'commentPage', 'totalPages' 대신 'commentTotalPages' 사용 --%>
    <c:if test="${commentPage > 1}">
        <a href="restaurantRecommendDetail.do?no=${recommend.recommendId}&page=${commentPage - 1}">이전</a>
    </c:if>

    <c:forEach begin="1" end="${commentTotalPages}" var="i">
        <c:choose>
            <c:when test="${i == commentPage}">
                <span>${i}</span>
            </c:when>
            <c:otherwise>
                <a href="restaurantRecommendDetail.do?no=${recommend.recommendId}&page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${commentPage < commentTotalPages}">
        <a href="restaurantRecommendDetail.do?no=${recommend.recommendId}&page=${commentPage + 1}">다음</a>
    </c:if>
</div>

    </div>

    <!-- 댓글 작성 폼 -->
    <form action="insertRestaurantComment.do" method="post" class="comment-form">
        <input type="hidden" name="recommendId" value="${recommend.recommendId}" />
        <input type="hidden" name="targetType" value="restaurant" /> 
         <input type="hidden" name="page" value="${commentPage != null && commentPage > 0 ? commentPage : 1}" />
       <input type="hidden" name="redirectUrl" value="restaurantRecommendDetail.do?no=${recommend.recommendId}&page=${commentPage != null && commentPage > 0 ? commentPage : 1}" />
        <div class="textarea-button-container">
            <textarea name="content" rows="2" 
                placeholder="<c:if test='${loginUser == null}'>로그인 후 댓글을 작성하세요</c:if><c:if test='${loginUser != null}'>댓글을 입력하세요</c:if>" 
                required></textarea>
            <button type="submit" >등록</button>
        </div>
    </form>  
</div>
    
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services&autoload=false"></script>

<script type="text/javascript">
    console.log("--- 지도 스크립트 블록 시작 (Geocoding 활성화 시도) ---");
    // JSP의 recommend 객체에서 직접 address와 name 가져오기 시도
    var storeAddress = "${recommend.address}"; 
    var storeName = "${recommend.name}";     
    console.log("JSP에서 EL 처리를 통해 가져온 주소:", storeAddress);
    console.log("JSP에서 EL 처리를 통해 가져온 매장 이름:", storeName);

    // Kakao Maps SDK 로드가 완료되면 실행될 콜백 함수
    kakao.maps.load(function() {
        console.log("Kakao Maps SDK 로드 완료.");

        // Geocoder 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
        console.log("Geocoder 객체 생성.");

        // 주소로 좌표를 검색합니다
        // storeAddress가 비어있지 않은 경우에만 Geocoding 실행
        if (storeAddress && storeAddress.trim() !== "") {
             geocoder.addressSearch(storeAddress, function(result, status) {
                console.log("주소 검색 결과:", result, "상태:", status);

                // 정상적으로 검색이 완료됐으면
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // 좌표 생성
                    console.log("검색된 좌표 (LatLng):", coords);

                    var mapContainer = document.getElementById('map'); // 지도를 표시할 div
                    var mapOption = {
                        center: coords, // 검색된 좌표로 지도 중심 설정
                        level: 3 // 지도의 확대 레벨
                    };

                    // 지도를 생성합니다
                    var map = new kakao.maps.Map(mapContainer, mapOption);
                    console.log("지도 생성 완료.");

                    // 결과값으로 받은 위치를 마커로 표시합니다
                    var marker = new kakao.maps.Marker({
                        map: map, // 마커를 표시할 지도
                        position: coords // 마커를 표시할 위치
                    });
                    console.log("마커 생성 완료.");

                    // 마커에 인포윈도우를 표시합니다 (선택 사항)
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:6px 0;">' + storeName + '</div>' // 표시할 내용
                    });
                    infowindow.open(map, marker);
                    console.log("인포윈도우 생성 및 표시 완료.");

                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                    map.setCenter(coords);
                    console.log("지도를 마커 위치로 이동 완료.");

                } else {
                    console.error('주소 검색 결과가 없습니다 또는 Geocoding 실패:', status);
                     var mapContainer = document.getElementById('map'); // 지도를 표시할 div
                    mapContainer.innerHTML = '<p>지도를 불러오는데 실패했습니다. 주소를 확인해주세요.</p>';
                    mapContainer.style.textAlign = 'center';
                    mapContainer.style.padding = '20px';
                }
            });
        } else {
             console.error('가져온 주소 값이 비어있어 Geocoding을 수행할 수 없습니다.');
             var mapContainer = document.getElementById('map'); // 지도를 표시할 div
             mapContainer.innerHTML = '<p>지도 정보를 불러오는데 필요한 주소 정보가 없습니다.</p>';
             mapContainer.style.textAlign = 'center';
             mapContainer.style.padding = '20px';
        }
    });

    console.log("--- 지도 스크립트 블록 종료 ---");
    
    
    
</script>
<script>

$(document).ready(function() {

    // '.like-btn' 클래스를 가진 버튼에 클릭 이벤트 리스너를 추가합니다.
    $('.like-btn').on('click', function(e) {
        e.preventDefault(); // 버튼의 기본 동작(예: 폼 제출)을 방지합니다.

        const buttonElement = this; // 클릭된 버튼 요소를 참조합니다.
        // 버튼의 'data-id' 속성에서 맛집 추천 게시글 ID를 가져옵니다.
        const recommendId = $(buttonElement).data('id'); // recommendId 변수 선언

        // JSP EL을 사용하여 모델에 담긴 로그인 사용자 ID를 가져옵니다.
        // 컨트롤러에서 mv.addObject("loginUser", loginUser); 로 넘겨줬다고 가정합니다.
        // loginUser 객체에 loginId 필드가 있다고 가정합니다.
        const loginId = "${loginUser.loginId}"; // loginId 변수 선언

        // **로그인 여부 확인:**
        if (!loginId || loginId === "" || loginId === "null") {
            alert('로그인 후 좋아요를 누를 수 있습니다.');
            return;
        }

        // **★ 서버로 보낼 데이터 객체 올바르게 구성 ★**
        const requestData = {
            // 선언된 recommendId 변수 사용
            "recommendId": recommendId,
            // 선언된 loginId 변수 사용
            "loginId": loginId,
            // 필요하다면 targetType 등 추가
            "targetType": "restaurant" // 서버에서 targetType을 사용한다면 추가
        };

        // **AJAX 요청 시작:**
        $.ajax({
            url: 'toggleRestaurantLike.do', // 서버 측 URL
            method: 'post',
            contentType: 'application/json',
            // **★ 올바르게 구성된 requestData 객체를 JSON 문자열로 변환하여 전송 ★**
            data: JSON.stringify(requestData),
            dataType: 'json', // 서버 응답을 JSON으로 기대

            success: function(response) {
                console.log("좋아요 처리 성공:", response);

                const $btn = $(buttonElement);
                const count = response.likeCount;

                const iconText = (response.status === 'liked')
                    ? '❤️ 좋아요'
                    : '🤍 좋아요';

                $btn.find('.like-icon').text(iconText);

                // 총 좋아요 개수 업데이트 (ID가 'like-num'인 요소)
                $('#like-num').text(count);

            },
            error: function(xhr, status, error) {
                console.error("좋아요 처리 중 오류 발생:", status, error, xhr);
                // 서버에서 반환한 오류 메시지가 있다면 표시
                if (xhr.responseJSON && xhr.responseJSON.message) {
                     alert('오류: ' + xhr.responseJSON.message);
                 } else {
                     alert('좋아요 처리 중 오류가 발생했습니다.');
                 }
            }
        });
        // **AJAX 요청 종료**
    });
    // **버튼 클릭 이벤트 리스너 종료**

    // 여기에 댓글 답글 접기/펼치기 등 다른 JavaScript 코드 작성

}); // $(document).ready() 종료
</script>

<c:import url="/WEB-INF/views/common/footer.jsp" />	
</body>
</html>
