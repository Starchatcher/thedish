<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>The Dish main</title>
 <style>
 
 	div h3 {
 	text-align: center;
 	}
    body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
      background-color: white;
    }
    .container {
      max-width: 1000px;
      margin: 50px auto;
      text-align: center;
    }
    h2 {
      margin-bottom: 40px;
      font-size: 24px;
    }
    .content {
      display: flex;
      justify-content: space-between;
      gap: 30px;
    }
    .notice, .best {
      flex: 1;
      background: white;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.05);
      text-align: left;

    }
    .notice ul {
      padding-left: 20px;
    }
    .pagination {
      text-align: center;
      margin-top: 15px;
    }
    .pagination button {
      background: white;
      border: 1px solid #ccc;
      margin: 0 3px;
      padding: 5px 10px;
      cursor: pointer;
    }
    .pagination button.active {
      background: black;
      color: white;
    }
    img {
      width: 100%;
      border-radius: 8px;
    }
  </style>
</head>
<body>


<c:import url="/WEB-INF/views/common/menubar.jsp" />



  <div class="container">
    <h2>아름답고 맛있는 미래 가치를 선도</h2>

    <div class="content">
      <!-- 공지사항 -->
      <div class="notice">
        <a href="noticeList.do"><h3>공지사항 (NOTICE)</h3></a>
        <ul id="noticeList"></ul>
        <div class="pagination" id="pagination"></div>
      </div>

      <!-- 이번주 추천 음식 -->
      <div class="best">
        <h3 id="rcm">이번주 추천 음식 (This Week’s Best)</h3>
        <img src="dish.jpg" alt="추천 음식">
      </div>
    </div>
  </div>

  <script>
    const notices = [
      "신제품 출시 안내: 고객 여러분의 많은 요청에 따라 동남아 퓨전 신메뉴를 출시합니다.",
      "포인트 제도 변경 안내: 2025년 6월 1일부터 적립률이 조정됩니다.",
      "고객 후기 이벤트: SNS에 공유하고 선물 받자! 5월 1일부터 20일까지 진행됩니다.",
      "여름 한정 메뉴 출시 예정 안내",
      "매장 운영시간 변경 공지",
      "5월 휴무일 안내",
      "단체예약 프로모션 안내",
      "신규 지점 오픈 공지"
    ];

    const itemsPerPage = 5;
    let currentPage = 1;

    function renderNotices() {
      const list = document.getElementById('noticeList');
      const start = (currentPage - 1) * itemsPerPage;
      const end = start + itemsPerPage;
      list.innerHTML = '';
      notices.slice(start, end).forEach((item, idx) => {
        list.innerHTML += `<li><strong>${start + idx + 1}.</strong> ${item}</li>`;
      });
    }

    function renderPagination() {
      const pagination = document.getElementById('pagination');
      const pageCount = Math.ceil(notices.length / itemsPerPage);
      pagination.innerHTML = '';
      for (let i = 1; i <= pageCount; i++) {
        const btn = document.createElement('button');
        btn.innerText = i;
        btn.classList.toggle('active', i === currentPage);
        btn.onclick = () => {
          currentPage = i;
          renderNotices();
          renderPagination();
        };
        pagination.appendChild(btn);
      }
    }

    renderNotices();
    renderPagination();
  </script>

 <c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>