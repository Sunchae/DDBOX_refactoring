<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>HTA CINEMA</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ticketingPay.css">
  	<link rel="icon" href="/resources/images/favicon.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <div class="container" style="width:1250px;">
        <div class="head">
            <h2>빠른예매</h2>
        </div>
        <div class="left-container">
            <h5>관람권 및 할인적용</h5>
            <div class="sale-ticket">
                 <span>메가박스 포인트/쿠폰</span>
                     <button type="button" id="point-modal-show" class="btn-modal-show">DD박스 멤버십 포인트</button>
                     <button type="button" id="coupon-modal-show" class="btn-modal-show">DD박스 할인 쿠폰</button>
                     <button type="button" id="vipcoupon-modal-show" class="btn-modal-show">DD박스 VIP영화쿠폰</button>
            </div>
            <div class="pay-kakao" >
                <h5>결제수단 선택</h5>
                <div class="text-wrap">
                    <div class="" id="pay-kakao-id"></div>
                    <div class="text-event align-center"><p>1만원 이상 결제시 영화관람권 추첨 이벤트 자동응모!</p></div>
                </div>
                <div class="pay-wrap">
                    <input type="radio" class="active" name="radio-kakao-pay" id="kakao-pay-radiobox" checked>
                    <label for="kakao-pay-radiobox">카카오페이 결제</label>
                </div>
                <div class="pay-story">
                    <ul>
                        <li>내통장결제는 본인명의의 계좌를 최초 1회등록 후 비밀번호 입력만으로 간편하게 이용할 수 있는 현금결제 서비스 입니다.</li>
                        <li>은행 점검시간의 경우 내통장결제서비스 이용이 불가합니다.</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="right-container">
            <div class="title-name">
                <p class="title-text">영화 제목 : ${movie.movie_title}</p>
