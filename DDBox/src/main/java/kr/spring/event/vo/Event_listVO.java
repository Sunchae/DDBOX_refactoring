package kr.spring.event.vo;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Event_listVO {
	private int event_num;			//이벤트 등록 번호
	@NotBlank
	private String event_title;		//이벤트 제목
	private String event_content;	//이벤트 내용
	private MultipartFile upload1;
	private String event_photo1;	//이벤트 사진1(필수)
	private MultipartFile upload2;
	private String event_photo2;	//이벤트 사진2
	private int event_type;			//이벤트 타입
	private int scr_num;			//상영관 번호
	private int event_status;		//이벤트 종료여부
	private int hit;
	@NotBlank
	private String event_start;		//이벤트 시작 날짜
	@NotBlank
	private String event_end;		//이벤트 종료 날짜
	private int event_point;		//이벤트 포인트
	private int mem_num;			//회원번호
	
}
