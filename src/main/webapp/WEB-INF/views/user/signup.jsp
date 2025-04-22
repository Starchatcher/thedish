<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - The Dish</title>
    <link rel="stylesheet" href="<c:url value='/resources/static/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">The Dish</h1>
        </header>
        
        <main class="signup-form">
            <c:if test="${not empty errorMsg}">
                <div class="error-message">${errorMsg}</div>
            </c:if>
            
            <form action="<c:url value='/user/signup'/>" method="post" id="signupForm">
                <div class="form-group id-group">
                    <input type="text" id="userId" name="userId" placeholder="아이디" value="${user.userId}" required>
                    <button type="button" class="btn-check" onclick="checkIdDuplicate()">중복확인</button>
                </div>
                <div id="idFeedback" class="feedback-message"></div>
                
                <div class="form-group">
                    <input type="password" id="password" name="password" placeholder="비밀번호" required>
                    <div class="password-guide">영문, 숫자, 특수문자 조합 8-20자</div>
                </div>
                
                <div class="form-group">
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
                </div>
                
                <div class="form-group">
                    <input type="text" id="name" name="name" placeholder="이름" value="${user.name}" required>
                </div>
                
                <div class="form-group">
                    <input type="text" id="birthdate" name="birthdate" placeholder="생년월일 8자리" maxlength="8" value="${user.birthdate}" required>
                    <div class="gender-buttons">
                        <button type="button" class="gender-btn ${user.gender == 'male' ? 'selected' : ''}" id="male" onclick="selectGender('male')">남자</button>
                        <button type="button" class="gender-btn ${user.gender == 'female' ? 'selected' : ''}" id="female" onclick="selectGender('female')">여자</button>
                        <button type="button" class="gender-btn ${user.gender == 'none' ? 'selected' : ''}" id="none" onclick="selectGender('none')">선택안함</button>
                    </div>
                    <input type="hidden" id="gender" name="gender" value="${user.gender}">
                </div>
                
                <div class="form-group email-group">
                    <input type="email" id="email" name="email" placeholder="이메일 입력하세요" value="${user.email}" required>
                    <button type="button" class="btn-send" onclick="sendVerificationCode()">보내기</button>
                </div>
                
                <div class="form-group verification-group">
                    <input type="text" id="verificationCode" name="verificationCode" placeholder="인증번호를 입력하세요" required>
                    <button type="button" class="btn-verify" onclick="verifyCode()">인증</button>
                </div>
                <div id="verificationFeedback" class="feedback-message"></div>
                
                <button type="submit" class="btn-confirm">확인</button>
            </form>
        </main>
    </div>
    
    <script>
        // 아이디 중복 확인 상태
        let isIdChecked = false;
        let isIdAvailable = false;
        
        // 이메일 인증 상태
        let isEmailVerified = false;
        
        // 성별 선택 함수
        function selectGender(gender) {
            document.getElementById('gender').value = gender;
            
            // 버튼 스타일 변경
            document.getElementById('male').classList.remove('selected');
            document.getElementById('female').classList.remove('selected');
            document.getElementById('none').classList.remove('selected');
            
            document.getElementById(gender).classList.add('selected');
        }
        
        // 아이디 중복 확인 함수
        function checkIdDuplicate() {
            const userId = document.getElementById('userId').value;
            const idFeedback = document.getElementById('idFeedback');
            
            if (!userId) {
                idFeedback.textContent = '아이디를 입력해주세요.';
                idFeedback.className = 'feedback-message error';
                return;
            }
            
            // 아이디 유효성 검사 (영문, 숫자 조합 5-20자)
            const idRegex = /^[a-zA-Z0-9]{5,20}$/;
            if (!idRegex.test(userId)) {
                idFeedback.textContent = '아이디는 영문, 숫자 조합 5-20자로 입력해주세요.';
                idFeedback.className = 'feedback-message error';
                return;
            }
            
            // AJAX로 중복 확인 요청
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '<c:url value="/user/check-id"/>', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        isIdChecked = true;
                        
                        if (response.isDuplicate) {
                            idFeedback.textContent = '이미 사용 중인 아이디입니다.';
                            idFeedback.className = 'feedback-message error';
                            isIdAvailable = false;
                        } else {
                            idFeedback.textContent = '사용 가능한 아이디입니다.';
                            idFeedback.className = 'feedback-message success';
                            isIdAvailable = true;
                        }
                    } else {
                        idFeedback.textContent = '서버 오류가 발생했습니다.';
                        idFeedback.className = 'feedback-message error';
                    }
                }
            };
            xhr.send('userId=' + encodeURIComponent(userId));
        }
        
        // 이메일 인증 코드 발송 함수
        function sendVerificationCode() {
            const email = document.getElementById('email').value;
            const verificationFeedback = document.getElementById('verificationFeedback');
            
            if (!email) {
                verificationFeedback.textContent = '이메일을 입력해주세요.';
                verificationFeedback.className = 'feedback-message error';
                return;
            }
            
            // 이메일 유효성 검사
            const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            if (!emailRegex.test(email)) {
                verificationFeedback.textContent = '유효한 이메일 주소를 입력해주세요.';
                verificationFeedback.className = 'feedback-message error';
                return;
            }
            
            // AJAX로 이메일 인증 코드 발송 요청
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '<c:url value="/user/send-verification"/>', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            verificationFeedback.textContent = '인증 코드가 발송되었습니다. 이메일을 확인해주세요.';
                            verificationFeedback.className = 'feedback-message success';
                        } else {
                            verificationFeedback.textContent = '인증 코드 발송에 실패했습니다. 다시 시도해주세요.';
                            verificationFeedback.className = 'feedback-message error';
                        }
                    } else {
                        verificationFeedback.textContent = '서버 오류가 발생했습니다.';
                        verificationFeedback.className = 'feedback-message error';
                    }
                }
            };
            xhr.send('email=' + encodeURIComponent(email));
        }
        
        // 인증 코드 확인 함수
        function verifyCode() {
            const email = document.getElementById('email').value;
            const code = document.getElementById('verificationCode').value;
            const verificationFeedback = document.getElementById('verificationFeedback');
            
            if (!code) {
                verificationFeedback.textContent = '인증 코드를 입력해주세요.';
                verificationFeedback.className = 'feedback-message error';
                return;
            }
            
            // AJAX로 인증 코드 확인 요청
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '<c:url value="/user/verify-code"/>', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            verificationFeedback.textContent = '인증이 완료되었습니다.';
                            verificationFeedback.className = 'feedback-message success';
                            isEmailVerified = true;
                        } else {
                            verificationFeedback.textContent = '인증 코드가 올바르지 않습니다. 다시 확인해주세요.';
                            verificationFeedback.className = 'feedback-message error';
                            isEmailVerified = false;
                        }
                    } else {
                        verificationFeedback.textContent = '서버 오류가 발생했습니다.';
                        verificationFeedback.className = 'feedback-message error';
                    }
                }
            };
            xhr.send('email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code));
        }
        
        // 아이디 입력 필드 변경 시 중복 확인 상태 초기화
        document.getElementById('userId').addEventListener('input', function() {
            isIdChecked = false;
            isIdAvailable = false;
            document.getElementById('idFeedback').textContent = '';
        });
        
        // 이메일 입력 필드 변경 시 인증 상태 초기화
        document.getElementById('email').addEventListener('input', function() {
            isEmailVerified = false;
            document.getElementById('verificationFeedback').textContent = '';
        });
        
        // 폼 제출 전 유효성 검사
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            // 아이디 중복 확인 여부 검사
            if (!isIdChecked || !isIdAvailable) {
                e.preventDefault();
                alert('아이디 중복 확인을 해주세요.');
                return;
            }
            
            // 비밀번호 일치 여부 검사
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }
            
            // 비밀번호 복잡성 검사
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/;
            if (!passwordRegex.test(password)) {
                e.preventDefault();
                alert('비밀번호는 영문, 숫자, 특수문자 조합 8-20자로 입력해주세요.');
                return;
            }
            
            // 이메일 인증 확인
            if (!isEmailVerified) {
                e.preventDefault();
                alert('이메일 인증을 완료해주세요.');
                return;
            }
            
            // 성별 선택 확인
            const gender = document.getElementById('gender').value;
            if (!gender) {
                e.preventDefault();
                alert('성별을 선택해주세요.');
                return;
            }
            
            // 생년월일 유효성 검사
            const birthdate = document.getElementById('birthdate').value;
            if (!/^\d{8}$/.test(birthdate)) {
                e.preventDefault();
                alert('생년월일은 8자리 숫자로 입력해주세요. (예: 19990101)');
                return;
            }
        });
    </script>
</body>
</html>