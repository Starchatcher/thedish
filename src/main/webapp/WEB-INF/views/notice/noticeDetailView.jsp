<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            font-size: 22px;
            font-weight: bold;
            border-bottom: 2px solid gray;
            padding-bottom: 6px;
            margin-bottom: 30px;
            color: #2e5f4d;
        }

        .notice-title {
            font-size: 28px;
            font-weight: bold;
            color: #2f4f4f;
            margin-bottom: 10px;
        }

        .meta-info {
            font-size: 14px;
            color: gray;
            margin-bottom: 30px;
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .meta-info span i {
            margin-right: 6px;
            color: gray;
        }

        .notice-content {
            font-size: 18px;
            line-height: 1.8;
            white-space: pre-line;
            margin-bottom: 40px;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn-group button {
            background-color: black;
            color: white;
            padding: 10px 20px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn-group button:hover {
            background-color: gray;
        }
        
       .attachment-wrapper {
    margin: 30px 0;
}

.attachment-toggle {
    cursor: pointer;
    display: inline-block;
    background-color: #2c3e50;
    color: #fff;
    padding: 10px 16px;
    border-radius: 6px;
    font-size: 15px;
    transition: background 0.2s ease;
    user-select: none;
}
.attachment-toggle:hover {
    background-color: #1e2e3c;
}

.attachment-list {
    margin-top: 12px;
    padding: 12px;
    background-color: #f4f4f4;
    border-left: 4px solid #2c3e50;
    border-radius: 6px;
}

.attachment-link {
    display: inline-block;
    font-size: 15px;
    color: #1a0dab;
    text-decoration: none;
}
.attachment-link:hover {
    text-decoration: underline;
}

.hidden {
    display: none;
}
    </style>
</head>

<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />

<script>
    function toggleAttachment() {
        const list = document.getElementById('attachment-list');
        list.classList.toggle('hidden');
    }
</script>

<div class="container">
    <div class="section-title">📢 공지사항</div>

    <div class="notice-title">${ requestScope.notice.title }</div>

<c:if test="${not empty notice.originalFileName}">
    <div class="attachment-wrapper">
        <div class="attachment-toggle" onclick="toggleAttachment()">
            <i class="fas fa-download"></i> 첨부파일
        </div>
        <div id="attachment-list" class="attachment-list hidden">
            <a href="nfdown.do?ofile=${notice.originalFileName}&rfile=${notice.renameFileName}" class="attachment-link">
                <i class="fas fa-paperclip"></i> ${notice.originalFileName}
            </a>
        </div>
    </div>
</c:if>
    <div class="meta-info">
        <span><i class="fas fa-user"></i>${ requestScope.notice.createdBy }</span>
        <span><i class="fas fa-calendar-alt"></i>${ requestScope.notice.createdAt }</span>
        <span><i class="fas fa-eye"></i>${ requestScope.notice.readCount }</span>
    </div>

    <div class="notice-content">${ requestScope.notice.content }</div>

    <div class="btn-group">
        <button onclick="location.href='noticeList.do?page=1';">목록</button>
        <button onclick="history.back();">이전 페이지</button>
    </div>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
