<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 내용 시작 -->
<div class="page-main">
	<div class="tit-util">
		<h3>응모권 이벤트 리스트</h3>
		<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
		</c:if>
		
		<table class="striped-table">
			<tr>
				<th>이벤트 번호</th>
				<th width="400">제목</th>
				<th>추첨</th>
			</tr>
			<c:forEach var="list" items="${list}">
			<tr>
				<c:if test="${list.event_type == 2}">
				<td class="align-center">${list.event_num}</td>
				<td><a href="detail?event_num=${list.event_num}">${list.event_title}</a></td>
																														<!-- 이벤트넘으로 넘겨줌 -->
				<td><input type="button" value="결과확인" onclick="location.href='${pageContext.request.contextPath}/event/entryName?event_num=${list.event_num}'"></td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
		
	</div>
</div>
<!-- 내용 끝 -->