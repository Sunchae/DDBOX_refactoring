<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 시작 -->
<div class="page-main">
	<h5>자주묻는 질문</h5>
	<span>회원님들께서 가장 자주하시는 질문을 모았습니다.<br>궁금하신 내용에 대해 검색해보세요.</span>
	
	<!-- 검색 기능 -->
	<form action="question" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
			</li>
			<li>
				<input type="submit" value="검색">
				<input type="button" value="목록" onclick="location.href='question'">
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
	<c:if test="${count>0}">
	
	
	<br><br>
	<!-- 카테고리 -->
	<div class="search_area">
		<ul class="c_tab type_free">
			<li class="on"><a href="question">전체</a></li>
			<li class="on"><a href="question?board_category=1">예매</a></li>
			<li class="on"><a href="question?board_category=2">관람/결제수단</a></li>
			<li class="on"><a href="question?board_category=3">멤버십</a></li>
			<li class="on"><a href="question?board_category=4">VIP</a></li>
			<li class="on"><a href="question?board_category=5">할인/혜택</a></li>
			<li class="on"><a href="question?board_category=6">영화관이용</a></li>
			<li class="on"><a href="question?board_category=7">특별관</a></li>
			<li class="on"><a href="question?board_category=8">기프트샵</a></li>
			<li class="on"><a href="question?board_category=9">홈페이지/모바일</a></li>
		</ul>
	</div>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<div>
	<span>총 ${count}건이 검색되었습니다.</span>
	</div>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">

	<!-- 컬럼 -->
	<table>
		<tr>
			<th class="align-center" width="65">번호</th>
			<th class="align-center" width="150">구분</th>
			<th  width="500" class="align-center">제목</th>
			<th class="align-center">조회수</th>
		</tr>
	</table>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	
	<!-- 데이터 -->
	<table>
	<c:forEach var="question" items="${list}"> <!-- 여기 다시 한번 확인 -->
	<tr>
		<td class="align-center" width="65"><a href="question/detail?board_num=${question.board_num}">${question.board_num}</a></td>
		<td class="align-center" width="150">
			<c:if test="${question.board_category==1}">[예매]</c:if>
			<c:if test="${question.board_category==2}">[관람/결제수단]</c:if>
			<c:if test="${question.board_category==3}">[멤버십]</c:if>
			<c:if test="${question.board_category==4}">[VIP]</c:if>
			<c:if test="${question.board_category==5}">[할인/혜택]</c:if>
			<c:if test="${question.board_category==6}">[영화관]</c:if>
			<c:if test="${question.board_category==7}">[특별관]</c:if>
			<c:if test="${question.board_category==8}">[기프트샵]</c:if>
			<c:if test="${question.board_category==9}">[홈페이지/모바일]</c:if>
		</td>
		<td class="align-center" width="500"><a href="question/detail?board_num=${question.board_num}">${question.board_title}</a></td>
		<td class="align-center"><a href="question/detail?board_num=${question.board_num}">${question.board_hit}</a></td>
	</tr>
	</c:forEach>
	</table>
	<br>
	<div class="align-center">${page}</div>
	</c:if>
	
	<!-- 하단 표시 -->
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<div class="search_order">
		<span>
			<a onclick="location.href='${pageContext.request.contextPath}/faq/email'" style="cursor:pointer;"><img src="${pageContext.request.contextPath}/images/faq/자주묻는질문.png"></a>
		</span>
	</div>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//검색 유효성 체크
	$('#search_form').submit(function(){
		if($('#keyword').val().trim()==''){
			alert('검색어를 입력하세요');
			$('#keyword').val('').focus();
			return false;
		}
	});//end of submit
	
	//정렬 선택
	$('#order').change(function(){
		location.href='question?keyword='+$('#keyword').val()+'&order='+$('#order').val();
	});
});
</script>
<!-- 내용 끝 -->