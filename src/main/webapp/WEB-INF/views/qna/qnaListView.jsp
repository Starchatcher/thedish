<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 문의 목록</title>
<style>
body {
	font-family: 'Pretendard', sans-serif;
	background-color: #f9f9f9;
	padding: 40px;
}

h2 {
	text-align: center;
	margin-bottom: 30px;
	font-size: 24px;
	color: #333;
	margin-top: 50px;
}

table {
	width: 100%;
	border-collapse: collapse;
	background-color: #fff;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

th, td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #e0e0e0;
	font-size: 14px;
}

th {
	background-color: #f3f3f3;
	font-weight: bold;
}

td a {
	color: #007bff;
	text-decoration: none;
}

td a:hover {
	text-decoration: underline;
}

.status-complete {
	color: #28a745;
	font-weight: bold;
}

.status-pending {
	color: #dc3545;
	font-weight: bold;
}

.empty-row td {
	padding: 40px;
	font-size: 16px;
	color: #888;
}

.btn-wrap {
	text-align: center;
	margin-top: 30px;
}

.qna-btn {
    display: inline-block;
    padding: 10px 24px;
    font-size: 15px;
    background-color: #4A5568; /* 모던 다크 그레이 */
    color: white;
    text-decoration: none;
    border-radius: 6px;
    border: none;
    transition: background-color 0.25s ease-in-out;
}

.qna-btn:hover {
    background-color: #2D3748; /* 좀 더 어두운 그레이 */
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<h2>내 문의 목록</h2>

<table>
    <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성일</th>
            <th>답변 여부</th>
            <th>처리 상태</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="q" items="${qnaList}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td>
                    <a href="qnaDetail.do?qnaId=${q.qnaId}">
                        ${q.title}
                    </a>
                </td>
                <td><fmt:formatDate value="${q.createdAt}" pattern="yyyy-MM-dd" /></td>
                <td>
                    <c:choose>
                        <c:when test="${q.isAnswered == 'Y'}">✔</c:when>
                        <c:otherwise>✖</c:otherwise>
                    </c:choose>
                </td>
                <td class="status-${fn:toLowerCase(q.status)}">${q.status}</td>
            </tr>
        </c:forEach>

        <c:if test="${empty qnaList}">
            <tr class="empty-row">
                <td colspan="5">문의 내역이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>
<div class="btn-wrap">
    <a href="qnaWriteForm.do" class="qna-btn">문의하기</a>
</div>


<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
