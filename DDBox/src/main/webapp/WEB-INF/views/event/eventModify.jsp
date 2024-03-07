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
	<h2>글수정</h2>
	<form:form action="modify" modelAttribute="event_listVO" id="register_form" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="event_title">제목</form:label>
				<form:input path="event_title"/>
				<form:errors path="event_title" cssClass="error-color"/>
			</li>
			<li><b>내용</b></li>
			<li>
				<form:textarea path="event_content"/>
				<form:errors path="event_content" cssClass="error-color"/>
			</li>
			<li>
			    <form:label path="event_type">이벤트 타입</form:label>
				<select id="event_type" name="event_type" class="type-select">
 					<option value="0" <c:if test="${event_type==0}">selected</c:if>>룰렛</option>
 			 		<option value="1" <c:if test="${event_type==1}">selected</c:if>>스페셜 이벤트</option>
		  			<option value="2" <c:if test="${event_type==2}">selected</c:if>>응모권 이벤트</option>
		  			<option value="3" <c:if test="${event_type==3}">selected</c:if>>멤버쉽</option>
		  			<option value="4" <c:if test="${event_type==4}">selected</c:if>>극장별</option>
		  			<option value="5" <c:if test="${event_type==5}">selected</c:if>>제휴/할인</option>
				</select>
			</li>
			
			<%-- <li>
				<form:label path="scr_num">상영관 번호</form:label>
			</li> --%>
			<li>
				<form:label path="event_start">이벤트 시작 날짜</form:label>
				<form:input path="event_start"/>
				<form:errors path="event_start" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="event_end">이벤트 종료 날짜</form:label>
				<form:input path="event_end"/>
				<form:errors path="event_end" cssClass="error-color"/>
			</li> 
			<li>
				<form:label path="upload1">파일업로드</form:label>
				<input type="file" name="upload1" id="upload1">
			</li>
			<li>
				<form:label path="upload2">파일업로드</form:label>
				<input type="file" name="upload2" id="upload2">
			</li>
		</ul>
		<div class="align-center">
			<form:button>전송</form:button>
			<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/event/main'">
		</div>
	</form:form>
</div>
<!-- 내용 끝 -->