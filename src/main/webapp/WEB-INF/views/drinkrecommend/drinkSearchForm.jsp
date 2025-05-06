<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식 검색 및 술 추천</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Arial', sans-serif;
        /* 두 번째 페이지의 배경 그라디언트 적용 */
        background: linear-gradient(120deg, #f8d5dc, #d3eaf2);
        /* 전체 페이지 중앙 정렬 스타일은 menubar, sidebar와 함께 사용하기 어려워 제외 */
        /* height: 100vh; display: flex; align-items: center; justify-content: center; */
    }

    /* 검색 컨테이너 스타일 적용 (로그인 컨테이너 스타일 참고) */
    .search-container {
        background-color: rgba(255, 255, 255, 0.8); /* 투명한 배경 */
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        max-width: 700px; /* 너비 조정 (슬라이더를 고려하여 조금 더 넓게 설정) */
        margin: 50px auto; /* 페이지 중앙에 배치 및 상하 마진 추가 */
        text-align: left; /* 내용 정렬을 왼쪽으로 변경 */
    }

    /* 컨테이너 내 제목 및 설명 중앙 정렬 */
    .search-container h2,
    .search-container p {
        text-align: center;
        margin-bottom: 20px;
    }

    /* 검색 입력 그룹 (input과 button) 스타일 */
    .search-container .input-group {
        display: flex; /* 가로로 배치 */
        margin-bottom: 20px;
        align-items: center; /* 세로 중앙 정렬 */
    }

    .search-container .input-group input[type="text"] {
        flex-grow: 1; /* 남은 공간 채우기 */
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-right: 10px;
        font-size: 1rem; /* 폰트 크기 조정 */
    }

    .search-container .input-group button {
        padding: 10px 20px;
        background-color: #f29abf; /* 두 번째 페이지에서 사용된 색상 계열 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease; /* 호버 효과 */
        font-size: 1rem; /* 폰트 크기 조정 */
    }

    .search-container .input-group button:hover {
        background-color: #e089a8; /* 호버 시 색상 변경 */
    }

    /* 슬라이더 컨테이너 스타일 */
    .slider-container {
        margin: 20px 0;
        padding: 0 10px; /* 슬라이더 영역 내부 패딩 */
    }

    .slider-container label {
        display: block; /* 라벨을 별도 줄로 */
        margin-bottom: 8px; /* 라벨과 슬라이더 간 간격 */
        font-weight: bold;
    }

    .slider-container input[type="range"] {
        width: calc(100% - 80px); /* 값 표시 영역 확보 */
        vertical-align: middle; /* 라벨/값과 세로 정렬 */
        margin-right: 10px;
    }

    .slider-container span {
        display: inline-block;
        width: 70px; /* 값 표시 영역 너비 */
        text-align: right;
        vertical-align: middle; /* 라벨/슬라이더와 세로 정렬 */
    }

    /* 추가적인 스타일 조정 (필요에 따라 추가) */
    /* 예: menubar, sidebar와 search-container 간의 간격 조정 등 */

</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="search-container">
    <h2>검색 키워드</h2>
    <p>검색하실 음식를 입력하세요.<br>EX) 치즈, 튀김</p>
    
    <form action="drinkSearchRecommend.do" method="get">
        <div class="input-group">
            <input type="text" name="keyword" placeholder="검색어를 입력하세요" required>
            <button type="submit">추천 술 보기</button>
        </div>
        
        <div class="slider-container">
            <label for="minPrice">최소 가격:</label>
            <input type="range" id="minPrice" name="minPrice" min="0" max="100000" value="0" step="1000">
            <span id="minPriceValue">0원</span>
        </div>

        <div class="slider-container">
            <label for="maxPrice">최대 가격:</label>
            <input type="range" id="maxPrice" name="maxPrice" min="0" max="100000" value="100000" step="1000">
            <span id="maxPriceValue">100000원</span>
        </div>

        <div class="slider-container">
            <label for="minAlcohol">최소 알코올 도수:</label>
            <input type="range" id="minAlcohol" name="minAlcohol" min="0" max="100" value="0" step="1">
            <span id="minAlcoholValue">0%</span>
        </div>

        <div class="slider-container">
            <label for="maxAlcohol">최대 알코올 도수:</label>
            <input type="range" id="maxAlcohol" name="maxAlcohol" min="0" max="100" value="100" step="1">
            <span id="maxAlcoholValue">100%</span>
        </div>

    </form>

    <script>
        // 가격 슬라이더
        const minPriceSlider = document.getElementById('minPrice');
        const minPriceValue = document.getElementById('minPriceValue');
        const maxPriceSlider = document.getElementById('maxPrice');
        const maxPriceValue = document.getElementById('maxPriceValue');

        minPriceSlider.oninput = function() {
            minPriceValue.textContent = this.value + '원';
            if (parseInt(minPriceSlider.value) > parseInt(maxPriceSlider.value)) {
                maxPriceSlider.value = minPriceSlider.value;
                maxPriceValue.textContent = minPriceSlider.value + '원';
            }
        }

        maxPriceSlider.oninput = function() {
            maxPriceValue.textContent = this.value + '원';
            if (parseInt(maxPriceSlider.value) < parseInt(minPriceSlider.value)) {
                minPriceSlider.value = maxPriceSlider.value;
                minPriceValue.textContent = maxPriceSlider.value + '원';
            }
        }

        // 알코올 도수 슬라이더
        const minAlcoholSlider = document.getElementById('minAlcohol');
        const minAlcoholValue = document.getElementById('minAlcoholValue');
        const maxAlcoholSlider = document.getElementById('maxAlcohol');
        const maxAlcoholValue = document.getElementById('maxAlcoholValue');

        minAlcoholSlider.oninput = function() {
            minAlcoholValue.textContent = this.value + '%';
            if (parseInt(minAlcoholSlider.value) > parseInt(maxAlcoholSlider.value)) {
                maxAlcoholSlider.value = minAlcoholSlider.value;
                maxAlcoholValue.textContent = minAlcoholSlider.value + '%';
            }
        }

        maxAlcoholSlider.oninput = function() {
            maxAlcoholValue.textContent = this.value + '%';
            if (parseInt(maxAlcoholSlider.value) < parseInt(minAlcoholSlider.value)) {
                minAlcoholSlider.value = maxAlcoholSlider.value;
                minAlcoholValue.textContent = maxAlcoholSlider.value + '%';
            }
        }
    </script>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
