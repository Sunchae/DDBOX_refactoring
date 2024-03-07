<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!-- 내용 시작 -->
    <title>영화 상세 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movieDetail.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

    <!-- 영화 상세 페이지 컨테이너 -->
<div class="movie-detail-page">

    <!-- 1번 영역: 영화 제목, 좋아요 버튼, 포스터, 예매 버튼 -->
    <div class="movie-content-area">
        <div class="movie-texts">
            <h1 class="movie-title-kr">${movie.movie_title}</h1>
            <h2 class="movie-title-en">${movie.movie_original_title}</h2>
			<button class="like-button" data-num="${movie.movie_num}">
				<img src="" class="heart-icon" alt="좋아요">
				<span class="likes-count">${likesCount}</span>
			</button>
		</div>
        <div class="movie-booking-area">
            <img src="https://image.tmdb.org/t/p/w500/${movie.movie_poster}" alt="영화 포스터" class="movie-poster">
            <div></div>
            <a href="/reserve/reserveMain" ><button class="booking-button">예매하기</button></a>
        </div>
    </div>

	<!-- 2번 영역: 영화 tagline, 줄거리, 감독, 장르, 등급, 개봉일, 출연진 -->
    <div class="movie-info-area">
        <p class="tagline">${movie.movie_tagline}</p>
        <div class="summary">
        	<span class="summary-test">${movie.movie_overview }</span> 
       		 <button class="more-button">더보기</button>
       	</div>
        <div class="additional-info">
            <p id="director">감독 : Director Name</p>
            <p id="genres">장르: Genre</p>
            <p>
				이용등급:

				<c:choose>
					<c:when test="${movie.movie_gradeNm == 1}">
						12세 이용가
					</c:when>
					<c:when test="${movie.movie_gradeNm == 2}">
						15세 이용가
					</c:when>
					<c:when test="${movie.movie_gradeNm == 0}">
						전체 이용가
					</c:when>
				</c:choose>


			</p>
            <p>개봉일: ${movie.movie_opendate }</p>
            <p id="cast-list">출연진: Cast Members</p>
        </div>
    </div>

    <!-- 3번 영역: 차트/그래프 예매자 남녀비율, 연령대 등 -->
	<div class="charts-container">
	    <div id="age_group_chart" class="chart"></div>
	    <div id="gender_chart" class="chart"></div>
	</div>
	<!-- 4번 영역: 사용자 리뷰 및 평점 -->
    <div class="user-reviews-area">
        <h3>사용자 리뷰 및 평점</h3>
        <div class="review-form">
            <!-- AJAX로 처리될 리뷰 폼 -->
        </div>
        <div class="reviews-list">
            <!-- 사용자 리뷰 목록 -->
        </div>
    </div>

</div>
<script>
$(document).ready(function() {
    var movieNum = $('.like-button').data('num'); // 영화 번호를 변수에 저장

    // 페이지 로드 시 좋아요 상태 확인
    checkLikeStatus(movieNum);

    // 좋아요 버튼 클릭 이벤트
    $('.like-button').on('click', function() {
        var $this = $(this); // 현재 클릭된 버튼을 $this 변수에 할당

        // 좋아요 토글 요청
        $.ajax({
            url: '/movie/toggleLike',
            type: 'POST',
            dataType: 'json',
            data: { movie_num: movieNum },
            success: function(param) {
               if(param.status == "logout"){
            	   alert(param.message);
            	   window.location.href="/member/login";//로그인 페이지로 이동
               }else{
            	
            	var heartIcon = $this.find('.heart-icon');
                var likesCountSpan = $this.find('.likes-count');

                if(param.liked) {
                    heartIcon.attr('src', '${pageContext.request.contextPath}/images/movie/채워진하트.png'); // 채워진 하트 이미지로 변경
                } else {
                    heartIcon.attr('src', '${pageContext.request.contextPath}/images/movie/빈하트.png'); // 빈 하트 이미지로 변경
                }
                likesCountSpan.text(param.likesCount); // 좋아요 개수 업데이트
               }
            },
            error: function() {
                alert('좋아요 처리 중 오류가 발생했습니다.');
            }
        });
    });
});

// 페이지 로드 시 현재 사용자의 좋아요 상태 확인 함수
function checkLikeStatus(movieNum) {
    $.ajax({
        url: '/movie/checkLikeStatus',
        type: 'POST',
        dataType: 'json',
        data: { movie_num: movieNum },
        success: function(response) {
            var heartIcon = $('.like-button').find('.heart-icon');
            if(response.status === "liked") {
                heartIcon.attr('src', '${pageContext.request.contextPath}/images/movie/채워진하트.png');
            } else {
                heartIcon.attr('src', '${pageContext.request.contextPath}/images/movie/빈하트.png');
            }
        },
        error: function() {
            console.error('좋아요 상태 확인 중 오류 발생');
        }
    });
}

function getQueryStringParam(param) {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    return urlParams.get(param);
}

// movieNum 변수에 'movie_num' 쿼리 파라미터 값을 할당
let movieNum = getQueryStringParam('movie_num');

console.log(movieNum); // 콘솔에서 movie_num 값 확인

