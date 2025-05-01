<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>건강 맞춤형 추천 검색</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f7fdf8;
      color: #333;
    }
    .main-container {
      max-width: 800px;
      margin: 60px auto;
      padding: 40px;
      background-color: #ffffff;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    .invalid-input {
      border-color: #f44336;
    }
    .no-result {
      padding: 10px;
      color: #f44336;
      text-align: center;
      font-weight: bold;
    }
    h2 {
      font-size: 28px;
      color: #2e7d32;
      margin-bottom: 20px;
    }
    form {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 12px;
      position: relative;
    }
    input[type="text"] {
      padding: 12px 16px;
      width: 60%;
      border: 2px solid #c8e6c9;
      border-radius: 8px;
      font-size: 16px;
    }
    ul#suggestions {
      position: absolute;
      top: 58px;
      left: 20%;
      width: 60%;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 0 0 8px 8px;
      list-style: none;
      margin: 0;
      padding: 0;
      z-index: 999;
      display: none;
    }
    ul#suggestions li {
      padding: 10px;
      text-align: left;
      cursor: pointer;
    }
    ul#suggestions li:hover,
    ul#suggestions li.highlight {
      background-color: #c8e6c9;
      font-weight: bold;
    }
    button[type="submit"] {
      padding: 12px 24px;
      background-color: #66bb6a;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button[type="submit"]:hover {
      background-color: #43a047;
    }
    @media (max-width: 600px) {
      input[type="text"] {
        width: 100%;
      }
      ul#suggestions {
        left: 0;
        width: 100%;
      }
    }
  </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<div class="main-container">
  <h2>예방하고 싶은 질병을 입력하세요</h2>
  <form action="recommendIngredients.do" method="get" onsubmit="return validateSearch();">
    <input type="text" name="condition" id="conditionInput" placeholder="예: 고혈압, 당뇨" autocomplete="off" />
    <ul id="suggestions"></ul>
    <button type="submit">추천 재료 보기</button>
  </form>
</div>

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
    if (e.key === 'ArrowUp' || e.key === 'ArrowDown' || e.key === 'Enter') return;
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
</script>

<script>
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

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
