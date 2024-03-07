let choice_num;
let choice_screen;
let choice_date;
let choice_time;
        
         //날짜 클릭
         $(document).on('click','.mon',function(){
            choice_date = $(this).attr('data-day');
        	 //선택한 날짜에 해당하는 상영 정보 가져오는 함수 호출
        	 getMoviesByDate(choice_date);
         });
		
		function getMoviesByDate() {
               $.ajax({
                   url: 'getMoviesByDate', // 서버에서 해당 날짜에 상영하는 영화 목록을 가져오는 엔드포인트
                   type: 'get',
                   data: { date : choice_date },
                   dataType: 'json',
                   success: function (param) {
                       console.log(param.movielist);
                      // 성공적으로 받은 영화 목록을 화면에 표시하는 함수 호출
                       displayMovies(param.movielist);
                       
                   },
                   error: function () {
                       alert('네트워크 오류 발생(날짜선택)');
                   }
               });
           }
		
		function displayMovies(movies){
            //영화 목록을 표시할 부분의 선택자를 지정
            let movieListContainer = $('.col-body');
            
            //이전에 표시된 영화목록 삭제
            movieListContainer.empty();
            
            //받아온 영화 목록을 반복하여 화면에 추가
            $.each(movies, function(index,movie){
              //각 영화에 대한 화면 출력 처리
              displayMovieItem(movie);
               
            });
         }
		
		
		//반복 돌려서 영화 리스트 출력하는 function 
         function displayMovieItem(movie) {
               let movieListContainer = $('.col-body');
           
               let output = '<li class="movie-choice" data-num="' + movie.movie_num + '">';
               output += movie.movie_title;
               //output += '<h3>' + movie.title + '</h3>';
               // 추가적인 영화 정보 표시 로직 작성
               output += '</li>';
               
               // movieListContainer에 영화 정보 추가
               movieListContainer.append(output);
           }

		
         //영화 클릭
          $(document).on('click','.movie-choice',function(){
             let movie_num = $(this).attr('data-num');
             choice_num = movie_num;
             selectMovie(movie_num);
         });

		
		function selectMovie(movie_num){
         $.ajax({
             url: 'getMovie',
             type: 'get',
             data: {movie_num: movie_num},
             dataType: 'json',
             success: function(param){
                displaySelectedMovie(param);
                displayScreen(param.list);
             },
             error: function(){
                 alert('네트워크 오류 발생(영화선택)');
             }
         });
        }


		//영화 클릭시 아래에 선택 영화 보여주는 function
         function displaySelectedMovie(param){
             let output;
             if(param.status == 'yesMovie'){
                 output = 'https://image.tmdb.org/t/p/w500/' + param.movieVO.movie_poster; 
             } else if(param.status == 'noMovie'){
                 output = '../resources/images/noimage.png';
             } else {
                 alert('영화 표시 오류 발생');
             }
             $('#picture').attr('src', output); 
             $('#picture-name').text(param.movieVO.movie_title); 
             console.log(param);
             
         }


		function displayScreen(list) {
               let screenList = $('.screen-list');
               screenList.empty(); // 기존 목록 제거
            
               //$(movie_num.list).each(function(index,item) {
               $.each(list, function(index, item) {   
                   let output = '<li class="each-screen" data-num="'+item.scr_num+'">';
                   output += item.scr_name;
                   output += '</li>';
                   screenList.append(output);
                   
                   console.log(item);
               });
               
           }
		
		
         //극장 클릭
         $(document).on('click','.each-screen',function(){
            let scr_num = $(this).attr('data-num');
            choice_screen = scr_num;
            selectScreen(scr_num);
            getMovieSchedule(choice_num,choice_screen,choice_date);
         });


		//영화 스케줄 가져오기위한 ajax통신
       function getMovieSchedule(choice_num,choice_screen,choice_date) {
           $.ajax({
               url: 'getMovieSchedule',  // 해당 URL은 실제로 서버에서 처리하는 URL로 변경해야 합니다.
               type: 'get',
               data: {
                   choice_num: choice_num,
                   choice_screen: choice_screen,
                   choice_date: choice_date
               },
               dataType: 'json',
               success: function (param) {
                   // 성공적으로 데이터를 받아왔을 때의 처리
                   displayMovieSchedule(param.scheduleList);
                   alert('scheduleList.shw_num : '+ param.scheduleList[0].shw_num);
               },
               error: function () {
                   // 오류 발생 시 처리
                   alert('네트워크 오류 발생(상영 시간표 조회)');
               }
           });
       }	


		 // 상영 시간표를 화면에 표시하는 함수
       function displayMovieSchedule(scheduleList) {
           let timeListContainer = $('.time-list');
           	   timeListContainer.empty();
            
           $.each(scheduleList, function(index, item) {
                  let output = '<li class="each-time" data-num="'+item.shw_num+'">';
                   output += item.shw_time;
                   output += '</li>';
                   timeListContainer.append(output);
                   
                   console.log(item);
            });           
           console.log(scheduleList);
        } 
		
		
		 //영화관 선택 시 선택한 영화관 정보 출력
       function selectScreen(scr_num){
          $.ajax({
             url: 'getScreen',
             type: 'get',
             data: {scr_num:scr_num},
             dataType: 'json',
             success: function(param){
                displaySelectedScreen(param);
             },
             error: function(){
                alert('네트워크 오류 발생(극장선택)');
             }
          });
       }


		function displaySelectedScreen(param){
           //param.screen에 데이터 담겨 있음  아래에 마련된 공간에 데이터 비우고 영화관 이름 집어넣으면 됨
         let screenPick = $('.screen-name');
          screenPick.empty();
          
          let output = '<li class="selected-screen" data-num="'+param.screen.scr_num+'">';
                output += param.screen.scr_name;
             output += '</li>';
          screenPick.append(output);
       }        
		
         //시간 클릭
         $(document).on('click','.each-time',function(){
        	 let shw_num = $(this).attr('data-num');
        	 choice_time = shw_num;
        	 selectTime(shw_num);
         });
         
         function selectTime(shw_num){
        	 $.ajax({
        		 url : 'getTime',
        		 type: 'get',
        		 data: {shw_num:shw_num},
        		 dataType:'json',
        		 success: function(param){
        			 displaySelectedTime(param);
        		 },
        		 error:function(){
        			 alert('네트워크 오류 발생(시간선택)');
        		 }
        	 });
         }
         
         function displaySelectedTime(param){
        	 let timePick = $('.timePick');
        	 	 timePick.empty();
        	 	 
        	 let output = '<li class="selected-time" data-num="'+param.selectedTime.shw_num+'">';
                 output += param.selectedTime.shw_time;
                 output += '</li>';
                 timePick.append(output);
         }
         
         
         
         

         
           //동적 생성된 영화관 클릭 했을 시 클릭한 영화관 이름 받아오고 싶음    
           $(document).on('click','.each-screen',function(){
              choice_screen = $(this).attr('data-num');
              console.log('choice_num : ' + choice_num);
              console.log('choice_screen : ' + choice_screen);
              console.log('choice_date : ' + choice_date);
            });       
           
           $(document).on('click','.screen-choice',function(){
                alert('영화를 먼저 선택하세요');
                
            });


