<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 상세</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop.cart.js"></script>
</head>
<body>
<div class="page-main">
	<div class="main-title">
		<h3 class="align-center">${store.store_title}</h3>
		<div class="img">
			<img src="${pageContext.request.contextPath}/upload/${store.store_photo}" width="400">
		</div>
		<div class="store-detail">
			<form id="store_cart">
				<input type="hidden" name="store_num" value="${store.store_num}" id="store_num">
				<input type="hidden" name="store_price" value="${store.store_price}" id="store_price">
				<input type="hidden" name="quantity" value="${quantity}" id="quantity">
				<ul>
					<li>가격 : <b><fmt:formatNumber value="${store.store_price}"/>원</b></li>
					<li>재고 : <span><fmt:formatNumber value="${quantity}"/></span></li>
					<c:if test="${quantity > 0}">
					<li>
						<label for="order_quantity">구매수량</label>
						<input type="number" name="order_quantity" min="1" max="${quantity}" autocomplete="off" id="order_quantity" class="quantity-width">
					</li>
					<li>
						<span id="item_total_txt">총주문 금액 : 0원</span>
					</li>
					<li>
						<input type="submit" value="장바구니에 담기">
					</li>
					</c:if>
					<c:if test="${quantity <= 0}">
					<li class="align-center">
						<span class="sold-out">품절</span>
					</li>
					</c:if>
				</ul>
			</form>
		</div>
		<hr size="1" noshade="noshade" width="100%">
		<p>
			${store.store_content}
		</p>
	</div>
</div>
</body>
</html>