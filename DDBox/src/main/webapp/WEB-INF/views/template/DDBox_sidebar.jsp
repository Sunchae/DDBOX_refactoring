<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.1/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

 
    
 <div class="b-example-divider"></div>

  <div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px;">
    <a href="/member/myPage" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
      <span class="fs-4">My-DDBox</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="/member/myPageTicket" class="nav-link " aria-current="page">
          나의 예매내역
        </a>
      </li>
      <li>
        <a href="/member/myPageCoupon" class="nav-link link-dark">
          관람권/할인쿠폰 관리
        </a>
      </li>
      <li>
        <a href="/member/myPagePoint" class="nav-link link-dark">
          DD포인트
        </a>
      </li>
      <li>
        <a href="/member/myPageEvent" class="nav-link link-dark">
          이벤트 참여내역
        </a>
      </li>
      <li>
        <a href="/member/myPageGiftshop" class="nav-link link-dark">
          스토어 구매 내역
        </a>
      </li>
      <li>
        <a href="/faq/email" class="nav-link link-dark">
          나의 문의내역
        </a>
      </li>
    </ul>
    <hr>
    <div class="dropdown">
      <a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
        
        <c:if test="${!empty user}">
			<img id="myPage-profile" src="${pageContext.request.contextPath}/member/photoView" 
	                              width="80" height="80" class="rounded-circle me-2 my-photo">
		</c:if>
        <c:if test="${!empty user && !empty user.mem_nickname}">
			[<span class="user_name">${user.mem_nickname}</span>]
		</c:if>
		<c:if test="${!empty user && empty user.mem_nickname}">
			<strong>${sessionScope.user.mem_id}</strong>
		</c:if>
        
     
        
        
        
      </a>
      <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
        <li><a class="dropdown-item" href="/member/updateUser">회원정보 수정</a></li>
        <li><a class="dropdown-item" href="/member/myPageProfile">프로필 관리</a></li>
        <li><a class="dropdown-item" href="/member/withdraw">회원탈퇴</a></li>
        
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
      </ul>
    </div>
  </div>
