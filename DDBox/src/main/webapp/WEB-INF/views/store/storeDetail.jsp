<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KJY.css">
<!-- 내용 시작 -->
<div class="page-main">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop.cart.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/store.js"></script>

	<div class="main-title" id="store_form">
		<div class="align-right">
			<c:if test="${user.mem_auth ==9}"> 		<%-- 관리자 로그인 되어있을 때 만 보임 --%>
			<input type="button" value="글쓰기" onclick="location.href='write'">
			</c:if>
		</div>
	</div>
</div>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
<div class="body-wrap">
	<c:if test="${store.store_status == 1}">
		<div class="result-display">
			<div class="align-center">
				본 상품은 판매 중지 되었습니다.
				<p>
				<input type="button" value="판매상품 보기" onclick="location.href='store/storeMainTest'">
			</div>
		</div>
	</c:if>
										<%-- contents --%>
	<c:if test="${store.store_status == 2}">										
	<div id="contents">
		<div class="inner-wrap">
			<!-- ::before -->
										<%-- store-detail --%>
			<div class="store-view">
				<h2 class="tit">${store.store_title}</h2>
				<div class="sub-info">
					<p class="bundle">${store.store_content}</p>
				</div>
										<%-- box-store-detail --%>
			<div class="box-store-view">
			<!-- ::before -->
				<div class="left">
					<div class="img">
						<p>
							<img alt="${store.store_title}" src="${pageContext.request.contextPath}/upload/${store.store_photo}">
						</p>
					</div>
				</div>
										<%-- right --%>
			<div class="right">
										<%-- goods-info --%>
				<div class="goods-info">
					<div class="line">
						<p class="tit">판매수량</p>
						<div class="cont">
							<div class="sale-count">
								<span>${store.quantity}</span>
								<span>개</span>
								|
								<span> 1회 2개 구매가능 </span>
								|
								<span> 1인 2개 구매가능 </span>
							</div>
						</div>
					</div>
					<div class="line">
						<p class="tit">구매 후 취소</p>
						<div class="cont">
							<p class="txt">
								"구매 후 취소가 불가한 상품입니다."
							</p>
						</div>
					</div>
				</div>
										<%-- goods-info end --%>
										<%-- type --%>
				<div class="type">
					<div class="receipt">
						<div class="line">
							<p class="tit">
								<span class="line32">수량/금액</span>
							</p>
								<div class="cont">
									<form id="store_cart" action="storePay" style="border:none">
										<input type="hidden" name="store_num" value="${store.store_num}" id="store_num">
										<input type="hidden" name="store_price" value="${store.store_price}" id="store_price">
										<input type="hidden" name="quantity" value="${store.quantity}" id="quantity">
										<input type="hidden" name="total_price" value="" id="total_price">
										<input type="hidden" name="store_photo" value="${store.store_photo}" id="store_photo">
										<ul>
											<li>가격 : <b><fmt:formatNumber value="${store.store_price}"/>원</b></li>
											<li>재고 : <span><fmt:formatNumber value="${store.quantity}"/></span></li>
											<c:if test="${store.quantity > 0}">
											<li>
												<label for="order_quantity">구매수량</label>
												<input type="number" name="order_quantity" value="1" min="1" max="${quantity}" autocomplete="off" id="order_quantity" class="quantity-width">
											</li>
											<li>
												<span>총 주문 금액 :<span id="item_total_txt">0</span>원</span>
											</li>
											<li>
												<input type="submit" value="구매">
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
							</div>
						</div>
					</div>
										<%-- type end --%>
			</div>
										<%-- right end --%>
			</div>
										<%-- box-store-detail end --%>
			</div>
										<%-- store-detail end --%>
										<%-- box-pulldown --%>
			<div class="box-pulldown">
				<div class="tit">
					<button type="button" class="btn-toggle">
						"구매 후 취소 " 
						<i class="iconset ico-arr-toggle-down">
							<span class="material-symbols-outlined"> expand_more </span>
						</i>
					</button>
				</div>
				<div class="dotList02">
					"■&nbsp;교환 / 환불 / 사용기한 연장&nbsp;불가&nbsp;안내"
					<br>
					" - 본 상품은 이벤트 상품으로 &nbsp;"
					<span style="color:#e74c3c">
						<strong>
							<u>교환/환불/사용기한 연장&nbsp;절대&nbsp;불가</u>
						</strong>
					</span>
					"하니 신중하게 구매 부탁드립니다."
					<br>
					" - 본 권은 특가 상품으로 구매 후 미사용 하였더라도 취소가 일절 불가능 합니다."
					<br>
					" - 본 권은 영화 관람권 PIN 번호 1개당 4회 관람 가능한 권으로 4회 중 "
					<span style="color:#e74c3c">
						<strong>
							<u>잔여 미사용횟수가 남아 있더라도 개별 부분 환불이 불가능</u>
						</strong>
					</span>
					"합니다."
				</div>
			</div>
										<%-- box-pulldown end --%>
			<!-- ::after -->
		</div>
	</div>
	</c:if>
										<%-- contents end --%>
</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${user.mem_auth ==9}">
		<input type="button" value="수정" onclick="location.href='update?store_num=${store.store_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.href='delete?store_num=${store.store_num}';
				}
			};
		</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='storeMainTest'">
	</div>
</body>
</html>
<!-- 내용 끝 -->
