<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h2>드링크 수정</h2>

<form action="${pageContext.request.contextPath}/drinkUpdate.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="drinkId" value="${drink.drinkId}" />
    
    <label for="name">드링크명 (NAME):</label><br/>
    <input type="text" id="name" name="name" value="${drink.name}" maxlength="200" required /><br/><br/>
    
    <label for="alcoholContent">도수 (ALCOHOL_CONTENT):</label><br/>
    <input type="number" id="alcoholContent" name="alcoholContent" step="0.1" min="0" value="${drink.alcoholContent}" required /><br/><br/>
    
    <label for="price">가격 (PRICE):</label><br/>
    <input type="number" id="price" name="price" min="0" value="${drink.price}" required /><br/><br/>
    
    <label for="pairingFood">페어링 음식 (PAIRING_FOOD):</label><br/>
    <input type="text" id="pairingFood" name="pairingFood" maxlength="255" value="${drink.pairingFood}" /><br/><br/>
    
    <label for="description">설명 (DESCRIPTION):</label><br/>
    <textarea id="description" name="description" maxlength="4000" rows="4">${drink.description}</textarea><br/><br/>
    
    <label>현재 이미지:</label><br/>
    <img id="imagePreview" 
         src="<c:choose>
                 <c:when test='${not empty drink.imageUrl}'>${drink.imageUrl}</c:when>
                 <c:when test='${empty drink.imageUrl and not empty drink.imageId}'>
                     ${pageContext.request.contextPath}/image/view.do?imageId=${drink.imageId}
                 </c:when>
                 <c:otherwise></c:otherwise>
              </c:choose>" 
         alt="현재 이미지" width="200" /><br/><br/>
    
    <label for="imageFile">이미지 변경:</label><br/>
    <input type="file" id="imageFile" name="imageFile" accept="image/*" onchange="previewImage(event)" /><br/><br/>
    
    <button type="submit" class="submit-btn">수정하기</button>
</form>

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
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>