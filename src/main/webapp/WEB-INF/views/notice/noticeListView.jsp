<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>The Dish 공지사항</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-top: 40px;
            margin-bottom: 20px;
            font-size: 28px;
        }

        #search-area {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 30px;
            gap: 10px;
        }

        #searchForm select,
        #searchForm input[type="text"] {
            padding: 8px 10px;
            font-size: 14px;
            border: 1px solid #aaa;
            border-radius: 6px;
        }

        #searchForm input[type="submit"] {
            padding: 8px 16px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        #searchForm input[type="submit"]:hover {
            background-color: #1c2a38;
        }

        .register-btn {
            background-color: #666;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
        }

        .register-btn:hover {
            background-color: #444;
        }

        .notice-header, .notice-item {
            width: 90%;
            margin: 0 auto;
            display: flex;
            padding: 12px 10px;
            border-bottom: 1px solid #ccc;
            font-size: 14px;
        }

        .notice-header {
            font-weight: bold;
            background-color: #f1f1f1;
        }

        .notice-col {
            flex: 1;
            text-align: center;
        }

        .notice-title a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
        }

        .notice-title a:hover {
            color: #ff8c00;
        }

        @media (max-width: 768px) {
            .notice-header, .notice-item {
                font-size: 12px;
                flex-direction: column;
                text-align: center;
            }
            .notice-col {
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h1>📢 공지사항</h1>

<%
  String defaultAction = request.getParameter("action");
  if (defaultAction == null) defaultAction = "제목";
%>

<div id="search-area">
    <form id="searchForm" method="get">
        <select id="search-type" name="action" onchange="updateAction();">
            <option value="제목" ${defaultAction.equals("제목") ? "selected" : ""}>제목</option>
            <option value="내용" ${defaultAction.equals("내용") ? "selected" : ""}>내용</option>
        </select>
        <input type="text" id="search-query" name="keyword" placeholder="검색어를 입력하세요" required>
        <input type="submit" value="검색" />
    </form>

    <c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.role eq 'ADMIN' }">
        <button class="register-btn" onclick="location.href='${pageContext.servletContext.contextPath}/moveWrite.do';">
             공지사항 등록
        </button>
    </c:if>
</div>

<script>
    function updateAction() {
        var form = document.getElementById('searchForm');
        var type = document.getElementById('search-type').value;
        form.action = (type === "제목") ? "noticeSearchTitle.do" : "noticeSearchContent.do";
    }
    window.onload = updateAction;
</script>

<!-- Header Row -->
<div class="notice-header">
    <div class="notice-col">번호</div>
    <div class="notice-col notice-title">제목</div>
    <div class="notice-col">작성자</div>
    <div class="notice-col">작성일</div>
    <div class="notice-col">조회수</div>
    <div class="notice-col">첨부파일</div>
</div>

<!-- Notice Rows -->
<c:forEach items="${requestScope.list}" var="notice">
    <div class="notice-item">
        <div class="notice-col">${notice.noticeId}</div>
        <div class="notice-col notice-title">
            <c:url var="no" value="ndetail.do">
                <c:param name="no" value="${notice.noticeId}" />
                <c:param name="page" value="${nowpage}" />
            </c:url>
            <a href="${no}">${notice.title}</a>
        </div>
        <div class="notice-col">${notice.createdBy}</div>
        <div class="notice-col">${notice.createdAt}</div>
        <div class="notice-col">${notice.readCount}</div>
        <div class="notice-col">
            <c:if test="${not empty notice.originalFileName}">○</c:if>
        </div>
    </div>
</c:forEach>

<c:import url="/WEB-INF/views/common/pagingView.jsp" />
<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
