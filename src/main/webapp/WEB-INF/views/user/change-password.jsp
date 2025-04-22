<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경 - The Dish</title>
    <link rel="stylesheet" href="<c:url value='/resources/static/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">The Dish</h1>
        </header>
        
        <main class="password-change">
            <h2>비밀번호 변경</h2>
            
            <c:if test="${not empty errorMsg}">
                <div class="error-message">${errorMsg}</div>
            </c:if>
            
            <form action="<c:url value='/user/change-password'/>" method="post" id="passwordChangeForm">
                <div class="form-group">
                    <input type="password" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호" required>
                </div>
                
                <div class="form-group">
                    <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
                    <div class="password-guide">영문, 숫자, 특수문자 조합 8-20자</div>
                </div>
                
                <div class="form-group">
                    <input type="password" id="confirmNewPassword" name="confirmNewPassword" placeholder="새 비밀번호 확인" required>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn-confirm">확인</button>
                    <button type="button" class="btn-cancel" onclick="location.href='<c:url value="/user/mypage"/>'">취소</button>
                </div>
            </form>
        </main>
    </div>
    
    <script>
        document.getElementById('passwordChangeForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmNewPassword = document.getElementById('confirmNewPassword').value;
            
            // 비밀번호 일치 여부 검사
            if (newPassword !== confirmNewPassword) {
                e.preventDefault();
                alert('새 비밀번호가 일치하지 않습니다.');
                return;
            }
            
            // 비밀번호 복잡성 검사
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/;
            if (!passwordRegex.test(newPassword)) {
                e.preventDefault();
                alert('비밀번호는 영문, 숫자, 특수문자 조합 8-20자로 입력해주세요.');
                return;
            }
        });
    </script>
</body>
</html>