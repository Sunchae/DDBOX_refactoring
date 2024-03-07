<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 내용 시작 -->
<style>
	 form {
            border: none;
            width: 800px;
    margin: 0 auto;
    padding: 10px 10px 30px 10px;
        }
        .page-main{
	width:20%;
	margin:0 auto;/*중앙 정렬*/
}
#page_body {
	    width: 50%;
	    float: left;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<div class="page-main">
	<form>
	<h2>${event_list.event_title}</h2>
	<c:if test="${!empty user && user.mem_auth == 9}">
	<input type="button" value="수정" onclick="location.href='update?event_num=${event_list.event_num}'">
	</c:if>
	<div class="detail-info">
		<p>기간 ${event_list.event_start}~${event_list.event_end}<br>
		조회 ${event_list.hit}
		</p>
	</div>
	<div class="detail-content">
		${event_list.event_content}
	</div>

	<c:if test="${fn:endsWith(event_list.event_photo2,'.jpg') || 
					fn:endsWith(event_list.event_photo2,'.JPG') ||
					fn:endsWith(event_list.event_photo2,'.jpeg') ||
					fn:endsWith(event_list.event_photo2,'.JPEG') ||
					fn:endsWith(event_list.event_photo2,'.gif') ||
					fn:endsWith(event_list.event_photo2,'.GIF') ||
					fn:endsWith(event_list.event_photo2,'.png') ||
					fn:endsWith(event_list.event_photo2,'.PNG')}">
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${event_list.event_photo2}" class="detail-img">
	</div>
	</c:if>
	<div style="text-align:center;">
	<c:if test="${event_list.event_type == 2}">
    	<input type="button" class="entry_btn" value="응모하기" onclick='entryButtonClick("${event_list.event_num}")' data-event_num="${event_list.event_num}">
	</c:if>		
	</div>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/event_entry.js"></script>
<!-- 내용 끝 -->