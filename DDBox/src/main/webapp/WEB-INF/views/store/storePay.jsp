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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KJY.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop.cart.js"></script>
		<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	</head>
	<body>
		<div class="container">
			<div id="storePay">
				<div class="contents">
					<div class="inner-wrap">
						<div class="store-payment">
							<h2 class="tit">상품구매</h2>
							<h3 class="tit">주문상품정보</h3>
							<div class="table-wrap">
								<table class="board-list">
									<colgroup>
				                        <col style="width:180px;">
				                        <col>
				                        <col style="width:150px;">
				                        <col style="width:80px;">
				                        <col style="width:200px;">
				                    </colgroup>
				                    <thead>
										<tr>
											<th scope="colgroup" colspan="2">주문상품</th>
											<th scope="col">수량</th>
											<th scope="col">상품가격</th>
											<th scope="col">합계</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="a-c">
												<div class="goods-info">
													<p class="img">
													<a href="${pageContext.request.contextPath}/store/detail?store_num=${store.store_num}">
														<img src="${pageContext.request.contextPath}/upload/${store.store_photo}" width="50">
													</a>
													</p>
												</div>
											</td>
											<th scope="row">
												<div class="goods-info">
													<p class="name">
														<a href="${pageContext.request.contextPath}/store/detail?store_num=${store.store_num}">${store.store_title}</a>
													</p>
													<p class="bundle">
														${store.store_content}
													</p>
												</div>
											</th>
											<td>${param.order_quantity}</td>
											<td>${store.store_price}</td>
											<td>${param.total_price}</td>
										</tr>
									</tbody>
								</table>
								<div class="align-center cart-submit">
									<form action="insertPay" id="payForm" style="border:none">
										<input type="hidden" name="store_title" value="${store.store_title}" id="store_title">
										<input type="hidden" name="order_quantity" value="${param.order_quantity}"  id="order_quantity">
										<input type="hidden" name="total_price" value="${param.total_price}" id="">
										<input type="hidden" name="store_num" value="${store.store_num}" id="store_num">
										<input type="hidden" name="pay_date" value="" id="pay_date" readonly="readonly">
									</form>
									<button id="check_module" type="button">구매</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
		
			$("#check_module").click(function() {
				$('#pay_date').val(new Date().toISOString().substring(0,10));
				var IMP = window.IMP; // 생략가능
				IMP.init('imp66004703');
				// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
				// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
				IMP.request_pay({
					pg : 'kakaopay',
					pay_method : 'card',
					merchant_uid : 'merchant_' + new Date().getTime(),
					/* 
					 *  merchant_uid에 경우 
					 *  https://docs.iamport.kr/implementation/payment
					 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
					 */
					name : '${store.store_title}',
					// 결제창에서 보여질 이름
					// name: '주문명 : ${auction.a_title}',
					// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
					amount :${param.total_price},
					// amount: ${bid.b_bid},
					// 가격 
					buyer_name : '${member.mem_id}',
					// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
					// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
					buyer_postcode : '123-456',
				}, function(rsp) {
					console.log(rsp);
					if (rsp.success) {
						var msg = '결제가 완료되었습니다.';
						msg += '결제 금액 : ' + rsp.paid_amount;
						$('#pay_uid').val(rsp.merchant_uid);
						$('#payForm').submit();
						// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
						// 자세한 설명은 구글링으로 보시는게 좋습니다.
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
					}
					alert(msg);
				});
			});
		</script>
	</body>
</html>