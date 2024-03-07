<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        padding: 20px;
        margin: 0;
    }

    #withdrawForm {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        margin: auto;
    }

    #withdrawForm div {
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 5px;
    }

    input[type="password"],
    input[type="text"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #dddddd;
        border-radius: 4px;
        box-sizing: border-box; /* 입력 필드의 패딩을 너비에 포함 */
    }

    #captchaImage {
        display: block;
        margin: 10px 0;
        width: 100%;
        height: auto;
        border-radius: 4px;
    }

    #refreshCaptcha {
        background-color: #007bff;
        color: #ffffff;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    button[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #4B3891;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    button[type="submit"]:hover,
    #refreshCaptcha:hover {
        opacity: 0.9;
    }
</style>
<h2>회원 탈퇴</h2>
<form id="withdrawForm" action="/member/withdraw" method="post">
    <div>
        <label for="mem_pw">비밀번호:</label>
        <input type="password" id="mem_pw" name="mem_pw" required>
    </div>
    <div>
        <label>캡차:</label>
        <img src="" id="captchaImage" alt="캡차 이미지" />
        <input type="text" id="captchaInput" name="captcha" required>
        <button type="button" id="refreshCaptcha">캡차 새로고침</button>
    </div>
    <button type="submit">탈퇴하기</button>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script>
var captchaKey = ""; // 캡차 키를 저장할 변수

//캡차 이미지와 키를 불러오는 함수
function loadCaptcha() {
 $.ajax({
     url: '/captcha/generate',
     type: 'get',
     dataType: 'json',
     success: function(data) {
         captchaKey = data.key; // 캡차 키를 변수에 저장
         $('#captchaImage').attr('src', '/captcha/image?key=' + captchaKey);
     },
     error: function() {
         alert('캡차 이미지를 불러오는 데 실패했습니다.');
     }
 });
}

$('#refreshCaptcha').click(function(){
    loadCaptcha(); // 캡차 새로고침 함수 호출
});

function loadCaptcha() {
    $.ajax({
        url: '/captcha/generate', // 캡차 키 발급 요청
        type: 'get',
        dataType: 'json',
        success: function(data) {
            captchaKey = data.key; // 새로 발급받은 캡차 키 저장
            // 이미지 URL에 타임스탬프 추가하여 캐시 문제 해결
            var timestamp = new Date().getTime();
            $('#captchaImage').attr('src', '/captcha/image?key=' + captchaKey + "&_ts=" + timestamp);
        },
        error: function() {
            alert('캡차 이미지를 불러오는 데 실패했습니다.');
        }
    });
}

//폼 제출 로직
$('#withdrawForm').submit(function(e){
 e.preventDefault(); // 기본 제출 동작 방지
 var memPw = $('#mem_pw').val();
 var captchaValue = $('#captchaInput').val();

 // 캡차 검증 요청
 $.ajax({
     url: '/captcha/validate',
     type: 'post',
     data: {key: captchaKey, value: $('#captchaInput').val()}, // 동적으로 저장된 캡차 키 사용
     success: function(data) {
         if(data.success) {
             // 캡차 검증 성공, 실제 탈퇴 로직 수행
        	 // 회원 탈퇴 요청을 AJAX로 전송
             $.ajax({
                 url: '/member/withdraw',
                 type: 'post',
                 data: {
                     mem_pw: $('#mem_pw').val(), // 비밀번호
                     // 필요한 경우 추가 데이터 포함
                 },
                 success: function(response) {
                     // 탈퇴 처리 성공 시 로직
                     alert('회원 탈퇴 처리가 완료되었습니다.');
                     window.location.href = "/main/main"; // 홈페이지나 로그인 페이지로 리디렉션
                 },
                 error: function() {
                     // 탈퇴 처리 실패 시 로직
                     alert('회원 탈퇴 처리 중 문제가 발생했습니다.');
                 }
             });
         } else {
             alert('캡차 입력이 잘못되었습니다.');
         }
     },
     error: function() {
         alert('캡차 검증 실패');
     }
 });
});

loadCaptcha(); // 페이지 로드 시 캡차 이미지 로드
</script>
