<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/chat.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<!-- 내용 시작 -->
<div id="chatDetail" class="page-main">
	<h5>상담톡 문의확인</h5>
	<span>상담톡 문의입니다</span>
	
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<h3 id="chatroom_title"><span id="chatroom_name"></span></h3>
   
	<div id="chatting_message"></div>
	<form method="post" id="detail_form">
		<input type="hidden" name="chatroom_num" id="chatroom_num" value="${param.chatroom_num}">
		<ul>
			<li>
				<textarea rows="5" cols="40" placeholder="내용을 입력해주세요" name="message" id="message" ></textarea> <!-- style="height: 105px;" -->
			</li>
		</ul>
		<div id="message_btn">
			<input type="submit" value="전송">
		</div>
	</form>

	<br>
	
   
    <c:if test="${user.mem_auth == 1}">
	<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/faq/main'">
	</c:if>
	<c:if test="${user.mem_auth == 9}">
	<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/chat/chattingListForAdmin'">	
	</c:if>
</div>
<!-- 내용 끝 -->