<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/variable/pretendardvariable.css" rel="stylesheet" />
  <meta charset="UTF-8">
  <title>FAQ V-Menu</title>
  <style>
    .faq-fixed-wrapper {
      position: fixed;
      top: 250px;
      right: 180px;
      z-index: 999;
      text-align: center;
    }

    .faq-fixed-link {
      width: 60px;
      height: 60px;
      background-color: transparent;
      border: none;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .faq-fixed-link img {
      width: 100%;
      height: auto;
      object-fit: contain;
      filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
      transition: transform 0.3s ease;
    }

    .faq-fixed-link img:hover {
      transform: scale(1.08);
    }

    .v-menu-center {
      position: relative;
      margin-top: 10px;
      width: 100%;
    }

    .v-menu-item {
      position: absolute;
      opacity: 0;
      padding: 12px 18px;
      min-width: 110px;
      background: rgba(255, 255, 255, 0.85);
      backdrop-filter: blur(10px);
      color: #222;
      font-family: 'Pretendard Variable', sans-serif;
      font-size: 15px;
      font-weight: 500;
      border-radius: 12px;
      box-shadow: 0 8px 18px rgba(0, 0, 0, 0.15);
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      white-space: nowrap;
      pointer-events: none;
      transition: all 0.4s ease;
      top: 0;
    }

    .v-menu-item.left {
      right: 40px;
    }

    .v-menu-item.right {
      left: 40px;
    }

    .v-menu-item.show {
      opacity: 1;
      pointer-events: auto;
      transform: translateY(10px);
    }

    .v-menu-item:hover {
      background-color: rgba(255, 255, 255, 0.95);
      transform: translateY(12px);
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
    }
  </style>
</head>
<body>

<div class="faq-fixed-wrapper">
  <!-- FAQ 고정 버튼 -->
  <button class="faq-fixed-link" onclick="toggleVMenu()">
    <img src="${ pageContext.request.contextPath }/resources/images/question.png" alt="QUESTION">
  </button>

  <!-- V자 방향 메뉴 -->
  <div class="v-menu-center">
    <a href="${ pageContext.servletContext.contextPath }/qnaList.do"
       class="v-menu-item left" id="menuQna">✉️ 1:1 문의</a>

    <a href="${ pageContext.servletContext.contextPath }/FAQList.do"
       class="v-menu-item right" id="menuFaq">📄 FAQ</a>
  </div>
</div>

<script>
  function toggleVMenu() {
    const faq = document.getElementById("menuFaq");
    const qna = document.getElementById("menuQna");

    const isVisible = faq.classList.contains("show");

    faq.classList.toggle("show", !isVisible);
    qna.classList.toggle("show", !isVisible);
  }
</script>

</body>
</html>
