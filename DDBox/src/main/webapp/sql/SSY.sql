--이벤트 리스트
create table event_list(
event_num number not null,
event_title varchar2(150) not null,
event_content clob not null,
event_photo1 varchar2(200) not null,
event_photo2 varchar2(200),
event_type number(1) not null,
event_status number(1) not null,
event_start varchar2(10) not null,
event_end varchar2(10) not null,
mem_num number not null,
hit number(8) default 0 not null,
scr_num number,
constraint event_list_pk primary key (event_num),
constraint event_list_fk1 foreign key (mem_num) references member(mem_num),
constraint event_list_fk2 foreign key (scr_num) references screen(scr_num)
);
create sequence eventlist_seq;

--당첨자 리스트 보류
create table win_list(
event_num number not null,
point_num number not null,
mem_num number not null,
entry_num number not null,
win_date date default sysdate not null,
entry_title varchar2(150),
entry_content clob,
constraint win_list_fk1 foreign key (event_num) references event_list(event_num),
constraint win_list_fk2 foreign key (point_num) references point(point_num),
constraint win_list_fk3 foreign key (entry_num) references entry_list(entry_num)
);

--응모권 참여자 리스트
create table entry_list(
entry_num number not null,
event_num number not null,
mem_num number not null,
entry_date date default sysdate not null,--참여일
win_type number default 0 not null,--추첨상태(0-미추첨,1-당첨,2-미당첨)
win_date date,--추첨일
constraint entry_list_pk primary key (entry_num),
constraint entry_list_fk1 foreign key (mem_num) references member(mem_num),
constraint entry_list_fk2 foreign key (event_num) references event_list(event_num)
);
create sequence entrylist_seq;

--룰렛 참여자 리스트
create table rentry_list(
rentry_num number not null,
mem_num number not null,
event_point number(5),
rentry_date date default sysdate not null,
constraint rentry_list_pk primary key (rentry_num),
constraint rentry_list_fk1 foreign key (mem_num) references member(mem_num)
);
create sequence rentrylist_seq;