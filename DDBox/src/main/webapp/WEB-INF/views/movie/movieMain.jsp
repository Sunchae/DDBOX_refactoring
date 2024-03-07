<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!-- 내용 시작 -->
<h1>전체 영화</h1>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movieMain.css">


<div class="container">
    <div class="row">
        <c:forEach var="movie" items="${list}">
            <div class="col-md-4">
                <div class="movie-lists">
                    <!-- 링크를 감싸는 레이어 -->
                    <a href="/movie/movieDetail?movie_num=${movie.movie_num}"
                        class="poster-link">
                        <!-- 이벤트를 적용한 레이어 -->
                        <div class="event-layer"></div>
                        <img src="https://image.tmdb.org/t/p/w500/${movie.movie_poster}"
                            class="img-fluid movie-poster" alt="${movie.movie_title} Poster">
                        <div class="movie-summary">
                            <h5>${movie.movie_title}</h5>
                            <p>${movie.movie_overview}</p>
                        </div>
                    </a>

                    
                </div>
                <div class="movie-details">
                        <div>
                            <p>
                             <c:choose>
                                <c:when test="${movie.movie_gradeNm == 1}">
                                    <img src="${pageContext.request.contextPath}/images/movie/12.png" alt="12세 이용가" />
                                </c:when>
                                <c:when test="${movie.movie_gradeNm == 2}">
                                    <img src="${pageContext.request.contextPath}/images/movie/15.png" alt="15세 이용가" />
                                </c:when>
                                <c:when test="${movie.movie_gradeNm == 0}">
                                    <img src="${pageContext.request.contextPath}/images/movie/all.png" alt="전체 이용가" />
                                </c:when>
                            </c:choose>
                            
                            <span>${movie.movie_title}</span>
                            </p>
                            
                            
                            <p>개봉일: ${movie.movie_opendate}</p>
                        </div>
                        <div>
                            <!-- 좋아요 기능 추가 필요 -->
                            <button class="btn  btn-sm"><img src="${pageContext.request.contextPath}/images/movie/빈하트.png" class="heart-icon" alt="좋아요"> ${movie.likesCount}</button>
                            <!-- 예매페이지로 링크 필요 -->
                            <a href="/reserve/reserveMain" class="btn btn-dark rounded-pill btn-sm" style="color: white;">예매하기</a>
                        </div>
                    </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 내용 끝 -->
