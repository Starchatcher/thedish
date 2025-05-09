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
      background: #e8dcca;
      padding: 30px 20px 10px;
      font-family: 'Noto Sans KR', sans-serif;
      font-size: 18px;
      color: brown;
      border-top: 1px solid #f9e4b7;
      text-align: center;
      line-height: 1.8;
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
      color: #4e342e;
    }

    .footer-info p {
      margin: 0;
    }
  </style>
</head>
<body>



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