<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Main1 내용 시작 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
/* 추가적인 스타일링을 위한 부분 */
.carousel-item img {
	height: 400px; /* 캐러셀 이미지 높이 조절 */
	object-fit: cover; /* 이미지 비율 유지 */
}

.btn-container {
	display: none; /* 기본적으로 버튼 컨테이너 숨김 */
	position: absolute;
	bottom: 10px;
	left: 50%;
	transform: translateX(-50%);
	justify-content: center;
}

.poster {
	position: relative;
}

.poster:hover .btn-container {
	display: flex; /* 포스터 위에 마우스를 올렸을 때만 버튼 컨테이너 표시 */
}

.movie-poster:hover {
	filter: blur(1.5px);
}

.carousel-control-prev, .carousel-control-next {
	display: block;
}
</style>
<body>
	<div class="container mt-5">

		<!-- 캐러셀 영역 -->
		<div id="movieCarousel" class="carousel slide mx-auto d-block"
			data-ride="carousel" style="max-width: 800px;">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<!-- YouTube 임베드 코드 -->
					<iframe width="800" height="400"
						src="https://www.youtube.com/embed/EqRPpz7vt4I?si=PJCZpDKXo3mDTUvK"
						frameborder="0" allowfullscreen> </iframe>
					<div class="carousel-caption d-none d-md-block">
						<!-- <h5>영화 제목 1</h5>
						<p>영화 소개</p> -->
					</div>
				</div>
				<div class="carousel-item">
					<!-- 다른 YouTube 비디오를 삽입하려면 여기에 삽입 -->
					<iframe width="800" height="400"
						src="https://www.youtube.com/embed/Bldf9SWRPFM?si=7GSq_KDvUknQezY2"
						frameborder="0" allowfullscreen> </iframe>
					<div class="carousel-caption d-none d-md-block">
						<!-- <h5>영화 제목 2</h5>
						<p>영화 소개</p> -->
					</div>
				</div>
			</div>
			<a class="carousel-control-prev" href="#movieCarousel" role="button"
				data-slide="prev"> <span class="carousel-control-prev-icon"
				aria-hidden="true"></span> <span class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#movieCarousel" role="button"
				data-slide="next"> <span class="carousel-control-next-icon"
				aria-hidden="true"></span> <span class="sr-only">Next</span>
			</a>
		</div>

		<!-- 영화 목록 -->
		<div class="row mt-5">

			<%-- 영화 목록 반복 출력 --%>
			<c:forEach var="movie" items="${movieList}">
				<div class="col-md-4 mb-4">
					<div class="card">
						<div class="poster">
							<img src="https://image.tmdb.org/t/p/w500/${movie.movie_poster}"
								class="card-img-top movie-poster" alt="Movie Poster"
								style="width: 100%; height: 550px; object-fit: cover; object-position: center;">
							<div class="btn-container">
								<a href="/movie/movieDetail?movie_num=${movie.movie_num}"
									class="btn btn-light" style="margin-right: 5px;">상세정보</a> <a
									href="/reserve/reserveMain?movie_num=${movie.movie_num}"
									class="btn btn-light">예매하기</a>
							</div>
						</div>
						<div class="card-body" style="height: 150px;">
							<h5 class="card-title">${movie.movie_title}</h5>
							<p class="card-text">${movie.movie_tagline}</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	




	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script type="text/javascript">
$(document).ready(function(){
    // #movieCarousel의 carousel 요소를 찾고, slide.bs.carousel 이벤트 발생 시 자동 재생 설정
    $('#movieCarousel').carousel({ interval: 10000 });
    
  //캐러셀이 슬라이드될 때마다 실행되는 함수
    $('#movieCarousel').on('slide.bs.carousel', function () {
        // 현재 활성화된 슬라이드에서 유튜브 비디오를 찾음
        var videoElement = $(this).find('.carousel-item.active iframe');

        // 찾은 비디오를 재생
        if(videoElement.length > 0) {
            videoElement[0].contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
        }
    });
});

</script>
	<!-- Main1 내용 끝 -->