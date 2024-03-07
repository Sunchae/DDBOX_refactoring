<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSH.css">
<div class="page-main">
	<h5>공지/뉴스</h5>
	<span>DDBOX의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.</span>	
		
	<br>
	
	<hr style="border-width:1px 0 0 0; border-color:#ccc;">
	<ul class="detail-info">
		<li>
			<c:if test="${news.news_category==1}">[시스템점검]</c:if>
				<c:if test="${news.news_category==2}">[극장]</c:if>
				<c:if test="${news.news_category==3}">[행사/이벤트]</c:if>
				<c:if test="${news.news_category==4}">[기타]</c:if>
		${news.news_title}</li>
		<li>
			작성일 ${news.news_regdate}
			조회수 ${news.news_hit}
		</li>
	</ul>
		<br>
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">
		<div class="detail-content">
			<br>${news.news_content}
		</div>
		
		<hr style="border-width:1px 0 0 0; border-color:#ccc;">
		<div class="align-right">
			<c:if test="${!empty user && user.mem_auth == 9}">
				<input type="button" value="수정" onclick="location.href='update?news_num=${news.news_num}'">
				<input type="button" value="삭제" id="delete_btn">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.href='delete?news_num=${news.news_num}'
					}
				};
			</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/faq/news'">
		</div>
		<hr size="1" width="100%">
	</div>
<!-- 내용 끝 -->