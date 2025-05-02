<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
    body {
        font-family: Arial, sans-serif; /* 기본 폰트 설정 */
        line-height: 1.6;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f4; /* 배경색 */
        color: #333; /* 기본 글자색 */
    }

    h1 {
        text-align: center; /* 제목 가운데 정렬 */
        color: #333;
        margin-bottom: 30px; /* 제목 아래 여백 */
    }

    form {
        max-width: 600px; /* 폼 최대 너비 */
        margin: 20px auto; /* 가운데 정렬 및 상하 여백 */
        padding: 30px;
        background: #fff; /* 폼 배경색 */
        border-radius: 8px; /* 모서리 둥글게 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }

    label {
        display: block; /* 라벨을 블록 요소로 만들어 위아래로 배치 */
        margin-bottom: 8px; /* 라벨 아래 여백 */
        font-weight: bold; /* 라벨 글자 굵게 */
        color: #555; /* 라벨 색상 */
    }

    input[type="text"],
    input[type="number"],
    textarea {
        display: block; /* 입력 필드들을 블록 요소로 */
        width: 100%; /* 부모 요소 너비에 맞춤 */
        padding: 10px;
        margin-bottom: 20px; /* 입력 필드 아래 여백 */
        border: 1px solid #ccc; /* 테두리 */
        border-radius: 4px; /* 테두리 모서리 둥글게 */
        box-sizing: border-box; /* padding이 너비에 포함되도록 설정 */
        font-size: 1rem; /* 폰트 크기 */
    }

    textarea {
        resize: vertical; /* 세로 방향으로만 크기 조절 가능 */
    }

    input[type="file"] {
        display: block;
        margin-bottom: 20px;
    }

    /* 필수 입력 필드 표시 (*) 스타일은 HTML 인라인 스타일로 이미 적용되어 있습니다. */

    button[type="submit"] {
        display: block;
        width: 100%; /* 버튼 너비 전체 */
        padding: 12px 20px;
        background-color: #5cb85c; /* 버튼 배경색 (초록색 계열) */
        color: white; /* 버튼 글자색 */
        border: none; /* 테두리 없음 */
        border-radius: 4px; /* 모서리 둥글게 */
        font-size: 1.1rem; /* 폰트 크기 */
        cursor: pointer; /* 마우스 오버 시 포인터 모양 변경 */
        transition: background-color 0.3s ease; /* 배경색 변경 시 부드러운 효과 */
        margin-top: 10px; /* 버튼 위 여백 */
    }

    button[type="submit"]:hover {
        background-color: #4cae4c; /* 마우스 오버 시 배경색 변경 */
    }

    button[type="submit"]:active {
        background-color: #449d44; /* 클릭 시 배경색 변경 */
    }

    /* 입력 필드 포커스 시 스타일 */
    input[type="text"]:focus,
    input[type="number"]:focus,
    textarea:focus {
        border-color: #5cb85c; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 아웃라인 제거 */
        box-shadow: 0 0 5px rgba(92, 184, 92, 0.5); /* 포커스 시 그림자 효과 */
    }

</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1>드링크 등록</h1>
<form action="${pageContext.request.contextPath}/drinkInsert.do" method="post" enctype="multipart/form-data">

    <label for="name">드링크명 (NAME) <span style="color:red">*</span>:</label>
    <input type="text" id="name" name="name" maxlength="200" required />

    <label for="alcoholContent">도수 (ALCOHOL_CONTENT) <span style="color:red">*</span>:</label>
    <input type="number" id="alcoholContent" name="alcoholContent" step="0.1" min="0" required />

    <label for="price">가격 (PRICE) <span style="color:red">*</span>:</label>
    <input type="number" id="price" name="price" min="0" required />

    <label for="pairingFood">페어링 음식 (PAIRING_FOOD):</label>
    <input type="text" id="pairingFood" name="pairingFood" maxlength="255" />

    <label for="description">설명 (DESCRIPTION):</label>
    <textarea id="description" name="description" maxlength="4000" rows="4"></textarea>

    <!-- 추천 수, 평균 평점, 조회수는 기본값 0으로 서버에서 처리하므로 숨김 필드로 관리 (필요시) -->
    <input type="hidden" id="recommendNumber" name="recommendNumber" value="0" />
    <input type="hidden" id="avgRating" name="avgRating" value="0" />
    <input type="hidden" id="viewCount" name="viewCount" value="0" />

    <!-- 이미지 업로드 필드 -->
    <label for="imageFile">이미지 업로드:</label>
    <input type="file" id="imageFile" name="imageFile" accept="image/*" />

    <button type="submit" class="submit-btn">등록하기</button>

</form>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>