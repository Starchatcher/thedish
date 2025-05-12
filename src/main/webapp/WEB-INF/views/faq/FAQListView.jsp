<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Dish FAQ</title>
<style>
    body {
        font-family: Arial, sans-serif;
        padding: 20px;
        background: #f8f8f8;
    }

    h1 {
        text-align: center;
        color: #333;
    }

    #faqListContainer {
        max-width: 800px;
        margin: 40px auto;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .faq-item {
        border-bottom: 1px solid #eee;
        margin-bottom: 10px;
    }

    .question {
        font-weight: bold;
        padding: 15px 20px;
        cursor: pointer;
        background: #fefefe;
        position: relative;
    }

    .question::after {
        content: '+';
        position: absolute;
        right: 20px;
        font-size: 18px;
    }

    .faq-item.active .question::after {
        content: '-';
    }

    .answer {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease;
        padding: 0 20px;
        color: #555;
    }

    .faq-item.active .answer {
        max-height: 500px;
        padding: 15px 20px;
    }

    .admin-btns {
        margin-top: 10px;
        text-align: right;
    }

    .admin-btns form {
        display: inline;
    }

    .admin-btns button,
    .register-btn {
        background-color: #666;
        color: #fff;
        border: none;
        padding: 7px 14px;
        font-size: 13px;
        border-radius: 5px;
        cursor: pointer;
        margin-left: 5px;
    }

    .admin-btns button:hover,
    .register-btn:hover {
        background-color: #444;
    }

    .answer-text {
        white-space: pre-line;
    }

    .register-wrapper {
        text-align: center;
        margin-bottom: 30px;
    }
</style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp"/>

<h1>자주 묻는 질문 (FAQ)</h1>

<!-- 등록 버튼 -->
<c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.role eq 'ADMIN'}">
    <div class="register-wrapper">
        <button class="register-btn" onclick="location.href='FAQWrite.do';">+ FAQ 등록</button>
    </div>
</c:if>

<div id="faqListContainer">
    <c:choose>
        <c:when test="${not empty faqList}">
            <c:forEach var="faq" items="${faqList}">
                <div class="faq-item" id="faq-${faq.faqId}">
                    <div class="question" onclick="toggleFAQ(this)">Q: <span class="question-text">${faq.question}</span></div>
                    <div class="answer">
                        <div class="answer-text" id="answerText-${faq.faqId}">${faq.answer}</div>

                        <!-- 관리자 전용 버튼 -->
                        <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.role eq 'ADMIN'}">
                            <div class="admin-btns">
                                <!-- 수정 버튼: 수정 페이지 이동 -->
                                <form action="faqmoveup.do" method="get">
                                    <input type="hidden" name="no" value="${faq.faqId}">
                                    <button type="submit">수정</button>
                                </form>

                                <!-- 삭제 버튼 -->
                                <button onclick="deleteFAQ(${faq.faqId})">삭제</button>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p style="text-align:center; padding:20px;">FAQ가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp"/>

<script>
    function toggleFAQ(element) {
        const item = element.closest('.faq-item');
        item.classList.toggle('active');
    }

    function deleteFAQ(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            location.href = "faqdelete.do?Id=" + id;
        }
    }
</script>

</body>
</html>