const dataDate = new Date();
   let year = dataDate.getFullYear();
   let month = dataDate.getMonth();
   let dataDay = dataDate.getDate();
   let dayLabel = dataDate.getDay();
   let dayNumber = Number(dataDay);
   $('div.month').text((Number(month) + 1) + "월");

   const reserveDate = $('div.now-day');

   const weekOfDay = [ "일", "월", "화", "수", "목", "금", "토" ];
   let thisWeek = [];
   let button = "";
   let spanWeekOfDay = "";
   let spanDay = "";
   let div = "";
   for (let i = dayNumber; i <= dayNumber + 11; i++) {

      div = document.createElement("div");
      button = document.createElement("button");
      spanWeekOfMonth = document.createElement("span");
      spanWeekOfDay = document.createElement("span");
      spanDay = document.createElement("strong");
      spanWeekOfMonth.classList = "movie-week-of-month";
      spanWeekOfDay.classList = 'movie-week-of-day';
      spanDay.classList = 'movie-day';
      let resultDay = new Date(year, month, i);
      let yyyy = resultDay.getFullYear();
      let mm = Number(resultDay.getMonth()) + 1;
      let dd = resultDay.getDate();
      let d = resultDay.getDay();

      mm = String(mm).length === 1 ? '0' + mm : mm;
      dd = String(dd).length === 1 ? '0' + dd : dd;
      d = String(d).length === 1 ? '0' + d : d;
      spanWeekOfMonth.innerHTML = mm;
      spanWeekOfDay.innerHTML = dd;

      button.append(spanWeekOfDay);
      if (d == '01') {
         d = weekOfDay[1];
         button.classList = "mon";
         button.setAttribute('data-day', yyyy +'-'+ mm +'-'+ dd);
      } else if (d == '02') {
         d = weekOfDay[2];
         button.classList = "mon";
         button.setAttribute('data-day', yyyy +'-'+ mm +'-'+ dd);
      } else if (d == '03') {
         d = weekOfDay[3];
         button.classList = "mon";
         button.setAttribute('data-day', yyyy +'-'+ mm +'-'+ dd);
      } else if (d == '04') {
         d = weekOfDay[4];
         button.classList = "mon";
         button.setAttribute('data-day', yyyy +'-'+ mm +'-'+ dd);
      } else if (d == '05') {
         d = weekOfDay[5];
         button.classList = "mon";
         button.setAttribute('data-day', yyyy +'-'+ mm +'-'+ dd);
      } else if (d == '06') {
         d = weekOfDay[6];
         button.classList = "mon sat";
         button.setAttribute('data-day', yyyy +'-'+ mm +'-'+ dd);
      } else if (d == '00') {
         d = weekOfDay[0];
         button.classList = "mon sun";
         button.setAttribute('data-day', yyyy +'-'+ mm +'-'+ dd);
      }
      if (i === dayNumber) {
         button.classList = "mon active";
         //해당날짜는 버튼이 눌려있게 설정함
      }
      spanDay.innerHTML = d;
      button.append(spanDay);
      reserveDate.append(button);

      thisWeek[i] = yyyy + "-" + mm + '-' + dd + '-' + d;
   }

   //날짜 클릭시 활성화 버튼과 hidden으로 data값 전송
   $('div.now-day').on('click', 'button.mon', function() {
      let $btnActive = $(this);
      let dataAttr = $btnActive.attr('data-day');
      if ($btnActive.hasClass('active')) {
         $('button.mon').removeClass('active');
      } else {
         $('button.mon').removeClass('active');
         $btnActive.addClass('active');
         
         
      }
   });
      