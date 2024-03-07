--스토어 메인
create table store(
	store_num number not null,
	store_title varchar2(150) not null,
	store_content clob not null,
	store_price number(12) not null,
	store_photo varchar2(200),
	store_reg_date date default sysdate not null,
	store_modify_date date,
	store_status number(1) default 0 not null,		--판매여부(1:미표시 2:표시)
	store_ip varchar2(40) not null,
	mem_num number not null,
	store_type number(1) default 0 not null,
	quantity number(5) not null
	constraint store_pk primary key (store_num),
	constraint store_fk foreign key (mem_num) references member (mem_num)
);
create sequence store_seq;

create table pay(
	pay_id number not null,
	pay_status number(1) not null,		--결제 상태(0:결제진행중, 1:결제완료,2: 결제취소)
	total_price number(12) not null,
	pay_date date default sysdate not null,
	store_num number not null,
	mem_num number not null,
	order_quantity varchar2(5) not null,
	store_title varchar2(150) not null,
	constraint pay_pk primary key (pay_id),
	constraint pay_fk foreign key (mem_num) references member (mem_num),
	constraint pay_fk1 foreign key (store_num) references member (store_num),
);
create sequence pay_seq;
