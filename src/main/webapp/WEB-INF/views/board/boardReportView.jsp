<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 신고</title>
<style>
.report-form .label-wrapper {
    display: flex;
    align-items: center;
    height: 32px; /* label 높이 영역 고정 */
}

.report-form .label-wrapper label {
    font-weight: bold;
    font-size: 15px;
}

.report-form {
    max-width: 800px;
    margin: 60px auto;
    padding: 30px;
    background-color: #fdfdfd;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    font-family: 'Arial', sans-serif;
}

.report-form h2 {
    font-size: 22px;
    margin-bottom: 20px;
    color: #444;
}

.report-form textarea {
    width: 100%;                /* 양쪽 꽉 채움 */
    padding: 10px 12px;         /* 내부 여백: 상하 10px, 좌우 12px */
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
    resize: vertical;
    margin-bottom: 20px;
    margin-top: 10px;
    box-sizing: border-box;     /* padding 포함한 전체 크기로 계산 */
    line-height: 1.5;
}

.report-form button {
    background-color: #d9534f;
    color: white;
    border: none;
    padding: 10px 18px;
    border-radius: 6px;
    font-size: 15px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.report-form button:hover {
    background-color: #c9302c;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function checkByte(textarea) {
  const maxByte = 500;
  let text = textarea.value;
  let byteCount = 0;
  let cutIndex = text.length;

  for (let i = 0; i < text.length; i++) {
    const char = text.charAt(i);
    byteCount += (char.match(/[ㄱ-ㅎㅏ-ㅣ가-힣]/)) ? 3 : (encodeURIComponent(char).length > 1 ? 2 : 1);

    if (byteCount > maxByte) {
      cutIndex = i;
      break;
    }
  }

  if (byteCount > maxByte) {
    alert("최대 500byte까지만 입력 가능합니다.");
    textarea.value = text.substring(0, cutIndex);
    byteCount = 0;
    for (let i = 0; i < cutIndex; i++) {
      const char = textarea.value.charAt(i);
      byteCount += (char.match(/[ㄱ-ㅎㅏ-ㅣ가-힣]/)) ? 3 : (encodeURIComponent(char).length > 1 ? 2 : 1);
    }
  }

  document.getElementById("byteCount").innerText = byteCount;
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:if test="${not empty alertMsg}">
  <script>
    alert("${alertMsg}");
  </script>
</c:if>
<div class="report-form">
    <h2>🚨 게시글 신고</h2>
    
    <form action="boardReportInsert.do" method="post">
        <input type="hidden" name="targetId" value="${param.targetId}">
        <input type="hidden" name="category" value="${param.category}">
        
        <div class="label-wrapper">
		    <label for="reason">신고 사유</label>
		</div>
        <textarea name="reason" id="reason" oninput="checkByte(this)" required></textarea>
		<div><span id="byteCount">0</span> / 500 byte</div>

        <button type="submit">신고 제출</button>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />	
</body>
</html>