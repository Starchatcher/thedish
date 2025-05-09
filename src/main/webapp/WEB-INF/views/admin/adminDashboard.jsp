<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String todayKorean = new SimpleDateFormat("yyyy\uB144 M\uC6D4 d\uC77C").format(new Date());
%>
<html>
<head>
    <title>관리자 대시보드</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
        }
        .sidebar {
    width: 220px;
    height: 100vh;
    background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
    position: fixed;
    color: #ecf0f1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 25px 20px;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
}
        .sidebar h2 {
    font-size: 18px;
    margin-bottom: 25px;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: #ecf0f1;
    border-bottom: 1px solid #7f8c8d;
    padding-bottom: 8px;
    text-align: center;
}
        .sidebar a {
    color: #bdc3c7;
    text-decoration: none;
    display: block;
    margin: 12px 0;
    padding: 10px 15px;
    border-radius: 8px;
    font-size: 15px;
    transition: background 0.3s, color 0.3s;
}
        .sidebar a:hover {
    background-color: #2980b9;
    color: #fff;
    font-weight: bold;
    transform: translateX(5px);
}
        .calendar-box {
            margin-top: 30px;
            padding: 10px;
            background-color: #34495e;
            border-radius: 10px;
            text-align: center;
            font-size: 14px;
        }
        .main-content {
            margin-left: 240px;
            padding: 30px;
        }
        .dashboard {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }
        .row-flex {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }
        .section {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            flex: 1;
            min-width: 300px;
        }
        .section-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #2c3e50;
        }
        .status-box {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        .status-item {
            flex: 1;
            min-width: 100px;
            background-color: #ecf0f1;
            border-radius: 8px;
            padding: 10px;
            text-align: center;
            font-weight: bold;
        }
        .stats-table {
            width: 100%;
            border-collapse: collapse;
        }
        .stats-table th, .stats-table td {
            padding: 10px;
            text-align: center;
        }
        .stats-table thead th {
            background-color: #2980b9;
            color: white;
        }
        .stats-table tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-nav">
        <h2>관리자 메뉴</h2>
        <a href="${pageContext.request.contextPath}/main.do">메인 페이지</a>
        <a href="${pageContext.request.contextPath}/ndetail.do?no=1&page=1">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/board/boardDetailView.do?boardId=1">자유게시판 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">사용자 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">레시피 데이터관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">술 데이터관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">FAQ</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">1:1문의</a>
    </div>
    <div class="calendar-box">
        오늘은 <%= todayKorean %>입니다
    </div>
</div>

<div class="main-content">
    <div class="dashboard">
        <div class="row-flex">
            <div class="section">
                <div class="section-title">오늘의 알림</div>
                <div class="status-box">
                    <div class="status-item">신규가입 <br><span><%= request.getAttribute("todayJoin") %></span></div>
                    <div class="status-item">탈퇴수 <br><span><%= request.getAttribute("todayWithdraw") %></span></div>
                    <div class="status-item">신고수 <br><span><%= request.getAttribute("todayReport") %></span></div>
                    <div class="status-item">후기수 <br><span><%= request.getAttribute("todayReview") %></span></div>
                    <div class="status-item">문의 <br><span><%= request.getAttribute("todayInquiry") %></span></div>
                </div>
            </div>

            <div class="section">
                <div class="section-title">📈 방문자 현황</div>
                <canvas id="lineChart"></canvas>
            </div>

            <div class="section">
                <div class="section-title">📋 일자별 요약</div>
                <table class="stats-table">
                    <thead>
                        <tr>
                            <th>일자</th>
                            <th>게시글</th>
                            <th>조회수</th>
                            <th>방문자</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="sumPost" value="0" />
                        <c:set var="sumView" value="0" />
                        <c:set var="sumVisit" value="0" />

                        <c:forEach var="row" items="${dailySummary}">
                            <tr>
                                <td>${row.DAY}</td>
                                <td>${row.POST_COUNT}건</td>
                                <td>${row.VIEW_COUNT}회</td>
                                <td>${row.VISIT_COUNT}명</td>
                            </tr>
                            <c:set var="sumPost" value="${sumPost + row.POST_COUNT}" />
                            <c:set var="sumView" value="${sumView + row.VIEW_COUNT}" />
                            <c:set var="sumVisit" value="${sumVisit + row.VISIT_COUNT}" />
                        </c:forEach>

                        <tr style="font-weight: bold; background-color: #dcdde1;">
                            <td>최근 7일 합계</td>
                            <td>${sumPost}건</td>
                            <td>${sumView}회</td>
                            <td>${sumVisit}명</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    const labels = <%= new Gson().toJson(request.getAttribute("visitLabels")) %>;
    const data = <%= new Gson().toJson(request.getAttribute("visitData")) %>;

    const ctx = document.getElementById('lineChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '방문자 수',
                data: data,
                borderColor: '#2980b9',
                backgroundColor: 'rgba(41, 128, 185, 0.2)',
                tension: 0.4,
                pointRadius: 4,
                pointBackgroundColor: '#2980b9'
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
        }
    });
</script>

</body>
</html>
