<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 수정</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        .container {
            max-width: 800px;
            margin: 60px auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #333;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            margin-top: 20px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #fefefe;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            height: 200px;
        }

        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 30px;
        }

        .btn {
            background-color: #666;
            color: white;
            border: none;
            padding: 10px 22px;
            font-size: 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .file-box {
            margin-top: 20px;
        }

        input[type="file"] {
            border: none;
        }

    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp"/>

<div class="container">
    <h2>FAQ 수정</h2>

    <form action="faqupdate.do" method="post">
        <input type="hidden" name="faqId" value="${faq.faqId}" />

        <label for="question">질문</label>
        <input type="text" id="question" name="question" value="${faq.question}" required />

        <label for="answer">답변</label>
        <textarea id="answer" name="answer" required>${faq.answer}</textarea>

        <%-- 선택적 파일첨부 영역 예시 (현재는 FAQ에 파일 연동 안된 경우 생략 가능) --%>
        <!--
        <div class="file-box">
            <label for="file">파일 첨부</label>
            <input type="file" name="uploadFile" id="file">
        </div>
        -->

        <div class="btn-group">
            <button type="submit" class="btn">수정</button>
            <button type="button" class="btn" onclick="history.back();">취소</button>
        </div>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
