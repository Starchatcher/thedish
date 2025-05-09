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

#map {
    height: 400px
    width: 100%;
    margin-top: 40px;
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
    position: relative; /* z-index가 작동하려면 position 속성이 static 외의 값이어야 합니다. */
    z-index: 10; /* 다른 요소들보다 높은 값 설정 */
    flex-shrink: 0;
}

.stats {
    margin-top: 20px;
    text-align: center;
}

/* Comments Section 스타일 통합 */
.comments-section {
    margin-top: 20px; /* 나중에 정의된 20px 적용 */
    padding: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

/* Comments Section h3 스타일 통합 */
.comments-section h3 {
    margin-bottom: 15px; /* 나중에 정의된 15px 적용 */
    font-size: 24px;
    color: #333;
}

/* Comments Section ul 스타일 통합 */
.comments-section ul {
    list-style-type: none;
    padding: 0;
}

/* Comments Section li 스타일 통합 */
.comments-section li {
    margin-bottom: 15px; /* 나중에 정의된 15px 적용 */
    padding: 10px;
    border: 1px solid #eaeaea;
    border-radius: 5px;
    background-color: #fafafa; /* 나중에 정의된 #fafafa 적용 */
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
    
    .custom-overlay-content {
    position: relative;
    background-color: white; /* 배경색 */
    border: 1px solid #ddd; /* 테두리 */
    border-radius: 5px; /* 둥근 모서리 */
    padding: 10px; /* 안쪽 여백 */
    white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
}
    
    
    </style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script>

  
</script>

</head>

<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:if test="${  loginUser.role eq 'ADMIN' }">
<a href="moveUpdateDrinkPage.do?drinkId=${drink.drinkId}&page=${currentPage != null ? currentPage : 1}">수정</a>
 <a href="drinkStoreInsert.do?drinkId=${drink.drinkId}&page=${currentPage != null ? currentPage : 1}">판매처 등록</a>
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

<!-- 서버에서 전달받은 'pairingList'가 비어있지 않다면 -->
<c:choose>
    <c:when test="${ not empty pairingList }">
        <table>
            <thead>
                <tr>
                    <th>레시피 이름</th>
                    <th>페어링 이유</th>
                    <!-- 필요하다면 추가 정보 컬럼 추가 (예: 이미지, 설명) -->
                </tr>
            </thead>
            <tbody>
                <!-- pairingList의 각 항목(페어링 정보 객체)을 'pairing' 변수에 담아 반복 -->
                <c:forEach var="pairing" items="${ pairingList }">
                    <tr>
                       <!--  'pairing' 객체의 속성(예: recipeName, reason)을 EL 표현식으로 출력 -->
                        <td>${ pairing.recipeName }</td>
                        <td>${ pairing.reason }</td>
                        <!-- 필요하다면 추가 정보 셀 추가 -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    
    <c:otherwise>
        <p>아직 등록된 페어링 정보가 없습니다.</p>
    </c:otherwise>
</c:choose>




<div class="stats">
    <span>조회수: ${drink.viewCount}</span>    
    <span>평균 평점: ${drink.avgRating}</span>       
    <!-- 로그인한 사용자에게만 평점 입력 폼 표시 -->
      <c:if test="${loginUser != null}">
        <div class="rating-form-area">
            <h4>내 평점 부여/수정</h4>
            <!-- 평점 부여 폼 -->
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
  <!-- 로그인하지 않은 사용자에게 안내 메시지 표시 -->
    <c:if test="${loginUser == null}">
         <div class="rating-form-area">
             <p>평점을 부여하려면 <a href="loginPage.do">로그인</a>해주세요.</p> 
         </div>
    </c:if>
	

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
<!-- 로그인하지 않은 사용자에게는 댓글 작성 폼이 보이지 않음 -->
<c:if test="${loginUser == null}">
    <p>댓글을 작성하려면 <a href="loginPage.do">로그인</a>해주세요.</p> 
</c:if>

 
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<c:import url="/WEB-INF/views/common/footer.jsp" />

<script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7724415b4929d53594c486d4493f37fb&libraries=services&autoload=false"></script>
<!-- 2. initMap 함수를 정의하는 스크립트 -->
  <script type="text/javascript">
        console.log("--- 지도 스크립트 블록 시작 (Geocoding 활성화 시도) ---"); // 로그 변경
        var storeAddress = "${storeInfo['STORE_ADDRESS']}"; // EL 치환
        var storeName = "${storeInfo['STORE_NAME']}";     // EL 치환
        console.log("JSP에서 EL 처리 후 storeAddress 값:", storeAddress);
        console.log("JSP에서 EL 처리 후 storeName 값:", storeName);
        console.log("initMap 함수 정의 전");

        function initMap() {
            console.log(">>> initMap 함수 내부 진입! (Geocoding 활성화) <<<"); // 로그 변경

            var mapContainer = document.getElementById('map');
             if (!mapContainer) {
                 console.error("ID 'map'을 가진 지도를 담을 HTML 요소를 찾을 수 없습니다.");
                 return;
            }

           
             console.log("JS에서 mapContainer 높이 설정:", mapContainer.style.height); 
            var mapOption = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567), // 초기 중심 좌표 (주소 검색 실패 시 사용)
                level: 3
            };
            console.log("mapOption 객체 정의 완료");

            var map = new kakao.maps.Map(mapContainer, mapOption);
            console.log("지도 생성 성공!");

           
            // 주소-좌표 변환 객체를 생성합니다
            var geocoder = new kakao.maps.services.Geocoder();
            console.log("Geocoder 객체 생성 성공!"); // <<-- 이 로그가 나오는지 확인

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch(storeAddress, function(result, status) {
                console.log("Geocoder Status:", status); // <<-- 이 로그와 상태값 (OK 여부) 확인
                if (status === kakao.maps.services.Status.OK) {
                    console.log("주소 검색 성공! 좌표:", result[0].y, result[0].x); // 검색된 좌표 로그

                    // 검색 결과의 첫 번째 좌표를 가져옵니다.
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    
                    map.setCenter(coords);
                    console.log("지도를 검색된 주소 위치로 이동");

                    // 중요: 중심 이동 후 레이아웃을 다시 계산하도록 요청
                    map.relayout();
                    console.log("map.relayout() 호출 완료");

                    
                    // 결과값으로 받은 위치를 마커로 표시합니다
                    var marker = new kakao.maps.Marker({
                        map: map, // 마커를 표시할 지도 객체
                        position: coords, // 마커의 위치
                        clickable: true // 마커 클릭 가능하도록 설정
                    });
                    console.log("마커 생성 성공!"); // <<-- 이 로그가 나오는지 확인

                     // 마커 위에 표시할 커스텀 오버레이를 생성합니다.
                     var customOverlay = new kakao.maps.CustomOverlay({
                         position: coords, // 마커와 동일한 위치에 표시
                         content: '<div class="custom-overlay-content">' + storeName + '</div>',
                         yAnchor: 1.9 // 마커 이미지 위에 텍스트가 오도록 조정
                     });
                     customOverlay.setMap(map);
                     console.log("커스텀 오버레이 생성 및 표시 성공!"); // <<-- 이 로그가 나오는지 확인

                    // 마커에 클릭 이벤트를 등록합니다.
                    kakao.maps.event.addListener(marker, 'click', function() {
                        var searchUrl = 'https://map.kakao.com/?q=' + encodeURIComponent(storeAddress);
                        window.open(searchUrl, '_blank');
                    });
                     console.log("마커 클릭 이벤트 등록 완료"); // <<-- 이 로그가 나오는지 확인

                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                    map.setCenter(coords);
                    console.log("지도를 검색된 주소 위치로 이동"); // <<-- 이 로그가 나오는지 확인

                } else {
                    // 주소 검색 실패 시 처리
                    console.error('주소-좌표 변환 실패. Status:', status); // 실패 상태값 확인
                     if (mapContainer) {
                         mapContainer.innerHTML = "<p>매장 주소를 좌표로 변환하는데 실패했습니다.</p>";
                     }
                }
            });

            // Geocoding 주석 처리 시 초기 중심 좌표로 이동했던 코드는 제거하거나 주석 처리합니다.
            // map.setCenter(mapOption.center);
            // console.log("지도를 초기 중심 좌표로 이동 (Geocoding 주석 처리 상태)");


        }

        console.log("initMap 함수 정의 후");

        // window.addEventListener('load', ...)`는 그대로 유지합니다.
        window.addEventListener('load', function() {
           console.log(">>> window 'load' 이벤트 발생 <<<");
            console.log(">>> kakao 객체 확인 시도 <<<");

            console.log("Type of kakao:", typeof kakao);
            console.log("Type of kakao.maps:", typeof kakao.maps);
            console.log("Type of kakao.maps.load:", typeof kakao.maps.load);


            if (typeof kakao !== 'undefined' && typeof kakao.maps !== 'undefined' && typeof kakao.maps.load === 'function') {
                 console.log(">>> Kakao Maps SDK 로드 확인. kakao.maps.load(initMap) 호출 시도 <<<");
                 kakao.maps.load(initMap); // SDK 로드가 완료된 후에 initMap 실행 요청
                 console.log(">>> kakao.maps.load(initMap) 호출 완료 <<<");
            } else {
                 console.error(">>> Kakao Maps SDK가 로드되지 않았거나 kakao.maps.load 함수를 사용할 수 없습니다. <<<");
                 var mapContainer = document.getElementById('map');
                 if (mapContainer) {
                     mapContainer.innerHTML = "<p>지도 로딩에 실패했습니다. 잠시 후 다시 시도해주세요.</p>";
                 }
            }
        });
        
    </script> 
   
</body>
</html>