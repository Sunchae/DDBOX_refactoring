<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 내용 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<div class="page-main">
	<h5>단체/대관 문의</h5>
	<span>단체 및 대관 예약 문의입니다.</span>
	
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<ul class="detail-info">
		<li>
			[${rental.scr_name}] 단체 및 대관 예약 문의 
		</li>
		<li>
			<c:set var="dateString" value="${rental.rental_date}" /> 예약 희망일 : ${fn:substring(dateString, 0, 10)}
		</li>
	</ul>
	<br>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	
	<div class="detail-content">
		<ul>
			<li>
				문의자명: ${rental.rental_name} (${rental.rental_email})<br>
			</li>
			<li>
				연락처: ${rental.rental_phone}<br>
			</li>
			<li>
				<br>${rental.rental_content}
			</li>
		</ul>
	</div>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	
	<div class="align-right">
		<c:if test="${!empty user && user.mem_auth == 9}">
			<form action="updateStatus" id="update_form" method="post" style="border:0 solid black;">
			<input type="hidden" name="rental_num" value="${rental.rental_num}">
			<select name="rental_status" id="rental_status">
				<option value="1" <c:if test="${rental.rental_status==1}">selected</c:if>>접수중</option>
				<option value="2" <c:if test="${rental.rental_status==2}">selected</c:if>>접수완료</option>
				<option value="3" <c:if test="${rental.rental_status==3}">selected</c:if>>승인완료</option>
				<option value="9" <c:if test="${rental.rental_status==9}">selected</c:if>>접수취소</option>
			</select>
			</form>
			<script>
				let rental_status = document.getElementById('rental_status');
				rental_status.onchange=function(){
					let update_form = document.getElementById('update_form');
					update_form.submit();
				};
			</script>
		</c:if>
	</div>
	<div class="align-left">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.href='delete?rental_num=${rental.rental_num}'
				}
			};
		</script>
	</div>
	<div class="align-right">
	<c:if test="${user.mem_auth == 1}">
	<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/rental'">
	</c:if>
	<c:if test="${user.mem_auth == 9}">
	<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/rental/rental_admin'">	
	</c:if>
	</div>
	</div>
	<hr size="1" width="100%">
<!-- 내용 끝 -->
