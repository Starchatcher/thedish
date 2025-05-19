<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>The Dish main</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 0;
      background-color:#ffffff;;
    }

    .container {
      max-width: 1100px;
      margin: 60px auto;
      padding: 0 20px;
    }

    /* 추천 이미지 (상단 Hero 스타일) */
   .hero {
  margin: 80px 0;
  text-align: center;
  margin-top: 200px;
}

    .hero h2 {
      font-size: 28px;
      margin-bottom: 30px;
      color: #2c3e50;
    }

    .hero img {
      max-width: 100%;
      border-radius: 12px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
    }

    .hero img:hover {
      transform: scale(1.02);
    }

    /* 인삿말 섹션 */
   .introduce {
  display: flex;
  gap: 50px;
  align-items: center;
  flex-wrap: wrap;
  margin-bottom: 100px;
}

    .introduce-text {
      flex: 1 1 480px;
    }

    .introduce-subtitle {
      color: #7c6f42;
      font-weight: 600;
      margin-bottom: 16px;
    }

    .introduce-title {
      font-size: 30px;
      font-weight: 800;
      margin-bottom: 20px;
      color: #222;
      line-height: 1.5;
    }

    .introduce-description {
      font-size: 16px;
      line-height: 1.8;
      color: #444;
    }

    .more-button {
      display: inline-block;
      margin-top: 24px;
      padding: 10px 22px;
      font-size: 15px;
      color: #7c6f42;
      border: 1.5px solid #7c6f42;
      background-color: transparent;
      border-radius: 4px;
      text-decoration: none;
      transition: all 0.3s ease;
    }

    .more-button:hover {
      background-color: #7c6f42;
      color: white;
    }

    .mainfood {
      flex: 1 1 480px;
    }

    .mainfood img {
      width: 100%;
      border-radius: 12px;
      object-fit: cover;
    }

    /* 공지사항 */
   .notice {
  margin-top: 40px;
  margin-bottom: 80px;
  background: #ffffff;
  padding: 25px 30px;
  border-radius: 16px;
  box-shadow: 0 6px 16px rgba(0,0,0,0.08);
}

    .notice h3 {
      text-align: center;
      color: black;
      margin-bottom: 20px;
      font-size: 20px;
      border-bottom: 2px solid #e0e0e0;
      padding-bottom: 10px;
    }

    .notice table {
      width: 100%;
      font-size: 14px;
      border-collapse: collapse;
    }

    .notice th, .notice td {
      border-bottom: 1px solid #ecf0f1;
      padding: 10px;
      text-align: center;
    }

    .notice th {
      background-color: #f5f5f5;
      color: #333;
      font-weight: bold;
    }

    .notice td a {
      text-decoration: none;
      color: #34495e;
    }

    .notice td a:hover {
      color: #2980b9;
      text-decoration: underline;
    }

    /* 애니메이션: 오른쪽에서 등장 */
    .scroll-animated-right {
      opacity: 0;
      transform: translateX(100px);
      transition: all 0.8s ease;
    }

    .scroll-animated-right.active {
      opacity: 1;
      transform: translateX(0);
    }

    @media (max-width: 768px) {
      .our-story {
        flex-direction: column;
      }
    }
    
    .hero .recommended-image {
    width: 400px; /* 또는 원하는 너비 (px, %, vw 등) */
    height: 300px; /* 또는 원하는 높이 */
    object-fit: cover; /* 이미지가 잘리지 않고 비율을 유지하며 지정된 크기에 맞게 채워지도록 함 */
    display: block; /* 이미지를 블록 요소로 만들어 레이아웃에 영향을 덜 받게 함 */
    margin: 0 auto; /* 가운데 정렬 (옵션) */
}

