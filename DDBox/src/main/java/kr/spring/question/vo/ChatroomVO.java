package kr.spring.question.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatroomVO {
	private int chatroom_num;
	private int user_num;
	private int admin_num;
	
	private int cnt; //읽지않은 메시지 수
	private String mem_id; //고객 id
}
