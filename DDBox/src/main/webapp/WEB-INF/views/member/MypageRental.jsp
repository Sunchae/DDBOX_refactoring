<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<!-- 내용 시작 -->
<div class="page-main">
	<h6>나의 문의내역</h6>
	<span>단체예약/대관문의</span>
	<!-- 검색 기능 -->
	<form action="rental" id="search_form" method="get">
		<ul class="search">
			<li>
				문의조회 <input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>목록순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>최신순</option>
			</select>
			<c:if test="${user.mem_auth==9}">
				<input type="button" value="글쓰기" onclick="location.href='question/write'">
			</c:if>
		</div>
	</form>
	<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
</div>
<!-- 내용 끝 -->