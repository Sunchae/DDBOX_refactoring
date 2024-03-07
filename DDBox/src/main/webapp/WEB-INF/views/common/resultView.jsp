<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${accessTitle}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/resultView.css"> 
</head>
<body>
    <div class="container">
        <h2>${accessTitle}</h2>
        <div class="message-box">
            <p>${accessMsg}</p>
            <button onclick="location.href='${accessUrl}'">이동</button>
        </div>
    </div>
</body>
</html>