<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<div class="page-main">
	<h6>나의 문의내역</h6>
	<span>문의조회</span>
	<!-- 검색 기능 -->
	<form action="question" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>목록순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>최신순</option>
			</select>
			<!--<c:if test="${!empty user && user.mem_num == question.mem_num}"> -->
					<input type="button" value="선택 삭제" id="delete_btn">
				<!-- 여기 체크박스 삭제 넣을 예정 -->
				<!-- </c:if> -->
		</div>
	</form>
	<!--
	<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	
	<c:if test="${count>0}">
	<table class="striped-table">
		<tr>
			<th>체크박스</th>
			<th class="align-center">번호</th>
			<th class="align-center">문의영화관</th>
			<th class="align-center">문의유형</th>
			<th width="400" class="align-center">제목</th>
			<th class="align-center">등록일</th>
			<th class="align-center">상태</th>
		</tr>
		<c:forEach var="email" items="${list}"> 
		<tr>
			<td>체크박스</td>
			<td class="align-center"><a href="email/detail?qna_num=${email.qna_num}">${email.qna_num}</a></td>
			<td class="align-center">
				<c:if test="${empty email.res_num}"> </c:if>
				<c:if test="${!empty email.res_num}">${email.res_num}</c:if>
			</td>
			<td class="align-center">
				<c:if test="${email.qna_type==1}">문의</c:if>
				<c:if test="${email.qna_type==2}">불만</c:if>
				<c:if test="${email.qna_type==3}">칭찬</c:if>
				<c:if test="${email.qna_type==4}">제안</c:if>
				<c:if test="${email.qna_type==5}">분실물</c:if>
			</td>
			<td class="align-center"><a href="email/detail?qna_num=${email.qna_num}">${email.qna_title}</a></td>
			<td class="align-center">
				<c:if test="${email.ask_content==null}">답변대기</c:if>
				<c:if test="${email.ask_content!=null}">답변완료</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
	 -->
</div>
<!-- 내용 끝 -->