s               <p class="screen-location">상영관 이름 : ${screen.scr_name}</p>
                <p class="screen-day">상영 날짜 : ${param.choice_date}</p>
            </div>
            
            <div class="pay-container" style="margin:0;">
                <div class="total">
                    <p class="total-title">금액</p>
                    <p class="total-pay"><span>${param.choice_price}</span>원</p>
                </div>
                <i class="fas fa-minus-circle"></i>
                <div class="discount-total">
                    <p class="discount-title">
                        할인적용
                    </p>
                    <p class="discount-pay">
                        <span>0</span>원
                    </p>
                </div>
                <div class="discount-content">
                    <div class="point">
                    <br>
                        <p class="use-point">포인트 적립</p>
                        <p class="point-discount"><span>${(param.choice_price * 0.01)}</span>원</p>
                    </div>
                </div>
                <br>
                <div class="final-pay">
                    <p class="final-title">최종결제금액</p>
                    <p class="final-total"><span>${param.choice_price}</span>원</p>
                </div>
                <br>
                <div class="way-pay">
                    <p class="way-pay-title">결제수단</p>
                    <p class="way-pay-content">카카오페이결제</p>
                </div>
                <div class="btn-final">
                    <a class="btn-pre" href="javascript:history.back();" style="color:white;">이전</a>
                    <c:choose>
                    <c:when test="${user.mem_auth == 1}">
                    	 <button id="check_module" class="btn-pay" type="button">구매</button>
                    	 
                    	<%--  <form action="payConfirm" style="border:none;" class="align-center" id="ticket_confirm">
							<input type="hidden" name="choice_num" value="${movie.movie_num}" id="choice_num">
							<input type="hidden" name="choice_screen" value="${screen.scr_num}" id="choice_screen">
							<input type="hidden" name="choice_date" value="${param.choice_date}" id="choice_date">
							<input type="hidden" name="choice_time" value="${show.shw_num}" id="choice_time">
							<input type="hidden" name="choice_people" value="${param.choice_people}" id="choice_people">
            				<input type="hidden" name="choice_price" value="${param.choice_price}" id="choice_price">	
						</form> --%>
						
						<form action="insertPay" method="post" style="border:none;" class="align-center" id="ticket_info">
							<input type="hidden" name="movie_num" value="${movie.movie_num}" id="choice_num">
							<input type="hidden" name="scr_num" value="${screen.scr_num}" id="choice_screen">
							<input type="hidden" name="shw_num" value="${show.shw_num}" id="choice_time">
							<input type="hidden" name="choice_date" value="${param.choice_date}" id="choice_date">
							<input type="hidden" name="res_mem_total" value="${param.choice_people}" id="choice_people">
            				<input type="hidden" name="res_pay" value="${param.choice_price}" id="choice_price">
						</form> 
						
							<script>
								$("#check_module").click(function() {
									var IMP = window.IMP; // 생략가능
									IMP.init('imp66004703');
									// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
									// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
									IMP.request_pay({
										pg : 'kakaopay',
										pay_method : 'card',
										merchant_uid : 'merchant_' + new Date().getTime(),
										/* 
										 *  merchant_uid에 경우 
										 *  https://docs.iamport.kr/implementation/payment
										 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
										 */
										name : '영화 제목 : ${movie.movie_title}',
										// 결제창에서 보여질 이름
										// name: '주문명 : ${auction.a_title}',
										// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
										amount : ${param.choice_price},
										// amount: ${bid.b_bid},
										// 가격 
										buyer_name : '${member.mem_id}',
										// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
										// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
										buyer_postcode : '123-456',
									}, function(rsp) {
										console.log(rsp);
										if (rsp.success) {
											var msg = '결제가 완료되었습니다.';
											msg += ' 결제 금액 : ' + rsp.paid_amount + '원';
											
											
											//success.submit();
											
											$('#ticket_info').submit();
											// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
											// 자세한 설명은 구글링으로 보시는게 좋습니다.
										} else {
											var msg = '결제에 실패하였습니다.';
											msg += '에러내용 : ' + rsp.error_msg;
										}
										alert(msg);
									});
								});
							</script>
                    </c:when>
                    <c:otherwise>
                     	<button class="btn-pay" type="button" onclick="location.href='payConfirm'">확인</button>
                    </c:otherwise>
                    </c:choose>
                </div>
                
            </div>
        </div>
    </div>
    <div>
    	<%-- <form action="payConfirm" style="border:none;" class="align-center" id="pay_confirm">
            <input type="hidden" name="choice_num" value="${movie.movie_num}" id="choice_num">
            <input type="hidden" name="choice_screen" value="${screen.scr_num}" id="choice_screen">
            <input type="hidden" name="choice_date" value="${param.choice_date}" id="choice_date">
            <input type="hidden" name="choice_time" value="${show.shw_num}" id="choice_time">
            <input type="hidden" name="choice_people" id="choice_people">
            <input type="hidden" name="choice_price" id="choice_price">
            <input type="submit" value="결제확인">
      </form> --%>
      
    </div>
    
    <div id="point-modal">
        <div class="point-modal">
            <div class="point-modal-header">
                <!--안보이게는   display:flex; 을 추가한다.-->
                <h5 class="tit">메가박스 멤버십 포인트</h5>
            </div>
            <div class="point-modal-body">
                <ul class="dot-list">
                    <li>회원님께서 보유하고 있는 포인트 중 사용가능한 포인트 입니다.</li>
                    <li>포인트 적립 및 사용내역은 나의 메가박스 멤버십 포인트에서 확인하세요</li>
                </ul>
                <div class="usable-point">
                    <i class="fas fa-parking"></i>
                    사용가능한 멤버십 포인트
                    <span><em>${LOGIN_USER.currentPoint}</em>P</span>
                </div>
                <div class="total-point">
	                    <c:choose>
		                     <c:when test="${not empty LOGIN_USER.currentPoint}">
		                     <div class="point-wrap">
		                    	 <div class="block" data-point="${LOGIN_USER.currentPoint }"><button class="btn-block">${LOGIN_USER.currentPoint }</button></div>
		                     	 <div class="block" data-point="" ></div>
			                     <div class="block" data-point=""></div>
			                     <div class="block" data-point=""></div>
		                     </div>
		                    </c:when>
		                     <c:otherwise>
		                     <div class="point-wrap">
		                     	<div class="block" data-point="" ></div>
				                <div class="block" data-point=""></div>
				                <div class="block" data-point=""></div>
				                <div class="block" data-point=""></div>
			                </div>
	                     </c:otherwise>
	                    </c:choose>
	                    <!-- 값이 존재하면 생성되도록 -->
	                    
                    <div class="point-wrap">
                        <div class="block" data-point="" ></div>
                        <div class="block" data-point=""></div>
                        <div class="block" data-point=""></div>
                        <div class="block" data-point=""></div>
                    </div>
                    <div class="text-right">
                    <c:choose>
                    	<c:when test="${not empty LOGIN_USER.currentPoint}">
                    		 <p>총 <em>${LOGIN_USER.currentPoint }</em>P/ <em>1</em>매</p>
                    	</c:when>
                    	<c:otherwise>
                    		 <p>총 <em>${LOGIN_USER.currentPoint }</em>P/ <em>0</em>매</p>
                    	</c:otherwise>
                    </c:choose>
                    </div>
                </div>
                <div class="button-list align-center">
                    <!--적용시 금액 할인되도록-->
                    <button type="button" class="btn-discount-pay" id="btn-point-close">닫기</button>
                    <!--취소시 style의 display값을 none으로 -->
                    <button type="button" class="btn-discount-pay" id="btn-point-submit">적용</button>
                </div>
            </div>
        </div>
    </div>
    <div id="coupon-modal">
        <div class="coupon-modal">
            <div class="coupon-modal-header">
                <!--보이게는 id값에  display:flex; 을 추가한다.-->
                <h5 class="tit">메가박스 할인 쿠폰</h5>
            </div>
            <div class="coupon-modal-body">
                <ul class="dot-list">
                    <li>사용할 쿠폰을 선택해주세요</li>
                </ul>
                <div class="usable-coupon">
                   <p>쿠폰번호</p>
                   <form action="/cupon" method="post" id="form-coupon">
                   <input type="text" title="메가박스 영화 할인쿠폰 16자리 입력" 
                  class="input-text" id="couponNo" style="width: 200px;" maxlength="16">
                  <button type="button" class="btn-submit">쿠폰등록</button>
                  </form>
                </div>
                <div class="total-point">
                    <div class="coupon-title">
                        <div class="coupon-name">
                            <p>쿠폰명</p>
                        </div>
                        <div class="coupon-date">
                            <p>유효기간</p>
                        </div>
                        <div class="coupon-use">
                            <p>사용</p>
                        </div>
                    </div>
                  
                </div>
                <div class="text-center">
                   <ul class="dot-list">
                       <li>사용가능한 쿠폰만 노출됩니다.</li>
                       <li>전체 쿠폰 목록은 나의 메가박스 할인쿠폰에서 확인 가능합니다.</li>
                       <li>보유하신 쿠폰은 등록 후 이용하실 수 있습니다.</li>
                   </ul>
                </div>
                <div class="button-list align-center">
                    <!--적용시 금액 할인되도록-->
                    <button type="button" class="btn-discount-pay" id="btn-coupon-close">닫기</button>
                    <!--취소시 style의 display값을 none으로 -->
                    <button type="button" class="btn-discount-pay" id="btn-coupon-submit">적용</button>
                </div>
            </div>
        </div>
    </div>
    <div id="vipcoupon-modal">
        <div class="vipcoupon-modal">
            <div class="vipcoupon-modal-header">
                <!--보이게는 id값에  display:flex; 을 추가한다.-->
                <h5 class="tit">메가박스 VIP 영화 쿠폰</h5>
            </div>
            <div class="vipcoupon-modal-body">
                <ul class="dot-list">
                    <li>사용할 쿠폰을 선택해주세요</li>
                </ul>
                <div class="usable-coupon">
                   <p>쿠폰번호</p>
                   <form action="/vipcoupon" method="post" id="form-vipcoupon">
                   <input type="text" title="메가박스 영화 할인쿠폰 16자리 입력" 
                  class="input-text" id="vipcouponNo" style="width: 200px;" maxlength="16">
                  <button type="button" class="btn-vipcoupon-submit">쿠폰등록</button>
                  </form>
                </div>
                <div class="total-point">
                    <div class="coupon-title">
                        <div class="coupon-name">
                            <p>쿠폰명</p>
                        </div>
                        <div class="coupon-date">
                            <p>유효기간</p>
                        </div>
                        <div class="coupon-use">
                            <p>사용</p>
                        </div>
                    </div>
                    <div class="vipcoupon-content">
                        <div class="coupon-content">  
                           <!--  
                           <div id="coupon-list">왈왈이 영화 무료 이용권</div>
                             <div id="coupon-date">2022년12월01일</div>
                           <div id="coupon-use-btn">
                              <button type="button" id="button-use" data-use="">사용</button>
                           </div>
                           -->
                    </div>
                </div>
                <div class="button-list align-center">
                    <!--적용시 금액 할인되도록-->
                    <button type="button" class="btn-discount-pay" id="btn-vipcoupon-close">닫기</button>
                    <!--취소시 style의 display값을 none으로 -->
                    <button type="button" class="btn-discount-pay" id="btn-vipcoupon-submit">적용</button>
                </div>
            </div>
        </div>
    </div>
    </div>
