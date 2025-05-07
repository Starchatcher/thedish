
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매처 등록 및 목록</title>
   
    <style>
        /* 판매처 목록 테이블 스타일 */
        .store-list-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .store-list-table th, .store-list-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .store-list-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
         .store-list-table tr:nth-child(even) {
            background-color: #f9f9f9; /* 짝수 행 배경색 */
        }
        .store-list-table tr:hover {
            background-color: #ddd; /* 호버 시 배경색 */
        }
        .store-list-table td:last-child {
            text-align: center; /* 삭제 버튼 가운데 정렬 */
            width: 80px; /* 삭제 버튼 열 너비 조정 */
        }
         .delete-button { /* 삭제 버튼 스타일 */
             background-color: #ff6666;
             color: white;
             border: none;
             border-radius: 4px;
             padding: 5px 10px;
             cursor: pointer;
             font-size: 12px;
             transition: background-color 0.3s ease;
         }
         .delete-button:hover {
             background-color: #ff3333;
         }
         /* 폼 스타일 조정 (기존 CSS에 맞게) */
         .insert-form div {
             margin-bottom: 15px;
         }
         .insert-form label {
             display: block; /* 레이블을 블록 요소로 만들어 필드 위에 오도록 */
             margin-bottom: 5px;
             font-weight: bold;
         }
          .insert-form input[type="text"] {
             width: calc(100% - 12px); /* 부모 너비에서 패딩 제외 */
             padding: 6px;
             border: 1px solid #ccc;
             border-radius: 4px;
         }
         .insert-form button[type="submit"],
         .insert-form button[type="button"] {
             padding: 8px 15px;
             border: none;
             border-radius: 4px;
             cursor: pointer;
             margin-right: 5px;
             transition: background-color 0.3s ease;
         }
         .insert-form button[type="submit"] {
             background-color: #4CAF50; /* 등록 버튼 색상 */
             color: white;
         }
          .insert-form button[type="submit"]:hover {
             background-color: #45a049;
         }
          .insert-form button[type="button"] {
             background-color: #f0f0f0; /* 취소 버튼 색상 */
             color: #333;
         }
         .insert-form button[type="button"]:hover {
             background-color: #ddd;
         }
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

    <div class="content-container">
        <h1>판매처 등록 및 목록</h1>

        <%-- 판매처 정보 등록 폼 --%>
        <h2>새 판매처 등록</h2>
        <form action="${pageContext.request.contextPath}/insertDrinkStore.do" method="post" class="insert-form">

            <%-- 어떤 음료에 대한 판매처인지 숨김 필드로 전달 --%>
            <input type="hidden" name="drinkName" value="${drinkName}" />
            <%-- 등록 완료 후 돌아갈 페이지 정보 전달 (선택 사항) --%>
            <input type="hidden" name="currentPage" value="${currentPage}" />

            <%-- 판매 장소명 입력 필드 --%>
            <div>
                <label for="storeName">판매 장소명: <span style="color:red">*</span></label>
                <input type="text" id="storeName" name="storeName" maxlength="255" required />
            </div>

            <%-- 판매 장소 주소 입력 필드 --%>
            <div>
                <label for="storeAddress">판매 장소 주소: <span style="color:red">*</span></label>
                <input type="text" id="storeAddress" name="storeAddress" maxlength="500" required />
            </div>

            <br>

            <%-- 등록 버튼 --%>
            <button type="submit">등록</button>
            <%-- 취소 버튼: 음료 목록 페이지의 원래 페이지로 돌아가기 --%>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/drinkList.do?page=${currentPage}'">목록으로</button>

        </form>

        <hr style="margin: 30px 0;"> <%-- 구분선 --%>

        <%-- *** 기존 판매처 목록 출력 *** --%>
        <h2>등록된 판매처 목록</h2>

        <c:if test="${not empty existingStores}">
            <table class="store-list-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>판매 장소명</th>
                        <th>주소</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- existingStores 목록 반복 출력 --%>
                    <c:forEach items="${existingStores}" var="store">
                        <tr>
                            <td>${store.storeId}</td>
                            <td>${store.storeName}</td>
                            <td>${store.storeAddress}</td>
                            <td>
                                <%-- 삭제 폼 (각 항목별 삭제) --%>
                      <form action="${pageContext.request.contextPath}/deleteDrinkStore.do" method="post" style="display:inline;">
    <%-- 삭제할 판매처 ID 전달 --%>
    <input type="hidden" name="storeId" value="${store.storeId}" />
    <%-- 삭제 후 현재 페이지 (판매처 등록 페이지)로 돌아오기 위해 drinkName과 currentPage 전달 --%>
    <input type="hidden" name="drinkName" value="${drinkName}" />
    <input type="hidden" name="currentPage" value="${currentPage}" />
    <button type="submit" class="delete-button" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
</form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <%-- 등록된 판매처가 없을 경우 메시지 출력 --%>
        <c:if test="${empty existingStores}">
            <p>등록된 판매처가 없습니다.</p>
        </c:if>

    </div>

    <%-- 푸터 등 공통 부분 include (필요시) --%>
    <c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>


</html>