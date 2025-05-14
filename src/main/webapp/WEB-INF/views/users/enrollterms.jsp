<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>이용약관 동의</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Arial', sans-serif;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .terms-container {
      background-color: rgba(255, 255, 255, 0.9);
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
      width: 700px; /* ✅ 스타일 맞춤 */
      max-height: 90vh;
      overflow-y: auto;
      text-align: center;
    }

    h2 {
      font-size: 1.5em;
      margin-bottom: 20px;
      color: #333;
    }

    textarea {
      width: 100%;
      height: 320px;
      padding: 14px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 6px;
      resize: none;
      box-sizing: border-box;
      margin-bottom: 20px;
      background: #fafafa;
    }

    .buttons {
      display: flex;
      justify-content: center;
      gap: 10px;
    }

    .buttons button {
      background-color: #444;
      color: white;
      border: none;
      padding: 10px 25px;
      font-size: 15px;
      font-weight: bold;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .buttons button:hover {
      background-color: #777;
    }
  </style>
</head>
<body>

  <div class="terms-container">
    <h2>이용약관 및 개인정보 수집 동의</h2>
    <form action="enrollPage.do" method="get">
      <textarea readonly>
[이용약관]

제1조 (목적)
본 약관은 'The Dish'(이하 '회사')가 제공하는 음식 추천, 레시피 공유, 주류 페어링 및 관련 서비스(이하 '서비스')의 이용조건과 운영에 관한 제반 사항을 규정함을 목적으로 합니다.

제2조 (회원가입)
1. 회원가입은 만 19세 이상만 가능하며, 가입 시 정확한 정보를 기재해야 합니다.
2. 동일인의 중복 가입은 제한될 수 있습니다.

제3조 (서비스 이용)
1. 서비스는 회원에게 음식 레시피 추천, 주류 정보, 건강 기반 추천 등 다양한 정보를 제공합니다.
2. 회원은 회사의 서비스를 영리 목적 없이 이용해야 하며, 타인의 정보를 도용하거나 게시판에 부적절한 내용을 등록해서는 안됩니다.

제4조 (개정관리 및 탈퇴)
1. 회원은 언제든지 탈퇴할 수 있으며, 탈퇴 시 개인정보 및 작성한 게시물은 관련 법령 및 회사 방침에 따라 처리됩니다.
2. 회사는 비정상적인 활동이 확인될 경우 이용을 제한할 수 있습니다.

제5조 (개인정보 수집 및 이용)
1. 수집 항목: 이름, 아이디, 비밀번호, 이메일, 전화번호, 연령, 성별 등 회원가입 시 입력 정보
2. 수집 목적: 사용자 식별, 맞춤형 추천 제공, 통계 분석, 문의 대응
3. 보유 기간: 회원 탈퇴 시까지, 또는 관계법령에 의거한 기간까지
4. 회사는 수집된 개인정보를 제3자에게 제공하지 않으며, 안전하게 보호합니다.
      </textarea>
      <div class="buttons">
        <button type="submit">동의하고 계속</button>
        <button type="button" onclick="history.back();">취소</button>
      </div>
    </form>
  </div>

</body>
</html>
