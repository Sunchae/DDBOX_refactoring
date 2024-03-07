--TICKET
create table ticket(
	res_num number not null,						--예매번호
	res_status number not null,						--예매상태
	res_mem_total number not null,					--예약 총 인원수
	res_mem_type number not null,					--예약자 타입(0:성인, 1:청소년)
	res_regdate date default sysdate not null,		--예매일(연/월/일/시/분/초)
	res_ticket number not null,						--티켓 가격(0:성인-15000원/1:청소년-12000원)
	res_pay number not null,						--예매 최종 결제금액(티켓 가격-사용한 포인트)
	res_payType number not null,					--결제 수단(0:카드, 1:무통장)
	res_userPoint number,							--결제시 사용한 포인트
	shw_num number default 0 not null,				--상영 번호
	scr_num number not null,						--상영관 번호
	mem_num number not null,						--회원 번호
	constraint ticket_pk primary key (res_num),
	constraint ticket_fk1 foreign key (shw_num) references show (shw_num),
	constraint ticket_fk2 foreign key (scr_num) references screen (scr_num),
	constraint ticket_fk3 foreign key (mem_num) references member (mem_num)
);

create sequence ticket_seq;

--SHOW
create table show(
	shw_num number not null,					--상영 번호
	shw_sdate varchar2(50) not null,			--상영 날짜
	shw_edate varchar2(50) not null,			--상영 날짜
	shw_time varchar2(50) not null,				--상영 시간
	shw_seatCnt varchar2(50) not null,			--남은 좌석수
	scr_num number not null,					--상영관 번호
	movie_num number not null,					--영화 코드
	constraint show_pk primary key (shw_num),
	constraint show_fk1 foreign key (scr_num) references screen (scr_num),
	constraint show_fk2 foreign key (movie_num) references movie (movie_num)
);
create sequence show_seq;

--SCREEN
create table screen(
	scr_num number not null,					--상영관 번호
	scr_name varchar2(100) not null,			--상영관 이름
	scr_do varchar2(50) not null,				--상영관 시
	scr_si varchar2(50) not null,				--상영관 구
	scr_type number not null,					--상영관 타입(0:2D/1:3D/2:4D)
	scr_seatTotal number not null,				--상영관 총 좌석수
	scr_seatLine number not null,				--상영관 좌석 행
	scr_seatRow number not null,				--상영관 좌석 열
	constraint screen_pk primary key (scr_num)
);
create sequence screen_seq;






