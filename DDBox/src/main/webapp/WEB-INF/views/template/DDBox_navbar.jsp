<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YSC.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


<div id="header">
	<div class="container-fluid">
		<nav class="navbar navbar-expand-lg navbar-light bg-top p-0" id="navbar-top">
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a href="${pageContext.request.contextPath}/faq/vip" class="nav-link">VIP LOUNGE</a></li>
					<li class="nav-item"><a href="#" class="nav-link">멤버십</a></li>
					<li class="nav-item"><a href="${pageContext.request.contextPath}/faq/main" class="nav-link">고객센터</a></li>
				</ul>
				<ul class="navbar-nav">
					<c:if test="${empty user }">
						<li class="nav-item"><a href="${pageContext.request.contextPath}/member/login" class="nav-link">로그인</a></li>
						<li class="nav-item"><a href="${pageContext.request.contextPath}/member/registerUserCheck" class="nav-link">회원가입</a></li>
					</c:if>
					<c:if test="${!empty user }">
						<li class="nav-item"><a href="${pageContext.request.contextPath}/member/logout" class="nav-link">로그아웃</a></li>
					</c:if>
					<li class="nav-item"><a href="#" class="nav-link">빠른예매</a></li>
				</ul>
			</div>
		</nav>
	
		<nav class="navbar navbar-expand-lg navbar-light" id="navbar-2">
			<div class="collapse navbar-collapse justify-content-start">
				<ul class="navbar-nav util-list">
					<li class="nav-item"><a class="nav-link" href="#"><img
							src="${pageContext.request.contextPath}/images/nav/ico-sitemap.png"></a>
					</li>

					<li class="nav-item dropdown"><a class="nav-link" href="#"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> <img
							src="${pageContext.request.contextPath}/images/nav/ico-search.png">
					</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<div class="search-box p-3">
								<form action="" onsubmit="return false;">
									<input class="form-control" type="search" name="keyword"
										placeholder="영화를 검색하세요!" aria-label="Search"
										id="movieSearchInput">
									
								</form>
								<ul id="searchResults" class="list-group"></ul>
								<!-- 검색 결과를 동적으로 추가할 리스트 -->
							</div>
						</ul></li>
				</ul>
			</div>
			<div class="collapse navbar-collapse justify-content-center" id="navbarNav">
				<ul class="navbar-nav ">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/movie/main">영화</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/reserve/reserveMain">예매</a></li>
					<li class="nav-item"><a class="nav-link" href="#">극장</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/main/main" ><img id="DDBoxLogo" src="${pageContext.request.contextPath}/images/DDBox.png"></a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event/main">이벤트</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/store/storeMainTest">스토어</a></li>
					<li class="nav-item"><a class="nav-link" href="#">혜택</a></li>
				</ul>
			</div>
			<div class="collapse navbar-collapse justify-content-end">
				<ul class="navbar-nav util-list">
					<li class="nav-item"><a class="nav-link" href="#"><img src="${pageContext.request.contextPath}/images/nav/ico-schedule.png"></a></li>
					<c:if test="${user.mem_auth != 9}">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/myPage"><img src="${pageContext.request.contextPath}/images/nav/ico-mymega.png"></a></li>
					</c:if>
					<c:if test="${user.mem_auth == 9}">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/AdminPageMain"><img src="${pageContext.request.contextPath}/images/nav/ico-mymega.png"></a></li>
					</c:if>
				</ul>
			</div>
		</nav>
	</div>
</div>

<script>
$(document).ready(function() {
    // 동적으로 생성되는 요소에 대한 이벤트 위임
     $(document).on("keyup", "#movieSearchInput", function() {
    	 console.log("키 입력 이벤트 발생");
        let keyword = $(this).val();

        if (keyword.length > 0) {
            $.ajax({
                url: '/movie/search', // 서버의 영화 검색 API URL
                type: 'GET',
                dataType: 'json',
                data: { keyword: keyword },
                success: function(movies) {
                	console.log(movies);
                    $("#searchResults").empty(); // 검색 결과 컨테이너를 비웁니다.
                    $.each(movies, function(index, movie) {
                        let movieLink = $('<a>').attr('href', "/movie/movieDetail?movie_num=" + movie.movie_num).text(movie.movie_title);
                        console.log(movie.movie_num)
                        $("#searchResults").append($('<li class="list-group-item">').append(movieLink));
                    });
                },
                error: function() {
                    console.error('검색 중 오류 발생');
                }
            });
        } else {
            $("#searchResults").empty(); // 검색창이 비었을 때 결과를 지웁니다.
        }
    });
});
</script>






