</body>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	/* $(function(){
		   $(".btn-pay").click(function(){
				if(!$('#userPhone')==null) {
					if(!$('#userBirth')==null){
						$('button.button-request').attr('disabled','false');
					}
				}
				 
		        let IMP = window.IMP; // 생략가능
				IMP.init('imp28206043'); 
				IMP.request_pay({ //param
					pg: 'kakao',//PG사
					pay_method: 'card',//지불수단
					merchant_uid: 'merchant_' + new Date().getTime(),//가맹점에서 구별하는 고유한 id
					name:$('p.title-text').text(),//상품명
					amount: $('p.final-total>em').text(),//총가격
					point:$('p.total-pay>em').text(),//포인트 금액
					total_amount:$('p.discount-pay>em').text(), //할인된 금액
					buyer_name: '${LOGIN_USER.name}',//Username
					buyer_email: '${LOGIN_USER.email}', //User이메일
					buyer_tel:'${LOGIN_USER.phoneNumber}'//User전화번호
					
					}, 
					function (rsp){//콜백함수
					if(rsp.success){ //결제 성공시: 결제 승인시 
						$.ajax({
							url:"/rest/ticketing/complete", //가맹점 서버
							method:"GET",
							headers:{"Content-Type":"application/json"},
							data:{
								movie:$("input[name=movie]").val(),
								ticketingToTalPay:$('p.final-total>em').text(),	//최종금액
								userDiscountPoint:$('p.point-discount>em').text(), //포인트적립
								userPoint:$("p.discount-pay>em").text(),//할인적용금액(할인사용)
								seatList:$("input[name=seatList]").val(),
								ticketingPay:$("input[name=ticketingPay]").val(),//총금액
								adult:$("input[name=adult]").val(),
								baby:$("input[name=baby]").val(),
								old:$("input[name=old]").val(),
								startTime:$("input[name=startTime]").val(),
								showScheduleNo:$("input[name=showScheduleNo]").val()
							}
						}).done(function(data){
							alert("결제완료");
							location.href="/";
						 })
					} else {
				alert("결제에 실패하였습니다. 에러내용 :" +rsp.error_msg);   
		   		}
		  		})
		   });  */
		   
		   $('#point-modal-show').click(function(){
			   $('#point-modal').css("display","flex");
		   });
		   $('#btn-point-close').click(function(){
			   $('#point-modal').css("display","none");
		   });
		   $('div.block>button').click(function(){
			    var a = $(this).closest('.block').attr('data-point');  
			    $('#btn-point-submit').click(function(){
			    if(a == null) {
			    	alert('포인트가 존재하지 않습니다.');
			    	return;
			    } else {
			    	 $('p.discount-pay>em').text(a);
			    	 let total = $('p.final-total>em').text();
			    	 let minus = parseInt($('p.discount-pay>em').text());
			    	 let numberTotal = total*1;
			    	 let currentTotal = numberTotal-minus
			    	 if(currentTotal >= 0){
			    		 $('p.final-total>em').text(currentTotal);
			    	 } else {
			    		 $('p.final-total>em').text(0);
			    	 }
			    	 let point = parseInt(currentTotal*0.05);
			    	 if(point >= 0){
			    		 $('p.point-discount>em').text(point);
			    	 } else {
			    		 $('p.point-discount>em').text(0);
			    	 }
					 $('#point-modal').css('display','none');
			    }
			});
		 });
		   $('#coupon-modal-show').click(function(){
			   $('#coupon-modal').css("display","flex");
		   });
		   $('#btn-coupon-close').click(function(){
			   $('#coupon-modal').css("display","none");
		   });
		   $('.btn-submit').click(function(){
			  let data = $('#couponNo').text();
			  //현재는 필요치 않아 block으로 설정함
			  if(data == null){
				  alert("쿠폰번호를 입력하세요");
				  return;
			  } else {
				  alert("현재 지원하지 않는 기능입니다.");
				  return;
			  }
			  //$('#form-coupon').submit();
		   });
		   
		   $('#button-use').click(function(){
			    let attr = $(this).attr('data-use');  
			   $('#btn-point-submit').click(function(){
			    if(a == null) {
			     	alert('쿠폰번호를 입력하세요.');
			    	return;
			    } else {
			    	alert("현재 지원하지 않는 기능입니다.");
					 return;
			    //	 $('p.discount-pay>em').text(a);
			  	// $('#coupon-modal').css('display','none');
			   }
			});
		 }); 
		   $('#vipcoupon-modal-show').click(function(){
			   $('#vipcoupon-modal').css("display","flex");
		   });
		   $('#btn-vipcoupon-close').click(function(){
			   $('#vipcoupon-modal').css("display","none");
		   });
		   $('.btn-vipcoupon-submit').click(function(){
				  let data = $('#vipcouponNo').text();
				  //현재는 필요치 않아 block으로 설정함
				  if(data == null){
					  alert("쿠폰번호를 입력하세요");
					  return;
				  } else {
					  alert("현재 지원하지 않는 기능입니다.");
					  return;
				  }
				  $('#form-vipcoupon').submit();
			   });
		   $('#btn-vipcoupon-submit').click(function(){
			    var a = $(this).attr('data-use');  
			    $('#btn-point-submit').click(function(){
			    if(a == null) {
			    	alert('포인트가 존재하지 않습니다.');
			    	return;
			    } else {
			    	alert('현재 지원하지 않는 기능입니다.');
			    	 //$('p.discount-pay>em').text(a);
					// $('#coupon-modal').css('display','none');
					//존재할 경우 입력
			    }
			});
		 });
		   
	})
</script>
</html>