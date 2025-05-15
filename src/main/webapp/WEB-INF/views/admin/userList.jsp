<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    String todayKorean = new SimpleDateFormat("yyyy\uB144 M\uC6D4 d\uC77C").format(new Date());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사용자 관리</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .sidebar {
            width: 240px; height: 100vh; position: fixed; top: 0; left: 0;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            padding: 20px 15px; color: #ecf0f1; box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
            box-sizing: border-box;
        }
        .sidebar h2 { font-size: 18px; margin-bottom: 25px; text-align: center; }
        .sidebar a {
            color: #bdc3c7; text-decoration: none; display: block;
            margin: 10px 0; padding: 10px 15px; border-radius: 8px;
            font-size: 14px; transition: background 0.3s, color 0.3s;
        }
        .sidebar a:hover { background-color: #2980b9; color: #fff; }
        .calendar-box {
            margin-top: 20px; padding: 8px; background-color: #34495e;
            border-radius: 10px; text-align: center; font-size: 13px;
        }
        .main-content { margin-left: 260px; padding: 80px 40px; }
        h1 { color: #2d3e50; font-size: 26px; font-weight: 800; text-align: center; margin-bottom: 25px; }
        .user-stats {
            display: flex; gap: 15px; justify-content: center; margin-bottom: 25px;
        }
        .stat-box {
            flex: 1; max-width: 240px; background: #ffffff; color: #2364aa;
            padding: 18px 12px; border-radius: 10px; text-align: center;
            font-size: 16px; font-weight: 700; transition: transform 0.3s ease;
        }
        .stat-box:hover { transform: translateY(-4px); }
        form.search-form {
            display: flex; justify-content: center; align-items: center; gap: 8px; margin-bottom: 25px;
        }
        .search-form input[type="text"], .search-form select {
            padding: 10px; font-size: 13px; border: 1px solid #ccc; border-radius: 6px;
            background: #ffffff; box-shadow: 0 1px 4px rgba(0,0,0,0.03);
        }
        .search-form button {
            background-color: #2364aa; color: white; border: none;
            padding: 10px 20px; font-size: 13px; border-radius: 6px;
            cursor: pointer; font-weight: bold; box-shadow: 0 2px 5px rgba(0,0,0,0.08);
            transition: background-color 0.3s ease;
        }
        .search-form button:hover { background-color: #3a7bc4; }
        .user-table-wrapper { display: flex; justify-content: center; }
        .user-table {
            width: 1000px; border-collapse: separate; border-spacing: 0 8px;
        }
        .user-table thead th {
            background-color: #2364aa; color: #ffffff; padding: 12px; font-size: 16px; text-align: center;
            border-top-left-radius: 6px; border-top-right-radius: 6px;
        }
        .user-table tbody tr {
            background-color: #ffffff; box-shadow: 0 2px 6px rgba(0,0,0,0.05); border-radius: 6px;
        }
        .user-table td {
            text-align: center; padding: 10px; font-size: 14px; font-weight: 500;
        }
        .user-table tbody tr:hover { background-color: #f7f9fb; }
        .pagination { text-align: center; margin-top: 25px; }
        .pagination a, .pagination strong {
            margin: 0 5px; text-decoration: none; color: #2364aa; font-weight: bold;
        }
        .pagination strong { color: #000; }
        .back-button { text-align: center; margin-top: 25px; }
        .back-button button {
            padding: 10px 25px; font-size: 13px; background-color: #2364aa; color: white;
            border: none; border-radius: 6px; cursor: pointer; font-weight: bold;
            box-shadow: 0 3px 8px rgba(0,0,0,0.08); transition: background-color 0.3s ease;
        }
        .back-button button:hover { background-color: #4a90e2; transform: translateY(-3px); }
		.action-btn {
		    display: inline-block;
		    min-width: 60px;        /* ▶️ 버튼의 최소 가로 길이 */
		    padding: 7px 14px;      /* ▶️ 상하 6px, 좌우 12px 패딩 (버튼 크기 핵심!) */
		    margin: 0 4px;          /* ▶️ 버튼 간격 */
		    font-size: 13px;
		    font-weight: bold;
		    border-radius: 6px;
		    border: none;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
        .view-btn { background-color: #2364aa; color: white; }
        .view-btn:hover { background-color: #1e4e8c; }
        .deactivate-btn { background-color: #dc3545; color: white; }
        .deactivate-btn:hover { background-color: #a71d2a; }
        .deactivate-btn[disabled] {
            background-color: #ccc; color: #666; cursor: not-allowed;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-nav">
        <h2>관리자 메뉴</h2>
        <a href="${pageContext.request.contextPath}/main.do">메인 페이지</a>
        <a href="${pageContext.request.contextPath}/ndetail.do?no=1&page=1">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/board/boardList.do">자유게시판 관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">사용자 관리</a>
        <a href="${pageContext.request.contextPath}/recipe/recipeList.do">레시피 데이터관리</a>
        <a href="${pageContext.request.contextPath}/drink/drinkList.do">술 데이터관리</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">FAQ</a>
        <a href="${pageContext.request.contextPath}/admin/userList.do">1:1문의</a>
    </div>
    <div class="calendar-box">
        오늘은 <%= todayKorean %>입니다
    </div>
</div>
<div class="main-content">
    <h1>사용자 관리</h1>
    <div class="user-stats">
        <div class="stat-box">총 가입자 수 : ${totalUsers}</div>
        <div class="stat-box">현재 회원 수 : ${activeUsers}</div>
        <div class="stat-box">현재 탈퇴한 수 : ${withdrawnUsers}</div>
    </div>
    <form class="search-form" method="get" action="${pageContext.request.contextPath}/admin/userList.do">
        <input type="text" name="keyword" placeholder="닉네임 또는 ID 검색" value="${param.keyword}" />
        <select name="status">
            <option value="">전체 상태</option>
            <option value="ACTIVE" <c:if test="${param.status == 'ACTIVE'}">selected</c:if>>정상</option>
            <option value="INACTIVE" <c:if test="${param.status == 'INACTIVE'}">selected</c:if>>탈퇴</option>
        </select>
        <button type="submit">검색</button>
    </form>
    <div class="user-table-wrapper">
    <table class="user-table" style="width: 1300px;">
        <thead>
        <tr>
            <th>회원ID</th>
            <th>닉네임</th>
            <th>이메일</th>
            <th>상태</th>
            <th>가입일</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${userList}">
            <c:if test="${not empty user.loginId}">
                <tr>
                    <td>${user.loginId}</td>
                    <td>${user.nickName}</td>
                    <td>${user.email}</td>
                    <td>${user.status}</td>
                    <td><fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd"/></td>
                    <td>
                        <form method="get" action="${pageContext.request.contextPath}/admin/userDetail.do" style="display:inline;">
                            <input type="hidden" name="userId" value="${user.userId}" />
                            <button type="submit" class="action-btn view-btn">보기</button>
                        </form>
                        <form method="post" action="${pageContext.request.contextPath}/admin/deactivateUser.do" style="display:inline;"
                              onsubmit="return confirm('정말로 탈퇴 처리하시겠습니까?');">
                            <input type="hidden" name="loginId" value="${user.loginId}" />
                            <button type="submit" class="action-btn deactivate-btn" <c:if test="${user.status eq 'INACTIVE'}">disabled</c:if>>탈퇴</button>
                        </form>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
    </div>
    <div class="pagination">
        <c:forEach begin="1" end="${totalPages}" var="pageNum">
            <c:choose>
                <c:when test="${pageNum == currentPage}">
                    <strong>${pageNum}</strong>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/admin/userList.do?page=${pageNum}&keyword=${param.keyword}&status=${param.status}">${pageNum}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    <div class="back-button">
        <button onclick="location.href='${pageContext.request.contextPath}/admin/dashboard.do'">이전 페이지</button>
    </div>
</div>
</body>
</html>
