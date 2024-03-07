<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<div class="page-main">
	<h5>문의글 답변</h5>
	<span>회원 문의글에 답변을 남겨주세요.</span><br>
	
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">	
	
	<form:form action="update" modelAttribute="emailVO" id="update_form" enctype="multipart/form-data">
	<form:hidden path="qna_num"/>
	<form:hidden path="mem_num"/>
	<form:errors element="div" cssClass="error-color" />
	<ul class="detail-info">
		<li>
			<c:if test="${emailVO.qna_type==1}">[문의]</c:if>
			<c:if test="${emailVO.qna_type==2}">[불만]</c:if>
			<c:if test="${emailVO.qna_type==3}">[칭찬]</c:if>
			<c:if test="${emailVO.qna_type==4}">[제안]</c:if>
			<c:if test="${emailVO.qna_type==5}">[분실물]</c:if>
		${emailVO.qna_title}</li>
		<li>
			작성일: ${emailVO.question_regdate}
			<c:if test="${emailVO.scr_num>0}">${emailVO.scr_name}</c:if>
		</li>
	</ul>
		<br>
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">
		
	<div class="detail-content">
	<!-- 사진 -->
	<c:if test="${fn:endsWith(emailVO.question_file, '.jpg') ||
				  fn:endsWith(emailVO.question_file, '.JPG') ||
				  fn:endsWith(emailVO.question_file, '.jpeg') ||
				  fn:endsWith(emailVO.question_file, '.JPEG') ||
				  fn:endsWith(emailVO.question_file, '.gif') ||
				  fn:endsWith(emailVO.question_file, '.GIF') ||
				  fn:endsWith(emailVO.question_file, '.png') ||
				  fn:endsWith(emailVO.question_file, '.PNG')}">
	<ul>
		<li>첨부파일 : <a href="file?qna_num=${emailVO.qna_num}">${emailVO.question_file}</a></li>
	</ul>
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${emailVO.question_file}" class="detail-img" width="760">
	</div>
	</c:if>
	
	<ul>
	<li>
	${emailVO.question_content}
	</li>
	</ul>
	</div>
	<br>
	<hr style="border-top: 1px dashed #ccc;">
		
		
	<!-- 답글 -->
	<ul>
	<li><b>답변 작성</b></li><br>
		<li>
		<form:textarea path="ask_content"/>
		<form:errors path="ask_content" cssClass="error-color"/>
		<script>
			function MyCustomUploadAdapterPlugin(editor){
				editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					return new UploadAdapter(loader);
				}
			}
			
			//데이터를 넣어야하기 때문에 #content를 찾음 (에러 발생시 console에 찍기)
			ClassicEditor
				.create(document.querySelector('#ask_content'),{
					extraPlugins:[MyCustomUploadAdapterPlugin]
				})
				.then(editor => {
					window.editor = editor;
				})
				.catch(error => {
					console.error(error);
				});
		</script>		
	</li>
	</ul>
	<div class="align-center">
        <form:button>등록</form:button>
        <input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/faq/email/detail?qna_num=${emailVO.qna_num}'">
	</div>
	</form:form>
</div>
