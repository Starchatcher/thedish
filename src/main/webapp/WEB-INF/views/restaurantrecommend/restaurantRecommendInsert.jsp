<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 추천 글 작성</title>
<%-- 필요한 CSS 또는 스타일 링크 --%>
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
</style>
</head>
<body>

<h1>맛집 추천 글 작성</h1>

<%-- action URL과 method, enctype 설정 --%>
<form action="${pageContext.request.contextPath}/restaurantRecommendInsert.do" method="post" enctype="multipart/form-data">

    <%-- RESTAURANT_RECOMMEND 테이블 컬럼에 맞는 입력 필드 --%>
    <%-- NAME (필수) --%>
    <label for="name" class="required">맛집 이름:</label>
    <input type="text" id="name" name="name" maxlength="100" required />

    <%-- PHONE --%>
    <label for="phone">전화번호:</label>
    <input type="text" id="phone" name="phone" maxlength="20" />

    <%-- ADDRESS --%>
    <label for="address">주소:</label>
    <input type="text" id="address" name="address" maxlength="200" />

    <%-- OPENING_HOURS --%>
    <label for="openingHours">영업 시간:</label>
    <input type="text" id="openingHours" name="openingHours" maxlength="250" />

    <%-- MENU --%>
    <label for="menu">대표 메뉴:</label>
    <input type="text" id="menu" name="menu" maxlength="500" />

    <%-- REVIEW (CLOB) --%>
    <label for="review">리뷰:</label>
    <textarea id="review" name="review" maxlength="4000" rows="8"></textarea> <%-- CLOB은 크지만, textarea UI 제한 --%>

    <%-- LOGIN_ID, VIEW_COUNT, LIKE_COUNT, CREATED_AT, UPDATED_AT은 서버에서 처리 --%>

    <%-- 이미지 업로드 필드 (IMAGE 테이블 관련) --%>
    <label for="imageFile">이미지 업로드:</label>
    <input type="file" id="imageFile" name="imageFile" accept="image/*" />

    <%-- 이미지 미리보기 창 --%>
    <div id="imagePreview">
        <img id="previewImage" src="#" alt="이미지 미리보기" />
    </div>

    <br/> <%-- 필드와 버튼 사이에 간격 추가 --%>

    <%-- 폼 제출 버튼 --%>
    <button type="submit">등록하기</button>
    <%-- 취소 버튼 (예시: 이전 페이지로 이동) --%>
    <button type="button" onclick="history.back()">취소</button>

</form>

<%-- 이미지 미리보기 JavaScript 코드 --%>
<script>
    const fileInput = document.getElementById('imageFile');
    const previewImage = document.getElementById('previewImage');
    const imagePreviewDiv = document.getElementById('imagePreview'); // 미리보기 div 추가

    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0]; // 선택된 파일 중 첫 번째 파일 가져오기

        if (file) {
            


            const reader = new FileReader(); // 파일을 읽기 위한 FileReader 객체 생성

            reader.onload = function(event) {
                // 파일 읽기가 완료되면 실행될 함수
                previewImage.src = event.target.result; // 미리보기 이미지의 src를 읽어온 파일 데이터 URL로 설정
                previewImage.style.display = 'block'; // 미리보기 이미지를 보이도록 설정
            }

            reader.readAsDataURL(file); // 파일을 Data URL 형태로 읽어오기
        } else {
            // 파일 선택이 취소된 경우
            previewImage.src = '#'; // 이미지 src 초기화
            previewImage.style.display = 'none'; // 미리보기 이미지를 숨김
        }
    });
</script>

</body>
</html>
