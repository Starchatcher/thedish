<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="paging" value="${requestScope.paging}" />

<%-- queryParams 외부에서 안 넘겼을 경우 자동 구성 --%>
<c:if test="${empty queryParams}">
    <c:choose>
        <c:when test="${not empty condition}">
            <c:set var="queryParams" value="condition=${condition}" />
        </c:when>
        <c:otherwise>
            <c:set var="queryParams" value="action=${action}&keyword=${keyword}&begin=${paging.startRow}&end=${paging.endRow}" />
            <c:if test="${not empty category}">
                <c:set var="queryParams" value="${queryParams}&category=${category}" />
            </c:if>
        </c:otherwise>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>페이징</title>
<style type="text/css">
.paging {
    margin: 30px auto;
    width: 650px;
    text-align: center;
}

.paging a,
.paging span {
    display: inline-block;
    width: 32px;
    height: 32px;
    line-height: 32px;
    margin: 0 3px;
    font-size: 13px;
    text-align: center;
    color: #333;
    border: 1px solid #d0d0d0;
    border-radius: 6px;
    background-color: #fff;
    text-decoration: none;
    transition: all 0.2s ease;
}

.paging a:hover {
    background-color: #f0f0f0;
    border-color: #bbb;
    color: #000;
}

.paging .current-page {
    background-color: #e0e0e0;
    color: #000;
    font-weight: 600;
    border-color: #ccc;
    cursor: default;
}

.paging .disabled {
    color: #aaa;
    border-color: #e0e0e0;
    background-color: #f9f9f9;
    cursor: not-allowed;
}
</style>
</head>
<body>

<div class="paging">
    <!-- 처음 페이지 -->
    <c:if test="${paging.currentPage eq 1}">
        <span class="disabled">&laquo;</span>
    </c:if>
    <c:if test="${paging.currentPage gt 1}">
        <a href="${paging.urlMapping}?page=1&${queryParams}">&laquo;</a>
    </c:if>

    <!-- 이전 페이지 블록 -->
    <c:if test="${paging.startPage eq 1}">
        <span class="disabled">&lt;</span>
    </c:if>
    <c:if test="${paging.startPage gt 1}">
        <a href="${paging.urlMapping}?page=${paging.startPage - 1}&${queryParams}">&lt;</a>
    </c:if>

    <!-- 페이지 번호 -->
    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
        <c:choose>
            <c:when test="${p eq paging.currentPage}">
                <span class="current-page">${p}</span>
            </c:when>
            <c:otherwise>
                <a href="${paging.urlMapping}?page=${p}&${queryParams}">${p}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 페이지 블록 -->
    <c:if test="${paging.endPage eq paging.maxPage}">
        <span class="disabled">&gt;</span>
    </c:if>
    <c:if test="${paging.endPage lt paging.maxPage}">
        <a href="${paging.urlMapping}?page=${paging.endPage + 1}&${queryParams}">&gt;</a>
    </c:if>

    <!-- 마지막 페이지 -->
    <c:if test="${paging.currentPage eq paging.maxPage}">
        <span class="disabled">&raquo;</span>
    </c:if>
    <c:if test="${paging.currentPage lt paging.maxPage}">
        <a href="${paging.urlMapping}?page=${paging.maxPage}&${queryParams}">&raquo;</a>
    </c:if>
</div>

</body>
</html>