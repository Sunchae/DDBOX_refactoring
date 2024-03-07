package kr.spring.reserve.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TicketVO {
	private int res_num;
	private int status;
	private int res_mem_total;
	private int res_mem_type;
	private Date res_regdate;
	private int res_ticket;
	private int res_pay;
	private int res_payType;
	private int res_usePoint;
	private int shw_num;
	private int scr_num;
	private int mem_num;
	
	private String mem_id;
	private String shw_date;
	private String shw_time;
	private String scr_do;
	private String scr_si;
	private String scr_name;
	private int scr_seatLine;
	private int scr_seatRow;
	private int movie_num;
	private String movie_title;
	private String scr_seatCnt;
}
