<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>맞춤형 건강 레시피 추천</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #fff9f0;
    }

    .main-container {
      width: 100%;
      min-height: 70vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 60px 20px;
    }

    .search-box {
      background-color: #ffffffcc;
      backdrop-filter: blur(5px);
      padding: 40px 30px;
      border-radius: 20px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
      text-align: center;
      max-width: 520px;
      width: 100%;
    }

    .search-box h2 {
      font-size: 24px;
      color: #d84315;
      margin-bottom: 20px;
      line-height: 1.6;
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 16px;
      position: relative;
    }

    input[type="text"] {
      padding: 14px 18px;
      width: 100%;
      border: 2px solid #ffab91;
      border-radius: 8px;
      font-size: 16px;
      box-sizing: border-box;
    }

    .invalid-input {
      border-color: #f44336;
    }

    button[type="submit"] {
      padding: 12px 24px;
      background-color: #ff7043;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button[type="submit"]:hover {
      background-color: #bf360c;
    }

    ul#suggestions {
      position: absolute;
      top: 100%;
      left: 0;
      width: 100%;
      background: #fff;
      border: 1px solid #ccc;
      border-radius: 0 0 8px 8px;
      list-style: none;
      padding: 0;
      margin: 0;
      display: none;
      z-index: 999;
    }

    ul#suggestions li {
      padding: 10px;
      cursor: pointer;
      text-align: left;
    }

    ul#suggestions li:hover,
    ul#suggestions li.highlight {
      background-color: #ffe0b2;
      font-weight: bold;
    }

    .no-result {
      padding: 10px;
      color: #f44336;
      font-weight: bold;
      text-align: center;
    }

    @media (max-width: 600px) {
      .search-box {
        padding: 30px 20px;
      }
    }
    .chef-hat {
  position: absolute;
  top: -80px;        /* 더 아래로 내려서 씌운 느낌 */
  left: -65px;       /* 왼쪽 모서리에 딱 맞게 */
  width: 150px;      /* 확실하게 크고 눈에 띄게 */
  transform: rotate(-29deg) scaleX(1.6);
  z-index: 10;
  pointer-events: none;
  filter: drop-shadow(3px 3px 4px rgba(0, 0, 0, 0.15));
}


  </style>
</head>
<body>

<!-- ✅ 공통 메뉴바 -->
<c:import url="/WEB-INF/views/common/recommendMenubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<!-- ✅ 메인 영역 -->
<div class="main-container">
  <div class="search-box">
  <img src="${pageContext.request.contextPath}/resources/images/chef-hat.png" class="chef-hat" alt="요리사 모자" />
    <h2>🍽 어떤 질병이든,<br/>맛있게 이겨낼 수 있어요!</h2>
    <form action="recommendIngredients.do" method="get" onsubmit="return validateSearch();">
      <input type="text" name="condition" id="conditionInput" placeholder="예: 감기, 고혈압, 당뇨병" autocomplete="off" />
      <ul id="suggestions"></ul>
      <button type="submit">🥗 맞춤 재료 추천 받기</button>
    </form>
  </div>
</div>

<!-- ✅ 자동완성 스크립트 -->
<script>
$(document).ready(function () {
  let selectedIndex = -1;

  $('#conditionInput').on('keydown', function (e) {
    const items = $('#suggestions li');
    if (e.key === 'ArrowDown') {
      if (items.length > 0) {
        selectedIndex = (selectedIndex + 1) % items.length;
        items.removeClass('highlight');
        items.eq(selectedIndex).addClass('highlight');
      }
      e.preventDefault();
    } else if (e.key === 'ArrowUp') {
      if (items.length > 0) {
        selectedIndex = (selectedIndex - 1 + items.length) % items.length;
        items.removeClass('highlight');
        items.eq(selectedIndex).addClass('highlight');
      }
      e.preventDefault();
    } else if (e.key === 'Enter') {
      if (selectedIndex >= 0 && items.length > 0) {
        $('#conditionInput').val(items.eq(selectedIndex).text());
        $('#suggestions').hide();
        selectedIndex = -1;
        e.preventDefault();
      }
    }
  });

  $('#conditionInput').on('keyup', function (e) {
    const query = $(this).val();
    if (['ArrowDown', 'ArrowUp', 'Enter'].includes(e.key)) return;
    selectedIndex = -1;
    if (query.length > 0) {
      $.ajax({
        url: 'autocompleteCondition.do',
        type: 'get',
        data: { keyword: query },
        success: function (data) {
          if (data.length > 0) {
            let html = '';
            data.forEach(name => {
              html += '<li class="suggest-item">' + name + '</li>';
            });
            $('#suggestions').html(html).show();
            $('#conditionInput').removeClass('invalid-input');
          } else {
            $('#suggestions').html('<li class="no-result">존재하지 않습니다. 다시 입력해주세요.</li>').show();
            $('#conditionInput').addClass('invalid-input');
          }
        },
        error: function () {
          console.error('자동완성 실패');
        }
      });
    } else {
      $('#suggestions').hide();
    }
  });

  $(document).on('click', '.suggest-item', function () {
    $('#conditionInput').val($(this).text());
    $('#suggestions').hide();
    selectedIndex = -1;
  });
});

function validateSearch() {
  const keyword = $('#conditionInput').val();
  if (keyword.length < 1) {
    alert("1글자 이상 입력해주세요.");
    return false;
  }
  let isValid = false;
  $.ajax({
    url: 'checkConditionExists.do',
    type: 'get',
    data: { keyword },
    async: false,
    success: function (result) {
      isValid = result === true || result === 'true';
    },
    error: function () {
      alert("서버 오류 발생");
    }
  });
  if (!isValid) {
    alert("없는 질병입니다.");
    return false;
  }
  return true;
}
</script>

<!-- ✅ 공통 푸터 -->
<c:import url="/WEB-INF/views/common/recommendFooter.jsp" />
</body>
</html>
