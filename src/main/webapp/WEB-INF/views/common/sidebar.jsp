<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sidebar</title>
<style>
.faq-fixed-link {				/*모양은 기능 넣고 추가*/
  position: fixed;
  top: 120px;
  right: 20px;
  background-color: #1f2937; /* 어두운 그레이 */
  color: #fff;
  padding: 12px 20px;
  border-radius: 9999px;
  text-decoration: none;
  font-weight: bold;
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
  transition: background-color 0.3s;
}

.faq-fixed-link:hover {
  background-color: #4b5563;
}
</style>
</head>
<body>
<a href="${ pageContext.servletContext.contextPath }/FAQList.do" class="faq-fixed-link">FAQ</a>
</body>
</html>