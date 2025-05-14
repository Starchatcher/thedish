<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${recommend.name} - 맛집 추천 글 수정</title> <%-- 글 이름에 따라 타이틀 변경 --%>
<%-- 필요한 CSS 또는 스타일 링크 (작성 페이지와 동일하거나 수정) --%>
<style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    h1 { color: #333; }
    form { margin-top: 20px; padding: 20px; border: 1px solid #ccc; border-radius: 5px; max-width: 600px; margin-left: auto; margin-right: auto; }
    label { display: block; margin-bottom: 5px; font-weight: bold; }
    input[type="text"], input[type="number"], textarea { width: calc(100% - 22px); padding: 10px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
    textarea { resize: vertical; }
    button { background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px; }
    button:hover { background-color: #45a049; }
    #imagePreview { margin-top: 10px; border: 1px solid #ccc; width: 150px; height: 150px; overflow: hidden; display: flex; justify-content: center; align-items: center; }
    #previewImage { max-width: 100%; max-height: 100%; display: none; } /* 초기에는 숨김 */
    .required::after { content: " *"; color: red; margin-left: 2px; }
    /* 기존 이미지를 표시할 컨테이너 스타일 */
    #existingImageContainer { margin-bottom: 10px; }
    #existingImageView { max-width: 150px; max-height: 150px; border: 1px solid #ccc; display: block; }
</style>
</head>
<body>

<h1>맛집 추천 글 수정</h1>

<%-- action URL을 수정 처리 URL로 변경 --%>
<%-- 수정 시에는 해당 글의 ID 정보도 서버로 함께 보내야 합니다. --%>
<form action="${pageContext.request.contextPath}/restaurantRecommendUpdate.do" method="post" enctype="multipart/form-data">

    <%-- ★ 수정할 글의 ID를 숨겨서 서버로 전달합니다. ★ --%>
    <input type="hidden" name="recommendId" value="${recommend.recommendId}" />

    <%-- RESTAURANT_RECOMMEND 테이블 컬럼에 맞는 입력 필드 (기존 값 채우기) --%>
    <%-- NAME (필수) --%>
    <label for="name" class="required">맛집 이름:</label>
    <input type="text" id="name" name="name" maxlength="100" value="${recommend.name}" required /> <%-- value="${recommend.name}" 추가 --%>

    <%-- PHONE --%>
    <label for="phone">전화번호:</label>
    <input type="text" id="phone" name="phone" maxlength="20" value="${recommend.phone}" /> <%-- value="${recommend.phone}" 추가 --%>

    <%-- ADDRESS --%>
    <label for="address">주소:</label>
    <input type="text" id="address" name="address" maxlength="200" value="${recommend.address}" /> <%-- value="${recommend.address}" 추가 --%>

    <%-- OPENING_HOURS --%>
    <label for="openingHours">영업 시간:</label>
    <input type="text" id="openingHours" name="openingHours" maxlength="250" value="${recommend.openingHours}" /> <%-- value="${recommend.openingHours}" 추가 --%>

    <%-- MENU --%>
    <label for="menu">대표 메뉴:</label>
    <input type="text" id="menu" name="menu" maxlength="500" value="${recommend.menu}" /> <%-- value="${recommend.menu}" 추가 --%>

    <%-- REVIEW (CLOB) --%>
    <label for="review">리뷰:</label>
    <textarea id="review" name="review" maxlength="4000" rows="8">${recommend.review}</textarea> <%-- textarea는 value 속성 대신 태그 내용에 값을 넣습니다. --%>

    <%-- LOGIN_ID, VIEW_COUNT, LIKE_COUNT, CREATED_AT, UPDATED_AT은 서버에서 처리 --%>
    <%-- UPDATED_AT은 수정 시 현재 시간으로 업데이트됩니다. --%>

    <%-- ★ 기존 이미지 표시 영역 추가 ★ --%>
    <label>현재 이미지:</label>
    <div id="existingImageContainer">
        <c:choose>
            <c:when test="${not empty recommend.imageUrl}">
                <img id="existingImageView" src="${recommend.imageUrl}" alt="${recommend.name} 이미지" />
            </c:when>
            <%-- BLOB 이미지 출력을 위해 image/view.do 사용 (목록 조회 쿼리에서 IMAGE_ID 가져왔다면) --%>
            <c:when test="${not empty recommend.imageId and recommend.imageId != 0}">
                <img id="existingImageView" src="${pageContext.request.contextPath}/image/view.do?imageId=${recommend.imageId}" alt="현재 이미지" />
            </c:when>
            <c:otherwise>
                <span>등록된 이미지가 없습니다.</span>
            </c:otherwise>
        </c:choose>
         <%-- 이미지 삭제 옵션 (선택 사항) --%>
         <%-- <input type="checkbox" id="deleteImage" name="deleteImage" value="true"> <label for="deleteImage">이미지 삭제</label> --%>
    </div>


    <%-- ★ 새로운 이미지 업로드 필드 (기존 이미지 대체) ★ --%>
    <label for="imageFile">새 이미지 업로드 (기존 이미지 대체):</label>
    <input type="file" id="imageFile" name="imageFile" accept="image/*" />

    <%-- 새로운 이미지 미리보기 창 (새 파일 선택 시 기존 이미지 숨기고 이 영역에 표시) --%>
    <div id="imagePreview">
        <img id="previewImage" src="#" alt="새 이미지 미리보기" />
    </div>

    <br/>

    <%-- 폼 제출 버튼 --%>
    <button type="submit">수정하기</button> <%-- 버튼 텍스트 변경 --%>
    <%-- 취소 버튼 (예시: 상세 페이지로 이동) --%>
    <button type="button" onclick="location.href='restaurantRecommendDetail.do?no=${recommend.recommendId}'">취소</button> <%-- 취소 시 상세 페이지로 이동 --%>

</form>

<%-- 새로운 이미지 미리보기 JavaScript 코드 --%>
<script>
    const fileInput = document.getElementById('imageFile');
    const previewImage = document.getElementById('previewImage');
    const imagePreviewDiv = document.getElementById('imagePreview');
    const existingImageContainer = document.getElementById('existingImageContainer'); // 기존 이미지 영역

    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0]; // 선택된 파일 중 첫 번째 파일 가져오기

        if (file) {
            // 새 파일 선택 시 기존 이미지 영역 숨김
            if (existingImageContainer) { // existingImageContainer 요소가 있는지 확인
                existingImageContainer.style.display = 'none';
            }

            const reader = new FileReader();

            reader.onload = function(event) {
                previewImage.src = event.target.result;
                previewImage.style.display = 'block'; // 새 이미지 미리보기 표시
                imagePreviewDiv.style.display = 'flex'; // 미리보기 컨테이너 표시
            }

            reader.readAsDataURL(file);
        } else {
            // 파일 선택이 취소된 경우, 기존 이미지 영역 다시 표시하고 새 이미지 미리보기 숨김
             if (existingImageContainer) {
                existingImageContainer.style.display = 'block'; // existingImageContainer 요소가 있는지 확인
            }
            previewImage.src = '#';
            previewImage.style.display = 'none';
            imagePreviewDiv.style.display = 'none'; // 미리보기 컨테이너 숨김
        }
    });

     // 페이지 로드 시 초기 이미지 미리보기 컨테이너 숨김
     // 새 이미지 파일이 선택되기 전까지는 기존 이미지 영역이 보이도록
    document.addEventListener('DOMContentLoaded', function() {
        imagePreviewDiv.style.display = 'none';
    });
</script>

</body>
</html>
