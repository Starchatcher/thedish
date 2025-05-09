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
        }

        h1 {
            text-align: center;
            color: #2f4f4f;
            margin-top: 30px;
            margin-bottom: 20px;
            font-size: 28px;
        }

        #search-area {
            text-align: center;
            margin-bottom: 30px;
        }

        #searchForm {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        #search-type, #search-query {
            padding: 8px;
            font-size: 14px;
            border: 1px solid gray;
            border-radius: 4px;
        }

        #searchForm input[type="submit"] {
            padding: 8px 16px;
            background-color: black;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #searchForm input[type="submit"]:hover {
            background-color: gray;
        }

        table {
            width: 100%;
            margin: 0 auto 40px;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        th, td {
            border: 1px solid gray;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: black;
            color: white;
        }

        td#title a {
            text-decoration: none;
            color: #2f4f4f;
            font-weight: 500;
        }

        td#title a:hover {
            color: gray;
        }

        @media (max-width: 768px) {
            table, h1 {
                width: 95%;
            }
            #searchForm {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <c:import url="/WEB-INF/views/common/menubar.jsp" />

    <h1>📌 공지사항</h1>

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
    </div>

    <script type="text/javascript">
        function updateAction() {
            var form = document.getElementById('searchForm');
            var searchType = document.getElementById('search-type').value;

            if (searchType === "제목") {
                form.action = "noticeSearchTitle.do";
            } else {
                form.action = "noticeSearchContent.do";
            }
        }
        window.onload = updateAction;
    </script>

    <table>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        <c:forEach items="${ requestScope.list }" var="notice">
            <tr>
                <td>${ notice.noticeId }</td>
                <td id="title">
                    <c:url var="no" value="ndetail.do">
                        <c:param name="no" value="${ notice.noticeId }" />
                        <c:param name="page" value="${ nowpage }" />
                    </c:url>
                    <a href="${ no }">${ notice.title }</a>
                </td>
                <td>${ notice.createdBy }</td>
                <td>${ notice.createdAt }</td>
                <td>${ notice.readCount }</td>
            </tr>
        </c:forEach>
    </table>


    <c:import url="/WEB-INF/views/common/pagingView.jsp" />
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
