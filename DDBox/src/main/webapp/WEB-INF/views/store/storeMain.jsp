<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<div class="page-main">
	<div class="main-title" id="store_form">
		<div class="align-right">
			<c:if test="${user.mem_auth ==9}"> 		<%-- 관리자 로그인 되어있을 때 만 보임 --%>
			<input type="button" value="글쓰기" onclick="location.href='write'">
			</c:if>
			<input type="button" value="결제테스트" onclick="location.href='${pageContext.request.contextPath}/kakaoPay/kakaoPay'">
		</div>
	</div>
	<c:forEach var="store" items="${list}">
	<c:if test="${store.store_type == 0}">
	<div class="store-main-list">
		<ul>
			<li>
				<a href="detail?store_num=${store.store_num}">
				<img src="${pageContext.request.contextPath}/upload/${store.store_photo}">
				<p>${store.store_title}</p>
				<p>${store.store_name}</p>
				</a>
			</li>
		</ul>
	</div>
	</c:if>
	</c:forEach>
</div>
<!-- 내용 끝 -->
