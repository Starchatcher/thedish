<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>건강 맞춤형 추천 검색</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f7fdf8;
            color: #333;
        }

        .main-container {
            max-width: 800px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #2e7d32;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        input[type="text"] {
            padding: 12px 16px;
            width: 60%;
            border: 2px solid #c8e6c9;
            border-radius: 8px;
            font-size: 16px;
        }

        button[type="submit"] {
            padding: 12px 24px;
            background-color: #66bb6a;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #43a047;
        }

        @media (max-width: 600px) {
            input[type="text"] {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="main-container">
    <h2>예방하고 싶은 질병을 입력하세요</h2>
    <form action="recommendIngredients.do" method="get">
        <input type="text" name="condition" placeholder="예: 고혈압, 당뇨" required />
        <button type="submit">추천 재료 보기</button>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>