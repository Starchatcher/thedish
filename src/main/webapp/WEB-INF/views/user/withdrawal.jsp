<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴 - The Dish</title>
    <link rel="stylesheet" href="<c:url value='/resources/static/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">The Dish</h1>
        </header>
        
        <main class="withdrawal-container">
            <h2>회원 탈퇴</h2>
            <p class="notice">서비스 퇴 전 아래의 주의사항을 꼭 확인해 주세요.</p>
            
            <div class="account-info">
                <h3>탈퇴할 계정</h3>
                <p>계정: ${user.userId}</p>
            </div>
            
            <div class="withdrawal-notice">
                <h3>계정 복구 및 데이터 파기</h3>
                <ul>
                    <li>탈퇴일로부터 30일 이내에는 계정 복구가 가능합니다.</li>
                    <li>그 이후에는 계정 복구가 불가능합니다.</li>
                </ul>
            </div>
            
            <div class="no-account">
                <p>이용 계정 없음</p>
            </div>
            
            <form action="<c:url value='/user/withdrawal'/>" method="post">
                <div class="agreement">
                    <label class="checkbox-container">
                        <input type="checkbox" name="agreeWithdrawal" required>
                        <span class="checkmark"></span>
                        <span class="label-text">주의사항을 모두 확인했으며, 이에 동의합니다.</span>
                    </label>
                </div>
                
                <div class="button-group">
                    <button type="button" class="btn-cancel" onclick="location.href='<c:url value="/user/mypage"/>'">취소</button>
                    <button type="submit" class="btn-next">다음으로</button>
                </div>
            </form>
        </main>
    </div>
</body>
</html>