<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제확인</title> 
</head>
<body>
	<h2 style="border-bottom: 1px solid black; padding-bottom: 20px;">결제 확인</h2>
	<hr size="1" width="100%" noshade>
	<div>
	<table class="striped-table align-center" style="padding-bottom: 20px;">
			<tr>
				<th width="30%">영화제목</th>
				<td class="align-center">${movie.movie_title}</td>
			</tr>
				<tr>
					<th>상영관</th>
					<td class="align-center">${screen.scr_name}</td>
				</tr>
				<tr>
					<th>상영날짜</th>
					<td class="align-center">${param.choice_date}</td>
				</tr>
				<tr>
					<th>상영시간</th>
					<td class="align-center">${show.shw_time}</td>
				</tr>
				<tr>
					<th>상영인원</th>
					<td class="align-center">${param.res_mem_total}명</td>
				</tr>
				<tr>
					<th>결제가격</th>
					<td class="align-center">${param.res_pay}원</td>
				</tr>
		</table>
			<div class="align-center">
				<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main'">
			</div>
		</div>
</body>
</html>