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
    /* 흑백 모던 스타일 배경: 밝은 회색 계열 */
    background: #f0f0f0; /* 밝은 회색 배경 */
    /* 전체 페이지 중앙 정렬 스타일은 menubar, sidebar와 함께 사용하기 어려워 제외 - 유지 */
    /* height: 100vh; display: flex; align-items: center; justify-content: center; */
    color: #333; /* 기본 글자색: 어두운 회색 */
}

/* 검색 컨테이너 스타일 적용 (로그인 컨테이너 스타일 참고) */
.search-container {
    /* 흑백 모던 스타일 배경: 흰색 또는 약간의 투명도 있는 흰색 */
    background-color: #ffffff; /* 흰색 배경 */
    /* background-color: rgba(255, 255, 255, 0.9); /* 약간 투명한 흰색 (선택 사항) */
    padding: 40px;
    border-radius: 10px; /* 둥근 모서리 (너무 둥글지 않게) */
    /* 그림자 효과: 부드럽고 은은한 회색 그림자 */
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    max-width: 700px; /* 너비 조정 유지 */
    margin: 50px auto; /* 페이지 중앙에 배치 및 상하 마진 추가 유지 */
    text-align: left; /* 내용 정렬을 왼쪽으로 변경 유지 */
    border: 1px solid #ddd; /* 얇은 경계선 추가 (선택 사항) */
}

/* 컨테이너 내 제목 및 설명 스타일 */
.search-container h2,
.search-container p {
    text-align: center;
    margin-bottom: 20px;
    color: #222; /* 글자색: 더 진한 회색 */
}

/* 검색 입력 그룹 (input과 button) 스타일 */
.search-container .input-group {
    display: flex; /* 가로로 배치 유지 */
    margin-bottom: 20px;
    align-items: center; /* 세로 가운데 정렬 유지 */
}

.search-container .input-group input[type="text"] {
    flex-grow: 1; /* 남은 공간 채우기 유지 */
    padding: 10px;
    border: 1px solid #ccc; /* 경계선 색상 변경 */
    border-radius: 5px;
    margin-right: 10px;
    font-size: 1rem;
    color: #333; /* 입력 글자색 */
    box-sizing: border-box; /* 패딩 포함 너비 계산 */
}

.search-container .input-group input[type="text"]:focus {
    border-color: #888; /* 포커스 시 경계선 색상 변경 */
    outline: none;
    box-shadow: 0 0 5px rgba(136, 136, 136, 0.3);
}


.search-container .input-group button {
    padding: 10px 20px;
    /* 흑백 모던 스타일 버튼 배경색 */
    background-color: #555; /* 중간 회색 */
    color: white; /* 글자색 흰색 유지 */
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    font-size: 1rem;
}

.search-container .input-group button:hover {
    /* 호버 시 배경색 더 어둡게 */
    background-color: #333;
}

/* 슬라이더 컨테이너 스타일 */
.slider-container {
    margin: 20px 0;
    padding: 0 10px; /* 슬라이더 영역 내부 패딩 유지 */
    color: #333; /* 슬라이더 라벨 및 값 글자색 */
}

.slider-container label {
    display: block; /* 라벨을 별도 줄로 */
    margin-bottom: 8px; /* 라벨과 슬라이더 간 간격 */
    font-weight: bold; /* 글자 굵게 */
    color: #555; /* 라벨 글자색 */
}

.slider-container input[type="range"] {
    width: calc(100% - 80px); /* 값 표시 영역 확보 */
    vertical-align: middle; /* 라벨/값과 세로 정렬 */
    margin-right: 10px;

    -webkit-appearance: none; /* 기본 스타일 제거 */
    appearance: none; /* 기본 스타일 제거 */
    background: transparent; /* 기본 배경 투명 */
    cursor: pointer; /* 마우스 커서 모양 */
    /* CSS 변수 선언 - JavaScript에서 이 값을 업데이트함 */
    --fill-percentage: 0%; /* 초기값 */
}

/* 슬라이더 트랙 스타일 */
.slider-container input[type="range"]::-webkit-slider-runnable-track {
    height: 8px; /* 트랙 높이 */
    background: linear-gradient(to right, #333 var(--fill-percentage), #ddd var(--fill-percentage)); /* 채워지는 색상 */
    border-radius: 5px; /* 둥근 모서리 */
}

.slider-container input[type="range"]::-moz-range-track {
    height: 8px; /* 트랙 높이 */
    background: linear-gradient(to right, #333 var(--fill-percentage), #ddd var(--fill-percentage)); /* 채워지는 색상 */
    border-radius: 5px; /* 둥근 모서리 */
}

.slider-container input[type="range"]::-ms-track {
    height: 8px; /* 트랙 높이 */
    background: transparent; /* 기본 배경 투명 */
}

/* 슬라이더 핸들 (thumb) 스타일 */
.slider-container input[type="range"]::-webkit-slider-thumb {
    -webkit-appearance: none; /* 기본 스타일 제거 */
    appearance: none; /* 기본 스타일 제거 */
    margin-top: -5px; /* 트랙 중앙 정렬 */
    background-color: #555; /* 핸들 색상: 중간 회색 */
    border: 1px solid #333; /* 핸들 테두리 */
    border-radius: 50%; /* 원형 */
    height: 18px; /* 핸들 크기 */
    width: 18px; /* 핸들 크기 */
}

.slider-container input[type="range"]::-moz-range-thumb {
    background-color: #555; /* 핸들 색상: 중간 회색 */
    border: 1px solid #333; /* 핸들 테두리 */
    border-radius: 50%; /* 원형 */
    height: 18px; /* 핸들 크기 */
    width: 18px; /* 핸들 크기 */
}

.slider-container input[type="range"]::-ms-thumb {
    background-color: #555; /* 핸들 색상: 중간 회색 */
    border: 1px solid #333; /* 핸들 테두리 */
    border-radius: 50%; /* 원형 */
    height: 18px; /* 핸들 크기 */
    width: 18px; /* 핸들 크기 */
}

/* 슬라이더 핸들 호버 스타일 */
.slider-container input[type="range"]:hover::-webkit-slider-thumb {
    background-color: #333; /* 호버 시 더 어두운 회색 */
}

.slider-container input[type="range"]:hover::-moz-range-thumb {
    background-color: #333; /* 호버 시 더 어두운 회색 */
}

.slider-container input[type="range"]:hover::-ms-thumb {
    background-color: #333; /* 호버 시 더 어두운 회색 */
}

/* 슬라이더 값 표시 스타일 */
.slider-container span {
    display: inline-block; /* 값 표시 영역을 인라인 블록으로 유지 */
    width: 70px; /* 값 표시 영역 너비 유지 */
    text-align: right; /* 텍스트 오른쪽 정렬 유지 */
    vertical-align: middle; /* 라벨/슬라이더와 세로 정렬 유지 */
    font-weight: bold; /* 값 표시 글자 굵게 */
    color: #333; /* 어두운 회색 */
}

</style>

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />


<div class="search-container">
    <h2>검색 키워드</h2>
    <p>검색하실 키워드를 입력하세요.<br>EX) 치즈, 12년, 꿀</p>
    
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
            <span id="maxPriceValue">500000원</span>
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
