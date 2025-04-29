<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Dish FAQ</title>
<style>
    /* 전체 페이지 기본 스타일 */
    body  {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f8f8f8;
    }

    h1 {
        color: #333;
        text-align: center;
        margin-bottom: 30px;
    }

    /* FAQ 목록 컨테이너 스타일 */
    #faqListContainer {
        max-width: 800px; /* 최대 너비 설정 */
        margin: 20px auto; /* 가운데 정렬 */
        background-color: #fff; /* 하얀 배경 */
        border-radius: 8px; /* 모서리 둥글게 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
        overflow: hidden; /* 컨테이너 넘치는 내용 숨김 */
    }

    /* 개별 FAQ 항목 스타일 */
    .faq-item {
        border-bottom: 1px solid #eee; /* 하단 구분선 */
    }
    .faq-item:last-child {
        border-bottom: none; /* 마지막 항목 하단선 제거 */
    }

    /* 질문 부분 스타일 */
    .question {
        font-weight: bold;
        color: #555;
        padding: 15px 20px; /* 안쪽 여백 */
        cursor: pointer; /* 클릭 가능한 모양 */
        background-color: #fefefe; /* 질문 배경색 */
        position: relative; /* ::after 위치 기준으로 설정 */
        transition: background-color 0.3s ease; /* 호버 시 부드러운 전환 */
    }

    .question:hover {
        background-color: #f0f0f0; /* 호버 시 배경색 변경 */
    }

    /* 드롭다운 화살표 (::after 가상 요소 사용) */
    .question::after {
        content: '+'; /* 기본 상태는 '+' */
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%); /* 세로 중앙 정렬 */
        font-size: 1.2em;
        transition: transform 0.3s ease; /* 회전 시 부드러운 전환 */
        color: #888;
    }

    /* 답변이 보이는 상태일 때 질문 스타일 및 화살표 변경 */
    .faq-item.active .question {
        background-color: #f0f0f0; /* 활성화 상태 배경색 */
    }
    .faq-item.active .question::after {
        content: '-'; /* 활성화 상태는 '-' */
        transform: translateY(-50%) rotate(0deg); /* 회전 초기화 (또는 45deg로 X자 모양 가능) */
        color: #333;
    }


    /* 답변 부분 스타일 */
     .answer {
        margin-top: 0;
        padding: 0 20px; /* 기본 패딩 (닫혔을 때) */
        color: #777;
        background-color: #fff;
        overflow: hidden; /* 내용이 넘칠 경우 숨김 */

        max-height: 0; /* 기본 상태: 높이 0으로 숨김 */
        transition: max-height 0.5s ease-out, padding 0.5s ease-out; /* 부드러운 전환 효과 */
    }

    /* 답변이 보이는 상태일 때 스타일 */
    .faq-item.active .answer {
         max-height: 2000px; /* <-- 충분히 큰 값으로 설정 */
         padding: 15px 20px; /* 열렸을 때 패딩 */
    }
    /* FAQ 없을 때 메시지 스타일 */
    #faqListContainer p {
        text-align: center;
        padding: 20px;
        color: #777;
    }

</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
  <h1>자주 묻는 질문 (FAQ)</h1>

    <div id="faqListContainer">
        <%-- 컨트롤러에서 넘겨받은 faqList 데이터 사용 --%>
        <c:choose>
            <c:when test="${not empty faqList}">
                <c:forEach var="faq" items="${faqList}">
                    <div class="faq-item">
                        <div class="question">
                            Q: <c:out value="${faq.question}"/>
                        </div>
                        <div class="answer">
                            A: <c:out value="${faq.answer}"/>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>등록된 FAQ가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        document.querySelectorAll('.question').forEach(item => {
            item.addEventListener('click', event => {
                // 클릭된 질문의 부모인 .faq-item 요소를 찾음
                const faqItem = item.closest('.faq-item');

                // 해당 faq-item에 'active' 클래스를 토글 (추가 또는 제거)
                faqItem.classList.toggle('active');

                // 다른 열려있는 FAQ 항목 닫기 (선택 사항)
                document.querySelectorAll('.faq-item.active').forEach(openItem => {
                    if (openItem !== faqItem) { // 방금 클릭한 항목이 아니면
                         openItem.classList.remove('active'); // active 클래스 제거
                    }
                });
            });
        });

         // 페이지 로드 시 모든 답변을 CSS의 max-height: 0으로 숨김 (별도의 JS display: none 설정 제거)
         // CSS에서 .answer { max-height: 0; overflow: hidden; ... } 속성으로 기본적으로 숨겨져야 함

    </script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>