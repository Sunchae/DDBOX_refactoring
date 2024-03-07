$(function(){
	// 수량변경
	$('#order_quantity').on('keyup mouseup',function(){
		if($('#order_quantity').val()==''){
			$('#item_total_txt').text('총 주문 금액 : 0원');
			return;
		}
		if($('#order_quantity').val()<=0){
			$('#order_quantity').val('');
			return;
		}
		if(Number($('#quantity').val()) < $('#order_quantity').val()){
			alert('수량이 부족합니다.');
			$('#order_quantity').val('');
			$('#item_total_txt').text('총 주문 금액 : 0원');
			return;
		}
		let total = $('#store_price').val() * $('#order_quantity').val();
		$('#item_total_txt').text(total.toLocaleString());
		$('#total_price').val(total);
	}); //end of on
	
	// total price
	$(function(){
		let total = $('#store_price').val() * $('#order_quantity').val();
		$('#total_price').val(total);
		$('#item_total_txt').text(total.toLocaleString());
	});


/*	//장바구니 담기 이벤트 연결
	$('#store_cart').submit(function(event){
		if($('#order_quantity').val() == ''){
			alert('수량을 입력하세요');
			$('#order_quantity').focus();
			return false;
		}
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			
			url:'../pay/payInsert',
			type:'post',
			data:form_data,
			dataType:'json',

			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'success'){
					alert('장바구니에 담았습니다.');
					location.href='${pageContext.request.contextPath}/pay/payDetail';
				}else if(param.result == 'overquantity'){
					alert('기존의 주문한 상품입니다. 개수를 추가하면 재고가 부족합니다.');
				}else{
					alert('장바구니 담기 오류')
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
		
	});*/
	
});
	/*	===========================================
	*	장바구니 상품 주문 수량 변경
	*	=========================================== */
$(function(){
	
	$('.cart-modify').on('click',function(){
		let input_quantity = $(this).parent().find('input[name="order_quantity"]');
		if(input_quantity.val()==''){
			alert('수량을 입력하세요');
			input_quantity.focus();
			return;
		}
		if(input_quantity.val() < 1 ){
			alert('상품의 최소 수량은 1입니다.');
								//태그에 명시한 value 값을 읽어옴
			input_quantity.val(input_quantity.attr('value'));
			return;
		}
		//서버와 통신
		$.ajax({
			url:'modifyCart.do',
			type:'post',
			data:{cart_num:$(this).attr('data-cartnum'),item_num:$(this).attr('data-itemnum'),order_quantity:input_quantity.val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'noSale'){
					alert('판매가 중지되었습니다.');
					location.href='list.do';
				}else if(param.result == 'noQuantity'){
					alert('상품의 수량이 부족합니다.');
					location.href='list.do';
				}else if(param.result == 'success'){
					alert('상품의 개수가 수정되었습니다.');
					location.href='list.do';
				}else{
					alert('장바구니 상품 개수 수정 오류!!');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
   /*	===========================================
	*	장바구니 상품 삭제
	*	=========================================== */
	$('.cart-del').on('click',function(){
		//서버와 통신
		$.ajax({
			url:'deleteCart.do',
			type:'post',
			data:{cart_num:$(this).attr('data-cartnum')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요.');
				}else if(param.result == 'success'){
					alert('선택하신 상품을 삭제했습니다.');
					location.href='list.do';
				}else{
					alert('장바구니 상품 삭제 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
});
	
//수량 -+설정
/*$(function(){
	let quantity = $(".quantity_input").val();
	$(".btn_plus").on("click",function(){
		$(".quantity_input").val(++quantity);
	});
	$(".btn_minus").on("click",function(){
		if(quantity >1){
			$(".quantity_input").val(--quantity);
		}
	});
	//전송할 데이터
	const form = {
			memberId : '${mem.mem_num}',
			store_num : '${store.store_num}',
			sub_total : ''
	}
	
	//장바구니 추가 버튼
	$(".btn_cart").on("click", function(e){
		form.sub_total= $("quantity_input").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/cart/cartList",
			type : "post",
			data : form,
			dataType : 'json',
			success : function(result){
					cartAlert(result);	
			}
		});
	});
	
	function cartAlert(result){
		if(result == '0'){
			alert("장바구니에 추가 하지 못하였습니다.");
		}else if(result == '1'){
			alert("장바구니에 추가되었습니다.");
		}else if(result == '2'){
			alert("장바구니에 이미 추가되었습니다.");
		}else if(result == '5'){
			alert("로그인이 필요합니다.");
		}
	}
	
});*/