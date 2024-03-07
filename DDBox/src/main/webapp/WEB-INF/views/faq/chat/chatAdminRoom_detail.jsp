<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/chat.js"></script>
<!-- 내용 시작 -->
<div id="chatDetail" class="page-main">
	<h3 id="chatroom_title"><span id="chatroom_name">1:1 문의</span></h3>
   
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
	<div class="align-right">
      <input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/faq/chat/chatUser'">
   </div>
</div>
<!-- 내용 끝 -->