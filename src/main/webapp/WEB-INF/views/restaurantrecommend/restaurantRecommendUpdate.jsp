<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${recommend.name} - 맛집 추천 글 수정</title>
<style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    form {
        margin-top: 20px;
        padding: 30px;
        border: 1px solid #ccc;
        border-radius: 10px;
        max-width: 700px;
        margin-left: auto;
        margin-right: auto;
        background-color: #fff;
        box-shadow: 0 6px 18px rgba(0,0,0,0.05);
    }
    form h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
    }
    label { display: block; margin-bottom: 5px; font-weight: bold; }
    input[type="text"], textarea {
        width: calc(100% - 22px);
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    textarea { resize: vertical; }
    .required::after { content: " *"; color: red; margin-left: 2px; }
    #existingImageContainer { margin-bottom: 10px; }
    #existingImageView { max-width: 150px; max-height: 150px; border: 1px solid #ccc; display: block; }

    /* ✅ 커스텀 파일 업로드 */
    .custom-file-upload {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-top: 8px;
    }

    .custom-file-upload input[type="file"] {
        display: none;
    }

    .upload-label {
        background-color: #444;
        color: white;
        padding: 10px 18px;
        font-size: 14px;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .upload-label:hover {
        background-color: #666;
    }

    #fileName {
        font-size: 14px;
        color: #555;
    }

    button.submit-btn {
        background-color: #444;
        color: white;
        font-size: 15px;
        padding: 10px 24px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        margin-right: 10px;
        transition: background-color 0.3s ease;
    }

    button.submit-btn:hover { background-color: #777; }

    button.cancel-btn {
        background-color: #cccccc;
        color: black;
        font-size: 15px;
        padding: 10px 24px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button.cancel-btn:hover { background-color: #999999; }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<form action="${pageContext.request.contextPath}/restaurantRecommendUpdate.do" method="post" enctype="multipart/form-data">
    <h2>맛집 추천 글 수정</h2>
    <input type="hidden" name="recommendId" value="${recommend.recommendId}" />

    <label for="name" class="required">맛집 이름:</label>
    <input type="text" id="name" name="name" maxlength="100" value="${recommend.name}" required />

    <label for="phone">전화번호:</label>
    <input type="text" id="phone" name="phone" maxlength="20" value="${recommend.phone}" />

    <label for="address">주소:</label>
    <input type="text" id="address" name="address" maxlength="200" value="${recommend.address}" />

    <label for="openingHours">영업 시간:</label>
    <input type="text" id="openingHours" name="openingHours" maxlength="250" value="${recommend.openingHours}" />

    <label for="menu">대표 메뉴:</label>
    <input type="text" id="menu" name="menu" maxlength="500" value="${recommend.menu}" />

    <label for="review">리뷰:</label>
    <textarea id="review" name="review" maxlength="4000" rows="8">${recommend.review}</textarea>

    <label>현재 이미지:</label>
    <div id="existingImageContainer">
        <c:choose>
            <c:when test="${not empty recommend.imageUrl}">
                <img id="existingImageView" src="${recommend.imageUrl}" alt="${recommend.name} 이미지" />
            </c:when>
            <c:when test="${not empty recommend.imageId and recommend.imageId != 0}">
                <img id="existingImageView" src="${pageContext.request.contextPath}/image/view.do?imageId=${recommend.imageId}" alt="현재 이미지" />
            </c:when>
            <c:otherwise>
                <span>등록된 이미지가 없습니다.</span>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ✅ 커스텀 파일 업로드 -->
    <label for="imageFile">새 이미지 업로드:</label>
    <div class="custom-file-upload">
        <label for="imageFile" class="upload-label">파일 선택</label>
        <span id="fileName">선택된 파일 없음</span>
        <input type="file" id="imageFile" name="imageFile" accept="image/*" />
    </div>

    <div style="margin-top: 30px;">
        <button type="submit" class="submit-btn">수정 완료</button>
        <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
    </div>
</form>

<script>
    // 파일 이름 표시
    document.getElementById('imageFile').addEventListener('change', function(e) {
        const file = e.target.files[0];
        document.getElementById('fileName').textContent = file ? file.name : '선택된 파일 없음';
    });
</script>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
