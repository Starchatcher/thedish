<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
  .footer {
    background-color: #f9f9f9;
    color: #333;
    padding: 40px 60px;
    font-family: 'Noto Sans KR', sans-serif;
    display: flex;
    justify-content: space-between;
    align-items: stretch; /* ✅ 높이 맞추기 */
    flex-wrap: wrap;
    border-top: 1px solid #ccc;
  }

  .footer-left {
    max-width: 50%;
  }

 .footer-left h2 {
  font-size: 28px; /* 기존 24px → 확대 */
  font-weight: 800;
  margin-bottom: 12px;
}

.footer-left p:first-of-type {
  font-size: 20px; /* “GLOBAL BEST COMPANY” */
  font-weight: bold;
  margin: 10px 0;
  
}

.footer-left p:nth-of-type(2) {
  font-size: 15px;
  line-height: 1.8;
  color: #444;
}


  .footer-right {
    text-align: right;
  }

  .footer-icons {
    margin-bottom: 10px;
  }

  .footer-icons a {
    display: inline-block;
    margin-left: 10px;
    color: #333;
    font-size: 20px;
    transition: color 0.3s ease;
  }

  .footer-icons a:hover {
    color: #2c3e50;
  }

  .footer-copy {
    font-size: 13px;
    color: #999;
  }

  @media (max-width: 768px) {
    .footer {
      flex-direction: column;
      align-items: center;
      text-align: center;
    }

    .footer-left,
    .footer-right {
      max-width: 100%;
    }

    .footer-policy-links a {
      margin: 0 6px;
    }
  }
  
  .footer-policy-links a {
  display: inline-block;
  font-size: 14px;
  color: #333;
  margin: 4px 0;
  text-decoration: none;
}

.footer-policy-links a i {
  margin-right: 6px;
  color: #2c3e50;
}
</style>

<footer class="footer">
  <div class="footer-left">
    <h2>The Dish</h2>
    <p>GLOBAL BEST COMPANY</p>
    <p>The Dish는 서비스를 제공하는 것을 넘어,<br>고객에게 깊은 감동과 즐거움을 선사하기 위해 최선을 다하고 있습니다.</p>
  </div>

  <div class="footer-right">
  <div class="footer-policy-links">
    <a href="${pageContext.request.contextPath}/terms.do" target="_blank">
      <i class="fas fa-file-contract"></i> The Dish 이용약관
    </a><br>
    <a href="${pageContext.request.contextPath}/privacy.do" target="_blank">
      <i class="fas fa-user-shield"></i> The Dish 개인정보처리방침
    </a>
  </div>
  <div class="footer-copy">
    The Dish<br>
	대표이사: 비개자<br>
	서울시 강남구 신사동00빌딩<br>
	사업자등록번호: T.02-123-4567<br>
	이메일 문의: contact@thedish.com<br>
    Copyright ©2025 The Dish, All Rights Reserved.
    
  </div>
</div>
</footer>
