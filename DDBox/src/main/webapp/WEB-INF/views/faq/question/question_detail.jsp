<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
	<div class="page-main">
	<h5>자주묻는 질문</h5>
	<span>회원님들께서 가장 자주하시는 질문을 모았습니다.<br>궁금하신 내용에 대해 검색해보세요.</span>
	
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<ul class="detail-info">
		<li>
			<c:if test="${question.board_category==1}">[예매]</c:if>
			<c:if test="${question.board_category==2}">[관람/결제수단]</c:if>
			<c:if test="${question.board_category==3}">[멤버십]</c:if>
			<c:if test="${question.board_category==4}">[VIP]</c:if>
			<c:if test="${question.board_category==5}">[할인/혜택]</c:if>
			<c:if test="${question.board_category==6}">[영화관]</c:if>
			<c:if test="${question.board_category==7}">[특별관]</c:if>
			<c:if test="${question.board_category==8}">[기프트샵]</c:if>
			<c:if test="${question.board_category==9}">[홈페이지/모바일]</c:if>
		${question.board_title}</li>
		<li>
			작성일 ${question.board_regdate}
			조회수 ${question.board_hit}
		</li>
	</ul>
		<br>
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">
		<div class="detail-content">
			<br>${question.board_content}
		</div>
		
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">
		<div class="align-right">
			<c:if test="${!empty user && user.mem_auth == 9}">
				<input type="button" value="수정" onclick="location.href='update?board_num=${question.board_num}'">
				<input type="button" value="삭제" id="delete_btn">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.href='delete?board_num=${question.board_num}'
					}
				};
			</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/question'">
		</div>
		<hr size="1" width="100%">
	</div>
<!-- 내용 끝 -->