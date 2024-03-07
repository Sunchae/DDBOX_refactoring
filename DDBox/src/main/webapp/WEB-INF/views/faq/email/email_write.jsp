<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<div class="page-main">
	<h5>이메일 문의</h5>
	<span>문의글을 남겨주시면 답변을 남겨드립니다.</span><br>
	
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	
	<form:form action="write" modelAttribute="emailVO" id="register_form" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
			※ 문의에 대한 따른 답변을 위해 회원 가입 시 입력하신 연락처를 확인해주세요. <input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/member/updateUser'">
			</li>
		</ul>
		<hr style="border-top: 1px dashed #ccc;">
		<!-- 내용기입 -->	
		<ul>
	 		<li style="display: flex; align-items: center; height: 30px;">
				<form:label path="qna_type" style="margin-right: 10px; padding-top: 0px;">문의유형(<span>*</span>)</form:label>
				<form:radiobutton path="qna_type" value="1" style="margin-right: 5px;"/>문의
				<form:radiobutton path="qna_type" value="2" style="margin-right: 5px; margin-left: 8px;"/>불만
				<form:radiobutton path="qna_type" value="3" style="margin-right: 5px; margin-left: 8px;"/>칭찬
				<form:radiobutton path="qna_type" value="4" style="margin-right: 5px; margin-left: 8px;"/>제안
				<form:radiobutton path="qna_type" value="5" style="margin-right: 5px; margin-left: 8px;"/>분실물
				<form:errors path="qna_type" cssClass="error-color"/>
			</li>
			<li style="display: flex; align-items: center; height: 30px;">
				<form:label path="scr_num" style="margin-right: 10px; padding-top: 0px;">해당 영화관</form:label>
				<form:select path="scr_num">
		            <form:option value="0">영화관 선택</form:option>
		            <c:forEach var="screen" items="${list}">
      				  <form:option value="${screen.scr_num}">${screen.scr_name}</form:option>
    				</c:forEach>
       			</form:select>
			</li>
			<li style="display: flex; align-items: center; height: 30px;  margin-top:10px;">
				<form:label path="qna_title" style="margin-right: 10px; padding-top: 0px;">제목(<span>*</span>)</form:label>
				<form:input path="qna_title"/>
				<form:errors path="qna_title" cssClass="error-color"/>
			</li><br>
			<li>내용(<span>*</span>)</li><br>
			<li>
			<form:textarea path="question_content"/>
			<form:errors path="question_content" cssClass="error-color"/>
			<script>
				function MyCustomUploadAdapterPlugin(editor){
					editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						return new UploadAdapter(loader);
					}
				}
				
				//데이터를 넣어야하기 때문에 #content를 찾음 (에러 발생시 console에 찍기)
				ClassicEditor
					.create(document.querySelector('#question_content'),{
						extraPlugins:[MyCustomUploadAdapterPlugin]
					})
					.then(editor => {
						window.editor = editor;
					})
					.catch(error => {
						console.error(error);
					});
			</script>		
		</li><br>
			<li style="display: flex; align-items: center; height: 30px;  margin-top:10px;">
				<form:label path="upload" style="margin-right: 10px; padding-top: 0px;">첨부파일</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul>
		<div class="align-center">
			<form:button>등록</form:button>
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/faq/email'">
		</div>
	</form:form>
</div>
<!-- 내용 끝 -->
