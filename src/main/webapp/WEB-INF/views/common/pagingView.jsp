<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <c:set var="paging" value="${ requestScope.paging }" />

 <%-- queryParams 구성 (기존 로직 유지) --%>
 <c:set var="queryParams" value="action=${action}&keyword=${keyword}&begin=${paging.startRow}&end=${paging.endRow}" />

 <c:if test="${ not empty category }">
   <c:set var="queryParams" value="${queryParams}&category=${category}" />
 </c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>페이징</title>
<style type="text/css">
.paging {
    margin: 30px auto;
    width: 650px; /* 필요에 따라 조정 */
    text-align: center;
}

.paging a, .paging span {
    display: inline-block;
    width: 30px; /* 필요에 따라 조정 */
    height: 30px; /* 필요에 따라 조정 */
    line-height: 30px;
    margin: 0 2px;
    text-align: center;
    font-size: 14px; /* 필요에 따라 조정 */
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
    cursor: default; /* 현재 페이지는 클릭되지 않도록 */
}

/* 비활성화된 스팬 스타일 */
.paging .disabled {
    color: #ccc; /* 회색 글씨 */
    border-color: #ccc; /* 회색 테두리 */
    cursor: default; /* 클릭되지 않도록 */
    background-color: #f9f9f9; /* 연한 배경색 */
}

</style>
</head>
<body>
<div class="paging">
    <%-- « (처음 페이지로) --%>
    <c:if test="${ paging.currentPage eq 1 }">
        <span class="disabled">&laquo;</span>
    </c:if>
    <c:if test="${ paging.currentPage gt 1 }">
        <a href="${ paging.urlMapping }?page=1&${ queryParams }">&laquo;</a>
    </c:if>

    <%-- < (이전 페이지 블록으로) --%>
    <c:if test="${ paging.startPage eq 1 }">
        <span class="disabled">&lt;</span> <%-- &lt; 는 < 기호 HTML 엔티티 --%>
    </c:if>
    <c:if test="${ paging.startPage gt 1 }">
         <%-- 이전 블록의 마지막 페이지 (현재 블록 시작 페이지 - 1) 로 이동 --%>
        <a href="${ paging.urlMapping }?page=${ paging.startPage - 1 }&${ queryParams }">&lt;</a>
    </c:if>

    <%-- 페이지 번호 (현재 블록) --%>
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

    <%-- > (다음 페이지 블록으로) --%>
    <c:if test="${ paging.endPage eq paging.maxPage }">
        <span class="disabled">&gt;</span> <%-- &gt; 는 > 기호 HTML 엔티티 --%>
    </c:if>
     <c:if test="${ paging.endPage lt paging.maxPage }">
         <%-- 다음 블록의 첫 페이지 (현재 블록 끝 페이지 + 1) 로 이동 --%>
        <a href="${ paging.urlMapping }?page=${ paging.endPage + 1 }&${ queryParams }">&gt;</a>
    </c:if>

    <%-- » (마지막 페이지로) --%>
    <c:if test="${ paging.currentPage eq paging.maxPage }">
        <span class="disabled">&raquo;</span> <%-- &raquo; 는 » 기호 HTML 엔티티 --%>
    </c:if>
    <c:if test="${ paging.currentPage lt paging.maxPage }">
        <a href="${ paging.urlMapping }?page=${ paging.maxPage }&${ queryParams }">&raquo;</a>
    </c:if>
</div>
</body>
</html>
