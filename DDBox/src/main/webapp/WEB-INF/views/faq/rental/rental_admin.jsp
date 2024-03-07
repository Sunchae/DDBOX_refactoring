<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 시작 -->
<div class="page-main">
	<h5>단체/대관 문의확인</h5>
	<span>등록된 단체/대관 문의입니다</span>

	<!-- 검색 기능 -->
	<form action="rental" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
			</li>
			<li>
				<input type="submit" value="검색">
				<input type="button" value="목록" onclick="location.href='rental'">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>목록순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>최신순</option>
			</select>
		</div>
	</form>
	
	<c:if test="${count==0}">
	<div class="result-display">신청한 예약건이 없습니다</div>
	</c:if>
	
	<c:if test="${count>0}">
	
	
	<br><br><br>
	<table class="striped-table">
		<tr>
			<th class="align-center">번호</th>
			<th class="align-center">관람희망일</th>
			<th class="align-center">문의자명</th>
			<th class="align-center">등록일</th>
			<th class="align-center">상태</th>
		</tr>
		<c:forEach var="rental" items="${list}"> 
		<tr>
			<td class="align-center"><a href="detail?rental_num=${rental.rental_num}">${rental.rental_num}</a></td>
			<td class="align-center"><a href="detail?rental_num=${rental.rental_num}"><c:set var="dateString" value="${rental.rental_date}" />
        ${fn:substring(dateString, 0, 10)}</a></td>
			<td class="align-center"><a href="detail?rental_num=${rental.rental_num}">${rental.rental_name}</a></td>
			<td class="align-center"><a href="detail?rental_num=${rental.rental_num}">${rental.rental_regdate}</a></td>
			<td class="align-center">
				<c:if test="${rental.rental_status==1}">접수중</c:if>
				<c:if test="${rental.rental_status==2}">접수완료</c:if>
				<c:if test="${rental.rental_status==3}">승인완료</c:if>
				<c:if test="${rental.rental_status==9}">접수취소</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//검색 유효성 체크
	$('#search_form').submit(function(){
		if($('#keyword').val().trim()==''){
			alert('검색어를 입력하세요');
			$('#keyword').val('').focus();
			return false;
		}
	});//end of submit
	
	//정렬 선택
	$('#order').change(function(){
		location.href='rental?keyword='+$('#keyword').val()+'&order='+$('#order').val();
	});
});
</script>
<!-- 내용 끝 -->