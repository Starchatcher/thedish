<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 정보 보기</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<style type="text/css">
body {
    font-family: 'Roboto', sans-serif;
    background-color: #f5f6fa;
    margin: 0;
    padding: 0;
}
.container {
    width: 800px;
    margin: 50px auto;
    background: #ffffff;
    border-radius: 10px;
    padding: 40px;
    box-shadow: 0px 0px 20px rgba(0,0,0,0.1);
}
h1 {
    text-align: center;
    color: navy;
    margin-bottom: 40px;
}
form {
    display: flex;
    flex-direction: column;
}
fieldset {
    border: none;
}
.form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
}
.form-group label {
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
}
.form-group input[type="text"],
.form-group input[type="password"],
.form-group input[type="email"],
.form-group input[type="tel"],
.form-group input[type="number"],
.form-group input[type="date"],
.form-group input[type="file"] {
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 8px;
    outline: none;
}
.form-group input[type="radio"] {
    margin-right: 5px;
}
.photo-preview {
    margin-bottom: 20px;
    text-align: center;
}
.photo-preview img {
    width: 150px;
    height: 160px;
    object-fit: cover;
    border: 2px solid navy;
    border-radius: 8px;
}
.button-group {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 30px;
}
.button-group input[type="submit"],
.button-group input[type="reset"],
.button-group a {
    background: navy;
    color: white;
    padding: 10px 20px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s;
    border: none;
    cursor: pointer;
}
.button-group input[type="submit"]:hover,
.button-group input[type="reset"]:hover,
.button-group a:hover {
    background: #003366;
}
.hidden-input {
    display: none;
}
</style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
function validate() {
    var pwdValue = $('#userPwd').val();
    var pwdValue2 = $('#userPwd2').val();
    
    if (pwdValue !== pwdValue2) {
        alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
        $('#userPwd').val('');
        $('#userPwd2').val('');
        $('#userPwd').focus();
        return false;
    }
    return true;
}

window.onload = function(){
    var photofile = document.getElementById('photofile');
    photofile.addEventListener('change', function(event){
        const files = event.currentTarget.files;
        const file = files[0];
        const reader = new FileReader();
        reader.onload = (e) => {
            document.getElementById('photo').setAttribute('src', e.target.result);
        };
        reader.readAsDataURL(file);
    });
};
</script>
</head>

<body>
<div class="container">
    <h1>내 정보 보기</h1>

    <form action="mupdate.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
        <input type="hidden" name="originalPwd" value="${ requestScope.member.userPwd }">
        <input type="hidden" name="ofile" value="${ requestScope.ofile }">

        <div class="photo-preview">
            <c:choose>
                <c:when test="${ !empty requestScope.member.photoFileName }">
                    <img src="/first/resources/photoFiles/${ requestScope.member.photoFileName }" id="photo" alt="프로필 사진">
                </c:when>
                <c:otherwise>
                    <img src="/first/resources/images/photo1.jpg" id="photo" alt="프로필 사진">
                </c:otherwise>
            </c:choose>
            <div style="margin-top:10px;">
                <input type="file" id="photofile" name="photofile">
            </div>
        </div>

        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" name="userId" id="userId" value="${ requestScope.member.userId }" readonly>
        </div>

        <div class="form-group">
            <label for="userPwd">암호</label>
            <input type="password" name="userPwd" id="userPwd">
        </div>

        <div class="form-group">
            <label for="userPwd2">암호확인</label>
            <input type="password" id="userPwd2">
        </div>

        <div class="form-group">
            <label for="userName">이름</label>
            <input type="text" name="userName" id="userName" value="${ requestScope.member.userName }" readonly>
        </div>

        <div class="form-group">
            <label>성별</label>
            <c:choose>
                <c:when test="${ requestScope.member.gender eq 'M' }">
                    <input type="radio" name="gender" value="M" checked> 남자
                    <input type="radio" name="gender" value="F"> 여자
                </c:when>
                <c:otherwise>
                    <input type="radio" name="gender" value="M"> 남자
                    <input type="radio" name="gender" value="F" checked> 여자
                </c:otherwise>
            </c:choose>
        </div>

        <div class="form-group">
            <label for="age">나이</label>
            <input type="number" name="age" min="19" max="100" value="${ member.age }">
        </div>

        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="tel" name="phone" value="${ member.phone }">
        </div>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" value="${ member.email }">
        </div>

        <div class="button-group">
            <input type="submit" value="수정하기">
            <input type="reset" value="수정취소">
            <c:url var="mdel" value="mdelete.do">
                <c:param name="userId" value="${ requestScope.member.userId }"></c:param>
            </c:url>
            <a href="${ mdel }">탈퇴하기</a>
            <a href="main.do">Home</a>
        </div>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
