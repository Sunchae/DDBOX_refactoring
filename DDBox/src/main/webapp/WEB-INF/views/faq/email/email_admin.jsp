<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 시작 -->
<div class="page-main">
	<h5>이메일 문의확인</h5>
	<span>등록된 이메일 문의입니다</span>

	<!-- 검색 기능 -->
	<form action="email" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
			</li>
			<li>
				<input type="submit" value="검색">
				<input type="button" value="목록" onclick="location.href='email'">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>목록순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>최신순</option>
			</select>
		</div>
	</form>
	
	
	<c:if test="${count==0}">
	<div class="result-display">작성된 문의사항이 없습니다</div>
	</c:if>
	
	
	<c:if test="${count>0}">
	<br><br><br>
	<table class="striped-table">
		<tr>
			<th class="align-center">번호</th>
			<th class="align-center">문의유형</th>
			<th width="300" class="align-center">제목</th>
			<th class="align-center">작성자</th>
			<th class="align-center">상태</th>
		</tr>
		<c:forEach var="email" items="${list}"> 
		<tr>
			<td class="align-center"><a href="detail?qna_num=${email.qna_num}">${email.qna_num}</a></td>
			<td class="align-center">
				<c:if test="${email.qna_type==1}">문의</c:if>
				<c:if test="${email.qna_type==2}">불만</c:if>
				<c:if test="${email.qna_type==3}">칭찬</c:if>
				<c:if test="${email.qna_type==4}">제안</c:if>
				<c:if test="${email.qna_type==5}">분실물</c:if>
			</td>
			<td class="align-center" width="300" ><a href="detail?qna_num=${email.qna_num}">${email.qna_title}</a></td>
			<td class="align-center"><a href="detail?qna_num=${email.qna_num}">${email.mem_id}</a></td>
			<td class="align-center">
				<c:if test="${email.ask_content==null}">답변대기</c:if>
				<c:if test="${email.ask_content!=null}">답변완료</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
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
		location.href='news?keyword='+$('#keyword').val()+'&order='+$('#order').val();
	});
});
</script>
<!-- 내용 끝 -->