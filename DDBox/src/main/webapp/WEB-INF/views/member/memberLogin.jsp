<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!-- 내용 시작 -->
<div class="page-main">
    <h2 class="login-title">회원로그인</h2>
    <form:form id="member_login" action="login" modelAttribute="memberVO" class="login-form">
		<form:errors element="div" cssClass="error-messages" />
		<div class="input-container">
			<input type="text" id="mem_id" name="mem_id" placeholder="아이디"
				class="form-input" autocomplete="off" /> <label for="mem_id"
				class="form-label">아이디</label>
		</div>
		<div class="input-container">
			<input type="password" id="mem_pw" name="mem_pw" placeholder="비밀번호"
				class="form-input" /> <label for="mem_pw" class="form-label">비밀번호</label>
		</div>
		<div class="stay-logged-in">
			<input type="checkbox" id="auto" name="auto"> <label
				for="auto">로그인상태유지</label>
		</div>
		<div class="form-actions">
            <form:button class="login-btn">로그인</form:button>
        </div>
    </form:form>
    <div class="align-center">
        <button class="home-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">홈으로</button>
    </div>
    
    <!-- 네이버 로그인 버튼 추가 -->
    <%
        String clientId = "f9uX41apZyfYkXFsl7yt"; // 애플리케이션 클라이언트 아이디값
        String redirectURI = URLEncoder.encode("http://localhost:8000/member/login", "UTF-8");
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString(32); // 상태 토큰으로 사용할 랜덤 문자열
        String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
        apiURL += "&client_id=" + clientId;
        apiURL += "&redirect_uri=" + redirectURI;
        apiURL += "&state=" + state;
        session.setAttribute("state", state);
    %>
    <div class="align-center" style="margin-top: 20px;">
        <a href="<%=apiURL%>"><img src="http://static.nid.naver.com/oauth/small_g_in.PNG" height="50" /></a>
    </div>
    
</div>

<!-- 내용 끝 -->
<style>


body, html {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5; /* 배경색 변경 */
}

.page-main {
    max-width: 400px;
    margin: 40px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px; /* 모서리 둥글게 */
    box-shadow: 0 4px 6px rgba(0,0,0,0.1); /* 그림자 효과 */
}

.login-title {
    text-align: center;
    color: #333;
}

.login-form {
    margin-top: 20px;
}

.input-container {
    position: relative;
    margin-bottom: 20px;
}


.form-input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    outline: none;
    transition: border-color .3s;
}

.form-input:focus {
    border-color: #007bff; /* 포커스 시 테두리 색상 변경 */
}
.form-input:not(:placeholder-shown) + .form-label,
.form-input:focus + .form-label {
    transform: translateY(-20px) scale(0.75);
    color: #007bff;
}


.form-label {
    position: absolute;
    top: 0;
    left: 0;
    padding: 10px;
    transition: all 0.3s ease;
    pointer-events: none;
    color: #6c757d;
}

.error-color {
    color: #d9534f; /* 오류 메시지 색상 */
}

.error-messages {
    display: block; /* 에러 메시지를 블록 요소로 만들어 줄 바꿈 효과를 줍니다. */
    color: #d9534f; /* 에러 메시지의 색상을 지정합니다. */
    font-size: 0.8em; /* 에러 메시지의 글꼴 크기를 조정합니다. */
    margin-top: 5px; /* 에러 메시지와 입력 필드 사이의 간격을 조정합니다. */
}

.stay-logged-in {
    margin: 10px 0;
}

.form-actions {
    text-align: center;
}

.login-btn, .home-btn {
    background-color: #4B3891;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color .3s;
}

.login-btn:hover, .home-btn:hover {
    background-color: #0056b3;
}

.align-center {
    text-align: center;
    margin-top: 20px;
}

.home-btn {
    background-color: #6c757d; /* 홈 버튼 색상 */
}

.home-btn:hover {
    background-color: #565e64;
}

</style>









