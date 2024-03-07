<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<!-- 내용 시작 -->
<div class="page-main">
	<h5>상담톡 문의하기</h5>
	<span>1:1 실시간 상담톡입니다.</span>
	
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<ul class="detail-info">
		<li>
			실시간 채팅 상담을 원하신다면 아래 버튼을 눌러주세요.
		</li>
		<br><li>
		<input type="button" value="1:1문의하기" onclick="location.href='${pageContext.request.contextPath}/faq/chat/chattingListForUser'">
		</li>
	</ul><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<!-- 하단 표시 -->
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<div class="search_order">
		<span>
			<a onclick="location.href='${pageContext.request.contextPath}/faq/email'" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/images/faq/자주묻는질문.png"></a>
		</span>
	</div>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
</div>
<!-- 내용 끝 -->