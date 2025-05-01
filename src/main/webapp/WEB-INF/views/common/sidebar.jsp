<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ Sidebar</title>
<style>
.faq-fixed-link {
  position: fixed;
  top: 180px;
  right: 15px;
  width: 100px;
  height: 100px;
  background-color: transparent; /* ✅ 배경 제거 */
  border: none;
  z-index: 999;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.faq-fixed-link img {
  width: 115%;
  height: 115%;
  object-fit: contain;
  display: block;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2)); /* 그림자만 남김 */
  transition: transform 0.3s ease;
}

.faq-fixed-link img:hover {
  transform: scale(1.08);
}
</style>
</head>
<body>

<a href="${ pageContext.servletContext.contextPath }/FAQList.do" class="faq-fixed-link">
  <img src="${ pageContext.request.contextPath }/resources/images/faqlogo.png" alt="FAQ">
</a>

</body>
</html>
