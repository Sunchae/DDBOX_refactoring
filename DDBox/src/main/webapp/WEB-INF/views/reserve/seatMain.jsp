<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Movie Booking</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ticketingList.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@300&display=swap" rel="stylesheet">
<style type="text/css">
#container{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 800px;
}

.movieContainer{
    margin: 20px 0px;
}

.showcase{
    background-color: #777;
    background: rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    display: flex;
    justify-content: center;
    margin: 16px 0;
    padding: 5px 10px;
}

.movieContainer select{
    margin: 10px;
    padding: 5px 15px 5px 15px;
    border-radius: 7px;
    appearance: none;
    border: 0;
}

.movieContainer select option{

   text-align: left;
}

li{
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: 10px;
}

.small{
    color: #777;
    margin-left: 2px;
}

.showcase .seat:hover{
    cursor: default;
    scale: 1;
}

.showcase .selectedSeat:hover{
    cursor: default;
    scale: 1;
}

.screen{
   background-color: white;
   margin: 25px;
   padding: 5px;
   width: 200px;
   height: 80px;
   transform: rotateX(-45deg);
   box-shadow: 0 3px 10px rgb(255 255 255 / 70%);
}

.seat{
    background-color: #444451;
    width: 15px;
    height: 12px;
    margin: 3px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    cursor: pointer;
    font-size:7pt;
    color:white;
}

.availableSeat{
    background-color: #444451;
    width: 15px;
    height: 12px;
    margin: 3px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    cursor: default;
}

.selectedSeatIcon{
    background-color: #6feaf6;
    width: 15px;
    height: 12px;
    margin: 3px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    cursor: default;
}

.seat:hover{
    scale: 1.2;
}

.selectedSeat:hover{
    scale: 1.2;
}

.seat:nth-of-type(2){
    margin-right: 18px;
}

.seat:nth-of-type(7){
    margin-left: 18px;
}

.occupiedSeat:nth-of-type(2){
    margin-right: 18px;
}
.occupiedSeat:nth-of-type(7){
    margin-left: 18px;
}

.selectedSeat{
    background-color: #6feaf6;
    width: 15px;
    height: 12px;
    margin: 3px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    cursor: pointer;
    font-size:7pt;
    color:white;
}

.occupiedSeat{
    background-color: #fff;
    width: 15px;
    height: 12px;
    margin: 3px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    font-size:7pt;
    color:black;
}

.row{
    display: flex;
}

.text{
    margin-top: 30px;
    padding: 20px;
}

#count{
    color: #6feaf6;
}

#costs{
    color: #6feaf6;
}
ul {
    list-style:none;
    margin:0;
    padding:10;
}

li {
	padding: 20;
	mragin: 0;
    float: left;
}
</style>
</head>

