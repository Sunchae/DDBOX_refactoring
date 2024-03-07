<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<!-- 내용 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<script type="text/javascript">
	$(document).ready(function () {
		$("#register_form").submit(function () {
			return validationForm();
		});
	});

	function validationForm(){
		var admitCheck1 = document.getElementById("admit1").checked;
		var admitCheck2 = document.getElementById("admit2").checked;
		
		if (!admitCheck1 && !admitCheck2){
			alert("동의 여부를 체크하세요.");
			return false;
		}else if(admitCheck2){
			alert("동의함을 체크하여야 작성 가능합니다.");
			return false;
		}else{
			return true;
		}
	}
</script>
<div class="page-main">
	<h5>단체/대관 문의</h5>
	<span>단체 및 대관 예약 문의입니다.</span><br>
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<form:form action="write" modelAttribute="rentalVO" id="register_form" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li style="display: flex; align-items: center; height: 30px;">
				<form:label path="scr_num" style="padding-top: 0px;">해당 영화관(<span>*</span>) </form:label>
				<form:select path="scr_num">
		            <form:option value="scr_num">영화관 선택</form:option>
		            <c:forEach var="screen" items="${list}">
      				  <form:option value="${screen.scr_num}">${screen.scr_name}</form:option>
    				</c:forEach>
       			</form:select>
			</li>
			<li style="display: flex; align-items: center; height: 30px; margin-top:5px;">
				<form:label path="rental_date" style="padding-top: 0px;">관람 희망일(<span>*</span>)</form:label>
				<input type="date" id="rental_date" name="rental_date">
				<form:errors path="rental_date" cssClass="error-color"/>
			</li>
			<li style="margin-top:10px;">
				<div class="hope">
					<form:label path="rental_per">희망인원(<span>*</span>)</form:label>
					<form:textarea path="rental_per"/>
					<form:errors path="rental_per" cssClass="error-color"/>
				</div>
				<div class="hope">
					<form:label path="rental_name">문의자명(<span>*</span>)</form:label>
					<form:textarea path="rental_name"/>
					<form:errors path="rental_name" cssClass="error-color"/>
				</div>
				<div class="hope">
					<form:label path="rental_phone">연락처(<span>*</span>)</form:label>
					<form:textarea path="rental_phone"/>
					<form:errors path="rental_phone" cssClass="error-color"/>
				</div>
				<div class="hope">
					<form:label path="rental_email">이메일(<span>*</span>)</form:label>
					<form:textarea path="rental_email"/>
					<form:errors path="rental_email" cssClass="error-color"/>
				</div>
			</li>	
			<li style="margin-bottom:10px;">내용(<span>*</span>)</li>
	 		<li >
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
		</ul>
		<br>
		<hr style="border-top: 1px dashed #ccc;">
		<!-- 개인정보 수집 동의란 -->
		<div>
		<ul>
			<li class="align-center"><b>&lt;개인정보 수집 및 이용에 대한 동의&gt;</b></li><br>
			<li>
				정보주체는 개인정보의 수집 및 이용을 거부할 권리가 있으나,
				문의 접수 및 회신을 위한 최소한의 개인정보만을 수집하기<br>때문에 이를 거부하실 경우에는 서비스 이용에 어려움이 있을 수 있습니다.
				그 밖의 사항은 CJ CGV의 개인정보처리방침에<br>따릅니다.
			</li><br>
			
			<li style="display: flex; align-items: center; height: 30px;">
				<label style="margin-right: 10px; padding-top: 0px;">동의여부(<span>*</span>)</label>
				<input type="radio" name="admitCheck" id="admit1" value="1" style="margin-right: 5px;">동의함
				<span style="margin-right: 15px;"></span>
				<input type="radio" name="admitCheck" id="admit2" value="2" style="margin-right: 5px;">동의안함
			</li>
		</ul>
		</div>
		<div class="align-center">
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/faq/rental'">
		</div>
	</form:form>
</div>
<!-- 내용 끝 -->
