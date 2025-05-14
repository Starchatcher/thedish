<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>탈퇴 확인</title>
<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f9f9f9;
  }

  .container {
    max-width: 600px;
    margin: 80px auto;
    text-align: center;
    background: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
  }

  h2 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #2c3e50;
  }

  .message {
    margin-bottom: 30px;
    font-size: 16px;
    color: #555;
  }

  .buttons {
    display: flex;
    justify-content: center;
    gap: 20px;
  }

  .buttons button {
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
  }

  .buttons .confirm {
  background-color: #444; /* 어두운 회색 - 탈퇴 */
  color: white;
}

.buttons .cancel {
  background-color: #777; /* 중간 회색 - 취소 */
  color: white;
}

.buttons button:hover {
  opacity: 1;
  filter: brightness(85%); /* 살짝 어두워지는 효과 */
}
</style>
</head>
<body>

<div class="container">
  <h2>정말로 탈퇴하시겠습니까?</h2>
  <div class="message">
    <p>탈퇴하면 계정과 관련된 모든 정보가 삭제됩니다. 이 작업은 되돌릴 수 없습니다.</p>
  </div>

  <div class="buttons">
    <form action="deleteUser.do" method="post">
      <input type="hidden" name="loginId" value="${param.loginId}" />
      <button type="submit" class="confirm">확인</button>
    </form>
    <a href="myinfo.do?loginId=${param.loginId}">
      <button type="button" class="cancel">취소</button>
    </a>
  </div>
</div>

</body>
</html>
