<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>레시피 등록</title>
    <style>
       /* insertRecipe.jsp 파일 내 <style> 태그 안에 추가 */

body {
    font-family: Arial, sans-serif;
    background-color: #f8f8f8; /* 목록 페이지와 동일한 배경색 */
    margin: 0;
    padding: 20px;
    line-height: 1.6; /* 가독성을 위한 줄 간격 */
}

h1 {
    text-align: center;
    margin-bottom: 30px; /* 제목 아래 여백 */
    color: #333; /* 제목 색상 */
}

/* 폼 컨테이너 역할을 할 form 태그 자체 스타일 */
form {
    max-width: 700px; /* 폼 전체의 최대 너비 지정 */
    margin: 0 auto; /* 가운데 정렬 */
    padding: 30px; /* 폼 내부 여백 */
    background-color: #fff; /* 흰색 배경 */
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

label {
    display: block; /* 라벨을 블록 레벨 요소로 만들어 줄바꿈 */
    margin-top: 15px; /* 라벨 위쪽 여백 */
    margin-bottom: 5px; /* 라벨 아래쪽 여백 */
    font-weight: bold;
    color: #555; /* 라벨 글자색 */
}

/* 텍스트 입력, 텍스트 영역, 드롭다운 메뉴 */
input[type="text"],
textarea,
select {
    width: 100%; /* 부모 요소(form 또는 감싸는 div) 너비에 꽉 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 둥근 모서리 */
    box-sizing: border-box; /* 패딩과 보더를 너비에 포함 */
    font-size: 14px; /* 글자 크기 */
}

textarea {
    resize: vertical; /* 세로 방향으로만 크기 조절 허용 */
    min-height: 100px; /* 최소 높이 지정 */
}

select {
    /* select 태그의 기본 스타일은 브라우저마다 다를 수 있습니다. */
    /* 필요에 따라 추가 스타일링 (예: 화살표 모양 변경) 필요 */
}

/* 숨겨진 진짜 input */
input[type="file"] {
    display: none;
}

/* 사용자 정의 파일 업로드 버튼 */
.custom-file-label {
    display: inline-block;
    padding: 10px 20px;
    background-color: #2f2f2f;
    color: #ffffff;
    font-size: 14px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.custom-file-label:hover {
    background-color: #444;
}

/* 필수 입력 표시 (*) 스타일 */
span[style="color:red"] { /* HTML에 직접 style로 지정된 색상을 타겟팅 */
    margin-left: 4px; /* 앞의 텍스트와 간격 */
}


/* 버튼 스타일 */
.submit-btn {
    display: block; /* 버튼을 블록 요소로 만들고 */
    width: auto; /* 너비 자동 (텍스트 내용에 맞게) */
    margin: 30px auto 0; /* 위쪽 여백, 좌우 auto로 가운데 정렬 */
    padding: 12px 30px; /* 내부 여백 */
    font-size: 16px;
    font-weight: bold;
    color: white; /* 글자색 */
    background-color: #444; /* 목록 페이지 검색 버튼 색상 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 커서 모양 변경 */
    transition: background-color 0.3s ease; /* 호버 시 부드러운 전환 */
}

.submit-btn:hover {
    background-color: #777; /* 호버 시 색상 변경 */
}

/* 필드셋 스타일 (선택 사항) */
fieldset {
    border: 1px solid #ddd;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 8px;
}

legend {
    font-size: 1.1em;
    font-weight: bold;
    color: #333;
    padding: 0 10px;
}

    </style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

    <h1>레시피 등록</h1>
    <form action="${pageContext.request.contextPath}/insertRecipe.do" method="post" enctype="multipart/form-data">
	
        <!-- 기존 입력 필드들 (생략 가능) -->
        <label for="name">레시피명 (NAME) <span style="color:red">*</span>:</label>
        <input type="text" id="name" name="name" maxlength="200" required />

        <label for="category">카테고리 (RECIPE_CATEGORY) <span style="color:red">*</span>:</label>
        <select id="category" name="recipeCategory" required>
            <option value="">-- 선택하세요 --</option>
        <option value="일품" ${recipe.recipeCategory == '일품' ? 'selected' : ''}>일품</option>
        <option value="찌개" ${recipe.recipeCategory == '찌개' ? 'selected' : ''}>찌개</option>
        <option value="반찬" ${recipe.recipeCategory == '반찬' ? 'selected' : ''}>반찬</option>
        <option value="스프" ${recipe.recipeCategory == '스프' ? 'selected' : ''}>스프</option>
        <option value="후식" ${recipe.recipeCategory == '후식' ? 'selected' : ''}>후식</option>
        <option value="국" ${recipe.recipeCategory == '국' ? 'selected' : ''}>국</option>
        <option value="밥" ${recipe.recipeCategory == '밥' ? 'selected' : ''}>밥</option>
         <option value="기타" ${recipe.recipeCategory == '기타' ? 'selected' : ''}>기타</option>
        </select>

        <label for="description">설명 (DESCRIPTION):</label>
        <textarea id="description" name="description" maxlength="500" rows="3"></textarea>

        

        <label for="instructions">조리 방법 (INSTRUCTIONS) <span style="color:red">*</span>:</label>
        <textarea id="instructions" name="instructions" maxlength="4000" rows="6" required></textarea>

        <label for="ingredientName">재료명 (INGREDIENT_NAME) <span style="color:red">*</span>:</label>
        <textarea id="ingredientName" name="ingredientName" maxlength="2000" rows="4" required></textarea>

       <label for="images">이미지 업로드:</label><br>
<label for="images" class="custom-file-label">파일 선택</label>
<input type="file" id="images" name="imageFile" accept="image/*" />
<span id="fileNameDisplay" style="margin-left: 10px; color: #ddd;">선택된 파일 없음</span>
<div id="imagePreview" style="margin-top: 10px; border: 1px solid #ccc; width: 150px; height: 150px; overflow: hidden;">
    <img id="previewImage" src="#" alt="이미지 미리보기" style="max-width: 100%; max-height: 100%; display: none;" />
</div>

<script>
    // JavaScript 코드를 여기에 작성합니다.
    // 요소를 찾을 때 HTML의 id 값인 'images'를 사용합니다.
    const fileInput = document.getElementById('images');
    const previewImage = document.getElementById('previewImage'); // 이 ID는 HTML에 그대로 있습니다.

    // fileInput 요소가 제대로 찾아졌는지 확인하는 로직을 추가하는 것도 좋습니다.
    if (fileInput) {
        fileInput.addEventListener('change', function(e) {
            const file = e.target.files[0]; // 선택된 파일 중 첫 번째 파일 가져오기

            if (file) {
                const reader = new FileReader(); // 파일을 읽기 위한 FileReader 객체 생성

                reader.onload = function(event) {
                    // 파일 읽기가 완료되면 실행될 함수
                    previewImage.src = event.target.result; // 미리보기 이미지의 src를 읽어온 파일 데이터 URL로 설정
                    previewImage.style.display = 'block'; // 미리보기 이미지를 보이도록 설정
                }

                reader.readAsDataURL(file); // 파일을 Data URL 형태로 읽어오기
            } else {
                // 파일 선택이 취소된 경우
                previewImage.src = '#'; // 이미지 src 초기화
                previewImage.style.display = 'none'; // 미리보기 이미지를 숨김
            }
        });
    } else {
        console.error("오류: 'images' ID를 가진 input 요소를 찾을 수 없습니다.");
    }
    
 // 파일명 표시
    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        const display = document.getElementById('fileNameDisplay');
        if (file) {
            display.textContent = file.name;
        } else {
            display.textContent = '선택된 파일 없음';
        }
    });
</script>


        <button type="submit" class="submit-btn">등록하기</button>
    </form>
    
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
