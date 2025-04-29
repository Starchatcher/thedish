<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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

</body>
</html>