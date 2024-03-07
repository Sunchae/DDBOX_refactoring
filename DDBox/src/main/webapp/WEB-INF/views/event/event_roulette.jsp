<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Roulette</title>
<title>룰렛이벤트</title>
</head>
<body>
<div id="app">
	<h2>룰렛이벤트</h2>
	<div class="roullette-outer">
	  	<!-- Canvas 엘리먼트 추가 -->
	  	<div class="roullette">
	  		<canvas id="rouletteCanvas" width="400" height="400"></canvas>
	  	</div>
	  	<div class="roullette-pin"></div>
	  	<button id="start-btn" class="start-btn">start</button>
	  	<!-- 버튼 클릭시 event_type = 0으로 설정 하기.. -->
	</div>
</div>

<!-- <div id="app">
	<h2>룰렛이벤트</h2>
	<div class="roullette-outer">
		<div class="roullette-pin"></div>
		<div class="roullette">
		값 영역
		<div class="item-wrapper">
			<div class="item">0point</div>
			<div class="item">100point</div>
			<div class="item">200point</div>
			<div class="item">300point</div>
			<div class="item">400point</div>
			<div class="item">500point</div>
		</div>
		선 영역
		<div class="line-wrapper">
			<div class="line"></div>
			<div class="line"></div>
			<div class="line"></div>
			<div class="line"></div>
			<div class="line"></div>
			<div class="line"></div>
		</div>
		</div>
	</div>
	<button class="start-btn">start</button>
</div> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/event_roullette.js"></script>
</body>
</html>