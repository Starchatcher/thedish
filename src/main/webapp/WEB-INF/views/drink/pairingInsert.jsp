<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.List, com.thedish.recipe.model.vo.Recipe" %>
    <%
    // 컨트롤러에서 전달받은 레시피 목록을 JavaScript에서 사용할 수 있도록 JSON 형태로 변환
    List<Recipe> allRecipes = (List<Recipe>) request.getAttribute("recipeList");
    String recipesJson = "[]"; // 기본값 빈 배열
    if (allRecipes != null) {
        // JSON 라이브러리 (예: Jackson, Gson)를 사용하여 List<Recipe>를 JSON 문자열로 변환
        // 여기서는 간단한 예시를 위해 직접 JSON 문자열을 생성합니다. 실제 프로젝트에서는 라이브러리 사용 권장
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < allRecipes.size(); i++) {
            Recipe recipe = allRecipes.get(i);
            sb.append("{");
            sb.append("\"recipeId\":").append(recipe.getRecipeId()).append(",");
            sb.append("\"name\":\"").append(recipe.getName().replace("\"", "\\\"")).append("\""); // 이름에 따옴표 포함될 경우 처리
            // 필요한 다른 필드도 추가 가능
            sb.append("}");
            if (i < allRecipes.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        recipesJson = sb.toString();
    }
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${drinkId}번 드링크 페어링 등록</title>
    <style>
        /* 기본 스타일 초기화 및 폰트 설정 */
        body {
            font-family: 'Arial', sans-serif; /* 현대적인 느낌의 산세리프 폰트 */
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f7f6; /* 연한 배경색 */
            color: #333;
        }

        /* 컨테이너 스타일 (가운데 정렬 및 최대 너비) */
        .container {
            max-width: 800px; /* 최대 너비 설정 */
            margin: 20px auto; /* 가운데 정렬 */
            padding: 30px;
            background-color: #fff; /* 하얀 배경 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
            border-radius: 8px; /* 모서리 둥글게 */
        }

        h1, h2 {
            color: #333;
            border-bottom: 2px solid #eee; /* 제목 아래 구분선 */
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        h1 {
            text-align: center; /* 메인 제목 가운데 정렬 */
            color: #5a67d8; /* 브랜드 색상 예시 */
        }

        /* 폼 스타일 */
        form div {
            margin-bottom: 15px; /* 폼 요소들 간 간격 */
        }

        label {
            display: block; /* 라벨을 블록 요소로 만들어 다음 입력 필드와 분리 */
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        textarea {
            width: 100%; /* 너비 100% */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px; /* 모서리 둥글게 */
            box-sizing: border-box; /* padding과 border를 너비에 포함 */
            font-size: 1rem;
            transition: border-color 0.2s ease-in-out; /* 호버/포커스 시 전환 효과 */
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: #5a67d8; /* 포커스 시 테두리 색상 변경 */
            outline: none; /* 기본 아웃라인 제거 */
            box-shadow: 0 0 5px rgba(90, 103, 216, 0.3); /* 은은한 그림자 추가 */
        }

        textarea {
            resize: vertical; /* 세로 방향으로만 크기 조절 허용 */
        }

        /* 버튼 스타일 */
        button[type="submit"],
        button[type="button"] {
            display: inline-block; /* 버튼을 인라인 블록 요소로 */
            background-color: #444; /* 배경색 */
            color: white; /* 글자색 */
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.2s ease-in-out; /* 호버 시 전환 효과 */
        }

         button[type="submit"]:hover,
        button[type="button"]:hover:not(:disabled) {
            background-color: #777; /* 호버 시 배경색 변경 */
        }

        button:disabled {
            background-color: #cccccc; /* 비활성화 상태 배경색 */
            cursor: not-allowed; /* 비활성화 상태 커서 */
        }


        /* 검색 결과 목록 스타일 (기존 스타일 개선) */
        .recipe-search-results {
            border: 1px solid #ccc;
            max-height: 200px;
            overflow-y: auto;
            display: none;
            width: 100%; /* 너비 100% (컨테이너 div 안에서) */
            box-sizing: border-box;
            background-color: #fff; /* 배경색 */
            border-radius: 4px;
            margin-top: 5px; /* 검색 입력 필드와의 간격 */
        }

        .recipe-search-results div {
            padding: 10px; /* 패딩 증가 */
            cursor: pointer;
            border-bottom: 1px solid #eee; /* 항목 간 구분선 */
        }

        .recipe-search-results div:last-child {
             border-bottom: none; /* 마지막 항목 구분선 제거 */
        }

        .recipe-search-results div:hover {
            background-color: #f1f1f1; /* 호버 시 배경색 */
        }

        /* 테이블 스타일 */
        table {
            width: 100%; /* 너비 100% */
            border-collapse: collapse; /* 테이블 테두리 합치기 */
            margin-top: 20px;
        }

        th, td {
            padding: 12px; /* 패딩 증가 */
            text-align: left; /* 텍스트 왼쪽 정렬 */
            border-bottom: 1px solid #ddd; /* 행 아래 구분선 */
        }

        th {
            background-color: #f2f2f2; /* 헤더 배경색 */
            font-weight: bold;
            color: #555;
        }

        tbody tr:nth-child(even) {
            background-color: #f9f9f9; /* 짝수 행 배경색 (얼룩말 무늬) */
        }

        tbody tr:hover {
            background-color: #e9e9e9; /* 행 호버 시 배경색 */
        }

         /* 기존 페어링 정보 테이블 내 버튼 스타일 */
        table button {
            padding: 5px 10px;
            font-size: 0.9rem;
            background-color: #dc3545; /* 삭제 버튼 색상 (빨간색 계열) */
            border-radius: 4px;
        }

        table button:hover:not(:disabled) {
            background-color: #c82333;
        }


        /* 기타 요소 */
        hr {
            border: none;
            height: 1px;
            background-color: #ccc;
            margin: 40px 0; /* 위아래 간격 */
        }

        #selectedRecipeName {
            font-weight: bold;
            color: #007bff; /* 선택된 항목 색상 예시 */
        }


    </style>

<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
  <div class="container">

        <h1>${drinkId}번 드링크 페어링 등록</h1>

        <form id="pairingForm" action="${ pageContext.request.contextPath }/insertPairing.do" method="post">
            <input type="hidden" name="drinkId" value="${ drinkId }">
            <%-- 선택된 레시피 ID가 여기에 설정됩니다. --%>
            <input type="hidden" id="selectedRecipeId" name="recipeId" required>

            <div>
                <label for="recipeSearchInput">레시피 검색:</label>
                <input type="text" id="recipeSearchInput" placeholder="레시피 이름 입력" autocomplete="off" />
                <%-- 검색 결과가 표시될 영역 --%>
                <div class="recipe-search-results" id="searchResultsArea">
                    <!-- 검색 결과 항목들이 여기에 동적으로 추가됩니다. -->
                </div>
            </div>

            <%-- 선택된 레시피 이름 표시 영역 (선택 사항) --%>
            <div style="margin-top: 5px;">
                <strong>선택된 레시피:</strong> <span id="selectedRecipeName">선택되지 않음</span>
            </div>

            <div style="margin-top: 15px;">
                <label for="reason">페어링 이유:</label><br>
                <textarea id="reason" name="reason" rows="4" cols="50" required></textarea>
            </div>
				
				
            <div style="margin-top: 15px;">
                 <%-- 레시피가 선택되어야 등록 버튼 활성화 (JavaScript로 제어) --%>
                <button type="submit" id="submitPairingBtn" disabled>페어링 등록</button>
            </div>
        </form>

        <%-- TODO: 뒤로가기 버튼 등 추가 --%>

        <hr> <%-- 섹션 구분선 --%>

        <h2>기존 페어링 정보</h2>
        <c:choose>
            <c:when test="${ not empty existingPairingList }">
                <table>
                    <thead>
                        <tr>
                            
                            
                            <th>레시피 이름</th>
                            <th>페어링 이유</th>
                            <%-- 관리자 삭제 기능을 위해 헤더 추가 (isAdmin이 true일 때만 보이게) --%>
                              <%-- 컨트롤러에서 전달받은 isAdmin 변수 값이 true이면 이 th가 보임 --%>
                                <th>관리</th>
                           
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pairing" items="${ existingPairingList }">
                            <tr>
                                
                                
                                <td>${ pairing.recipeName }</td>
                                <td>${ pairing.reason }</td>
                               
                               <c:if test="${  loginUser.role eq 'ADMIN' }"> <%-- isAdmin 값이 true이면 이 td가 보입니다. --%>
                                    <td>
                                        
                                         
                                        <button type="button" onclick="deletePairing(${ pairing.pairingId }, ${ drinkId });">삭제</button> 
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>아직 등록된 페어링 정보가 없습니다.</p>
            </c:otherwise>
        </c:choose>

        <%-- TODO: 뒤로가기 버튼 등 추가 --%>

    </div>

  

    <script>
        // 서버에서 전달받은 전체 레시피 목록을 JavaScript 변수에 저장
        const allRecipes = <%= recipesJson %>; // JSON 문자열을 JavaScript 객체로 파싱

        const recipeSearchInput = document.getElementById('recipeSearchInput');
        const searchResultsArea = document.getElementById('searchResultsArea');
        const selectedRecipeIdInput = document.getElementById('selectedRecipeId');
        const selectedRecipeNameSpan = document.getElementById('selectedRecipeName');
        const submitPairingBtn = document.getElementById('submitPairingBtn');

        // 입력 필드에 포커스되면 검색 결과 영역 보이게 (입력 내용 없으면 전체 목록 표시 등 추가 기능 가능)
         recipeSearchInput.addEventListener('focus', function() {
             if (this.value.length > 0) { // 입력된 내용이 있을 때만 보이게 하거나...
                 // 또는 입력 필드 클릭 시 전체 목록 표시하려면 여기에 allRecipes를 기반으로 목록 생성
                 // displaySearchResults(allRecipes);
             }
             searchResultsArea.style.display = 'block';
         });


        // 검색 입력 필드에서 입력 이벤트 감지
        recipeSearchInput.addEventListener('input', function() {
            const keyword = this.value.toLowerCase(); // 검색어 소문자로 변환하여 대소문자 구분 없이 검색
            searchResultsArea.innerHTML = ''; // 결과 목록 초기화

            if (keyword.length === 0) {
                 // 검색어가 없을 때 전체 목록을 보여주거나, 그냥 빈 목록을 보여주거나 선택
                 searchResultsArea.style.display = 'none'; // 일단 숨김
                 return;
            }

            const filteredRecipes = allRecipes.filter(recipe =>
                recipe.name.toLowerCase().includes(keyword) // 레시피 이름에 검색어 포함 여부 확인
            );

            if (filteredRecipes.length > 0) {
                filteredRecipes.forEach(recipe => {
                    const resultDiv = document.createElement('div');
                    resultDiv.textContent = recipe.name;
                    resultDiv.setAttribute('data-recipe-id', recipe.recipeId);
                    resultDiv.classList.add('recipe-option'); // 클릭 이벤트 처리를 위한 클래스 추가
                    searchResultsArea.appendChild(resultDiv);
                });
                 searchResultsArea.style.display = 'block'; // 검색 결과가 있을 때 보이게
            } else {
                 // 검색 결과가 없을 때 메시지 표시
                const noResultDiv = document.createElement('div');
                noResultDiv.textContent = '검색 결과가 없습니다.';
                searchResultsArea.appendChild(noResultDiv);
                searchResultsArea.style.display = 'block'; // 검색 결과가 없을 때도 보이게
            }
        });

        // 검색 결과 항목 클릭 이벤트 (이벤트 위임 사용)
        searchResultsArea.addEventListener('click', function(event) {
            const target = event.target;
            // 클릭된 요소가 레시피 옵션 항목인지 확인
            if (target && target.classList.contains('recipe-option')) {
                const selectedRecipeId = target.getAttribute('data-recipe-id');
                const selectedRecipeName = target.textContent;

                // 숨겨진 입력 필드에 레시피 ID 설정
                selectedRecipeIdInput.value = selectedRecipeId;

                // 검색 입력 필드에 선택된 레시피 이름 표시
                recipeSearchInput.value = selectedRecipeName;

                // 선택된 레시피 이름 표시 영역 업데이트
                selectedRecipeNameSpan.textContent = selectedRecipeName;

                // 검색 결과 영역 숨기기
                searchResultsArea.style.display = 'none';

                // 페어링 등록 버튼 활성화
                submitPairingBtn.disabled = false;

                console.log('선택된 레시피 ID:', selectedRecipeId);
            }
        });

         // 폼 제출 전에 selectedRecipeId 필드가 비어있으면 제출 방지
         pairingForm.addEventListener('submit', function(event) {
             if (!selectedRecipeIdInput.value) {
                 alert('페어링할 레시피를 먼저 검색하여 선택해주세요.');
                 event.preventDefault(); // 폼 제출 방지
             }
         });

        // 페이지 로드 시 등록 버튼 비활성화 상태 유지
        submitPairingBtn.disabled = true;


        // 검색 결과 영역 외부 클릭 시 숨기기
        document.addEventListener('click', function(event) {
            const isClickInside = recipeSearchInput.contains(event.target) || searchResultsArea.contains(event.target);
            if (!isClickInside) {
                searchResultsArea.style.display = 'none';
            }
        });

    </script>
    
    

     <script>
    function deletePairing(pairingId, drinkId) {
        console.log("deletePairing 함수 호출 시도:", pairingId, drinkId); // 이 로그는 이제 잘 나옵니다.

        // TODO: 실제 AJAX 삭제 요청 코드 (Fetch API 또는 jQuery.ajax 등 사용)
        // 이 부분이 문제입니다.

        if (confirm("정말 이 페어링 정보를 삭제하시겠습니까? (ID: " + pairingId + ")")) {
            // *** 이 안에 실제 서버로 삭제 요청을 보내는 AJAX 코드가 있어야 합니다. ***
            console.log("사용자가 삭제를 확인했습니다. AJAX 요청 시작 시도."); // 확인용 로그

            // 예시: Fetch API를 사용하여 POST 요청 보내기
            fetch('${ pageContext.request.contextPath }/deletePairing.do', {
                method: 'POST', // POST 방식으로 전송
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded', // 폼 데이터 형식
                    // 필요한 경우 CSRF 토큰 등 추가 (CSRF 설정 사용 시)
                },
                // 요청 본문에 데이터 포함 (URLSearchParams로 폼 데이터 형식 만듬)
                body: new URLSearchParams({
                    pairingId: pairingId // 삭제할 페어링 ID 전달 (이제 올바른 2가 전달될 것입니다)
                })
            })
            .then(response => {
                 console.log("Fetch 요청 응답 받음. 상태:", response.status); // 응답 상태 확인용 로그
                 if (!response.ok) {
                     // HTTP 상태 코드가 2xx 범위가 아닌 경우 오류 처리
                     console.error("HTTP 오류! 상태:", response.status);
                     throw new Error('Network response was not ok ' + response.statusText);
                 }
                 // 응답 본문을 텍스트로 받음 ('success', 'fail', 'error' 등)
                 return response.text();
             })
            .then(result => {
                console.log("서버 응답 본문:", result); // 서버에서 반환한 문자열 확인

                // 서버에서 받은 응답 문자열 처리
                if (result === 'success') {
                    alert('페어링 삭제 성공!');
                    // 성공 시 페이지 새로고침하여 목록 갱신 (drinkId도 함께 전달)
                    window.location.href = '${ pageContext.request.contextPath }/pairingInsert.do?drinkId=' + drinkId;
                    // 또는 해당 행만 DOM에서 제거하는 방식으로 업데이트 가능
                } else if (result === 'fail') {
                    alert('페어링 삭제 실패.');
                } else if (result === 'unauthorized') { // 관리자 권한 없을 때 서버 응답 (선택 사항)
                     alert('삭제 권한이 없습니다.');
                }
                 else { // 'error' 또는 예상치 못한 응답
                    alert('페어링 삭제 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('페어링 삭제 요청 중 오류 발생:', error);
                alert('페어링 삭제 중 통신 오류가 발생했습니다. 콘솔을 확인하세요.');
            });

        } else {
             console.log("사용자가 삭제를 취소했습니다."); // 확인용 로그
        }
    }
</script>


<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>