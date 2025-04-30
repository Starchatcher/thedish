<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>The Dish main</title>
<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #fdfefc;
  }

  .container {
    max-width: 1100px;
    margin: 60px auto;
    text-align: center;
  }

  h2 {
    margin-bottom: 50px;
    font-size: 28px;
    color: #2c3e50;
  }

  .content {
    display: flex;
    justify-content: space-between;
    gap: 40px;
    flex-wrap: wrap;
  }

  .notice, .best {
    flex: 1;
    background: #ffffff;
    padding: 25px 30px;
    border-radius: 16px;
    box-shadow: 0 6px 16px rgba(0,0,0,0.08);
  }

  .notice h3, .best h3 {
    text-align: center;
    color: #27ae60;
    margin-bottom: 20px;
    font-size: 20px;
    border-bottom: 2px solid #e0e0e0;
    padding-bottom: 10px;
  }

  /* 공지사항 테이블 */
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

  /* 추천 음식 */
  .best img {
    width: 100%;
    border-radius: 10px;
    transition: transform 0.3s ease;
  }

  .best img:hover {
    transform: scale(1.02);
  }

  @media (max-width: 768px) {
    .content {
      flex-direction: column;
    }
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
</script>
</head>

<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="container">
  <h2>아름답고 맛있는 미래 가치를 선도</h2>

  <div class="content">

    <!-- 공지사항 -->
    <div class="notice">
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
          <!-- AJAX로 공지글 삽입 -->
        </tbody>
      </table>
    </div>

    <!-- 이번주 추천 음식 -->
    <div class="best">
      <h3>이번주 추천 음식 (This Week’s Best)</h3>
      <img src="dish.jpg" alt="추천 음식">
    </div>

  </div>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
