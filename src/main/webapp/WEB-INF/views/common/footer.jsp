<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>The Dish - 음식과 술 추천</title>
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    footer {
      background: #222020;
      padding: 30px 40px 10px;
      font-family: 'Noto Sans KR', sans-serif;
      font-size: 20px;
      color: black;
      border-top: 1px solid black;
      margin-top: auto;
    }

    .footer-container {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      flex-wrap: wrap;
      text-align: center;
    }

    .footer-info {
      flex: 1;
      line-height: 1.8;
      color: #C8C8C8;
    }

    .footer-info p {
      margin: 0;
    }
  </style>
</head>
<body>

  <!-- (본문 내용이 있다면 여기에 작성) -->

  <footer>
    <div class="footer-container">
      <div class="footer-info">
        <p>
          The Dish<br>
          대표이사:비밀<br>
          서울시 강남구 신사동00빌딩<br>
          T.02-123-4567 TheDish@gmail.com<br>
        </p>
      </div>
    </div>
  </footer>

</body>
</html>