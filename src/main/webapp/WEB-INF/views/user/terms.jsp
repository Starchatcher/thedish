<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이용약관 - The Dish</title>
    <link rel="stylesheet" href="<c:url value='/resources/static/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">The Dish</h1>
        </header>
        
        <main class="terms-container">
            <form action="<c:url value='/user/terms'/>" method="post">
                <div class="terms-group">
                    <label class="checkbox-container">
                        <input type="checkbox" id="agreeAll" onclick="toggleAll()">
                        <span class="checkmark"></span>
                        <span class="label-text">전체 동의하기</span>
                    </label>
                    <p class="terms-description">실명 인증된 아이디로 가입, 위치기반서비스 이용약관 동의를 포함합니다.</p>
                </div>
                
                <div class="terms-group">
                    <label class="checkbox-container">
                        <input type="checkbox" name="terms" id="termsService" required>
                        <span class="checkmark"></span>
                        <span class="label-text">이용약관</span>
                    </label>
                    <div class="terms-text">
                        <p>여러분을 환영합니다 ##############</p>
                    </div>
                </div>
                
                <div class="terms-group">
                    <label class="checkbox-container">
                        <input type="checkbox" name="terms" id="termsPrivacy" required>
                        <span class="checkmark"></span>
                        <span class="label-text">개인정보 수집 및 이용</span>
                    </label>
                    <div class="terms-text">
                        <p>개인정보보호법에 따라 The Dish 회원가입 신청하시는 ####################</p>
                    </div>
                </div>
                
                <button type="submit" class="btn-next">다음</button>
            </form>
        </main>
    </div>
    
    <script>
        function toggleAll() {
            const agreeAll = document.getElementById('agreeAll');
            const checkboxes = document.querySelectorAll('input[name="terms"]');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = agreeAll.checked;
            });
        }
        
        // 개별 체크박스 변경 시 전체 동의 체크박스 상태 업데이트
        const checkboxes = document.querySelectorAll('input[name="terms"]');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                const allChecked = Array.from(checkboxes).every(c => c.checked);
                document.getElementById('agreeAll').checked = allChecked;
            });
        });
    </script>
</body>
</html>