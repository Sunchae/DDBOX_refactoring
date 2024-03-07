package kr.spring.reserve.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScreenVO {
	private int scr_num;
	private String scr_name;
	private String scr_do;
	private String scr_si;
	private int scr_type;
	private int scr_seatTotal;
	private int scr_seatLine;
	private int scr_seatRow;
}
