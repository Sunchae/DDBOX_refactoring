<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품구매</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop.cart.js"></script>
</head>
<body>
<div class="page-main">
	<div class="content-main">
		<h2>상품구매</h2>
		<table>
			<tr>
				<th>상품명</th>
				<th>수량</th>
				<th>상품가격</th>
				<th>합계</th>
			</tr>
			<%-- <c:forEach var="store" items="${list}">
			<tr>
				<td>
					<a href="${pageContext.request.contextPath}/store/storeDetail?store_num=${store.store_num}">
						<img src="${pageContext.request.contextPath}/upload/${store.storeVO.photo}" width="80">
						${store.storeVO.title}</a>
				</td>
				<td class="align-center"><fmt:formatNumber value="${store.order_quantity}" /></td>
				<td class="align-center"><fmt:formatNumber value="${sub_total}" />원</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="3" class="align-right"><b>총 구매금액</b></td>
				<td class="align-center"><fmt:formatNumber value="${all_total}" />원</td>
			</tr> --%>
		</table>
	</div>
</div>

</body>
</html>