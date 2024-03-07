package kr.spring.question.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;

import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NewsVO {
	private int news_num;
	private int mem_num;
	@Range(min=1,max=4)
	private int news_category;
	@NotBlank
	private String news_title;
	@NotBlank
	private String news_content;
	private Date news_regdate;
	private int news_hit;
}
