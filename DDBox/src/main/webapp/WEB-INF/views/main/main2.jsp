<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Main2 내용 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SSY.css">
<body>
	<div id="page-main">
		
		<h2><a href="${pageContext.request.contextPath}/event/main">이벤트</a></h2>
		
		<!-- 이벤트 목록 -->
		<div class="row mt-5">
			<!-- 이벤트 목록 반복 출력 -->
			
				<div class="event-list">
				<c:forEach var="event" items="${eventList}">
					<ul>
						<li class="list-card">
						<a href="${pageContext.request.contextPath}/event/detail?event_num=${event.event_num}">
								<p class="img">
									<img src="${pageContext.request.contextPath}/upload/${event.event_photo1}"
										class="list-img">
								</p>
								<p class="tit">${event.event_title}</p>
								<p class="date">${event.event_start}~${event.event_end}<br>조회수 : ${event.hit}</p>
								
						</a>
						</li>
					</ul>
				</c:forEach>
				</div>
			
		</div>

	</div>
<!-- Main2 내용 끝 -->
</body>