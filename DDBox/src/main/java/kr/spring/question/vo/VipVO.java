package kr.spring.question.vo;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VipVO {
	private int mem_num;
	private int vip_num;
	@NotBlank
	private String vip_title;
	@NotBlank
	private String vip_content;
}
