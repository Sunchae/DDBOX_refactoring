<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>상영정보 목록</h2>
	<form action="list" id="search_form" method="get">
		
		<div class="align-right">
			<c:if test="${!empty user && user.mem_auth==9}">
				<input type="button" value="상영정보 추가" onclick="location.href='addReserve'">
			</c:if>
		</div>
	</form>

	<c:if test="${count ==0}">
		<div class="result-display">표시할 게시물이 없습니다</div>
	</c:if>

	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr class="align-center">
				<th>상영번호</th>
				<th>상영시작날짜</th>
				<th>상영종료날짜</th>
				<th>상영시간</th>
				<th>상영영화</th>
				<th>상영관이름</th>
			</tr>
			<c:forEach var="reserve" items="${list}">
				<tr>
					<td class="align-center">${reserve.shw_num}</td>
					<td class="align-center">${reserve.shw_sdate}</td>
					<td class="align-center">${reserve.shw_edate}</td>
					<td class="align-center">${reserve.shw_time}</td>
					<td class="align-center">${reserve.movie_title}</td>
					<td class="align-center">${reserve.scr_name}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
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
		}); //end of submit
		
		//정렬 선택
		$('#order').change(function(){
			location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
		}); //end of change
	});
</script>
<!-- 내용 끝 -->