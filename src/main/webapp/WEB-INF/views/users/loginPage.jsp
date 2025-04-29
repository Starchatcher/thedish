<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<style type="text/css">
body {
    margin: 0;
    padding: 0;
    background: #f0f2f5;
    font-family: 'Roboto', sans-serif;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}
.container {
    background: #ffffff;
    padding: 40px 50px;
    border-radius: 12px;
    box-shadow: 0px 4px 20px rgba(0,0,0,0.1);
    width: 400px;
}
h1 {
    text-align: center;
    font-size: 36px;
    color: navy;
    margin-bottom: 30px;
}
form {
    display: flex;
    flex-direction: column;
}
label {
    margin-bottom: 15px;
    font-size: 16px;
    color: navy;
    font-weight: 700;
}
input[type="text"],
input[type="password"] {
    padding: 10px;
    margin-top: 5px;
    border: 1px solid #ced4da;
    border-radius: 8px;
    font-size: 16px;
}
input[type="submit"] {
    margin-top: 20px;
    padding: 12px;
    font-size: 18px;
    font-weight: bold;
    background-color: navy;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s;
}
input[type="submit"]:hover {
    background-color: #003366;
}
</style>
</head>
<body>

<div class="container">
    <h1>로그인</h1>
    <form action="login.do" method="post">
        <label for="userid">아이디
            <input type="text" id="userid" name="userId" required>
        </label>
        <label for="userpwd">비밀번호
            <input type="password" id="userpwd" name="userPwd" required>
        </label>
        <input type="submit" value="로그인">
    </form>
</div>

</body>
</html>
