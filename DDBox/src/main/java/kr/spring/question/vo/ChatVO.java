package kr.spring.question.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatVO {
	private int chat_num;
	private int chatroom_num;
	private int mem_num;
	private String message;
	private String reg_date;
	private int read_check;
}
