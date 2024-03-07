package kr.spring.question.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import kr.spring.reserve.vo.ScreenVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmailVO {
	private int qna_num;
	private int mem_num;
	@NotBlank
	private String qna_title;
	@Range(min=1,max=5)
	private int qna_type;
	private Integer scr_num; //영화관 (외래키)
	@NotBlank
	private String question_content;
	private String question_file;
	private MultipartFile upload;
	private Date question_regdate;
	private String ask_content;
	private Date ask_regdate;
	
	private String mem_id;
	
	private ScreenVO screen;
	
	private String scr_name;
	
	//member_detail
//	private String mem_name;
//	private String mem_email;
//	private String mem_phone;
}