<body>
	<h2 style="color:black;">빠른예매</h2>	
	<div style="display:flex;">	
	<div class="left-container" style="display:inline-block; align-items:center; width:100%; padding-top: 5%; background-color:lightgray;">
		<div class="align-center">
			<label for="movie"> 관람인원선택 : </label> 
			<select name="pickType" id="people">
				<option class="price" value="15000">일반</option>
				<option class="price" value="12000">청소년</option>
			</select>
		</div>	
		<!-- <div class="person_screen">
			<div class="section section-numberofpeople">
				<div class="check-people-box">
              <div class="check-people">
                    <p class="txt">성인</p>
                    <div class="count" style="display:inline-block; color:black; width: 100%; text-align: center;">
                        <button type="button" class="down" title="성인 좌석 선택 감소">-</button>
                        <div class="number" style="display:inline-block;">
                            <button type="button" class="now" title="성인 현재 좌석 선택 수">0</button>
                        </div>
                        <button type="button" class="up" title="성인 좌석 선택 증가">+</button>
                    </div>
                </div>
                <div class="check-people">
                    <p class="txt">청소년</p>
                    <div class="count">
                        <button type="button" class="down" title="청소년 좌석 선택 감소">-</button>
                        <div class="number">
                            <button type="button" class="now" title="청소년 현재 좌석 선택 수">0</button>
                        </div>
                        <button type="button" class="up" title="청소년 좌석 선택 증가">+</button>
                    </div>
                </div>
            </div>
			</div>
		</div> -->
		<ul class="showcase">
			<li>
				<div class="availableSeat"></div> <small class="small">선택가능</small>
			</li>
			<li>
				<div class="selectedSeatIcon"></div> <small class="small">선택한 좌석</small>
			</li>
			<li>
				<div class="occupiedSeat"></div> <small class="small">예매완료</small>
			</li>
		</ul>

		<div class="seatContainer" style="width:45%; margin:0 auto;">
			<div class="screen"></div>
			
			
			<div class="row">A
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span>
				<span class="seat">6</span> 
				<span class="seat">7</span> 
				<span class="seat">8</span>
			</div>
			
			<div class="row">B
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span>
				<span class="seat">6</span> 
				<span class="seat">7</span> 
				<span class="seat">8</span>
			</div>
			
			<div class="row">C
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span>
				<span class="seat">6</span> 
				<span class="seat">7</span> 
				<span class="seat">8</span>
			</div>

			<div class="row">D
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="occupiedSeat">5</span> 
				<span class="occupiedSeat">6</span> 
				<span class="seat">7</span> 
				<span class="seat">8</span>
			</div>

			<div class="row">E
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span>
				<span class="seat">6</span> 
				<span class="occupiedSeat">7</span> 
				<span class="seat">8</span>
			</div>

			<div class="row">F
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span>
				<span class="seat">6</span> 
				<span class="occupiedSeat">7</span> 
				<span class="occupiedSeat">8</span>
			</div>

			<div class="row">G
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span>
				<span class="seat">6</span> 
				<span class="seat">7</span> 
				<span class="seat">8</span>
			</div>
			
			<div class="row">H
				<span class="seat">1</span> 
				<span class="seat">2</span> 
				<span class="seat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span>
				<span class="seat">6</span> 
				<span class="seat">7</span> 
				<span class="seat">8</span>
			</div>
			
			<div class="row">I
				<span class="seat">1</span> 
				<span class="occupiedSeat">2</span> 
				<span class="occupiedSeat">3</span> 
				<span class="seat">4</span> 
				<span class="seat">5</span> 
				<span class="seat">6</span> 
				<span class="occupiedSeat">7</span> 
				<span class="seat">8</span>
			</div>

		</div>
	</div>	
		
	<div class="right-container" style=" width:40%; display:inline-block; ">
            <div class="movie-container" style="width:55%; height:600px;">
				<div class="title-area">
                    <p class="tit" style="font-size:18pt;">${movie.movie_title}</p>
                </div>
                  <br>
                <div class="movie-detail-area" style="height:220px;">
                    <p  style="width:150px;">상영관 이름 : ${screen.scr_name}</p>
                    <p style="width:150px;">
                    	<span>
                    		상영 날짜 : ${param.choice_date}
                    	</span>
                    </p>
                    <p>
                    	<span>
                    		상영 시간 : ${show.shw_time}
                    	</span>
                    </p>
                </div>
                <div>
                    <div class="kind-seat align-center" style="width:200px;">
                        <p class="tit-seat" style="font-size:15pt;">관람인원</p>
                         <span id="count" style="font-size:12pt;">0</span>명      
                    </div>
                </div>
                <div class="pay-area">
                    <p class="count">
                        
                    </p>
                    <div class="pay">
                        <p class="tit-pay" style="font-size:10pt;">최종결제금액 </p>
                    </div>   
                    <div class="money">
                        <span id="costs" style="font-size:10pt;">0</span>원
                    </div>
                </div>
                <hr size="1" style="color:white;">
                <div class="btn-group">
	                    	<form action="payMain" style="border:none;" id="pay_form" style="width: 50px;">
	           					<input type="hidden" name="choice_num" value="${movie.movie_num}" id="choice_num">
	           					<input type="hidden" name="choice_screen" value="${screen.scr_num}" id="choice_screen">
	            				<input type="hidden" name="choice_date" value="${param.choice_date}" id="choice_date">
	            				<input type="hidden" name="choice_time" value="${show.shw_num}" id="choice_time">
	            				<input type="hidden" name="choice_people" id="choice_people">
	            				<input type="hidden" name="choice_price" id="choice_price">
	            				<input type="submit" value="결제선택" id="pagePrevious" style="float:right;width:60px;">
	      					</form>
                </div>
            </div>
        </div>	
      </div>  

	<script type="text/javascript">
			let choice_people;
			let choice_price;
			
		document.addEventListener('DOMContentLoaded', () =>{
		
		let seatContainer = document.querySelector('.seatContainer');
		
		let moviePrice = 15000; // 영화가격 
		let count = document.querySelector('#count'); // 인원수
		let costs = document.querySelector('#costs'); // 가격
		
		
		// 선택한 좌석수 텍스트 변경해주기
		function countSeatPrice(){
		    let selectedSeatCount = document.querySelectorAll('.selectedSeat').length;
		    choice_people = selectedSeatCount;
		    choice_price = selectedSeatCount * moviePrice;
		    
		   	count.textContent = choice_people;
		    costs.textContent = choice_price;
		    
		    document.getElementById('choice_people').value = choice_people;
		    document.getElementById('choice_price').value = choice_price;
		}
		
		
		//좌석 클릭했을때
		seatContainer.addEventListener('click', (e) => {
		    if(e.target.className === 'seat'){
		        e.target.className = 'selectedSeat';
		    } else if(e.target.className === 'selectedSeat'){
		        e.target.className = 'seat';
		    }
		    countSeatPrice();
		});
		
		/* const payForm = document.getElementById('pay_form');
        payForm.addEventListener('submit', (e) => {
            e.preventDefault(); // 기존의 폼 전송 동작을 막음

            // hidden input 요소를 생성하여 값을 설정
            const hiddenCount = document.createElement('input');
            hiddenCount.type = 'hidden';
            hiddenCount.name = 'choice_people';
            hiddenCount.value = ${reserve.res_mem_total};

            const hiddenPrice = document.createElement('input');
            hiddenPrice.type = 'hidden';
            hiddenPrice.name = 'choice_price';
            hiddenPrice.value = ${reserve.res_pay};

            // 생성한 hidden input을 폼에 추가
            payForm.appendChild(hiddenCount);
            payForm.appendChild(hiddenPrice);

            // 이미 존재하는 hidden input에도 값을 설정
            document.getElementById('choice_people').value = choice_people;
            document.getElementById('choice_price').value = choice_price;

            // 폼을 서버로 제출
            payForm.submit();
        }); */
		
		
		});
   </script>
</body>

</html>