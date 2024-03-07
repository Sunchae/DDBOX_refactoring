<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<div class="page-main">
	<h5>VIP FAQ</h5>
	<span>VIP 문의글 작성</span><br>
	
	<form:form action="write" modelAttribute="vipVO" id="register_form" >
	<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li>
			<form:label path="vip_title">제목</form:label>
			<form:input path="vip_title"/>
			<form:errors path="vip_title" cssClass="error-color"/>
		</li>
		<br><li><b>내용</b></li>
		<li>
			<form:textarea path="vip_content"/>
			<form:errors path="vip_content" cssClass="error-color"/>
			<script>
				function MyCustomUploadAdapterPlugin(editor){
					editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						return new UploadAdapter(loader);
					}
				}
				
				//데이터를 넣어야하기 때문에 #content를 찾음 (에러 발생시 console에 찍기)
				ClassicEditor
					.create(document.querySelector('#vip_content'),{
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
	<div>
		<form:button>작성</form:button>
		<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/faq/vip'">
	</div>
	</form:form>
</div>
<!-- 내용 끝 -->
