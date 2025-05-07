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
    
    
    
    .starpoint_wrap{display:inline-block;}
.starpoint_box{position:relative;background:url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0 no-repeat;font-size:0;}
.starpoint_box .starpoint_bg{display:block;position:absolute;top:0;left:0;height:18px;background:url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 -20px no-repeat;pointer-events:none;}
.starpoint_box .label_star{display:inline-block;width:10px;height:18px;box-sizing:border-box;}
.starpoint_box .star_radio{opacity:0;width:0;height:0;position:absolute;}
.starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg{width:10%;}
.starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg{width:20%;}
.starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg{width:30%;}
.starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg{width:40%;}
.starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg{width:50%;}
.starpoint_box .star_radio:nth-of-type(6):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(6):checked ~ .starpoint_bg{width:60%;}
.starpoint_box .star_radio:nth-of-type(7):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(7):checked ~ .starpoint_bg{width:70%;}
.starpoint_box .star_radio:nth-of-type(8):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(8):checked ~ .starpoint_bg{width:80%;}
.starpoint_box .star_radio:nth-of-type(9):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(9):checked ~ .starpoint_bg{width:90%;}
.starpoint_box .star_radio:nth-of-type(10):hover ~ .starpoint_bg,
.starpoint_box .star_radio:nth-of-type(10):checked ~ .starpoint_bg{width:100%;}

.blind{position:absolute;clip:rect(0 0 0 0);margin:-1px;width:1px;height: 1px;overflow:hidden;}
    
    </style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script>

  
</script>

</head>

<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:if test="${  loginUser.role eq 'ADMIN' }">
<a href="moveUpdateDrinkPage.do?drinkId=${drink.drinkId}&page=${currentPage != null ? currentPage : 1}">수정</a>
 <a href="moveInsertDrinkStorePage.do?drinkId=${drink.drinkId}&page=${currentPage != null ? currentPage : 1}">판매처 등록</a>
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
    <span>평균 평점: ${drink.avgRating}</span>       
    <%-- 로그인한 사용자에게만 평점 입력 폼 표시 --%>
      <c:if test="${loginUser != null}">
        <div class="rating-form-area">
            <h4>내 평점 부여/수정</h4>
            <%-- 평점 부여 폼 --%>
            <form id="ratingForm" action="rateDrink.do" method="post">
                <input type="hidden" name="drinkId" value="${drink.drinkId}" />
              
               <div class="starpoint_wrap">
  <div class="starpoint_box">
    <label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5점</span></label>
    <label for="starpoint_2" class="label_star" title="1"><span class="blind">1점</span></label>
    <label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5점</span></label>
    <label for="starpoint_4" class="label_star" title="2"><span class="blind">2점</span></label>
    <label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5점</span></label>
    <label for="starpoint_6" class="label_star" title="3"><span class="blind">3점</span></label>
    <label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5점</span></label>
    <label for="starpoint_8" class="label_star" title="4"><span class="blind">4점</span></label>
    <label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5점</span></label>
    <label for="starpoint_10" class="label_star" title="5"><span class="blind">5점</span></label>
    <input type="radio" name="rating" id="starpoint_1" class="star_radio" value="0.5">
    <input type="radio" name="rating" id="starpoint_2" class="star_radio" value="1.0">
    <input type="radio" name="rating" id="starpoint_3" class="star_radio" value="1.5">
    <input type="radio" name="rating" id="starpoint_4" class="star_radio" value="2.0">
    <input type="radio" name="rating" id="starpoint_5" class="star_radio" value="2.5">
    <input type="radio" name="rating" id="starpoint_6" class="star_radio" value="3.0">
    <input type="radio" name="rating" id="starpoint_7" class="star_radio" value="3.5">
    <input type="radio" name="rating" id="starpoint_8" class="star_radio" value="4.0">
    <input type="radio" name="rating" id="starpoint_9" class="star_radio" value="4.5">
    <input type="radio" name="rating" id="starpoint_10" class="star_radio" value="5.0">
    <span class="starpoint_bg"></span>
  </div>
</div>

                <button type="submit">평점 제출</button>
            </form>
           
        </div>
    </c:if>

      
</div>
  <%-- 로그인하지 않은 사용자에게 안내 메시지 표시 --%>
    <c:if test="${loginUser == null}">
         <div class="rating-form-area">
             <p>평점을 부여하려면 <a href="loginPage.do">로그인</a>해주세요.</p> <%-- 예시: 로그인 페이지 URL --%>
         </div>
    </c:if>
	</div>

    <!-- 지도 정보를 출력할 구역 -->
    <div class="map-container" id="map">
     
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
        

        <textarea name="content" rows="4" cols="50" placeholder="댓글을 입력하세요" required></textarea><br/>

        <button type="submit">댓글 작성</button>
    </form>
