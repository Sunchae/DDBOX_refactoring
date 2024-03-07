$(function(){
	let message_socket; //웹소켓 식별자
	
	if($('#chatDetail').length>0){ //채팅 페이지
		//웹소켓 연결 후 코드 입력 (웹소켓 인식 후 데이터 넣어주는 과정 추가)
		connectWebSocket(); //아래 function 호출 (웹소켓 생성)
	}
	
	/*--------------------------
	*	웹소켓 연결
	* --------------------------*/
	function connectWebSocket(){
		message_socket = new WebSocket("ws://localhost:8000/message-ws");
		message_socket.onopen=function(evt){
			console.log("채팅페이지 접속 : " + $('#chatDetail').length);
			if($('#chatDetail').length == 1){
				message_socket.send("msg:");
			}
		};
		
		//서버로부터 메시지를 받으면 호출되는 함수 지정 (초기 데이터 읽어오기)
		message_socket.onmessage=function(evt){
			let data = evt.data;
			if($('#chatDetail').length == 1 && data.substring(0,4) == 'msg:'){
				selectMsg();
			}
		};
		//웹소켓 종료
		message_socket.onclose=function(evt){
			//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
			console.log('chat close');
		}
	}
	
	
	/*--------------------------
	*	채팅하기
	* --------------------------*/
	//채팅 데이터 읽기
	function selectMsg(){
		//서버와 통신
		$.ajax({
			url:'chatReadAjax',
			type:'post',
			data:{chatroom_num:$('#chatroom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
					message_socket.close();
				}else if(param.result == 'success'){
					/*----- UI 넣기 시작------*/
					$('#chatting_message').empty();
					
					let chat_date = '';
					$(param.list).each(function(index,item){
						let output = '';
						//날짜 추출
						if(chat_date != item.reg_date.split(' ')[0]){
							chat_date = item.reg_date.split(' ')[0];
							output += '<div class="date-position"><span>'+chat_date+'</span></div>';
						}
						
						//메시지 포지션
						if(item.mem_num == param.user_num){
							output += '<div class="from-position">';
							output += '<div>';
						}else{
							output += '<div class="to-position">';
							output += '<div class="space-photo">';
							output += '</div><div class="space-message">';
						}
						if(item.read_check==1){
							output += '<div class="read"><span>1</span></div>';
						}
						
						output += '<div class="item">';
						output += '<span>' + item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>') + '</span>';
						output += '<div class="align-right">' + item.reg_date.split(' ')[1] + '</div>';
						output += '</div>';
						output += '</div><div class="space-clear"></div>';
						output += '</div>';
						
						//문서 객체에 추가
					    $('#chatting_message').append(output);
					    //스크롤 하단
					    $('#chatting_message').scrollTop($('#chatting_message')[0].scrollHeight);
					});
					/*----- UI 넣기 끝------*/
					
				}else{
					alert('채팅 메시지 읽기 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
	}
	
		
	
	//메시지 입력 후 enter 이벤트 처리
	$('#message').keydown(function(event){
		if(event.keyCode == 13 && !event.shiftKey){
		$('#detail_form').trigger('submit'); //trigger:이벤트 강제 발생
		}
	});
	
	//채팅 메시지 등록
	$('#detail_form').submit(function(event){
		if($('#message').val().trim()==''){
			alert('메시지를 입력하세요');
			$('#message').val('').focus();
			return false;
		}
		//2000자 제한
		if($('#message').val().length>2000){
			alert('메시지를 2000자까지만 입력 가능합니다.');
			return false;
		}
		
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'writeChat',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
					message_socket.close();
				}else if(param.result == 'success'){
					$('#message').val('').focus();
					message_socket.send('msg:');
				}else{
					alert('채팅 메시지 등록 오류');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류');
				message_socket.close();
			}
		});
		event.preventDefault();
	});
	
	
	
});