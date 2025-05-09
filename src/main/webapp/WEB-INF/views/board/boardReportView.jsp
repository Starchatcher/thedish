<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 신고</title>
<style>
.report-form .label-wrapper {
    display: flex;
    align-items: center;
    height: 32px; /* label 높이 영역 고정 */
}

.report-form .label-wrapper label {
    font-weight: bold;
    font-size: 15px;
}

.report-form {
    max-width: 800px;
    margin: 60px auto;
    padding: 30px;
    background-color: #fdfdfd;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    font-family: 'Arial', sans-serif;
}

.report-form h2 {
    font-size: 22px;
    margin-bottom: 20px;
    color: #444;
}

.report-form textarea {
    width: 100%;                /* 양쪽 꽉 채움 */
    padding: 10px 12px;         /* 내부 여백: 상하 10px, 좌우 12px */
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
    resize: vertical;
    margin-bottom: 20px;
    margin-top: 10px;
    box-sizing: border-box;     /* padding 포함한 전체 크기로 계산 */
    line-height: 1.5;
}

.report-form button {
    background-color: #d9534f;
    color: white;
    border: none;
    padding: 10px 18px;
    border-radius: 6px;
    font-size: 15px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.report-form button:hover {
    background-color: #c9302c;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="report-form">
    <h2>🚨 게시글 신고</h2>
    
    <form action="boardReportInsert.do" method="post">
        <input type="hidden" name="targetId" value="${param.targetId}">
        <input type="hidden" name="category" value="${param.category}">
        
        <div class="label-wrapper">
		    <label for="reason">신고 사유</label>
		</div>
        <textarea name="reason" id="reason" rows="6" required placeholder="신고 사유를 작성해주세요."></textarea><br/>

        <button type="submit">신고 제출</button>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />	
</body>
</html>