package kr.spring.question.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class QuestionVO {
	private int board_num;
	@Range(min=1,max=9)
	private int board_category;
	@NotBlank
	private String board_title;
	@NotBlank
	private String board_content;
	private Date board_regdate;
	private int board_hit;
	private int mem_num;
}
