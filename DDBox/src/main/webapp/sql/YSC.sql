--MEMBER 
create table member(
	mem_num number not null,
	mem_id varchar2(30) unique not null,
	mem_auth number default 1 not null, --1:활동회원,2:정지회원,3:탈퇴회원,9:관리자
	constraint member_pk primary key (mem_num)
);

--MEMBER_DETAIL
create table member_detail(
	mem_num number not null,
	mem_name varchar2(30) not null,
	mem_nickname varchar2(30),
	mem_autoid varchar2(50) unique,
	mem_pw varchar2(12) not null,
	mem_birth varchar2(10) not null,
	mem_phone varchar2(15) not null,
	mem_email varchar2(50) not null,
	mem_zipcode varchar2(5) not null,
	mem_address1 varchar2(100) not null,
	mem_address2 varchar2(100) not null,
	mem_regdate date default sysdate not null,
	mem_modifydate date,
	mem_gender number(1) not null,-- 1:남자,2:여자
	mem_age number not null,--1:10대,2:20대,3:30대,4:40대,5:50대이상
	mem_photo blob,
	mem_photoname varchar2(100),
	mem_grade number default 1 not null,--1:일반회원,2:VIP,3:VVIP /회원등급에 따라 포인트 적립 퍼센티지 차별
	constraint member_detail_pk primary key (mem_num),
	constraint member_detail_fk foreign key (mem_num) references member (mem_num)
);
create sequence member_seq;
--POINT
create table point(
	point_num number not null,
	point_balance number default 0 not null,
	point_detail varchar2(20) not null,
	point_date date default sysdate not null,
	mem_num number not null,
	porder_id number,  -- 추후 스토어 쪽 컬럼명과 맞춰야함
	event_num number, --추후 이벤트 쪽 컬럼명과 맞춰야함
	constraint point_pk primary key (point_num),
	constraint point_fk1 foreign key (mem_num) references member (mem_num),
	constraint point_fk2 foreign key (porder_id) references porder (porder_id),
	constraint point_fk3 foreign key (event_num) references event_list (event_num)
);
create sequence point_seq;
--MOVIE
create table movie(
	movie_num number not null,
	movie_title varchar2(200),
	movie_original_title varchar2(200),
	movie_tagline varchar2(200),
	movie_popularity number,
	
	movie_director varchar2(30),
	movie_opendate date,
	movie_poster varchar2(200),
	movie_gradeNm number,
	movie_img1 varchar2(200),
	movie_img2 varchar2(200),
	movie_img3 varchar2(200),
	movie_overview clob,
	movie_runtime number(10),
	movie_status varchar2(100), 
	constraint movie_pk primary key (movie_num)
);

--MOVIE_DETAIL

--MOVIE_FAV
create table movie_fav(
	movie_num number not null,
	mem_num number not null,
	constraint movie_fav_fk1 foreign key (movie_num) references movie (movie_number),
	constraint movie_fav_fk2 foreign key (mem_num) references member (mem_num)
);


