/* 상단 히어로 메시지 섹션 */
.main-hero {
  background-image: url('<c:url value="resources/images/mainfood.jpeg"/>');
  background-size: cover;
  background-position: center;
  padding: 130px 0px; /* 위아래 넉넉한 여백 */
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.hero-overlay {
  width: 100%;
  height: 180%;
  background-color: rgba(0, 0, 0, 0.45); /* 어두운 반투명 배경 */
  display: flex;
  align-items: center;
  justify-content: center;
}

.hero-text {
  color: #fff;
  text-align: center;
  padding: 20px;
}

.hero-text h1 {
  font-size: 48px;
  font-weight: 800;
  line-height: 1.5;
  margin-bottom: 20px;
}

.hero-text p {
  font-size: 18px;
  line-height: 1.8;
}

/* Join Us 특징 소개 섹션 */
.join-us {
  background-color: #fff;
  padding: 80px 0;
  border-top: 1px solid #eee;
}

.join-us-container {
  max-width: 1100px;
  margin: 0 auto;
  display: flex;
  flex-wrap: wrap;
  gap: 40px;
  padding: 0 20px;
}

.join-us-left {
  flex: 1;
  min-width: 200px;
  text-align: left;
}

.join-us-left .dot {
  width: 14px;
  height: 14px;
  background-color: #fbb03b;
  border-radius: 50%;
  display: inline-block;
  margin-right: 10px;
  vertical-align: middle;
}

.join-us-left h2 {
  display: inline-block;
  font-size: 28px;
  font-weight: 800;
  margin-bottom: 10px;
}

.join-us-left p {
  font-size: 20px;
  color: #8d939a;
  font-weight: 600;
  line-height: 1.6;
}

.join-us-right {
  flex: 2;
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.feature-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid #333;
  padding-top: 20px;
}

.feature-text {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.feature-text strong {
  font-size: 16px;
  font-weight: 700;
  color: #000;
}

.feature-text span {
  font-size: 14px;
  color: #333;
}

.feature-btn {
  background-color: #111;
  color: #fff;
  padding: 10px 20px;
  font-size: 14px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.feature-btn:hover {
  background-color: #444;
}


/* 초기 상태 */
.dot.scroll-animated-fade {
  opacity: 0;
  transform: scale(1);
  transition: opacity 0.5s ease, transform 0.5s ease;
  width: 23px;
  height: 23px;
  /* delay 제거! */
}

/* 등장 시 */
.dot.scroll-animated-fade.active {
  opacity: 1;
  transform: scale(1.5);
  transition-delay: 0.2s; /* 등장할 때만 0.5초 기다림 */
}

.title-wrapper {
  position: relative;
  display: inline-block;
}

.title-wrapper h2 {
  position: relative;
  z-index: 2;               /* 텍스트는 항상 위에 */
  margin: 0;
  font-size: 30px;
  font-weight: 800;
}

.dot {
  position: absolute;
  top: 2px;                 /* 텍스트 높이 정렬 */
  left: -4px;              /* J 뒤로 절반 정도 숨김 */
  background-color: #fbb03b;
  border-radius: 50%;
  z-index: 1;               /* 텍스트 뒤로 */
  opacity: 0;
 
}

.dot.active {
  opacity: 1;
  transform: scale(1);      /* 등장 시 자연스럽게 커짐 */

}

 .recommend-card {
    max-width: 480px;
    margin: 0 auto;
    padding: 24px;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12); /* 강조된 그림자 */
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }

  .recommend-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 16px 36px rgba(0, 0, 0, 0.16); /* hover 시 더 진하게 */
  }

  .recommend-card img {
    width: 100%;
    height: 260px;
    object-fit: cover;
    border-radius: 12px;
    margin-bottom: 20px;
  }

  .recommend-card h3 {
    font-size: 22px;
    color: #2c3e50;
    margin-bottom: 10px;
  }

  .recommend-card p {
    font-size: 15px;
    color: #666;
    margin: 0;
  }
  </style>

  <script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
  <script>
    $(function(){
      $.ajax({
        url: 'ntop10.do',
        type: 'post',
        dataType: 'json',
        success: function(data){
          let values = '';
          for(let i = 0; i < data.length; i++){
            values += '<tr><td>' + data[i].noticeId 
              + '</td><td><a href="ndetail.do?no=' + data[i].noticeId + '">' + data[i].title 
              + '</a></td><td>' + data[i].createdAt + '</td></tr>';
          }
          $('#newnotice tbody').append(values);
        },
        error: function(xhr, status, error){
          console.log('error:', xhr, status, error);
        }
      });
    });

 // 스크롤 애니메이션 제어
    window.addEventListener('DOMContentLoaded', () => {
      const animatedEls = document.querySelectorAll('.scroll-animated-right, .scroll-animated-fade');

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('active');
          } else {
            entry.target.classList.remove('active'); // 반복적으로 보여주고 싶을 경우
          }
        });
      }, { threshold: 0.3 });

      animatedEls.forEach(el => observer.observe(el));
    });
 

    function requireLogin() {
      alert("로그인이 필요한 기능입니다.");
        alert("로그인 페이지로 이동합니다.");
        location.href = "${pageContext.request.contextPath}/loginPage.do";
      
    }

  </script>
  
</head>

<body>


<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />



<!-- 메인 히어로 메시지 섹션 -->
<section class="main-hero">
  <div class="hero-overlay">
    <div class="hero-text">
      <h1>맛있는 건강의 시작<br>The Dish와 함께하세요</h1>
      <p>
        우리는 건강을 위한 음식 추천과 술 페어링을 제공합니다.<br>
        다양한 레시피와 정보를 통해 당신의 식탁을 더욱 풍성하게 만들어 드립니다.
      </p>
    </div>
  </div>
