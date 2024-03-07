--이메일 문의 테이블 (**생성 완)
create table email_faq(
 qna_num number not null,
 mem_num number not null,
 qna_title varchar2(90) not null,
 qna_type number not null, --문의유형
 scr_num number, --해당되는 영화관
 question_content clob not null,
 question_file varchar2(200),
 question_regdate date default sysdate not null,
 ask_content clob,
 ask_regdate date,
 constraint email_faq_pk primary key (qna_num),
 constraint email_faq_fk1 foreign key (mem_num) references member (mem_num),
 constraint email_faq_fk3 foreign key (scr_num) references screen (scr_num)
);
create sequence email_faq_seq;


--단체 대관 예약 테이블 (**생성 완)
create table rental(
 rental_num number not null,
 mem_num number not null,
 scr_num number not null, --해당 영화관
 rental_regdate date default sysdate not null,
 rental_date date not null,--대관 희망 날짜
 rental_modifydate date,
 rental_per number not null, --희망인원
 rental_content clob not null,
 rental_name varchar2(30) not null, --신청자명
 rental_phone varchar2(15) not null, --전화번호
 rental_email varchar2(50) not null,
 rental_status number default 0 not null,
 constraint rental_pk primary key (rental_num),
 constraint rental_fk1 foreign key (mem_num) references member (mem_num),
 constraint rental_fk2 foreign key (scr_num) references screen (scr_num)
);
create sequence rental_seq;



--질문 통합 관리 게시판 (**생성 완)
create table question_board(
 mem_num number not null, --추가
 board_num number not null,
 board_category number not null,
 board_title varchar2(90) not null,
 board_content clob not null,
 board_regdate date default sysdate not null,
 board_hit number(8) default 0 not null,
 constraint question_board_pk primary key (board_num),
 constraint question_board_fk foreign key (mem_num) references member (mem_num)
);

create sequence question_seq;



--공지 테이블 (**생성 완)
create table news(
 mem_num number not null, --추가
 news_num number not null,
 news_category number not null,
 news_title varchar2(90) not null,
 news_content clob not null,
 news_regdate date default sysdate not null,
 news_hit number(8) default 0 not null,
 constraint notice_pk primary key (news_num),
 constraint notice_fk foreign key (mem_num) references member (mem_num)
);

create sequence news_seq;


--VIP/VVIP 질문 게시판 (**생성 완)
create table vip_faq(
 mem_num number not null, --추가
 vip_num number not null,
 vip_title varchar2(90) not null,
 vip_content clob not null,
 constraint vip_pk primary key (vip_num),
 constraint vip_fk foreign key (mem_num) references member (mem_num)
);

create sequence vip_seq;



--실시간 채팅방 테이블 (**생성 완)
create table faq_chatroom(
 chatroom_num number primary key,
 user_num number references member (mem_num) not null,
 admin_num number references member (mem_num) not null
);
create sequence faq_chatroom_seq;



--실시간 채팅 테이블 (**생성 완)
create table faq_chat(
 chat_num number primary key,
 chatroom_num number references faq_chatroom (chatroom_num) not null,
 mem_num number references member (mem_num) not null,
 message clob not null,
 reg_date date default sysdate,
 read_check number(1) default 1 not null
);
create sequence faq_chat_seq;

