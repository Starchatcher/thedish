<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 등록</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 800px;
        margin: 50px auto;
        background-color: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 6px;
        color: #34495e;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 12px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 16px;
    }

    .btn-group {
        text-align: center;
    }

    button {
        padding: 12px 24px;
        font-size: 16px;
        border: none;
        border-radius: 6px;
        background-color: #2c3e50;
        color: white;
        cursor: pointer;
    }

    button:hover {
        background-color: #1a252f;
    }
</style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<div class="container">
    <h2>📘 FAQ 등록</h2>

    <form action="faqinsert.do" method="post">
        <label for="question">질문</label>
        <input type="text" id="question" name="question" required />

        <label for="answer">답변</label>
        <textarea id="answer" name="answer" rows="6" required></textarea>

        <div class="btn-group">
            <button type="submit">등록</button>
            <button type="button" onclick="location.href='FAQList.do'">목록으로</button>
        </div>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>