<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<form action="recipeSearch.do" id="titleform" class="sform"
		method="get">
		<input type="hidden" name="action" value="title">
		<fieldset>
			<legend>검색할 제목을 입력하세요.</legend>
			<input type="search" name="keyword" size="50"> &nbsp; <input
				type="submit" value="검색">
		</fieldset>
	</form>

	<a href="moveInsertRecipePage.do">등록</a>
	<table align="center" width="500" border="1" cellspacing="0"
		cellpadding="0">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th><img></th>
			<th>설명</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="recipe">
			<tr align="center">
				<td>${ recipe.recipeId }</td>

				<td><a href="recipeDetail.do?no=${ recipe.recipeId }">${ recipe.name }</a></td>

				<td>
    <c:choose>
        <c:when test="${not empty recipe.imageUrl}">
            <img src="${recipe.imageUrl}" alt="이미지" width="100" height="80" />
        </c:when>
        <c:when test="${not empty recipe.imageId and recipe.imageId != 0}">
            <img src="${pageContext.request.contextPath}/image/view.do?imageId=${recipe.imageId}" alt="이미지" width="100" height="80" />
            
            
        </c:when>
        <c:otherwise>
            이미지 없음
        </c:otherwise>
    </c:choose>
</td>





				<td>${ recipe.description }</td>

				<td>${ recipe.viewCount }</td>
			</tr>
		</c:forEach>
	</table>
	<br>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>