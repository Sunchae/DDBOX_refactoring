package kr.spring.reserve.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ShowVO {
	private int shw_num;
	private String shw_sdate;
	private String shw_edate;
	private String shw_time;
	private String shw_seatCnt;
	private int scr_num;
	private int movie_num;
	
	private int scr_seatTotal;
	private int scr_seatLine;
	private int scr_seatRow;
	private String scr_name;
	private String movie_title;
	private int movie_runtime;
	private String movie_poster;
	private String movie_status;
}
