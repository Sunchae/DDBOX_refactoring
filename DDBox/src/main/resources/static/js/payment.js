	// 카카오결제
	$(function(){
		$("#btn-kakao-pay").click(function(){
			
			// 필수입력값을 확인.
			var name = $("#form-payment input[name='pay-name']").val();
			var tel = $("#form-payment input[name='pay-tel']").val();
			var email = $("#form-payment input[name='pay-email']").val();
			
			if(name == ""){
				$("#form-payment input[name='pay-name']").focus()
			}
			if(tel == ""){
				$("#form-payment input[name='pay-tel']").focus()
			}
			if(email == ""){
				$("#form-payment input[name='pay-email']").focus()
			}
			
			// 결제 정보를 form에 저장한다.
			let totalPayPrice = parseInt($("#total-pay-price").text().replace(/,/g,''))
			let totalPrice = parseInt($("#total-price").text().replace(/,/g,''))
			let discountPrice = totalPrice - totalPayPrice 
			let usePoint = $("#point-use").val()
			let useUserCouponNo = $(":radio[name='userCoupon']:checked").val()
			
			// 카카오페이 결제전송
			$.ajax({
				type:'get'
				,url:'/order/pay'
				,data:{
					total_amount: totalPayPrice
					,payUserName: name
					,sumPrice:totalPrice
					,discountPrice:discountPrice
					,totalPrice:totalPayPrice
					,tel:tel
					,email:email
					,usePoint:usePoint
					,useCouponNo:useUserCouponNo	
					
				},
				success:function(response){
					location.href = response.next_redirect_pc_url			
				}
			})
		})
	})

























/*
아임포트 카카오페이 결제
$('#paymentBtn').click(function () {
      var IMP = window.IMP;
      IMP.init('아임포트 본인 가맹점식별코드');
      
      //DOM객체들에서 사용할 데이터 뽑기
      var paymentGoods = $('input[name="paymentOrderName"]').val();
      var money = $('.totalprice').text();
      var memberName = $('input[name="mem_name"]').val();
      var memberEmail = $('input[name="mem_email"]').val();
      var memberPhone = $('input[name="mem_phone"]').val();
      
      var len = memberEmail.indexOf("@");
      var memberId = memberEmail.substr(0, len);
	  
 
      IMP.request_pay({
      	  //카카오페이 결제시 사용할 정보 입력
          pg: 'card',
          paymentCode: 'p' + new Date().getTime()+'_'+memberId,
          name: paymentGoods,
          amount: money,
          buyer_email: memberEmail,
          buyer_name: memberName,
          buyer_tel: memberPhone,
      }, function (rsp) {
      	  //결제 완료시
          if (rsp.success) {
              var msg = '결제가 완료되었습니다.';
              msg += '카드 승인번호 : ' + rsp.apply_num;
              
              // 
              만약 데이터들을 ajax로 보낼 시 사용할 코드
              $.ajax({
                  type: "GET", 
                  url: "/mypage/mypaymentList/paymentDetail", 
                  data: {
                      "amount" : money
                  },
              });
              //
              
              $('#paymentForm').submit();
              
          } else {
          	  //결제 실패시
              var msg = '결제에 실패하였습니다.';
              msg += '에러내용 : ' + rsp.error_msg;
            
              if($('input[name="eClassApprovedSetDate"]').length){
            document.location.href="/mypage/mySignUpForClassList"; //alert창 확인 후 이동할 url 설정
              }else {
            document.location.href="/challenge/challengeGather/challengeGatherList"; //alert창 확인 후 이동할 url 설정
              }
          }
          alert(msg);
      });
  });
*/