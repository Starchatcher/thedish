<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색 결과</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            width: 100px; /* 이미지 크기 조정 */
            height: auto;
        }
    </style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
    <h2>검색 결과</h2>
    <table>
        <thead>
            <tr>
                <th>음료 이름</th>
                <th>가격</th>
                <th>알코올 도수</th>
                <th>이미지</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="drink" items="${drinks}">
                <tr>
                    <td>${drink.name}</td>
                    <td>${drink.price}원</td>
                    <td>${drink.alcoholContent}%</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty drink.imageUrl}">
                                <a href="drinkDetail.do?no=${drink.drinkId}">
                                    <img src="${drink.imageUrl}" alt="${drink.name}">
                                </a>
                            </c:when>
                            <c:when test="${not empty drink.imageData}">
                               <a href="drinkDetail.do?no=${drink.drinkId}">
                                    <img src="${pageContext.request.contextPath}/image/view.do?imageId=${drink.imageId}" alt="이미지" />
                                </a>
                            </c:when>
                            <c:otherwise>
                            <a href="drinkDetail.do?no=${drink.drinkId}">
                                <span>이미지 없음</span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
