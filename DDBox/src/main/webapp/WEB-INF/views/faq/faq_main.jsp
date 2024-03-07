<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 시작 -->
<div class="page-main">
	<div class="align-center">
	
		<div class="check_warp">
			<!-- 빠른검색 -->
			<div class="box qna_search">
				<b class="c_tit" >자주찾는 질문 빠른 검색</b><br>
				<form action="question" id="search_form" method="get" style="height: 65px;border-bottom-width: 10px;padding-bottom: 10px;">
					<ul class="search">
						<li>
							<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어를 입력해 주세요.">
						</li>
					</ul>
					<div class="qu" style="height: 55px;">
						<a href="/faq/question?keyword=현금영수증" style="color:white;">현금영수증</a>
						<a href="/faq/question?keyword=관람권" style="color:white;">관람권</a>
						<a href="/faq/question?keyword=예매" style="color:white;">예매</a>
						<a href="/faq/question?keyword=환불" style="color:white;">환불</a>
						<a href="/faq/question?keyword=취소" style="color:white;">취소</a>
					</div>
				</form>
			</div>
			<!-- 상담톡 -->
			<div class="quick_chat" style="cursor:pointer;">
				<b class="c_tit">상담톡 이용</b><br>
				<span>상담 톡을 이용해보세요.</span><br>
				<input type="button" id="chatButton" value="문의하기" onclick="location.href='${pageContext.request.contextPath}/faq/chat/chatUser'">
			</div>
			<div class="quick_email"  style="cursor:pointer;">
				<b class="c_tit">이메일 문의</b><br>
				<span>24시간 365일 언제든지 문의해주세요.</span><br>
				<input type="button" onclick="location.href='${pageContext.request.contextPath}/faq/email'" value="문의하기">
			</div>
			
			<div class="quick_mypage"  style="cursor:pointer;">
				<b class="c_tit">내 상담 내역 확인</b><br>
				<span>문의하신 내용을 확인하실 수 있습니다.</span><br>
				<input type="button" onclick="location.href='${pageContext.request.contextPath}/member/myPage'" value="문의내역 조회">
			</div>
		<!-- 하단 표시 -->
		<hr style="border-width:1px 0 0 0; border-color:#ccc;clear:both;">
		<div class="search_order">
			<span>
				<a onclick="location.href='${pageContext.request.contextPath}/faq/email'" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/images/faq/자주묻는질문.png"></a>
			</span>
		</div>
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">			
		</div>
	</div>

</div>
<!-- 내용 끝 -->