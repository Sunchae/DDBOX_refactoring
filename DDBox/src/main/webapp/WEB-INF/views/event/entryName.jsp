<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<style>
	 form {
            border: none;
        }
</style>
<div class="page-main">
	<div class="tit-util">
		<h3>응모자 리스트</h3>
		<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
		</c:if>
	
		<table class="striped-table" >
			<tr>
				<th>응모자 번호</th>
				<th>응모자 아이디</th>
				<th>응모자 참여 날짜</th>
				<th>추첨 타입</th>
				<th>추첨 날짜</th>
			</tr>
			<c:forEach var="list" items="${list}">
			<tr id="entry_table">
				<td class="align-center" id="entryNum">${list.entry_num}</td>
				<td class="align-center" id="memId">${list.mem_id}</td>
				<td class="align-center" id="entryDate">${list.entry_date}</td>
				<td class="align-center" id="winnerType">${list.win_type == 1 ? '당첨' : '미당첨'}</td>
				
				<td class="align-center" id="winDate">${list.win_date}</td>
			</tr>
			</c:forEach>
		</table>
		<c:if test="${event_status == 1}">
		<form action="winnerEntry" method="post">
			<input type="hidden" name="event_num" value="${event_num}">
			<input type="hidden" name="event_status" value="${event_status}">
			<c:forEach var="item" items="${list}">
				<input type="hidden" name="entry_num" value="${item.entry_num}"> 			
			</c:forEach>
			<c:forEach var="item" items="${list}">
				<input type="hidden" name="mem_num" value="${item.mem_num}"> 			
			</c:forEach>
			<input type="submit" value="추첨">
		</form>
		</c:if>
		<hr size="1" width="100%">
	</div>
	<script>console.log(${event_num})</script>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/event_entry.js"></script> --%>
<!-- 내용 끝 -->