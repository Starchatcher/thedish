<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>드롭다운 메뉴</title>
<style>
body {
	margin: 0;
	font-family: 'Arial', sans-serif;
}

  /* 로고 이미지 */
  .navbar .logo img {
    height: 100px;
    width: 120px;

    
  }

  /* 메뉴바 색상 */
.navbar {
	background-color: #8FBC8F;
	display: flex;
	padding: 0 40px;
	align-items: center;
	margin: 0;
	
}

.navbar>ul {
	display: flex;
	list-style: none;
	margin: 0;
	padding: 0;
}

.navbar>ul>li {
	position: relative;
}

.navbar>ul>li>a {
	display: block;
	padding: 20px 50px;
	color: black;
	text-decoration: none;
	font-weight: bold;
}

.navbar>ul>li:hover {
	background-color: green;
}

/* 드롭다운했을 때 배경색 */
.dropdown {
	position: absolute;
	top: 100%;
	left: 0;
	background-color: rgba(0, 0, 0, 0.9);
	min-width: 250px;
	padding: 20px;
	display: none;
	color: white;
	z-index: 1000;
}

.navbar>ul>li:hover .dropdown {
	display: flex;
	gap: 40px;
}

.dropdown-column {
	display: flex;
	flex-direction: column;
}

.dropdown-column h4 {
	color: #fff;
	margin-bottom: 10px;
	font-size: 18px;

}

.dropdown-column a {
	color: white; opacity: 1;
	text-decoration: none;
	margin-bottom: 8px;
	font-size: 14px;

}

.dropdown-column a:hover {
	color: orange;
}
  /* 로그인 버튼 */
  .navbar .login-btn {
    background-color: #426B1F;
    color: white;
    border: none;
    padding: 8px 16px;
    cursor: pointer;
    font-size: 16px;
    border-radius: 4px;
    text-decoration: none;
    position: relative;
    left: 180px;
  }
  
  .navbar .login-btn:hover {
    background-color: #45a049;
    text-decoration: none;
    color: white;

  }

</style>
</head>
<body>
	<nav class="navbar">
	<div class="logo">
    <a href="${ pageContext.servletContext.contextPath }/main.do">
      <img src="/thedish/resources/images/thedishlogo.jpg"/>
    </a>
  </div>
		<ul>
			<li><a href="#">인사말</a>
				<div class="dropdown">
					<div class="dropdown-column">
						<h4>사이트 소개</h4>
						<a href="#">인사말</a> 
					</div>
				</div></li>

			<li><a href="#">DISH</a>
				<div class="dropdown">
					<div class="dropdown-column">
						<h4>맞춤형 추천</h4>
						<a href="#">건강 맞춤형 추천</a>
						 <a href="#">술 페어링 추천</a>
					</div>
				</div>
			</li>
			
			<li><a href="#">INFO</a>
				<div class="dropdown">
					<div class="dropdown-column">
						<h4>정보 광장</h4>
						 <a href="${ pageContext.servletContext.contextPath }/recipeList.do">레시피 정보</a>
						 <a href="#">술 정보</a>
					</div>
				</div>
			</li>
			
			<li><a href="#">Community</a>
				<div class="dropdown">
					<div class="dropdown-column">
						<h4>소통광장</h4>
						 <a href="${ pageContext.servletContext.contextPath }/boardList.do"">자유 게시판</a>
						 <a href="#">후기 게시판</a>
						 <a href="#">팁공유 게시판</a>
						 <a href="#">공지사항</a>
					</div>
				</div>
				</li>

			
		</ul>
		<div>
    <a href="#login" class="login-btn">login</a>
 		 </div>
	</nav>
	

</body>
</html>
