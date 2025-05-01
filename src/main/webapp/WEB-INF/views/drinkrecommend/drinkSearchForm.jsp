<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
        .slider-container {
            margin: 20px 0;
        }
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
        <span id="maxPriceValue">1000000원</span>
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

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>