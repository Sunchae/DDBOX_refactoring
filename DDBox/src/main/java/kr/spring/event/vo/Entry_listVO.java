package kr.spring.event.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Entry_listVO {
	   private int entry_num;
	   private int event_num;
	   private int mem_num;
	   private Date entry_date;//참여 날짜
	   private Date win_date;//추첨 날짜
	   private int win_type;//추첨 타입
	   
	   private String mem_id;
	   private String event_title;
	   private int mem_auth;
}
