<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
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
				
				<td>${ recipe.name }</td>
				
				<td><c:if test="${not empty recipe.imageUrl}">
						<img src="${recipe.imageUrl}" alt="이미지" width="100" height="80" />
					</c:if></td>
				
				<td>${ recipe.instructions }</td>

				<td>${ recipe.viewCount }</td>
			</tr>
		</c:forEach>
	</table>
	<br>
</body>
</html>