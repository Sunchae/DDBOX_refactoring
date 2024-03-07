package kr.spring.payment.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PayVO {
	private int pay_id;
	private int pay_status;
	private String store_title;
	private int total_price;
	private Date pay_date;
	private int store_num;
	private int mem_num;
	private int order_quantity;
}
