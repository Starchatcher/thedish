<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>관리자 대시보드</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Chart.js CDN -->
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            height: 100vh;
        }

        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            color: white;
            padding: 20px;
        }

        .sidebar h2 {
            font-size: 22px;
            margin-bottom: 30px;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            margin: 10px 0;
            padding: 8px;
            border-radius: 4px;
        }

        .sidebar a:hover {
            background-color: #34495e;
        }

        .main-content {
            flex: 1;
            background-color: #f4f7f9;
            padding: 30px;
            overflow-y: auto;
        }

        .main-content h1 {
            color: #333;
            margin-bottom: 20px;
        }

        .charts {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
        }

        .chart-box {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            flex: 1;
            min-width: 400px;
        }

        canvas {
            width: 100% !important;
            height: 300px !important;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>관리자 메뉴</h2>
    <a href="${pageContext.request.contextPath}/admin/noticeList.do">공지사항 관리</a>
    <a href="${pageContext.request.contextPath}/admin/userList.do">사용자 관리</a>
    <a href="${pageContext.request.contextPath}/main.do">메인 페이지</a>
</div>

<div class="main-content">
    <h1>관리자님 환영합니다 👋</h1>
    <p>이곳은 관리자만 접근 가능한 대시보드입니다.</p>

    <div class="charts">
        <!-- 꺾은선 그래프 -->
        <div class="chart-box">
            <h3>조회 현황 (레시피, 드링크)</h3>
            <canvas id="lineChart"></canvas>
        </div>

        <!-- 레이더 차트 -->
        <div class="chart-box">
            <h3>활동 지표 (조회수/좋아요/공유 등)</h3>
            <canvas id="radarChart"></canvas>
        </div>
    </div>
</div>

<script>
    // 꺾은선 그래프 데이터
    const lineCtx = document.getElementById('lineChart');
    new Chart(lineCtx, {
        type: 'line',
        data: {
            labels: ['4월19일', '4월20일', '4월21일', '4월22일', '4월23일', '4월24일', '4월25일'],
            datasets: [
                {
                    label: '레시피',
                    data: [25, 15, 30, 22, 28, 32, 24],
                    borderColor: '#007bff',
                    fill: false,
                    tension: 0.3
                },
                {
                    label: '드링크',
                    data: [12, 16, 10, 18, 14, 19, 16],
                    borderColor: '#ff7f0e',
                    fill: false,
                    tension: 0.3
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });

    // 레이더 차트 데이터
    const radarCtx = document.getElementById('radarChart');
    new Chart(radarCtx, {
        type: 'radar',
        data: {
            labels: ['조회수', '좋아요', '공유', '저장', '댓글'],
            datasets: [
                {
                    label: '레시피',
                    data: [60, 50, 30, 40, 35],
                    backgroundColor: 'rgba(0, 123, 255, 0.4)',
                    borderColor: '#007bff',
                    borderWidth: 1
                },
                {
                    label: '드링크',
                    data: [30, 25, 15, 20, 18],
                    backgroundColor: 'rgba(255, 127, 14, 0.4)',
                    borderColor: '#ff7f0e',
                    borderWidth: 1
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' }
            },
            scales: {
                r: {
                    min: 0,
                    max: 80
                }
            }
        }
    });
</script>

</body>
</html>
