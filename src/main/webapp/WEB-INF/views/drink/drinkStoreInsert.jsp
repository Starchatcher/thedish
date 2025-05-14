<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매처 관리</title>
   <style>
    /* 전체 레이아웃 및 기본 스타일 */
    body {
        font-family: 'Segoe UI', Roboto, Arial, sans-serif; /* 모던한 글꼴 */
        margin: 0;
        padding: 20px; /* 전체 여백 */
        background-color: #f4f7f6; /* 은은한 배경색 */
        color: #333;
        line-height: 1.6; /* 가독성을 위한 줄 간격 */
    }

    .container {
        max-width: 1000px; /* 최대 너비 설정 */
        margin: 20px auto; /* 중앙 정렬 및 상하 여백 */
        padding: 20px;
        background-color: #fff; /* 컨테이너 배경색 */
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
        border-radius: 8px; /* 모서리 둥글게 */
    }

    h1, h2 {
        color: #444; /* 브랜드 색상 또는 강조색 */
        border-bottom: 2px solid #444; /* 제목 아래 구분선 */
        padding-bottom: 10px;
        margin-bottom: 20px;
    }

    h2 {
        color: #444;
        border-bottom-color: #e9ecef; /* 덜 강조되는 구분선 */
    }

    hr {
        border: none;
        height: 1px;
        background-color: #e0e0e0;
        margin: 30px 0; /* 충분한 구분 여백 */
    }

    /* 음료 정보 섹션 스타일 */
    .drink-info p {
        margin-bottom: 15px;
        padding: 10px;
        background-color: #e9ecef; /* 정보 배경색 */
        border-radius: 4px;
        display: flex; /* 레이아웃 조정을 위해 flexbox 사용 */
        align-items: center;
    }

    .drink-info p strong {
        margin-right: 10px; /* 라벨과 입력 필드 사이 간격 */
    }

    .readonly {
        background-color: #f8f9fa; /* 읽기 전용 필드 배경색 */
        border: 1px solid #ced4da;
        padding: 8px;
        border-radius: 4px;
        flex-grow: 1; /* 남은 공간 채우도록 설정 */
    }

    /* 폼 스타일 */
    form div {
        margin-bottom: 15px;
    }

    form label {
        display: block; /* 라벨을 블록 요소로 만들어 다음 요소와 분리 */
        margin-bottom: 5px;
        font-weight: bold;
        color: #777;
    }

    form input[type="text"] {
        width: calc(100% - 20px); /* 너비 조정 (padding 고려) */
        padding: 10px;
        border: 1px solid #444;
        border-radius: 4px;
        box-sizing: border-box; /* 패딩이 너비에 포함되도록 설정 */
    }

    form input[type="text"]:focus {
        border-color: #777; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 outline 제거 */
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* 포커스 시 그림자 */
    }

    button[type="submit"] {
        display: inline-block; /* 버튼을 인라인 블록으로 */
        padding: 10px 20px;
        background-color: #444; /* 등록 버튼 색상 */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.2s ease; /* 호버 애니메이션 */
    }

    button[type="submit"]:hover {
        background-color: #777;
    }

    /* 메시지 영역 스타일 */
    #messageArea {
        margin-top: 20px;
        padding: 15px;
        border-radius: 5px;
        display: none; /* 기본 숨김 */
        font-weight: bold;
    }

    .message.success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .message.error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    /* 테이블 스타일 */
    table {
        width: 100%; /* 부모 너비에 맞춤 */
        border-collapse: collapse;
        margin-top: 20px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* 테이블에도 은은한 그림자 */
    }

    th, td {
        border: 1px solid #dee2e6; /* 연한 테두리 */
        padding: 12px; /* 셀 내부 여백 */
        text-align: left;
    }

    th {
        background-color: #e9ecef; /* 헤더 배경색 */
        font-weight: bold;
        color: #495057;
    }

    tbody tr:nth-child(even) {
        background-color: #f8f9fa; /* 짝수 행 배경색 (얼룩말 줄무늬) */
    }

    tbody tr:hover {
        background-color: #777; /* 호버 시 배경색 변경 */
    }

    td button {
        padding: 6px 12px;
        background-color: #dc3545; /* 삭제 버튼 색상 */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.2s ease;
    }

    td button:hover {
        background-color: #777;
    }

    /* 추가적인 관리자 페이지 느낌 요소 */
    /* 예: 사이드바나 상단바가 있다고 가정하고 컨테이너 패딩 등을 조정할 수 있습니다. */
    /* 현재는 단일 페이지 구성에 맞춰 스타일링 */

</style>


