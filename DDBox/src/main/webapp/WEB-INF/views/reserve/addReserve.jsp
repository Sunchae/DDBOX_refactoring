<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영정보 추가</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

</head>
<body>
<script type="text/javascript">
	$(function() {
		// 상영 시작 날짜에 Datepicker를 적용
		$("#startDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});

		// 상영 종료 날짜에 Datepicker를 적용
		$("#endDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
</script>
<div class="page-main">
	<h2>상영정보 추가</h2>
	<form:form action="addReserve" id="ticket_register" modelAttribute="showVO">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="shw_sdate">상영시작날짜</form:label>
				<form:input	path="shw_sdate" id="startDate" placeholder="날짜 선택" autocomplete="off"/> 
				<form:errors path="shw_sdate" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="shw_edate">상영종료날짜</form:label>
				<form:input	path="shw_edate" id="endDate" placeholder="날짜 선택" autocomplete="off"/> 
				<form:errors path="shw_edate" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="shw_time">상영시간</form:label>
				<form:input path="shw_time" type="time"/>
				<form:errors path="shw_time" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="shw_seatCnt">상영좌석수</form:label> 
				<form:input	path="shw_seatCnt"/> 
				<form:errors path="shw_seatCnt" cssClass="error-color" />
			</li>
			<li>
				<form:label path="scr_name">상영관 선택</form:label>
					<form:select class="screen_choice" path="scr_num">
					<c:forEach var="reserve" items="${list3}">
						<form:option value="${reserve.scr_num}">${reserve.scr_name}</form:option>
					</c:forEach>
					</form:select>
				<form:errors path="movie_title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="movie_title">영화선택</form:label>
					<form:select class="movie_choice" path="movie_num">
					<c:forEach var="reserve" items="${list}">
						<form:option value="${reserve.movie_num}">${reserve.movie_title}</form:option>
					</c:forEach>
					</form:select>
				<form:errors path="movie_title" cssClass="error-color"/>
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="submit" value="홈으로" class="default-btn" onclick="location.href='reserveList'">
		</div>                                  
	</form:form>
</div>
</body>
</html>