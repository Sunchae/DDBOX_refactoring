package kr.spring.store.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StoreVO {
	private int store_num;
	@NotBlank
	private String store_title;
	@NotBlank
	private String store_content;
	private int store_price;
	private MultipartFile upload;
	private String store_photo;
	private int store_type;				//상품 분류 번호 0:디디티켓 1:팝콘/음료/굿즈
	private Date store_reg_date;
	private Date store_modify_date;
	private int store_status;			//상품 판매여부 1:판매완료 2:판매중
	private String store_ip;
	private int mem_num;
	private int quantity;
}
