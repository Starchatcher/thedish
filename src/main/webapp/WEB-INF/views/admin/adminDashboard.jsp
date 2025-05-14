<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String todayKorean = new SimpleDateFormat("yyyy년 M월 d일").format(new Date());
%>
<!DOCTYPE html>
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
            padding: 20px 15px;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
        }
        .sidebar h2 {
            font-size: 18px;
            margin-bottom: 25px;
            text-align: center;
        }
        .sidebar a {
            color: #bdc3c7;
            text-decoration: none;
            display: block;
            margin: 10px 0;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 14px;
            transition: background 0.3s, color 0.3s;
        }
        .sidebar a:hover {
            background-color: #2980b9;
            color: #fff;
        }
        .calendar-box {
            margin-top: 20px;
            padding: 8px;
            background-color: #34495e;
            border-radius: 10px;
            text-align: center;
            font-size: 13px;
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
            box-shadow: 0 4px 10px rgba(0,0,0,0.06);
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
            min-width: 120px;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.06);
            padding: 15px 10px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .status-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 14px rgba(0,0,0,0.1);
        }
        .status-item span {
            display: block;
            margin-top: 10px;
            font-size: 24px;
            font-weight: 800;
            color: #2c3e50;
        }
        .stats-table {
            width: 100%;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.06);
            border-collapse: collapse;
        }
        .stats-table thead th {
            background-color: #2364aa;
            color: #ffffff;
            font-size: 16px;
            letter-spacing: 1px;
            padding: 12px;
        }
        .stats-table tbody td {
            font-size: 15px;
            color: #333;
            padding: 12px;
            text-align: center;
        }
        .stats-table tbody tr:last-child {
            background-color: #f7e9a0;
            font-weight: 800;
            border-top: 2px solid #ddd;
        }
        .stats-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .chart-container {
  width: 100%;
  height: 320px;
  position: relative;
}
canvas {
  width: 100% !important;
  height: 100% !important;
}
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-nav">
        <h2>관리자 메뉴</h2>
        <a href="${pageContext.request.contextPath}/main.do">메인 페이지</a>
        <a href="${pageContext.request.contextPath}/noticeList.do">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/boardList.do">게시판 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">사용자 관리</a>
        <a href="${pageContext.request.contextPath}/recipeList.do">레시피 데이터관리</a>
        <a href="${pageContext.request.contextPath}/drinkList.do">술 데이터관리</a>
        <a href="${pageContext.request.contextPath}/FAQList.do">FAQ</a>
        <a href="${pageContext.request.contextPath}/qnaList.do">1:1문의</a>
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
                    <div class="status-item">신규가입 <span>${todayJoin}</span></div>
                    <div class="status-item">탈퇴수 <span>${todayWithdraw}</span></div>
                    <div class="status-item">신고수 <span>${todayReport}</span></div>
                    <div class="status-item">후기수 <span>${todayReview}</span></div>
                    <div class="status-item">문의 <span>${todayInquiry}</span></div>
                </div>
            </div>

            <div class="section">
                <div class="section-title">일자별 요약</div>
                <table class="stats-table">
                    <thead>
                        <tr>
                            <th>일자</th>
                            <th>게시글</th>
                            <th>게시판 조회수</th>
                            <th>레시피 조회수</th>
                            <th>드링크 조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="sumPost" value="0" />
                        <c:set var="sumBoardView" value="0" />
                        <c:set var="sumRecipeView" value="0" />
                        <c:set var="sumDrinkView" value="0" />
                        <c:forEach var="row" items="${dailySummary}">
                            <tr>
                                <td>${row.DAY}</td>
                                <td>${row.POST_COUNT}건</td>
                                <td>${row.BOARD_VIEW_COUNT}회</td>
                                <td>${row.RECIPE_VIEW_COUNT}회</td>
                                <td>${row.DRINK_VIEW_COUNT}회</td>
                            </tr>
                            <c:set var="sumPost" value="${sumPost + row.POST_COUNT}" />
                            <c:set var="sumBoardView" value="${sumBoardView + row.BOARD_VIEW_COUNT}" />
                            <c:set var="sumRecipeView" value="${sumRecipeView + row.RECIPE_VIEW_COUNT}" />
                            <c:set var="sumDrinkView" value="${sumDrinkView + row.DRINK_VIEW_COUNT}" />
                        </c:forEach>
                        <tr>
                            <td>최근 7일 합계</td>
                            <td>${sumPost}건</td>
                            <td>${sumBoardView}회</td>
                            <td>${sumRecipeView}회</td>
                            <td>${sumDrinkView}회</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="display: flex; gap: 30px; flex-wrap: wrap; justify-content: space-between; margin-top: 40px;">
            <div style="flex: 1; min-width: 400px; height: 320px; background: white; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.06); padding: 20px;">
                <div style="font-size: 16px; font-weight: bold; color: #2980b9; margin-bottom: 10px;">
                    게시글 수 그래프
                </div>
                <div class="chart-container">
                <canvas id="lineChart1"></canvas>
                </div>
            </div>

            <div style="flex: 1; min-width: 400px; height: 320px; background: white; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.06); padding: 20px;">
                <div style="font-size: 16px; font-weight: bold; color: #27ae60; margin-bottom: 10px;">
                    총 조회수 그래프
                </div>
                <div class="chart-container">
                <canvas id="lineChart2"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const labels = <%= new Gson().toJson(request.getAttribute("postViewLabels")) %>;
    const postData = <%= new Gson().toJson(request.getAttribute("postData")) %>;
    const viewData = <%= new Gson().toJson(request.getAttribute("viewData")) %>;

    const commonOptions = {
        responsive: true,
        plugins: { legend: { display: false }},
        scales: {
            y: {
                beginAtZero: true,
                ticks: { stepSize: 10, font: { size: 14 }, color: '#333' },
                grid: { color: 'rgba(0,0,0,0.05)' }
            },
            x: {
                reverse: false,
                ticks: { font: { size: 14 }, color: '#555' },
                grid: { display: false }
            }
        }
    };

    const commonDatasetStyle = {
        fill: true,
        tension: 0.4,
        pointRadius: 5,
        pointHoverRadius: 8,
        borderWidth: 3
    };

    new Chart(document.getElementById('lineChart1').getContext('2d'), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                ...commonDatasetStyle,
                label: '게시글 수',
                data: postData,
                borderColor: '#2980b9',
                backgroundColor: 'rgba(41, 128, 185, 0.1)',
                pointStyle: 'circle',
                pointBackgroundColor: '#2980b9'
            }]
        },
        options: commonOptions
    });

    new Chart(document.getElementById('lineChart2').getContext('2d'), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                ...commonDatasetStyle,
                label: '조회 수',
                data: viewData,
                borderColor: '#27ae60',
                backgroundColor: 'rgba(39, 174, 96, 0.15)',
                pointStyle: 'rectRounded',
                pointBackgroundColor: '#27ae60'
            }]
        },
        options: commonOptions
    });
</script>

</body>
</html>
