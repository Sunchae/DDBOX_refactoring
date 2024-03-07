<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<div class="page-main">
	<h5>VIP FAQ</h5>
	<span>고객님께서 궁금하신 내용을 먼저 확인해주세요.</span>

	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<ul class="detail-info">
		<li class="">${vip.vip_title}</li>
	</ul>

	<br>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">

	<div class="detail-content">
		${vip.vip_content}
	</div>
	<br>
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
		<div class="align-right">
			<c:if test="${!empty user && user.mem_auth == 9}">
				<input type="button" value="수정" onclick="location.href='update?vip_num=${vip.vip_num}'">
				<input type="button" value="삭제" id="delete_btn">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.href='delete?vip_num=${vip.vip_num}'
					}
				};
			</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/vip'">
		</div>
		<hr size="1" width="100%">
	</div>
<!-- 내용 끝 -->