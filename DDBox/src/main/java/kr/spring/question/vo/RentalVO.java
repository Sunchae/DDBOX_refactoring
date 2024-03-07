package kr.spring.question.vo;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RentalVO {
	private int rental_num;
	private int mem_num;
	private Integer scr_num; //영화관
	private Date rental_regdate;
	@NotBlank
	private String rental_date;
	private Date rental_modifydate;
	@Min(value=1)
	private int rental_per;
	@NotBlank
	private String rental_content;
	@NotBlank
	private String rental_name;
	@NotBlank
	private String rental_phone;
	@Email
	@NotBlank
	private String rental_email;
	private int rental_status;
	
	private String scr_name;
	
}