//영화 상세 정보를 가져오는 함수
function fetchMovieDetails(movieNum) {
    let apiKey = "fa44f7ba22e7b7a5a7d41d6feaf39cea";
    const url = "https://api.themoviedb.org/3/movie/" +movieNum+ "?api_key=" +apiKey+ "&language=ko-KR";
    const creditsUrl = "https://api.themoviedb.org/3/movie/"+movieNum+"/credits?api_key="+apiKey+"&language=ko-KR";
    
    console.log(url);
    console.log(creditsUrl);
    
    fetch(url)
    .then(response => response.json())
    .then(data => {
        // 장르 정보 표시
        const genres = data.genres.map(genre => genre.name).join(', ');
        document.getElementById('genres').textContent = '장르: ' +genres;
    })
    .catch(error => console.log('Error:', error));
    
    // 영화 크레딧 정보 가져오기
    fetch(creditsUrl)
    .then(response => response.json())
    .then(data => {
        // 감독 정보 찾기
        const director = data.crew.find(member => member.job === "Director");
        const directorName = director.name;
        console.log(director);
        console.log(directorName);
        if(director) {
            // 감독의 이름만 표시
            document.getElementById('director').textContent = `감독: `+directorName;
        } else {
            document.getElementById('director').textContent = '감독: 정보 없음';
        }
        
	     // 상위 4명의 배우 이름 추출 및 표시
	     const topFourCastNames = data.cast.slice(0, 4).map(actor => actor.name).join(', ');
	     console.log(topFourCastNames);
	     document.getElementById('cast-list').textContent = '출연진 : ' +topFourCastNames ;
	       
    })
    .catch(error => console.log('Error:', error));
    
}

// 페이지 로드 시 영화 상세 정보 가져오기
document.addEventListener('DOMContentLoaded', function() {
    fetchMovieDetails(movieNum);
});

//줄거리 파트
document.addEventListener('DOMContentLoaded', function() {
	 const moreButton = document.querySelector('.more-button');
	    const summaryText = document.querySelector('.summary-test'); 
	
    console.log(moreButton);
    $('.more-button').on('click', function() {
    	console.log('버튼 클릭됨'); // 클릭 이벤트 발생 확인용
        if (summaryText.style.display === 'block') {
            summaryText.style.display = '-webkit-box';
            moreButton.textContent = '더보기';
        } else {
            summaryText.style.display = 'block';
            moreButton.textContent = '접기';
        }
    });
});

</script>
<!-- Google Charts 로드 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
// Google Charts 라이브러리의 Bar Chart와 Pie Chart 패키지 로드
google.charts.load('current', {'packages':['bar', 'corechart']});

// 페이지가 로드될 때 실행될 콜백 함수 설정
google.charts.setOnLoadCallback(loadChartData);

function loadChartData() {
	
    drawAgeGroupChart();
    drawGenderChart();
}

function drawAgeGroupChart() {
    var movieNum = new URLSearchParams(window.location.search).get('movie_num');
    
    $.ajax({
        url: '/movie/likesByAgeGroup',
        type: 'GET',
        data: { movie_num: movieNum },
        dataType: 'json',
        success: function(response) {
            if(response.status === "success") {
                drawAgeGroupChartWithData(response.data);
            } else {
                console.error("Failed to fetch likes by age group data:", response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("An error occurred:", error);
        }
    });
}

function drawAgeGroupChartWithData(data) {
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Age Group');
    dataTable.addColumn('number', 'Percentage');

    var totalLikes = Object.values(data).reduce((acc, cur) => acc + cur, 0); // 전체 '좋아요' 수 계산

    Object.keys(data).forEach(function(key) {
        var percentage = (data[key] / totalLikes) * 100; // 각 항목의 비율을 퍼센테이지로 계산
        dataTable.addRow([key, percentage]);
    });

    var options = {
        chart: {
            title: '연령대별 좋아요 분포',
        },
        bars: 'vertical',
        vAxis: {
            minValue: 0,
            maxValue: 100, // 세로축의 최대값을 100%로 설정
            format: '#\'%\'', // 세로축 레이블을 퍼센테이지 형식으로 표시
        },
    };

    var chart = new google.charts.Bar(document.getElementById('age_group_chart'));
    chart.draw(dataTable, google.charts.Bar.convertOptions(options));
}

function drawGenderChart() {
    var movieNum = new URLSearchParams(window.location.search).get('movie_num');
    
    $.ajax({
        url: '/movie/likesByGender',
        type: 'GET',
        data: { movie_num: movieNum },
        dataType: 'json',
        success: function(response) {
            if(response.status === "success") {
                drawGenderChartWithData(response.data);
            } else {
                console.error("Failed to fetch likes by gender data:", response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("An error occurred:", error);
        }
    });
}

function drawGenderChartWithData(data) {
	console.log(data);
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Gender');
    dataTable.addColumn('number', 'Likes');

    // 서버로부터 받은 데이터를 차트 데이터로 변환
  
    dataTable.addRow(['Male', data.MALE_COUNT]);
    dataTable.addRow(['Female', data.FEMALE_COUNT]);
	console.log('남자 좋아요 숫자 : ' + data.MALE_COUNT);
	console.log('여자 좋아요 숫자 : ' + data.FEMALE_COUNT);
    var options = {
        title: '성별 좋아요 분포',
        pieHole: 0.4, // 도넛 차트 형태로 표시하기 위한 옵션
    };

    var chart = new google.visualization.PieChart(document.getElementById('gender_chart'));
    chart.draw(dataTable, options);
}
</script>
    