</c:if>
<%-- 로그인하지 않은 사용자에게는 댓글 작성 폼이 보이지 않음 --%>
<c:if test="${loginUser == null}">
    <p>댓글을 작성하려면 <a href="loginPage.do">로그인</a>해주세요.</p> <%-- 예시: 로그인 페이지 링크 --%>
</c:if>
<c:import url="/WEB-INF/views/common/footer.jsp" />

<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7724415b4929d53594c486d4493f37fb&libraries=services&callback=initMap"></script>
<script type="text/javascript">
// 서버에서 전달받은 주소 및 장소 이름 변수 (예: Spring MVC 모델에 담겨 JSP로 전달)
// 서버 코드 수정 후 ${storeInfo['STORE_ADDRESS']} 형태로 접근 가능하다고 가정
var storeAddress = "${storeInfo['STORE_ADDRESS']}";
var storeName = "${storeInfo['STORE_NAME']}"; // <-- 새롭게 추가된 변수

console.log("JSP에서 EL 처리 후 storeAddress 값:", storeAddress);
console.log("JSP에서 EL 처리 후 storeName 값:", storeName);


// 주소 값이 유효한지 확인합니다.
if (storeAddress && storeAddress.trim() !== "") {
    // 주소 값이 있을 경우 지도 표시 로직 실행

    var mapContainer = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스
    var mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 초기 중심 좌표 (서울 시청) - 주소 검색 성공 시 이 좌표는 무시됩니다.
        level: 3 // 지도의 확대 레벨 (숫자가 작을수록 확대)
    };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(storeAddress, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {

            // 검색 결과의 첫 번째 좌표를 가져옵니다.
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map, // 마커를 표시할 지도 객체
                position: coords, // 마커의 위치
                clickable: true // 마커 클릭 가능하도록 설정
            });

         // 마커 위에 표시할 커스텀 오버레이를 생성합니다.
            var customOverlay = new kakao.maps.CustomOverlay({
                position: coords, // 마커와 동일한 위치에 표시
                // 커스텀 오버레이에 표시할 내용 (HTML 문자열)
                content: '<div style="padding:5px; font-size:12px; background: white; border: 1px solid #ccc; z-index: 2; white-space: nowrap; position: absolute; transform: translate(-50%, -230%); pointer-events: none;">' + storeName + '</div>',
                yAnchor: 0 // yAnchor 값을 0으로 설정하여 마커 위쪽에 표시
            });

            // 지도에 커스텀 오버레이를 표시합니다.
            customOverlay.setMap(map);


// 지도에 커스텀 오버레이를 표시합니다.
customOverlay.setMap(map);


            // 지도에 커스텀 오버레이를 표시합니다.
            customOverlay.setMap(map);


            // 마커에 클릭 이벤트를 등록합니다.
      kakao.maps.event.addListener(marker, 'click', function() {
    // 정보창(InfoWindow)을 여는 코드는 여기에 넣지 않습니다.
    // CustomOverlay는 setMap(map)으로 이미 지도에 표시되어 있습니다.

    // 클릭 시 카카오맵 웹사이트로 이동할 URL을 생성합니다.
    var searchUrl = 'https://map.kakao.com/?q=' + encodeURIComponent(storeAddress);

    // 새 탭으로 카카오맵 웹사이트를 엽니다.
    window.open(searchUrl, '_blank');
});


            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);

        } else {
            // 주소 검색 실패 시 처리
            console.error('주소-좌표 변환 실패. Status:', status);
            // 지도를 표시하지 않거나, 오류 메시지를 div 영역에 표시합니다.
            mapContainer.innerHTML = "<p>매장 주소를 좌표로 변환하는데 실패했습니다.</p>";
        }
    });

} else {
    // 스토어 주소 값이 없는 경우
    console.log("전달된 스토어 주소가 없습니다.");
    // 지도를 표시하지 않고, 해당 div 영역에 메시지를 표시합니다.
    var mapContainer = document.getElementById('map');
    mapContainer.innerHTML = "<p>해당 술에 대한 매장 정보가 없습니다.</p>";
}
</script>

<c:import url="/WEB-INF/views/common/sidebar.jsp" />
</body>
</html>