<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KJY.css">
<title>상품구매내역</title>
</head>
<body>
	<h2 style="border-bottom: 1px solid black; padding-bottom: 20px;">구매 내역</h2>
	<hr size="1" width="100%" noshade>
	<div>
		<table class="striped-table align-center"
			style="padding-bottom: 20px;">
			<tr>
				<th width="30%">상품명</th>
				<td class="align-center">${storePay.store_title}</td>
			</tr>
			<tr>
				<th>총 구매금액</th>
				<td class="align-center">${storePay.total_price}</td>
			</tr>
			<tr>
				<th>주문날짜</th>
				<td class="align-center">${storePay.pay_date}</td>
			</tr>
		</table>
		<div class="align-center">
				<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main'">
				<input type="button" value="주문내역으로 이동" onclick="location.href='${pageContext.request.contextPath}/member/myPageGiftshop'">
			</div>
		</div>
</body>
</html>