</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
  
  <div class="container">
    <h1>판매처 관리 페이지</h1>

    <%-- 컨트롤러에서 모델에 담아 전달된 음료 정보를 표시 --%>
    <c:if test="${not empty drink}">
        <h2>음료 정보</h2>
        <p>
            <%-- 음료 이름 표시 (수정 불가) --%>
            **음료 이름:** <input type="text" value="${drink.name}" readonly class="readonly"> 
            <%-- 판매처 등록 시 사용할 음료 이름 및 ID (hidden 필드) --%>
            <input type="hidden" id="drinkName" name="drinkName" value="${drink.name}"> 
            <input type="hidden" id="drinkId" name="drinkId" value="${drink.drinkId}">
        </p>
        <hr>
    </c:if>

        <%-- 새로운 판매처 등록 폼 --%>
    <h2>새로운 판매처 등록</h2>
    <form id="addStoreForm" method="post">
        <%-- 숨겨진 필드로 음료 이름 및 ID 전달 (폼 태그 안으로 이동) --%>
         <input type="hidden" name="drinkId" id="drinkIdForUpdate" value="${drink.drinkId}"> <%-- id 속성 추가 또는 변경 --%>
        <input type="hidden" name="drinkName" value="${drink.name}">

        <div>
            <label for="storeName">판매처 이름:</label>
            <input type="text" id="storeName" name="storeName" required>
        </div>
        <div>
            <label for="storeAddress">판매처 주소:</label>
            <input type="text" id="storeAddress" name="storeAddress" required>
        </div>
        <button type="submit">판매처 등록</button>
    </form>


    <%-- 메시지를 표시할 영역 추가 --%>
    <div id="messageArea" class="message" style="display: none;"></div> 

    <hr>

    <%-- 기존 판매처 목록 표시 --%>
    <h2>등록된 판매처 목록</h2>
    <div id="storeListArea"> <%-- 목록을 감싸는 div 추가 --%>
        <c:if test="${not empty drinkStores}">
            <table>
                <thead>
                    <tr>
                        <th>STORE ID</th>
                        <th>판매처 이름</th>
                        <th>판매처 주소</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="store" items="${drinkStores}">
                        <tr>
                            <td>${store.storeId}</td>
                            <td>${store.storeName}</td>
                            <td>${store.storeAddress}</td>
                            <td>
                                <%-- 삭제 버튼 - 클릭 시 삭제 요청 --%>
                                <button onclick="deleteStore(${store.storeId})">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty drinkStores and not empty drink}">
            <p>등록된 판매처가 없습니다.</p>
        </c:if>
    </div> <%-- storeListArea 끝 --%>

    <%-- JavaScript for AJAX and Delete --%>
    <script>
    
    const testVar = "test";
    const testString = `${testVar}/testUrl.do`;
    console.log("템플릿 리터럴 테스트 결과:", testString);
        // 판매처 등록 폼 선택
        const addStoreForm = document.getElementById('addStoreForm');
        // 메시지 영역 선택
        const messageArea = document.getElementById('messageArea');
        // 판매처 목록 영역 선택 (업데이트를 위해)
        const storeListArea = document.getElementById('storeListArea');
        // 현재 음료 ID 가져오기
        const currentDrinkId = document.getElementById('drinkIdForUpdate').value; 
        // 컨텍스트 경로 가져오기
        const contextPath = "${pageContext.request.contextPath}";
        console.log("확인된 컨텍스트 경로:", contextPath);
        // 폼 제출 이벤트 리스너 추가
        addStoreForm.addEventListener('submit', function(event) {
            // 기본 폼 제출 동작 막기
            event.preventDefault();

            // 폼 데이터 가져오기
            const formData = new FormData(addStoreForm);
            console.log("폼 데이터에 담긴 drinkId:", formData.get('drinkId'));
            const url = contextPath + "/drinkStoreInsert.do"; // <--- 이 라인 사용
            console.log("AJAX 요청 URL (연결 방식):", url); 
             console.log("AJAX 요청 URL:", url); 
            // 메시지 영역 초기화 및 숨김
            messageArea.style.display = 'none';
            messageArea.textContent = '';
            messageArea.className = 'message'; // 클래스 초기화

            // Fetch API를 사용하여 비동기 POST 요청 보내기
            fetch(url, {
                method: 'POST', // POST 메소드
                body: formData // FormData 객체 전송
            })
            .then(response => {
                // 응답 상태 확인
                if (!response.ok) {
                    // HTTP 상태 코드가 2xx 범위가 아니면 오류 처리
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                // 응답 본문을 텍스트로 읽기 (서버에서 간단한 문자열 응답을 기대)
                // 만약 서버가 JSON을 반환한다면 response.json() 사용
                 return response.text(); 
            })
            .then(result => {
                // 서버 응답 처리
                console.log('서버 응답:', result); // 디버깅을 위해 응답 로깅

                // 서버 응답에 따라 메시지 표시
                if (result === 'success') { // 서버에서 'success' 문자열을 반환한다고 가정
                    displayMessage('판매처 정보가 성공적으로 등록되었습니다.', 'success');
                    // 폼 필드 초기화
                    addStoreForm.reset();
                    // 등록 후 판매처 목록 새로고침 (간단한 방법)
                    // 페이지 전체 새로고침 대신 목록 부분만 업데이트하려면
                    // updateStoreList() 함수를 호출해야 함
                    updateStoreList(); 

                } else { // 서버에서 'fail' 또는 다른 문자열을 반환한다고 가정
                    displayMessage('판매처 정보 등록에 실패했습니다.', 'error');
                }
            })
            .catch(error => {
                // 요청 실패 또는 서버 오류 발생 시 처리
                console.error('Error:', error);
                displayMessage('판매처 등록 중 오류가 발생했습니다: ' + error.message, 'error');
            });
        });

        // 메시지 표시 함수
        function displayMessage(message, type) {
            messageArea.textContent = message;
            messageArea.className = 'message ' + type; // success 또는 error 클래스 추가
            messageArea.style.display = 'block'; // 메시지 영역 보이기
        }

        // 판매처 목록 업데이트 함수 (AJAX로 목록 다시 가져오기)
        function updateStoreList() {
        	 console.log("updateStoreList 호출됨"); // <--- 이 라인 추가
             console.log("updateStoreList 호출 시 currentDrinkId:", currentDrinkId); 
             // 현재 음료의 판매처 목록을 다시 가져오는 URL
           /*  const listUrl = `${contextPath}/drinkStoreInsert.do?drinkId=${currentDrinkId}`; */
           
            const listUrl = contextPath + "/drinkStoreInsert.do?drinkId=" + currentDrinkId;
            console.log("업데이트 목록 요청 URL:", listUrl);
            fetch(listUrl)
                .then(response => {
                    if (!response.ok) {
                         throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    // 응답을 HTML 텍스트로 받아서 파싱
                    return response.text(); 
                })
                .then(html => {
                    // 응답 HTML에서 판매처 목록 부분만 추출하여 교체
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(html, 'text/html');
                    const updatedListHtml = doc.getElementById('storeListArea').innerHTML;

                    // 기존 목록 영역을 새로운 HTML로 교체
                    storeListArea.innerHTML = updatedListHtml;
                })
                .catch(error => {
                    console.error('Error updating store list:', error);
                    displayMessage('판매처 목록 업데이트 중 오류 발생.', 'error');
                });
        }


        function deleteStore(storeId) {
            if (confirm("정말로 이 판매처를 삭제하시겠습니까?")) {
                // 삭제 요청을 보낼 URL (컨트롤러의 @RequestMapping value와 동일하게 설정)
                // storeId를 쿼리 스트링으로 전달합니다.
                 const deleteUrl = contextPath + "/deleteDrinkStore.do?storeId=" + storeId;

                console.log('삭제 요청 URL:', deleteUrl); // <--- 삭제 요청 URL 확인 로그 추가

                // Fetch API를 사용하여 비동기 POST 요청 보내기
                fetch(deleteUrl, {
                    method: 'POST' // 컨트롤러에서 RequestMethod.POST를 사용했으므로 POST 메소드 사용
                    // POST 요청이지만 데이터를 쿼리 스트링으로 보낼 것이므로 body는 필요 없습니다.
                    // 만약 body에 담아 보낸다면 headers 설정과 @RequestBody 또는 폼 데이터 파싱 필요
                })
                .then(response => {
                     // 응답 상태 확인
                    if (!response.ok) {
                         return response.text().then(text => {
                             throw new Error(`HTTP error! status: ${response.status} - ${text}`);
                         });
                    }
                    // 서버 응답을 텍스트로 받기 (예: 'success' 또는 'fail')
                    return response.text();
                })
                .then(result => {
                    console.log('삭제 서버 응답:', result); // 디버깅을 위해 응답 로깅

                    if (result === 'success') {
                        displayMessage('판매처 정보가 성공적으로 삭제되었습니다.', 'success');
                        // 삭제 성공 후 판매처 목록 새로고침 (updateStoreList 함수 재사용)
                        updateStoreList();
                    } else {
                        // 서버에서 실패 응답이 오거나 다른 문자열이 올 경우
                         displayMessage('판매처 정보 삭제에 실패했습니다.', 'error');
                    }
                })
                .catch(error => {
                    // 네트워크 오류 또는 서버 처리 중 예외 발생 시
                    console.error('Error deleting store:', error);
                    displayMessage('판매처 삭제 중 오류가 발생했습니다: ' + error.message, 'error');
                });
            }
        }
    </script>


</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
