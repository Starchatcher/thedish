<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>The Dish Introduce</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #fdfdfd;
      color: #333;
      margin: 0;
      padding: 0;
      line-height: 1.8;
    }

    section {
      max-width: 1000px;
      margin: 80px auto;
      padding: 20px;
    }

    section img {
      max-width: 100%;
      border-radius: 12px;
      margin-bottom: 20px;
    }

    section h2 {
      font-size: 26px;
      margin-bottom: 16px;
      color: #2c3e50;
    }

    section p {
      font-size: 16px;
      color: #444;
    }

    /* 애니메이션 */
    .scroll-animated {
      opacity: 0;
      transform: translateY(50px);
      transition: all 0.8s ease;
    }

    .scroll-animated.active {
      opacity: 1;
      transform: translateY(0);
    }

    /* 하단 여백 */
    body::after {
      content: '';
      display: block;
      height: 300px;
    }

    @media (max-width: 768px) {
      section {
        padding: 20px 15px;
      }
    }
  </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<!-- 1. 인트로 배너 + 인삿말 -->
<section class="scroll-animated">
  <img src="<c:url value='/resources/images/thedishlogo.jpg'/>" alt="The Dish 메인 배너">
  <h2>맛있게 먹고, 건강하게 마시고, 즐겁게 나누다 – The Dish</h2>
  <p>
    당신의 식탁을 더욱 특별하게 만들어줄 공간, The Dish에 오신 것을 환영합니다.<br>
    여기는 단순한 음식 추천이 아닌, 건강, 기분, 상황에 맞춘 섬세한 매칭이 함께하는 커뮤니티입니다.
  </p>
</section>

<!-- 2. 건강 맞춤형 추천 기능 -->
<section class="scroll-animated">
  <img src="<c:url value='/resources/images/healthfood.jpg'/>" alt="건강 맞춤 추천">
  <h2>건강을 위한 맞춤형 한 끼 추천</h2>
  <p>
    알레르기, 질병, 영양 상태 등 나의 건강 정보에 기반해 최적의 식단을 추천받을 수 있습니다.<br>
    The Dish는 사용자별 프로필을 분석하여, 단순한 '맛'을 넘어선 '건강한 한 끼'를 제공합니다.
  </p>
</section>

<!-- 3. 술 페어링 추천 기능 -->
<section class="scroll-animated">
  <img src="<c:url value='/resources/images/drink.jpg'/>" alt="술 페어링 추천">
  <h2>술과 어울리는 최고의 음식 조합</h2>
  <p>
    와인, 위스키, 맥주 등 다양한 술 종류에 따라 어울리는 안주와 요리를 자동으로 추천합니다.<br>
    전문 소믈리에와 요리사의 큐레이션이 반영된 페어링으로, 집에서도 특별한 경험을 누려보세요.
  </p>
</section>

<!-- 4. 커뮤니티 + FAQ -->
<section class="scroll-animated">
  <img src="<c:url value='/resources/images/community.jpg'/>" alt="커뮤니티 및 FAQ">
  <h2>함께 나누고 배우는 공간 – 커뮤니티와 FAQ</h2>
  <p>
    자유 게시판, 후기 공유, 꿀팁 모음, FAQ, 공지사항 등 다양한 커뮤니티 기능이 제공됩니다.<br>
    나만의 레시피를 공유하고, 다른 사람의 추천을 받으며, The Dish와 함께 성장하세요.
  </p>
</section>

<!-- 스크롤 애니메이션 JS -->
<script>
  window.addEventListener('DOMContentLoaded', () => {
    const animatedEls = document.querySelectorAll('.scroll-animated');
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('active');
        } else {
          entry.target.classList.remove('active');
        }
      });
    }, { threshold: 0.3 });

    animatedEls.forEach(el => observer.observe(el));
  });
</script>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>