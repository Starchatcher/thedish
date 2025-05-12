
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Dish FAQ</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f8f8f8;
    }

    h1 {
        color: #333;
        text-align: center;
        margin-bottom: 30px;
    }

    #faqListContainer {
        max-width: 800px;
        margin: 20px auto;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    .faq-item {
        border-bottom: 1px solid #eee;
    }
    .faq-item:last-child {
        border-bottom: none;
    }

    .question {
        font-weight: bold;
        color: #555;
        padding: 15px 20px;
        cursor: pointer;
        background-color: #fefefe;
        position: relative;
        transition: background-color 0.3s ease;
    }

    .question:hover {
        background-color: #f0f0f0;
    }

    .question::after {
        content: '+';
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 1.2em;
        transition: transform 0.3s ease;
        color: #888;
    }

    .faq-item.active .question {
        background-color: #f0f0f0;
    }
    .faq-item.active .question::after {
        content: '-';
        transform: translateY(-50%) rotate(0deg);
        color: #333;
    }

    .answer {
        margin-top: 0;
        padding: 0 20px;
        color: #777;
        background-color: #fff;
        overflow: hidden;
        max-height: 0;
        transition: max-height 0.5s ease-out, padding 0.5s ease-out;
    }

    .faq-item.active .answer {
         max-height: 2000px;
         padding: 15px 20px;
    }

    #faqListContainer p {
        text-align: center;
        padding: 20px;
        color: #777;
    }

    .admin-btns {
        text-align: right;
        padding: 5px 20px 10px;
    }

    .admin-btns button {
        background-color: #333;
        color: white;
        border: none;
        padding: 5px 10px;
        margin-left: 5px;
        border-radius: 4px;
        font-size: 0.9em;
        cursor: pointer;
    }

    .admin-btns button:hover {
        background-color: #666;
    }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"></c:import>

<h1>자주 묻는 질문 (FAQ)</h1>

<center>
<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.role eq 'ADMIN' }">
    <button onclick="location.href='${ pageContext.servletContext.contextPath }/FAQWrite.do';">faq 등록</button>
</c:if>
</center>

<div id="faqListContainer">
    <c:choose>
        <c:when test="${not empty faqList}">
            <c:forEach var="faq" items="${faqList}">
                <div class="faq-item">
                    <div class="question">
                        Q: <c:out value="${faq.question}"/>
                    </div>
                    <div class="answer">
                        A: <c:out value="${faq.answer}"/>
                        <c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.role eq 'ADMIN' }">
                            <div class="admin-btns">
                                <button onclick="location.href='faqmoveup.do?no=${faq.faqId}'">수정</button>
                                <button onclick="location.href='faqdelete.do?Id=${faq.faqId}'">삭제</button>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>등록된 FAQ가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<script>
    document.querySelectorAll('.question').forEach(item => {
        item.addEventListener('click', event => {
            const faqItem = item.closest('.faq-item');
            faqItem.classList.toggle('active');
            document.querySelectorAll('.faq-item.active').forEach(openItem => {
                if (openItem !== faqItem) {
                     openItem.classList.remove('active');
                }
            });
        });
    });
</script>
<c:import url="/WEB-INF/views/common/footer.jsp"></c:import>
</body>
</html>
