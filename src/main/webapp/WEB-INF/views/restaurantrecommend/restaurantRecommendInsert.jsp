<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 추천 글 작성</title>
<style>
    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        background-color: #f8f8f8;
        margin: 0;
        padding: 20px;
        color: #333;
    }

    h1 {
        text-align: center;
        margin-bottom: 30px;
    }

    form {
        max-width: 700px;
        margin: 0 auto;
        background: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    label {
        display: block;
        margin-top: 20px;
        margin-bottom: 8px;
        font-weight: bold;
        color: #444;
    }

    .required::after {
        content: " *";
        color: red;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
        box-sizing: border-box;
        background-color: #fafafa;
    }

    textarea {
        resize: vertical;
        min-height: 100px;
    }

    /* 이미지 미리보기 박스 */
    #imagePreview {
        margin-top: 10px;
        width: 150px;
        height: 150px;
        border: 1px solid #ccc;
        border-radius: 6px;
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
    }

    #previewImage {
        max-width: 100%;
        max-height: 100%;
        display: none;
    }

    /* 파일 업로드 input 숨기고 커스텀 버튼 사용 */
    input[type="file"] {
        display: none;
    }

    .custom-file-label {
        display: inline-block;
        padding: 10px 20px;
        background-color: #444;
        color: #fff;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 10px;
        transition: background-color 0.3s ease;
    }

    .custom-file-label:hover {
        background-color: #666;
    }

    /* 버튼 스타일 */
    .btn-group {
        margin-top: 30px;
        text-align: center;
    }

    .btn-group button {
        padding: 12px 30px;
        font-size: 16px;
        font-weight: bold;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        margin: 0 10px;
        transition: background-color 0.3s ease;
    }

    .btn-submit {
        background-color: #444;
        color: white;
    }

    .btn-submit:hover {
        background-color: #777;
    }

    .btn-cancel {
        background-color: #999;
        color: white;
    }

    .btn-cancel:hover {
        background-color: #777;
    }
</style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1>맛집 추천 글 작성</h1>

<form action="${pageContext.request.contextPath}/restaurantRecommendInsert.do" method="post" enctype="multipart/form-data">

    <label for="name" class="required">맛집 이름:</label>
    <input type="text" id="name" name="name" maxlength="100" required />

    <label for="phone">전화번호:</label>
    <input type="text" id="phone" name="phone" maxlength="20" />

    <label for="address">주소:</label>
    <input type="text" id="address" name="address" maxlength="200" />

    <label for="openingHours">영업 시간:</label>
    <input type="text" id="openingHours" name="openingHours" maxlength="250" />

    <label for="menu">대표 메뉴:</label>
    <input type="text" id="menu" name="menu" maxlength="500" />

    <label for="review">리뷰:</label>
    <textarea id="review" name="review" maxlength="4000" rows="6"></textarea>

    <label for="imageFile">이미지 업로드:</label>
    <label for="imageFile" class="custom-file-label">파일 선택</label>
    <input type="file" id="imageFile" name="imageFile" accept="image/*" />

    <div id="imagePreview">
        <img id="previewImage" src="#" alt="이미지 미리보기" />
    </div>

    <div class="btn-group">
        <button type="submit" class="btn-submit">등록하기</button>
        <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
    </div>
</form>

<script>
    const fileInput = document.getElementById('imageFile');
    const previewImage = document.getElementById('previewImage');

    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const label = document.querySelector('.custom-file-label');
            label.textContent = '📁 ' + file.name;

            const reader = new FileReader();
            reader.onload = function(event) {
                previewImage.src = event.target.result;
                previewImage.style.display = 'block';
            }
            reader.readAsDataURL(file);
        } else {
            previewImage.src = '#';
            previewImage.style.display = 'none';
        }
    });
</script>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>