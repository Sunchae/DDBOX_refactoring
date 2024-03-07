<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
        <a href="${pageContext.request.contextPath}/faq/main" class="nav-link " aria-current="page">
          고객센터 메인
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/faq/question" class="nav-link link-dark">
          자주찾는 질문
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/faq/news" class="nav-link link-dark">
          공지/뉴스
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/faq/email" class="nav-link link-dark">
          이메일 문의
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/faq/rental" class="nav-link link-dark">
          단체/대관 문의
        </a>
      </li>
    </ul>
    
  </div>
