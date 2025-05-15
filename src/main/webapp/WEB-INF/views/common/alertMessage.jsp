<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>
</head>
<body>
    <script>
        // 컨트롤러에서 모델에 'msg'라는 이름으로 담아 보낸 메시지를 가져옵니다.
        // JSTL c:out 태그를 사용하여 안전하게 출력하고, escapeXml='true'로 XSS 방지
        var message = "<c:out value='${msg}' escapeXml='true'/>";

        // 메시지가 비어있지 않다면 알림창을 띄웁니다.
        if (message && message.trim().length > 0) {
            alert(message);
        }

        // 알림창 확인 후 이동할 페이지를 결정합니다.
        // 필요에 따라 아래 둘 중 하나를 선택하거나 주석 처리하세요.

        // 1. 이전 페이지로 이동하는 경우
         history.back();

        // 2. 특정 페이지로 이동하는 경우 (예: 홈 또는 목록 페이지)
        // window.location.href = "${pageContext.request.contextPath}/"; // 예시: 프로젝트 홈으로 이동
        // window.location.href = "${pageContext.request.contextPath}/drinkList.do"; // 예시: 음료 목록으로 이동
    </script>
</body>
</html>
