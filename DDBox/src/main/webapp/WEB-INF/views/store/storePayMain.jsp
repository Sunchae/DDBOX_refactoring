<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KJY.css">
<div class="page-main">
<h2>스토어 구매 내역</h2>
<div>
	<table class="board-list">
		<colgroup>
		       <col style="width:180px;">
		       <col style="width:150px;">
		       <col style="width:80px;">
		       <col style="width:200px;">
	        </colgroup>
		<thead>
			<tr>
				<th scope="colgroup">주문번호</th>
				<th scope="col">상품명</th>
				<th scope="col">총 주문금액</th>
				<th scope="col">주문날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="storePay" items="${list}">
				<tr>
					<td class="a-c">
						<div class="goods-info">
							${storePay.pay_id}
						</div>
					</td>
					<th scope="row">
						<div class="goods-info">
							<p class="name">
								<a href="${pageContext.request.contextPath}/store/detail?store_num=${storePay.store_num}">${storePay.store_title}</a>
							</p>
						</div>
					</th>
					<td>${storePay.total_price}</td>
					<td>${storePay.pay_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="align-center">${page}</div>
</div>

<!-- 내용 끝 -->