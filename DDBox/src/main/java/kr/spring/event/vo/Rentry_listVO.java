package kr.spring.event.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Rentry_listVO {
	private int rentry_num;
	private int mem_num;
	private Date rentry_date;
	private int event_point;
	private int point_num;
}
