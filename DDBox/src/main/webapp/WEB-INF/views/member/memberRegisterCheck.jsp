<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->

<style>
    .mem-birth-select {
        width: 85px; 
    }
</style>
		


<div class="page-main">
	<h2>회원가입여부 확인</h2>
	<form:form action="registerUserCheck" id="member_registerCheck" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="mem_name">이름</form:label>
				<form:input path="mem_name"  placeholder="이름을 입력해주세요" autocomplete="off"/>
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
						
			<li>
                <form:label path="mem_birth">생년월일</form:label>
                <!-- Select2 사용 -->
                <select class="mem-birth-select" name="mem_birth_year" id="birthYear">
                    <option value="">년</option>
                </select>
                <select class="mem-birth-select" name="mem_birth_month" id="birthMonth">
                    <option value="">월</option>
                </select>
                <select class="mem-birth-select" name="mem_birth_day" id="birthDay">
                    <option value="">일</option>
                </select>
                <form:errors path="mem_birth" cssClass="error-color" />
            </li>
            
			<li>
				<form:label path="mem_phone">휴대폰 번호</form:label> 
				<form:input	path="mem_phone" placeholder="휴대폰 번호를 입력해주세요 ex)010-0000-0000" autocomplete="off"/> 
				<form:errors path="mem_phone" cssClass="error-color" />
			</li>
            
			
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">가입여부 확인</form:button>
			<input type="button" value="홈으로" class="default-btn"
			    onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>                                  
	</form:form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css">


<script type="text/javascript">
    $(document).ready(function() {
        // Select2 초기화
        $(".mem-birth-select").select2();
    });
    
    $(document).ready(function() {
    	let tyear = '${memberVO.mem_birth_year}';
    	if(tyear){
    		 $("#birthYear").prepend("<option value='"+tyear+"' selected>" + tyear + "년</option>");
    	}
    	let tmonth = '${memberVO.mem_birth_month}';
    	if(tmonth){
    		 $("#birthMonth").prepend("<option value='"+tmonth+"' selected>" + tmonth + "월</option>");
    	}
    	let tday = '${memberVO.mem_birth_day}';
    	if(tday){
    		 $("#birthDay").prepend("<option value='"+tday+"' selected>" + tday + "일</option>");
    	}
    	
    	
    	var currentYear = new Date().getFullYear();
        var endYear = currentYear - 100; // 100년 전까지의 연도

        for (var year = currentYear; year >= endYear; year--) {
            $("#birthYear").append("<option value='" + year + "'>" + year + "년</option>");
        }
     // 월의 일수를 계산하는 함수
        function getDaysInMonth(month, year) {
            return new Date(year, month, 0).getDate();
        }

        // 월 옵션 동적 생성
        for (var month = 1; month <= 12; month++) {
            $("#birthMonth").append("<option value='" + month + "'>" + month + "월</option>");
        }

        // 월이 변경될 때 일 옵션 업데이트
        $("#birthMonth").change(function() {
            var selectedMonth = $(this).val();
            var selectedYear = $("#birthYear").val(); // 연도 선택 필요

            if (selectedMonth !== "" && selectedYear !== "") {
                $("#birthDay").empty();
                var daysInMonth = getDaysInMonth(selectedMonth, selectedYear);

                for (var day = 1; day <= daysInMonth; day++) {
                    $("#birthDay").append("<option value='" + day + "'>" + day + "일</option>");
                }
            }
        });

        $(".mem-birth-select").select2();
    });
    
   
    
    
</script>


