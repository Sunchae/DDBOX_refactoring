$(function () {
	/*----------------------------
	 *          회원가입
	 *----------------------------*/
	//아이디 중복 여부 저장 변수 : 0은 아이지 중복 또는 중복 체크 미실행, 1은 아이디 미중복
	let checkId = 0;
	// 비밀번호 일치 여부 저장 변수 : 0은 비밀번호 불일치 또는 검증 미실행, 1은 비밀번호 일치
    let checkPasswordMatch = 0;

	//아이디 중복 체크
	$('#confirmId').click(function(){
		if($('#mem_id').val().trim()==''){
			$('#message_id').css('color','red').text('아이디를 입력하세요');
			$('#mem_id').val('').focus();
			return;
		}
		
		//서버와 통신
		$.ajax({
			url:'confirmId',
			type:'post',
			data:{mem_id:$('#mem_id').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'idNotFound'){
					$('#message_id').css('color','#000').text('등록 가능 ID');
					checkId = 1;
				}else if(param.result == 'idDuplicated'){
					$('#message_id').css('color','red').text('중복된 ID');
					$('#mem_id').val('').focus();
					checkId = 0;
				}else if(param.result == 'notMatchPattern'){
					$('#message_id').css('color','red').text('영문,숫자만 4~12자 입력');
					$('#mem_id').val('').focus();
					checkId = 0;
				}else{
					checkId = 0;
					alert('ID 중복 체크 오류');
				}
			},
			error:function(){
				checkId=0;
				alert('네트워크 오류 발생1111111')
			}
		});//end of ajax
	});//end of click
	
	// 비밀번호 일치 여부 검증
    function validatePassword() {
        var password = $('#mem_pw').val();
        var confirmPassword = $('#confirm_password').val();

        if(password !== confirmPassword) {
            $('#password_error_message').css('color', 'red').text('비밀번호가 일치하지 않습니다.');
            checkPasswordMatch = 0;
        } else {
            $('#password_error_message').css('color', 'green').text('비밀번호가 일치합니다.');
            checkPasswordMatch = 1;
        }
    }

    // 비밀번호 입력 및 비밀번호 확인 입력란의 변경 감지
    $('#mem_pw, #confirm_password').keyup(validatePassword);
	
	//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
	$('#member_register #mem_id').keydown(function(){
		checkId=0;
		$('#message_id').text('');
	});//end of keydown
	
	//submit 이벤트 발생시 아이디 중복 체크 여부 확인
	$('#member_register').submit(function(){
		if(checkId==0){
			$('#message_id').css('color','red').text('아이디 중복 체크 필수');
			if($('#mem_id').val().trim()==''){
				$('#mem_id').val('').focus();
			}
			return false;
		}
		 // 비밀번호 일치 여부 검증
        if(checkPasswordMatch == 0) {
            $('#password_error_message').css('color', 'red').text('비밀번호 확인이 필요합니다.');
            $('#confirm_password').focus();
            return false; // 폼 제출 중단
        }
        // 모든 검증을 통과한 경우 폼 제출 계속
    });
		
});//end of submit
	
	