</section>


<div class="container">

  <!-- 추천 이미지 -->
 <section class="hero">
  <h2>The Dish 추천 음식</h2>
  <div class="recommend-card">
    <c:choose>
      <c:when test="${not empty randomRecipe}">
        <a href="recipeDetail.do?no=${ randomRecipe.recipeId }">
          <c:choose>
            <c:when test="${not empty randomRecipeImage.imageUrl}">
              <img src="${randomRecipeImage.imageUrl}" alt="${randomRecipe.name} 이미지" />
            </c:when>
            <c:when test="${not empty randomRecipeImage.imageId and randomRecipeImage.imageId != 0}">
              <img src="${pageContext.request.contextPath}/image/view.do?imageId=${randomRecipeImage.imageId}" alt="${randomRecipe.name} 이미지" />
            </c:when>
            <c:otherwise>
              <img src="<c:url value='/resources/images/default-image.png'/>" alt="이미지 없음" />
            </c:otherwise>
          </c:choose>
        </a>
        <h3>${ randomRecipe.name }</h3>

      </c:when>
      <c:otherwise>
        <img src="<c:url value='/resources/images/default-image.png'/>" alt="추천 레시피 이미지 없음" />
        <h3>추천 레시피를 찾을 수 없습니다.</h3>
        <p>나중에 다시 시도해주세요.</p>
      </c:otherwise>
    </c:choose>
  </div>
</section>

  <!-- 인삿말 -->
  <section class="introduce">
    <div class="introduce-text">
      <p class="introduce-subtitle">The-Dish</p>
      <h3 class="introduce-title">우리는 맛과 건강을<br>중시하는 커뮤니티로<br>성장하고 있습니다</h3>
      <p class="introduce-description">
        우리는 건강을 위한 맞춤형 음식 추천을 제공합니다.<br>
        다양한 술과 어울리는 요리를 통해 고객의 맛과 건강을 동시에 만족시킵니다.
      </p>
      <a href="theDishIntroduce.do" class="more-button">자세히 보기</a>
    </div>
    <div class="mainfood scroll-animated-right">
      <img src="<c:url value='/resources/images/mainfood.jpg'/>" alt="음식사진">
    </div>
  </section>
  

<!-- Join Us 특징 섹션 -->
<section class="join-us">
  <div class="join-us-container">
   <div class="join-us-left">
  <div class="title-wrapper">
    <div class="dot scroll-animated-fade"></div>
      <h2>Join Us</h2>
      </div>
      <p>The Dish를<br>즐기는 방법</p>
    </div>
    <div class="join-us-right">
      <div class="feature-row">
        <div class="feature-text">
          <strong>건강 맞춤형 추천</strong>
          <span>건강과 맛 동시에 챙기고 싶나요?</span>
        </div>
        <!-- 건강 맞춤형 추천 -->
<c:choose>
  <c:when test="${not empty sessionScope.loginUser}">
    <button class="feature-btn" onclick="location.href='healthSearchForm.do'">지금 시작하기</button>
  </c:when>
  <c:otherwise>
    <button class="feature-btn" onclick="requireLogin()">지금 시작하기</button>
  </c:otherwise>
</c:choose>
      </div>
      <div class="feature-row">
        <div class="feature-text">
          <strong>술 페어링 추천</strong>
          <span>술에 어울리는 음식을 원하시나요?</span>
        </div>
        <!-- 술 페어링 추천 -->
<c:choose>
  <c:when test="${not empty sessionScope.loginUser}">
    <button class="feature-btn" onclick="location.href='drinkSearchForm.do'">지금 시작하기</button>
  </c:when>
  <c:otherwise>
    <button class="feature-btn" onclick="requireLogin()">지금 시작하기</button>
  </c:otherwise>
</c:choose>
      </div>
      <div class="feature-row">
        <div class="feature-text">
          <strong>커뮤니티</strong>
          <span>여러분들만의 시간이 필요하신가요?</span>
        </div>
        <button class="feature-btn" onclick="location.href='boardList.do'">지금 시작하기</button>
      </div>
      <div class="feature-row">
        <div class="feature-text">
          <strong>FAQ</strong>
          <span>사이트에 질문사항이 생기셨나요?</span>
        </div>
        <button class="feature-btn"onclick="location.href='FAQList.do'">자세히 보기</button>
      </div>
    </div>
  </div>
</section>

  <!-- 공지사항 -->
  <section class="notice">
    <h3>The Dish 공지사항</h3>
    <table id="newnotice">
      <thead>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody>
        <!-- AJAX로 삽입 -->
      </tbody>
    </table>
  </section>

</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
