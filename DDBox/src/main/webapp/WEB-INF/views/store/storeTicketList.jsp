<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<div class="page-main">
	<div class="main-title" id="store_form">
		<div class="align-right">
			<c:if test="${user.mem_auth ==9}"> 		<%-- 관리자 로그인 되어있을 때 만 보임 --%>
			<input type="button" value="글쓰기" onclick="location.href='write'">
			</c:if>
		</div>
	</div>
</div>
<script src="//cast.imp.joins.com/head/sNpWayIeZMwBzZiXjLEN5CFsn6DhQ2SnK1WFI5QSow2EAM4qWzAZAbZLTXgybHJFT1FUaXl1R2dEcHVJcVFBAstB2XI2taBmKgPLQdlyNrWgZio.js?url=https%3A%2F%2Fmegabox.co.kr%2Fstore%3FprdtClCd%3D&ref=https%3A%2F%2Fmegabox.co.kr%2Fstore%3FprdtClCd%3DCPC07"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KJY.css">
<!-- storeMainList -->
<div id="storeMainList">
<!-- contents -->
	<div id="contents">
<!-- inner-wrap -->
		<div class="inner-wrap">
			<h2 class="tit">디디티켓</h2>
<!-- tab-list -->
			<div class="tab-list fixed">
				<ul>
					<li id="storeTab_ticketList"><a href="${pageContext.request.contextPath}/store/ticketList">디디티켓</a>
					</li>
					<li id="storeTab_popcorn"><a href="${pageContext.request.contextPath}/store/storePopcorn">팝콘/음료/굿즈</a>
					</li>
				</ul>
			</div>
			<div id="divNewPrdArea">
				<div class="store-list mt30">
					<ul class="list">
						<c:forEach var="store" items="${list}">
							<li>
								<a href="${pageContext.request.contextPath}/store/detail?store_num=${store.store_num}">
									<div class="img">
										<img alt="${store.store_content}"
											src="${pageContext.request.contextPath}/upload/${store.store_photo}">
									</div>
									<div class="info">
										<div class="tit">
											<p class="name">${store.store_title}</p>
											<p class="bundle">${store.store_content}</p>
										</div>
										<div class="price">
											<p class="original">${store.store_price}<span>원</span></p>
										</div>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="align-center">${page}</div>
		</div>
	</div>
</div>
