<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<div class="page-main">
	<h5>공지/뉴스</h5>
	<span>DDBOX의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.</span>	
		
	<br>
		
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	
	<form:form action="write" modelAttribute="newsVO" id="register_form">
	<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li  style="display: flex; align-items: center; height: 30px;">
			<form:label path="news_title" style="padding-top: 0px;">제목</form:label>
			<form:input path="news_title"/>
			<form:errors path="news_title" cssClass="error-color"/>
		</li>
 		<li style="display: flex; align-items: center; height: 30px; margin-top:5px;">
			<form:label path="news_category" style="padding-top: 0px;">유형</form:label>
			<form:radiobutton path="news_category" value="1" style="margin-right: 5px;"/>시스템점검
			<form:radiobutton path="news_category" value="2" style="margin-right: 5px; margin-left: 5px;"/>극장
			<form:radiobutton path="news_category" value="3" style="margin-right: 5px; margin-left: 5px;"/>행사/이벤트
			<form:radiobutton path="news_category" value="4" style="margin-right: 5px; margin-left: 5px;"/>기타
			<form:errors path="news_category" cssClass="error-color"/>
		</li>
		<li style="margin-top: 5px;">내용</li>
		<li style="margin-top: 10px;">
			<form:textarea path="news_content"/>
			<form:errors path="news_content" cssClass="error-color"/>
			<script>
				function MyCustomUploadAdapterPlugin(editor){
					editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						return new UploadAdapter(loader);
					}
				}
				
				//데이터를 넣어야하기 때문에 #content를 찾음 (에러 발생시 console에 찍기)
				ClassicEditor
					.create(document.querySelector('#news_content'),{
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
		<form:button>등록</form:button>
		<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/faq/news'">
	</div>
	</form:form>
</div>
<!-- 내용 끝 -->
