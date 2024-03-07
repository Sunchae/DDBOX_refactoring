<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<style>
#nickname-input {
	width: 60%; /* 입력 필드의 너비 조정 */
	margin-right: 10px; /* 오른쪽 여백 추가 */
}

#edit-div button {
	padding: 5px 10px; /* 버튼의 내부 여백 */
}

#cancel-edit, #edit-nickname {
	margin-left: 10px; /* 버튼 간격 조정 */
}

#nickname-display {
	font-size: 24px;
	font-weight: bold;
	text-shadow: 2px 2px 4px #aaa;
	color: #333;
}
#edit-nickname, #cancel-edit, #save-nickname{
    background-color: #4B3891; /* 버튼 배경색 */
    border: none; /* 테두리 없음 */
    color: white; /* 글씨 색상 */
    padding: 10px 20px; /* 안쪽 여백 */
    text-align: center; /* 텍스트 가운데 정렬 */
    text-decoration: none; /* 텍스트 밑줄 없음 */
    display: inline-block; /* 인라인 블록 요소로 표시 */
    font-size: 16px; /* 글씨 크기 */
    margin: 4px 2px; /* 바깥 여백 */
    cursor: pointer; /* 마우스 오버 시 커서 변경 */
    border-radius: 25px; /* 모서리 둥글게 */
    transition-duration: 0.4s; /* 호버 효과 시간 */
}

#edit-nickname:hover, #cancel-edit:hover {
    background-color: #45a049; /* 호버 시 배경색 변경 */
}
</style>
<!-- Summary 시작 -->
<div style="background-color: lightgray; padding: 20px; width: 45%;">
    <div style="display: flex; align-items: center;">
		<img src="${pageContext.request.contextPath}/member/photoView"
			alt="프로필 사진"
			style="width: 80px; height: 80px; border-radius: 50%; margin-right: 10px;">
		<div id="nickname-area">
			<span id="nickname-display">${member.mem_nickname}</span>
			<!-- 닉네임 변경 버튼 추가 -->
			<button id="edit-nickname">닉네임 변경</button>
			<!-- 취소 버튼 추가, 처음에는 숨김 처리 -->
			<button id="cancel-edit" style="display: none;">취소</button>
		</div>
	</div>
    <hr>
    <div>
		<h4>
			회원 등급 :
			<c:choose>
				<c:when test="${member.mem_grade == 1}">
       			 일반 회원
    			</c:when>
				<c:when test="${member.mem_grade == 2}">
     			   VIP
  				  </c:when>
				<c:when test="${member.mem_grade == 3}">
      			  VVIP
   				 </c:when>
				<c:otherwise>
       			 알 수 없는 등급
  			  </c:otherwise>
			</c:choose>
		</h4>
	</div>
    <div style="display: flex; justify-content: space-between; margin-top: 20px;">
        <div>
            <h4>보유 쿠폰 정보</h4>
            
        </div>
      <!--   <div>
            <h4>포인트 정보</h4>
            <p> 포인트</p>
        </div> -->
    </div>
</div>

<script>
//JavaScript
document.addEventListener('DOMContentLoaded', function() {
    var editButton = document.getElementById('edit-nickname');
    var nicknameDisplay = document.getElementById('nickname-display');
    var nicknameArea = document.getElementById('nickname-area');

    editButton.addEventListener('click', function() {
        var currentNickname = nicknameDisplay.innerText;
        nicknameDisplay.style.display = 'none'; // 닉네임 표시 숨김
        editButton.style.display = 'none'; // '닉네임 변경' 버튼 숨김

        // 입력 필드와 변경하기 버튼을 포함하는 div 생성
        var editDiv = document.createElement('div');
        editDiv.id = 'edit-div';

        var inputElement = document.createElement('input');
        inputElement.type = 'text';
        inputElement.id = 'nickname-input';
        inputElement.value = currentNickname;
        inputElement.style.width = '70%'; // 입력 필드 크기 조정

        var saveButton = document.createElement('button');
        saveButton.innerText = '변경하기';
        saveButton.id = 'save-nickname';

        var cancelButton = document.createElement('button');
        cancelButton.innerText = '취소';
        cancelButton.id = 'cancel-edit';

        // div에 입력 필드와 버튼 추가
        editDiv.appendChild(inputElement);
        editDiv.appendChild(saveButton);
        editDiv.appendChild(cancelButton);

        // 닉네임 표시 영역을 새로운 div로 교체
        nicknameArea.appendChild(editDiv);
        inputElement.focus();

        // 변경하기 버튼 클릭 이벤트
        saveButton.addEventListener('click', function() {
            saveNickname(inputElement.value);
        });

        // 취소 버튼 클릭 이벤트
        cancelButton.addEventListener('click', function() {
            nicknameArea.removeChild(editDiv);
            nicknameDisplay.style.display = 'inline';
            editButton.style.display = 'inline';
        });

        // 엔터키 이벤트
        inputElement.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                saveNickname(inputElement.value);
            }
        });
    });

    function saveNickname(newNickname) {
        // AJAX 요청으로 서버에 닉네임 변경 요청
        $.ajax({
            url: '/member/changeNickname',
            type: 'POST',
            data: { nickname: newNickname },
            success: function(response) {
                if(response.success) {
                    alert('닉네임이 성공적으로 변경되었습니다.');
                    nicknameDisplay.innerText = newNickname;
                    nicknameDisplay.style.display = 'inline';
                    editButton.style.display = 'inline';
                    document.getElementById('edit-div').remove();
                } else {
                    alert('닉네임 변경에 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('닉네임 변경 중 오류가 발생했습니다.');
            }
        });
    }
});

</script>

<!-- Summary 끝 -->