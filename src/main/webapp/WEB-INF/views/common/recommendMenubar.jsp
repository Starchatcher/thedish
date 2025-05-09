<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>The Dish 메뉴바</title>
<style>
body {
	margin: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #FFFDF7;
}

.navbar {
	background-color: #ffffff;
	border-bottom: 2px solid #ffe0b2;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

.navbar-container {
	max-width: 1200px;
	margin: 0 auto;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 20px 40px;
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
	font-size: 23px;
	font-weight: bold;
	color: #6d4c41;
	text-decoration: none;
	padding: 20px 40px;
	border-radius: 8px;
	transition: all 0.3s ease;
	font-family: 'Noto Sans KR', sans-serif;
}

.menu > li > a:hover {
	background-color: #ffcc80;
	color: #ffffff;
}

.dropdown {
	position: absolute;
	top: 100%;
	left: 0;
	background-color: #fff3e0;
	min-width: 220px;
	padding: 15px;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	opacity: 0;
	visibility: hidden;
	transform: translateY(10px);
	transition: all 0.3s ease;
	z-index: 1000;
}

.menu > li:hover .dropdown {
	opacity: 1;
	visibility: visible;
	transform: translateY(0);
}

.dropdown-column {
	display: flex;
	flex-direction: column;
}

.dropdown-column h4 {
	color: #d84315;
	margin-bottom: 10px;
	font-size: 20px;
}

.dropdown-column a {
	color: #5d4037;
	opacity: 1;
	text-decoration: none;
	margin-bottom: 8px;
	font-size: 14px;
}

.dropdown-column a:hover {
	font-weight: bold;
	color: #bf360c;
}

.login-btn {
	background-color: #ff7043;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 8px 16px;
	cursor: pointer;
	font-size: 15px;
	transition: background-color 0.3s;
}

.login-btn:hover {
	background-color: #d84315;
}
</style>
</head>
<body>

	<nav class="navbar">
		<div class="navbar-container">
			<div class="logo">
				<a href="${ pageContext.servletContext.contextPath }/main.do">
					<img src="/thedish/resources/images/thedishlogo.jpg" alt="로고" />
				</a>
			</div>
			<ul class="menu">
				<li><a
					href="${ pageContext.servletContext.contextPath }/theDishIntroduce.do">인사말</a>
					<div class="dropdown">
						<div class="dropdown-column">
							<h4>사이트 소개</h4>
							<a
								href="${ pageContext.servletContext.contextPath }/theDishIntroduce.do">인사말</a>
						</div>
					</div></li>
				<li><a href="${ pageContext.servletContext.contextPath }/healthSearchForm.do">DISH</a>
					<div class="dropdown">
						<div class="dropdown-column">
							<h4>맞춤형 추천</h4>
							<a href="${ pageContext.servletContext.contextPath }/healthSearchForm.do">건강 맞춤형</a>
							<a href="${ pageContext.servletContext.contextPath }/drinkSearchForm.do">술 페어링</a>
						</div>
					</div></li>
				<li><a href="${ pageContext.servletContext.contextPath }/recipeList.do">INFO</a>
					<div class="dropdown">
						<div class="dropdown-column">
							<h4>정보 광장</h4>
							<a href="${ pageContext.servletContext.contextPath }/recipeList.do">레시피</a>
							<a href="${ pageContext.servletContext.contextPath }/drinkList.do">술 정보</a>
						</div>
					</div></li>
				<li><a href="${ pageContext.servletContext.contextPath }/boardList.do">Community</a>
					<div class="dropdown">
						<div class="dropdown-column">
							<h4>소통 광장</h4>
							<a href="${ pageContext.servletContext.contextPath }/boardList.do?category=free">자유게시판</a>
							<a href="${ pageContext.servletContext.contextPath }/boardList.do?category=review">후기게시판</a>
							<a href="${ pageContext.servletContext.contextPath }/boardList.do?category=tip">팁공유</a>
							<a href="${ pageContext.servletContext.contextPath }/noticeList.do">공지사항</a>
						</div>
					</div></li>
			</ul>

			<c:if test="${ empty sessionScope.loginUser }">
				<button onclick="location.href='${pageContext.request.contextPath}/loginPage.do'" class="login-btn">로그인</button>
			</c:if>
			<c:if test="${ !empty sessionScope.loginUser }">
				<div style="font-size: 14px;">
					${ sessionScope.loginUser.nickName } 님<br>
					<a href="logout.do">로그아웃</a> | 
					<a href="myinfo.do?loginId=${ sessionScope.loginUser.loginId }">내 정보</a>
					<c:if test="${ sessionScope.loginUser.role eq 'ADMIN' }">
						<br><a href="${pageContext.request.contextPath}/admin/dashboard.do">[관리자 페이지]</a>
					</c:if>
				</div>
			</c:if>
		</div>
	</nav>
</body>
</html>