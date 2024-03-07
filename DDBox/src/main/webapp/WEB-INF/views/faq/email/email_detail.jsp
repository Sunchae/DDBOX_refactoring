<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<div class="page-main">
	<h5>이메일 문의</h5>
	<span>문의글을 남겨주시면 답변을 남겨드립니다.</span>
	
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<ul class="detail-info">
		<li>
			<c:if test="${email.qna_type==1}">[문의]</c:if>
				<c:if test="${email.qna_type==2}">[불만]</c:if>
				<c:if test="${email.qna_type==3}">[칭찬]</c:if>
				<c:if test="${email.qna_type==4}">[제안]</c:if>
				<c:if test="${email.qna_type==5}">[분실물]</c:if>
		${email.qna_title}</li>
		<li>
			작성일: ${email.question_regdate}
			<c:if test="${email.scr_num>0}">${email.scr_name}</c:if>
		</li>
	</ul>
		<br>
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">

	<div class="detail-content">
	<!-- 사진 -->
	<c:if test="${fn:endsWith(email.question_file, '.jpg') ||
				  fn:endsWith(email.question_file, '.JPG') ||
				  fn:endsWith(email.question_file, '.jpeg') ||
				  fn:endsWith(email.question_file, '.JPEG') ||
				  fn:endsWith(email.question_file, '.gif') ||
				  fn:endsWith(email.question_file, '.GIF') ||
				  fn:endsWith(email.question_file, '.png') ||
				  fn:endsWith(email.question_file, '.PNG')}">
	<ul> <!-- 파일 다운로드 -->
		<li>첨부파일 : <a href="file?qna_num=${email.qna_num}">${email.question_file}</a></li>
	</ul>
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${email.question_file}" class="detail-img" width="800">
	</div>
	</c:if>		
	
	<!-- 질문글 -->
		<br>${email.question_content}
	</div>
	<br>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	
	<!-- 답글 -->
	<c:if test="${email.ask_content!=null}">
		<ul class="detail-info">
			<li>
				[답변] ${email.mem_id} 님, 답변 드립니다.
			</li>
			<li>
				답변일: ${email.ask_regdate}
			</li>
		</ul>
		<br>
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	 
		<div class="detail-content">
			<br>${email.ask_content}
		</div>
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">	
	</c:if>
	
	<div class="align-right">
		<c:if test="${empty email.ask_content && user.mem_auth == 9}">
			<input type="button" value="답변작성" onclick="location.href='update?qna_num=${email.qna_num}'">
		</c:if>
		<c:if test="${!empty email.ask_content && user.mem_auth == 9}">
			<input type="button" value="답변수정" onclick="location.href='update?qna_num=${email.qna_num}'">
		</c:if>
		<c:if test="${!empty user && user.mem_num == email.mem_num}">
			<input type="button" value="삭제" id="delete_btn">
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.href='delete?qna_num=${email.qna_num}'
				}
			};
		</script>
	</c:if>
	<c:if test="${user.mem_auth == 1}">
	<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/email'">
	</c:if>
	<c:if test="${user.mem_auth == 9}">
	<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/email/email_admin'">	
	</c:if>
	</div>
	<hr size="1" width="100%">
</div>
<!-- 내용 끝 -->
