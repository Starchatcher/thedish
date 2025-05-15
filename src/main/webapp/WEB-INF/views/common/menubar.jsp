<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>드롭다운 메뉴</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Arial', sans-serif;
    }

    .navbar {
      background: white;
    }

    .navbar-container {
      max-width: 1200px;
      margin: 0 auto 30px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-radius: 0 0 20px 20px;
      padding: 10px 40px;
      background-color: transparent;
      flex-wrap: wrap;
    }

    .logo img {
      height: 150px;
      width: 200px;
      filter: drop-shadow(2px 2px 3px rgba(0, 0, 0, 0.2));
    }

    .menu {
      display: flex;
      gap: 30px;
      list-style: none;
      margin: 0;
      padding: 0;
    }

    .menu > li {
      position: relative;
    }

    .menu > li > a {
      display: block;
      padding: 20px 40px;
      color: #4e342e;
      text-decoration: none;
      font-family: 'Noto Sans KR', sans-serif;
      font-weight: bold;
      font-size: 23px;
    }

    .menu > li:hover {
      background-color: gray;
    }

    .dropdown {
      position: absolute;
      top: 100%;
      left: 0;
      background-color: rgba(0, 0, 0, 0.9);
      min-width: 250px;
      padding: 20px;
      display: block;
      opacity: 0;
      visibility: hidden;
      transform: translateY(-10px);
      transition: all 0.3s ease-in-out;
      z-index: 1000;
    }

    .menu > li:hover .dropdown {
      opacity: 1;
      visibility: visible;
      transform: translateY(0px);
    }

    .dropdown-column {
      display: flex;
      flex-direction: column;
    }

    .dropdown-column h4 {
      color: white;
      margin-bottom: 10px;
      font-size: 20px;
    }

    .dropdown-column a {
      color: white;
      opacity: 1;
      text-decoration: none;
      margin-bottom: 8px;
      font-size: 14px;
    }

    .dropdown-column a:hover {
      color: #d84315;
      font-weight: bold;
    }

    .login-btn {
      background-color: black;
      color: white;
      border: none;
      padding: 8px 16px;
      cursor: pointer;
      font-size: 16px;
      border-radius: 4px;
      text-decoration: none;
    }

    .login-btn:hover {
      background-color: gray;
    }

.user-actions {
  display: flex;
  gap: 10px;
  align-items: center;
  margin-top: 6px;
}

.action-btn img {
  width: 26px;
  height: 26px;
  object-fit: contain;
  transition: transform 0.2s ease;
}

.action-btn img:hover {
  transform: scale(1.1);
}
  </style>

  <script>
    function requireLogin() {
      alert("로그인이 필요한 기능입니다.");
      setTimeout(() => {
        alert("로그인 페이지로 이동합니다.");
        location.href = "${pageContext.request.contextPath}/loginPage.do";
      }, 200);
    }
  </script>
</head>

<body>
  <nav class="navbar">
    <div class="navbar-container">

      <!-- 로고 -->
      <div class="logo">
        <a href="${ pageContext.servletContext.contextPath }/main.do">
          <img src="/thedish/resources/images/thedishlogo.jpg" alt="로고" />
        </a>
      </div>

      <!-- 메뉴 -->
      <ul class="menu">
        <li>
          <a href="${ pageContext.servletContext.contextPath }/theDishIntroduce.do">인사말</a>
          <div class="dropdown">
            <div class="dropdown-column">
              <h4>사이트 소개</h4>
              <a href="${ pageContext.servletContext.contextPath }/theDishIntroduce.do">인사말</a>
            </div>
          </div>
        </li>

        <li>
          <a href="#">DISH</a>
          <div class="dropdown">
            <div class="dropdown-column">
              <h4>맞춤형 추천</h4>

              <!-- ✅ 로그인 여부에 따라 다르게 이동 -->
              <c:choose>
                <c:when test="${empty sessionScope.loginUser}">
                  <a href="#" onclick="requireLogin(); return false;">건강 맞춤형 추천</a>
                </c:when>
                <c:otherwise>
                  <a href="${ pageContext.servletContext.contextPath }/healthSearchForm.do">건강 맞춤형 추천</a>
                </c:otherwise>
              </c:choose>
			  <c:choose>
                <c:when test="${empty sessionScope.loginUser}">
                 <a href="#" onclick="requireLogin(); return false;">술 페어링 추천</a>
                </c:when>
                <c:otherwise>
              <a href="${ pageContext.servletContext.contextPath }/drinkSearchForm.do">술 페어링 추천</a>
              </c:otherwise>
              </c:choose>
            </div>
          </div>
        </li>

        <li>
          <a href="${ pageContext.servletContext.contextPath }/recipeList.do">INFO</a>
          <div class="dropdown">
            <div class="dropdown-column">
              <h4>정보 광장</h4>
              <a href="${ pageContext.servletContext.contextPath }/recipeList.do">레시피 정보</a>
              <a href="${ pageContext.servletContext.contextPath }/drinkList.do">술 정보</a>
            </div>
          </div>
        </li>

        <li>
          <a href="${ pageContext.servletContext.contextPath }/boardList.do">Community</a>
          <div class="dropdown">
            <div class="dropdown-column">
              <h4>소통광장</h4>
              <a href="${ pageContext.servletContext.contextPath }/boardList.do?category=free">자유 게시판</a>
              <a href="${ pageContext.servletContext.contextPath }/boardList.do?category=review">후기 게시판</a>
              <a href="${ pageContext.servletContext.contextPath }/boardList.do?category=tip">팁공유 게시판</a>
              <a href="${ pageContext.servletContext.contextPath }/restaurantRecommendList.do">맛집 추천 게시판</a>
              <a href="${ pageContext.servletContext.contextPath }/noticeList.do">공지사항</a>
            </div>
          </div>
        </li>
      </ul>

      <!-- 로그인/로그아웃 -->
      <c:if test="${ empty sessionScope.loginUser }">
  <button onclick="location.href='${pageContext.request.contextPath}/loginPage.do'" class="login-btn">로그인</button>
</c:if>

<c:if test="${ !empty sessionScope.loginUser }">
  <div id="loginBox" class="lineA">
    <div style="margin-bottom: 4px;">
      <strong>${ sessionScope.loginUser.nickName }</strong> 님
    </div>

    <div class="user-actions">
      <!-- 내 정보 버튼 -->
      <a href="myinfo.do?loginId=${ sessionScope.loginUser.loginId }" class="action-btn" title="내 정보">
        <img src="${pageContext.request.contextPath}/resources/images/user-round-search.png" alt="내 정보">
      </a>

      <!-- 관리자 페이지 버튼 (관리자만) -->
      <c:if test="${ sessionScope.loginUser.role eq 'ADMIN' }">
        <a href="${pageContext.request.contextPath}/admin/dashboard.do" class="action-btn" title="관리자 페이지">
          <img src="${pageContext.request.contextPath}/resources/images/settings.png" alt="관리자">
        </a>
      </c:if>
      
      <!-- 로그아웃 버튼 -->
      <a href="logout.do" class="action-btn" title="로그아웃">
        <img src="${pageContext.request.contextPath}/resources/images/log-out.png" alt="로그아웃">
      </a>
      
    </div>
  </div>
</c:if>

    </div>
  </nav>
</body>
</html>
