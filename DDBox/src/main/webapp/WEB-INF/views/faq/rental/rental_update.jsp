<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>단체/대관 문의 수정</h2>
	<form:form action="update" modelAttribute="rentalVO" id="register_form">
	<form:hidden path="rental_num"/>
	<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li>
			<form:label path="scr_num">해당 영화관(*) </form:label>
			<form:select path="scr_num">
	            <form:option value="scr_num">영화관 선택</form:option>
	            <c:forEach var="screen" items="${list}">
    			<form:option value="${screen.scr_num}">${screen.scr_name}</form:option>
   				</c:forEach>
       			</form:select>
			</li>
			<li>
				<form:label path="rental_date">관람 희망일(*)</form:label>
				<input type="date" id="rental_date" name="rental_date">
				<form:errors path="rental_date" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="rental_per">희망인원(*)</form:label>
				<form:textarea path="rental_per"/>
				<form:errors path="rental_per" cssClass="error-color"/>
			</li>
	 		<li><b>내용</b></li>
	 		<li>
				<form:textarea path="rental_content"/>
				<form:errors path="rental_content" cssClass="error-color"/>
				<script>
				function MyCustomUploadAdapterPlugin(editor){
					editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						return new UploadAdapter(loader);
					}
				}
				
				//데이터를 넣어야하기 때문에 #content를 찾음 (에러 발생시 console에 찍기)
				ClassicEditor
					.create(document.querySelector('#rental_content'),{
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
	 		<li>
				<form:label path="rental_name">문의자명(*)</form:label>
				<form:textarea path="rental_name"/>
				<form:errors path="rental_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="rental_phone">연락처(*)</form:label>
				<form:textarea path="rental_phone"/>
				<form:errors path="rental_phone" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="rental_email">이메일(*)</form:label>
				<form:textarea path="rental_email"/>
				<form:errors path="rental_email" cssClass="error-color"/>
			</li>
		</ul>
		<!-- 개인정보 수집 동의란 -->
		<div>
		<ul>
			<li>
			개인정보 수집 및 이용에 대한 동의
			</li>
			<li>
				<label>동의여부</label>
				<input type="radio" name="admitCheck" id="admit1" value="1">동의함
				<input type="radio" name="admitCheck" id="admit2" value="2">동의안함
			</li>
			<li>
				정보주체는 개인정보의 수집 및 이용을 거부할 권리가 있으나,
				문의 접수 및 회신을 위한 최소한의 개인정보만을 수집하기 때문에 이를 거부하실 경우에는 서비스 이용에 어려움이 있을 수 있습니다.
				그 밖의 사항은 CJ CGV의 개인정보처리방침에 따릅니다.
			</li>
		</ul>
		</div>
		<div class="align-center">
			<form:button>등록하기</form:button>
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/faq/rental'">
		</div>
	</form:form>
</div>
<!-- 내용 끝 -->
