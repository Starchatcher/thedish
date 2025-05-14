<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
    /* 드링크 수정 폼 섹션 스타일 */
    .drink-update-form-section {
        margin-top: 30px; /* 상단 여백 */
        margin-bottom: 30px; /* 하단 여백 */
        padding: 30px; /* 내부 여백 */
        background-color: #ffffff; /* 섹션 배경색 */
        border-radius: 8px; /* 모서리 둥글게 */
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
        max-width: 600px; /* 폼 섹션 최대 너비 */
        margin-left: auto; /* 가운데 정렬 */
        margin-right: auto; /* 가운데 정렬 */
    }

    .drink-update-form-section h2 {
        color: #4a4a4a; /* 제목 색상 */
        border-bottom: 2px solid #eeeeee; /* 제목 아래 구분선 */
        padding-bottom: 10px; /* 아래 여백 */
        margin-top: 0; /* 상단 여백 제거 */
        margin-bottom: 20px; /* 아래 여백 */
        font-size: 1.8rem; /* 제목 글자 크기 */
        text-align: center; /* 제목 가운데 정렬 */
    }

    /* 폼 요소 div 간 간격 */
    .drink-update-form-section form div {
        margin-bottom: 18px; /* 각 폼 그룹(라벨+입력 필드) 간 간격 */
    }

    .drink-update-form-section label {
        display: block; /* 라벨을 블록 요소로 만들어 다음 입력 필드와 분리 */
        margin-bottom: 8px; /* 라벨과 입력 필드 사이 간격 */
        font-weight: bold; /* 글자 두껍게 */
        color: #555; /* 라벨 색상 */
        font-size: 1rem;
    }

    .drink-update-form-section input[type="text"],
    .drink-update-form-section input[type="number"],
    .drink-update-form-section textarea {
        width: 100%; /* 너비 100% (부모 div 기준) */
        padding: 12px; /* 패딩 */
        border: 1px solid #ccc;
        border-radius: 5px; /* 모서리 둥글게 */
        box-sizing: border-box; /* padding과 border를 너비에 포함 */
        font-size: 1rem;
        transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out; /* 전환 효과 */
    }

    .drink-update-form-section input[type="text"]:focus,
    .drink-update-form-section input[type="number"]:focus,
    .drink-update-form-section textarea:focus {
        border-color: #5a67d8; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 아웃라인 제거 */
        box-shadow: 0 0 8px rgba(90, 103, 216, 0.2); /* 은은한 그림자 추가 */
    }

    .drink-update-form-section textarea {
        resize: vertical; /* 세로 방향으로만 크기 조절 허용 */
        min-height: 100px; /* 최소 높이 설정 */
    }

    /* 현재 이미지 미리보기 스타일 */
    .drink-update-form-section .current-image-preview {
        max-width: 150px; /* 이미지 최대 너비 */
        height: auto; /* 비율 유지 */
        display: block; /* 블록 요소로 만들어 아래 요소와 분리 */
        margin-top: 10px; /* 상단 여백 */
        border: 1px solid #eee; /* 이미지 테두리 */
        border-radius: 5px; /* 모서리 둥글게 */
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
    }

    /* 파일 입력 필드 스타일 (직접 꾸미기는 어려움, 라벨을 꾸미는 방식 선호) */
     /* .drink-update-form-section input[type="file"] { ... } */


    /* 버튼 스타일 */
    .drink-update-form-section button[type="submit"] {
        display: inline-block; /* 인라인 블록 요소 */
        margin-top: 10px; /* 위쪽 여백 */
        background-color: #444; /* 수정 버튼 색상 (녹색 계열) */
        color: white; /* 글자색 */
        padding: 12px 25px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 1.1rem; /* 글자 크기 약간 크게 */
        transition: background-color 0.2s ease-in-out;
    }

    .drink-update-form-section button[type="submit"]:hover {
        background-color: #777; /* 호버 시 배경색 변경 */
    }
.file-upload-wrapper {
    display: flex;
    align-items: center;
}

.file-upload-label {
    display: inline-block;
    background-color: #555 !important;
    color: #ffffff !important; /* 명확하게 설정 */
    padding: 10px 18px;
    font-size: 0.95rem;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
    text-align: center;
    white-space: nowrap;
}



.file-upload-input {
    display: none;
}


</style>

</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="drink-update-form-section"> <%-- 드링크 수정 폼 섹션 시작 --%>

    <h2>드링크 수정</h2>

    <form action="${pageContext.request.contextPath}/drinkUpdate.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="drinkId" value="${drink.drinkId}" />

        <div> <%-- 각 입력 필드를 div로 감싸서 스타일 적용 용이하게 --%>
            <label for="name">드링크명 (NAME):</label><br/>
            <input type="text" id="name" name="name" value="${drink.name}" maxlength="200" required />
        </div>

        <div>
            <label for="alcoholContent">도수 (ALCOHOL_CONTENT):</label><br/>
            <input type="number" id="alcoholContent" name="alcoholContent" step="0.1" min="0" value="${drink.alcoholContent}" required />
        </div>

        <div>
            <label for="price">가격 (PRICE):</label><br/>
            <input type="number" id="price" name="price" min="0" value="${drink.price}" required />
        </div>

        <div>
            <label for="pairingFood">페어링 음식 (PAIRING_FOOD):</label><br/>
            <input type="text" id="pairingFood" name="pairingFood" maxlength="255" value="${drink.pairingFood}" />
        </div>

        <div>
            <label for="description">설명 (DESCRIPTION):</label><br/>
            <textarea id="description" name="description" maxlength="4000" rows="4">${drink.description}</textarea>
        </div>

        <div>
             <label>현재 이미지:</label><br/>
            <img id="imagePreview"
                 src="<c:choose>
                         <c:when test='${not empty drink.imageUrl}'>${drink.imageUrl}</c:when>
                         <c:when test='${empty drink.imageUrl and not empty drink.imageId}'>
                             ${pageContext.request.contextPath}/image/view.do?imageId=${drink.imageId}
                         </c:when>
                         <c:otherwise></c:otherwise>
                      </c:choose>"
                 alt="현재 이미지" class="current-image-preview" /> <%-- 이미지에 클래스 추가 --%>
        </div>

    <div>
    <label for="imageFile">이미지 변경:</label><br/>
    <div class="file-upload-wrapper">
        <label for="imageFile" class="file-upload-label">파일 선택</label>
        <input type="file" id="imageFile" name="imageFile" accept="image/*"
               onchange="previewImage(event)" class="file-upload-input" />
    </div>
</div>

        <div> <%-- 버튼도 div로 감싸서 여백 조절 --%>
            <button type="submit" class="submit-btn">수정하기</button>
             <%-- TODO: 취소 버튼 등 추가 --%>
        </div>
    </form>

</div> <%-- 드링크 수정 폼 섹션 끝 --%>

<script>
function previewImage(event) {
    const input = event.target;
    const preview = document.getElementById('imagePreview');
    
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        
        reader.onload = function(e) {
            preview.src = e.target.result;
        };
        
        reader.readAsDataURL(input.files[0]);
    }
}
</script>

<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>