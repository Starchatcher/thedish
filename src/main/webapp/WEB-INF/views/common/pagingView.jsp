<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 
 <c:set var="paging" value="${ requestScope.paging }" />

<c:set var="queryParams" value="action=${action}&keyword=${keyword}&begin=${paging.startRow}&end=${paging.endRow}" />

<c:if test="${ not empty category }">
  <c:set var="queryParams" value="${queryParams}&category=${category}" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.paging {
    margin: 30px auto;
    width: 650px;
    text-align: center;
}

.paging a, .paging span {
    display: inline-block;
    width: 30px;
    height: 30px;
    line-height: 30px;
    margin: 0 2px;
    text-align: center;
    font-size: 14px;
    border: 1px solid #8FBC8F; /* 연한 초록 테두리 */
    border-radius: 6px;
    color: #8FBC8F; /* 초록색 글씨 */
    text-decoration: none;
    transition: all 0.3s ease;
    background-color: #fff; /* 기본은 흰색 */
}

.paging a:hover {
    background-color: #8FBC8F; /* hover 시 초록색 채워짐 */
    color: #fff; /* 글자색은 흰색으로 */
}

.paging .current-page {
    background-color: #8FBC8F; /* 현재 페이지는 초록색 */
    color: #fff;
    font-weight: bold;
}

</style>
</head>
<body>
<div class="paging">
    <c:if test="${ paging.currentPage eq 1 }">
        <span>«</span>
    </c:if>
    <c:if test="${ paging.currentPage gt 1 }">
        <a href="${ paging.urlMapping }?page=1&${ queryParams }">«</a>
    </c:if>

    <c:forEach begin="${ paging.startPage }" end="${ paging.endPage }" var="p">
        <c:choose>
            <c:when test="${ p eq paging.currentPage }">
                <span class="current-page">${ p }</span>
            </c:when>
            <c:otherwise>
                <a href="${ paging.urlMapping }?page=${ p }&${ queryParams }">${ p }</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${ paging.currentPage eq paging.maxPage }">
        <span>»</span>
    </c:if>
    <c:if test="${ paging.currentPage lt paging.maxPage }">
        <a href="${ paging.urlMapping }?page=${ paging.maxPage }&${ queryParams }">»</a>
    </c:if>
</div>
</body>
</html>