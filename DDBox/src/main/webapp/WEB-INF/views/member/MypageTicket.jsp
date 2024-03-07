<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 내용 시작 -->
<div class="page-main">
<h2>마이페이지 예매/티켓</h2>
		<table class="striped-table align-center">
			<tr>
				<th>영화제목</th>
				<th>상영관</th>
				<th>상영시간</th>
			</tr>
			<c:forEach var="ticket" items="${list}">
				<tr>
					<td class="align-center"> ${ticket.movie_title}</td>
					<td class="align-center">${ticket.scr_name}</td>
					<td class="align-center">${ticket.shw_time}</td>
				</tr>
			</c:forEach>
		</table>
</div>
<!-- 내용 끝 -->