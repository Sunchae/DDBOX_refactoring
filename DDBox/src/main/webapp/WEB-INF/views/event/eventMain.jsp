<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 내용 시작 -->
<div id="page-main">
	<!-- <form action="main" id="event_form" method="get"> -->
		<div class="tit-util">
			<h3 class="tit">SPECIAL</h3>
			<div class="more-btn">
				<c:if test="${!empty user && user.mem_auth == 9}">
				<input type="button" value="글쓰기" onclick="location.href='write'">
				
				</c:if>
				<a href="${pageContext.request.contextPath}/event/special">더보기</a>
			</div>
		</div>
		<div class="event-list">
		<c:set var="specialCounter" value="0"/>
		<c:forEach var="list" items="${list}">
		<c:if test="${list.event_type == 1 && specialCounter < 3}">
		<c:set var="specialCounter" value="${specialCounter + 1}"/>
			<ul>
				<li class="list-card">
					<a href="detail?event_num=${list.event_num}">
						<p class="img">
							<img src="${pageContext.request.contextPath}/upload/${list.event_photo1}" class="list-img">
						</p>
						<p class="tit">${list.event_title}</p>
						<p class="date">${list.event_start}~${list.event_end}
						<br>조회 : ${list.hit}</p>
						
					</a>
				</li>
			</ul>
		</c:if>
		</c:forEach>
		</div>
		<div class="tit-util">
			<h3 class="tit">응모권 이벤트</h3>
			<div class="more-btn">
				<a href="${pageContext.request.contextPath}/event/entry">더보기</a>
			</div>
		</div>
		<div class="event-list">
		<c:set var="specialCounter" value="0"/>
		<c:forEach var="list" items="${list}">
		<c:if test="${list.event_type == 2 && specialCounter < 3}">
		<c:set var="specialCounter" value="${specialCounter + 1}"/>
			<ul>
				<li>
					<a href="detail?event_num=${list.event_num}">
						<p class="img">
							<img src="${pageContext.request.contextPath}/upload/${list.event_photo1}" class="list-img">
						</p>
						<p class="tit">${list.event_title}</p>
						<p class="date">${list.event_start}~${list.event_end}
						<br>조회 : ${list.hit}</p>
					</a>
				</li>
			</ul>
		</c:if>
		</c:forEach>
		</div>
		<div class="tit-util">
			<h3 class="tit">멤버쉽/CLUB</h3>
			<div class="more-btn">
				<a href="${pageContext.request.contextPath}/event/membership">더보기</a>
			</div>
		</div>
		<div class="event-list">
		<c:set var="specialCounter" value="0"/>
		<c:forEach var="list" items="${list}">
		<c:if test="${list.event_type == 3 && specialCounter < 3}">
		<c:set var="specialCounter" value="${specialCounter + 1}"/>
			<ul>
				<li class="list-card">
					<a href="detail?event_num=${list.event_num}">
						<p class="img">
							<img src="${pageContext.request.contextPath}/upload/${list.event_photo1}" class="list-img">
						</p>
						<p class="tit">${list.event_title}</p>
						<p class="date">${list.event_start}~${list.event_end}
						<br>조회 : ${list.hit}</p>
					</a>
				</li>
			</ul>
		</c:if>
		</c:forEach>
		</div>
		<div class="tit-util">
			<h3 class="tit">극장별</h3>
			<div class="more-btn">
				<a href="${pageContext.request.contextPath}/event/theater">더보기</a>
			</div>
		</div>
		<div class="event-list">
		<c:set var="specialCounter" value="0"/>
		<c:forEach var="list" items="${list}">
		<c:if test="${list.event_type == 4 && specialCounter < 3}">
		<c:set var="specialCounter" value="${specialCounter + 1}"/>
			<ul>
				<li class="list-card">
					<a href="detail?event_num=${list.event_num}">
						<p class="img">
							<img src="${pageContext.request.contextPath}/upload/${list.event_photo1}" class="list-img">
						</p>
						<p class="tit">${list.event_title}</p>
						<p class="date">${list.event_start}~${list.event_end}
						<br>조회 : ${list.hit}</p>
					</a>
				</li>
			</ul>
		</c:if>
		</c:forEach>
		</div>
		<div class="tit-util">
			<h3 class="tit">제휴/할인</h3>
			<div class="more-btn">
				<a href="${pageContext.request.contextPath}/event/discount">더보기</a>
			</div>
		</div>
		<div class="event-list">
		<c:set var="specialCounter" value="0"/>
		<c:forEach var="list" items="${list}">
		<c:if test="${list.event_type == 5 && specialCounter < 3}">
		<c:set var="specialCounter" value="${specialCounter + 1}"/>
			<ul>
				<li class="list-card">
					<a href="detail?event_num=${list.event_num}">
						<p class="img">
							<img src="${pageContext.request.contextPath}/upload/${list.event_photo1}" class="list-img">
						</p>
						<p class="tit">${list.event_title}</p>
						<p class="date">${list.event_start}~${list.event_end}
						<br>조회 : ${list.hit}</p>
					</a>
				</li>
			</ul>
		
		</c:if>
		</c:forEach>
		</div>
	<!-- </form> -->
</div>
<!-- 내용 끝 -->