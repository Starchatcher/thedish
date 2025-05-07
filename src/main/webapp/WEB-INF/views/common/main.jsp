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
      color: #27ae60;
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
      const animatedEls = document.querySelectorAll('.scroll-animated-right');

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('active');
          } else {
            entry.target.classList.remove('active'); // 초기화
          }
        });
      }, { threshold: 0.3 });

      animatedEls.forEach(el => observer.observe(el));
    });
  </script>
</head>

<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="container">

  <!-- 추천 이미지 -->
 <section class="hero">
    <h2>이번주 추천 음식 (This Week’s Best)</h2>
    <%-- 컨트롤러에서 전달받은 randomRecipe 객체와 randomRecipeImage 객체를 사용합니다. --%>
    <c:choose>
        <%-- randomRecipe 객체가 존재하고 이미지 정보 객체도 존재하는 경우 --%>
        <c:when test="${not empty randomRecipe and not empty randomRecipeImage}">
            <a href="recipeDetail.do?no=${ randomRecipe.recipeId }"> <%-- 상세 페이지 링크 --%>
                <c:choose>
                    <%-- IMAGE_URL 컬럼 값이 있는 경우 --%>
                    <c:when test="${not empty randomRecipeImage.imageUrl}">
                        <img src="${randomRecipeImage.imageUrl}" alt="${randomRecipe.name} 이미지" class="recommended-image"/> <%-- 클래스 추가 --%>
                    </c:when>
                    <%-- IMAGE_URL이 없고 IMAGE_ID가 유효한 경우 (image/view.do 사용) --%>
                    <c:when test="${not empty randomRecipeImage.imageId and randomRecipeImage.imageId != 0}">
                        <img src="${pageContext.request.contextPath}/image/view.do?imageId=${randomRecipeImage.imageId}" alt="${randomRecipe.name} 이미지" class="recommended-image"/> <%-- 클래스 추가 --%>
                    </c:when>
                    <c:otherwise>
                        <%-- 이미지 정보는 있지만 URL이나 ID가 없는 경우 (발생 가능성 낮음) --%>
                        <img src="<c:url value='/resources/images/thedishlogo.jpg'/>" alt="이미지 없음" class="recommended-image"/> <%-- 클래스 추가 --%>
                    </c:otherwise>
                </c:choose>
            </a>
             <%-- 추천 레시피의 이름과 설명 표시 --%>
             <h3>${ randomRecipe.name }</h3>
             <p>${ randomRecipe.description }</p>
        </c:when>
         <%-- 랜덤 레시피는 있지만 이미지 정보가 없는 경우 --%>
        <c:when test="${not empty randomRecipe and empty randomRecipeImage}">
            <%-- 레시피 정보는 표시하고 이미지는 기본 이미지를 사용 --%>
            <a href="recipeDetail.do?no=${ randomRecipe.recipeId }">
                <img src="<c:url value='/resources/images/default-image.png'/>" alt="이미지 없음" class="recommended-image"/> <%-- 클래스 추가 --%>
            </a>
            <h3>${ randomRecipe.name }</h3>
            <p>${ randomRecipe.description }</p>
        </c:when>
        <c:otherwise>
            <%-- 랜덤 레시피 자체를 가져오지 못한 경우 --%>
            <img src="<c:url value='/resources/images/default-image.png'/>" alt="추천 레시피 이미지 없음" class="recommended-image"/> <%-- 클래스 추가 --%>
            <h3>추천 레시피를 찾을 수 없습니다.</h3>
            <p>나중에 다시 시도해주세요.</p>
        </c:otherwise>
    </c:choose>
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
<hr>
</html>
