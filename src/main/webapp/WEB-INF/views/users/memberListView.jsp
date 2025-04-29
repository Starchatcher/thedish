<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.paging.currentPage }">
	<c:set var="nowpage" value="${ requestScope.paging.currentPage }" />
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
<style type="text/css">
body {
    font-family: 'Roboto', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}
.container {
    width: 1200px;
    margin: 50px auto;
    padding: 20px;
    background: #fff;
    box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
}
h1 {
    text-align: center;
    color: navy;
    margin-bottom: 30px;
}
fieldset#ss {
    width: 100%;
    margin-bottom: 30px;
    padding: 20px;
    background: #e9ecef;
    border: none;
    border-radius: 8px;
}
fieldset#ss legend {
    font-size: 1.2em;
    font-weight: bold;
}
form.sform {
    margin: 20px 0;
    padding: 20px;
    background: #f1f3f5;
    border-radius: 8px;
    display: none;
}
form.sform input[type="submit"] {
    background: navy;
    color: white;
    border: none;
    padding: 8px 16px;
    margin-top: 10px;
    border-radius: 4px;
    cursor: pointer;
}
form.sform input[type="submit"]:hover {
    background: #003366;
}
button {
    background: navy;
    color: white;
    padding: 10px 20px;
    margin: 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1em;
}
button:hover {
    background: #003366;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
table th, table td {
    border: 1px solid #dee2e6;
    padding: 10px;
    text-align: center;
}
table th {
    background: #343a40;
    color: white;
}
table tr:nth-child(even) {
    background: #f1f3f5;
}
table tr:hover {
    background: #dee2e6;
}
</style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
    $('input[name=item]').on('change', function(){
        $('input[name=item]').each(function(index){
            if($(this).is(':checked')){
                $('form.sform').eq(index).css('display', 'block');
            } else {
                $('form.sform').eq(index).css('display', 'none');
            }
        });
    });
});

function changeLogin(element) {
    var userid = element.name.substring(8);
    if(element.checked == true && element.value == 'false') {
        location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userId=" + userid + "&loginOk=N";
    } else if(element.checked == true && element.value == 'true') {
        location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userId=" + userid + "&loginOk=Y";
    }
}
</script>
</head>
<body>

<div class="container">
    <c:import url="/WEB-INF/views/common/menubar.jsp" />
    <h1>회원 관리</h1>

    <center>
        <button onclick="location.href='${ pageContext.servletContext.contextPath }/mlist.do?page=1';">회원 전체 목록</button>
    </center>

    <fieldset id="ss">
        <legend>검색 항목 선택</legend>
        <input type="radio" name="item" id="uid"> 회원 아이디
        <input type="radio" name="item" id="ugen"> 성별
        <input type="radio" name="item" id="uage"> 연령대
        <input type="radio" name="item" id="uenroll"> 가입날짜
        <input type="radio" name="item" id="ulogok"> 로그인 제한여부
    </fieldset>

    <!-- 검색 폼들 -->
    <form action="msearch.do" id="uidform" class="sform" method="get">
        <input type="hidden" name="action" value="uid">
        <fieldset>
            <legend>회원 아이디 검색</legend>
            <input type="search" name="keyword" size="50">
            <input type="submit" value="검색">
        </fieldset>
    </form>

    <form action="msearch.do" id="ugenform" class="sform" method="get">
        <input type="hidden" name="action" value="ugen">
        <fieldset>
            <legend>성별 검색</legend>
            <input type="radio" name="keyword" value="M"> 남자
            <input type="radio" name="keyword" value="F"> 여자
            <input type="submit" value="검색">
        </fieldset>
    </form>

    <form action="msearch.do" id="uageform" class="sform" method="get">
        <input type="hidden" name="action" value="uage">
        <fieldset>
            <legend>연령대 검색</legend>
            <input type="radio" name="keyword" value="20"> 20대
            <input type="radio" name="keyword" value="30"> 30대
            <input type="radio" name="keyword" value="40"> 40대
            <input type="radio" name="keyword" value="50"> 50대
            <input type="radio" name="keyword" value="60"> 60대 이상
            <input type="submit" value="검색">
        </fieldset>
    </form>

    <form action="msearch.do" id="uenrollform" class="sform" method="get">
        <input type="hidden" name="action" value="uenroll">
        <fieldset>
            <legend>가입 날짜 검색</legend>
            <input type="date" name="begin"> ~ <input type="date" name="end">
            <input type="submit" value="검색">
        </fieldset>
    </form>

    <form action="msearch.do" id="ulogokform" class="sform" method="get">
        <input type="hidden" name="action" value="ulogok">
        <fieldset>
            <legend>로그인 제한 여부 검색</legend>
            <input type="radio" name="keyword" value="Y"> 로그인 가능
            <input type="radio" name="keyword" value="N"> 로그인 제한
            <input type="submit" value="검색">
        </fieldset>
    </form>

    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>성별</th>
                <th>나이</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>가입날짜</th>
                <th>마지막 수정날짜</th>
                <th>가입방식</th>
                <th>로그인 제한여부</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${ requestScope.list }" var="m">
                <tr>
                    <td>${ m.userId }</td>
                    <td>${ m.userName }</td>
                    <td>${ m.gender eq "M" ? "남자" : "여자" }</td>
                    <td>${ m.age }</td>
                    <td>${ m.phone }</td>
                    <td>${ m.email }</td>
                    <td>${ m.enrollDate }</td>
                    <td>${ m.lastModified }</td>
                    <td>${ m.signType }</td>
                    <td>
                        <c:if test="${ m.loginOk eq 'Y' }">
                            <input type="radio" name="loginok_${ m.userId }" value="true" checked onchange="changeLogin(this);"> 가능
                            <input type="radio" name="loginok_${ m.userId }" value="false" onchange="changeLogin(this);"> 제한
                        </c:if>
                        <c:if test="${ m.loginOk eq 'N' }">
                            <input type="radio" name="loginok_${ m.userId }" value="true" onchange="changeLogin(this);"> 가능
                            <input type="radio" name="loginok_${ m.userId }" value="false" checked onchange="changeLogin(this);"> 제한
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <c:import url="/WEB-INF/views/common/pagingView.jsp" />
    <hr>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</div>

</body>
</html>
