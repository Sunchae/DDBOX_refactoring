package kr.spring.payment.controller;

import java.sql.Date;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.payment.service.PayService;
import kr.spring.payment.vo.PayVO;
import kr.spring.store.service.StoreService;
import kr.spring.store.vo.StoreVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PayController {
	
	@Autowired
	private PayService payService;
	
	/*=================================
	 *	결제 글 저장
	 *=================================*/
	//자바빈 초기화
	@ModelAttribute
	public PayVO initCommand() {
		return new PayVO();
	}
	
	//결제 페이지 상세
	@RequestMapping("/store/storePay")
	public String payMain(HttpSession session, Model model, int store_num, int total_price, int order_quantity) {
		log.debug("<<페이메인>>");
		StoreVO store = null;
		store = payService.selectStore(store_num);
		
		model.addAttribute("store", store);
		model.addAttribute("total_price", total_price);
		model.addAttribute("order_quantity", order_quantity);
		return "storePay";
	}
	
	@GetMapping("/store/insertPay")
	public String insertPay(Model model, int store_num, int order_quantity, int total_price,Date pay_date, String store_title, HttpSession session) {
		log.debug("<<페이메인2323>>");
		log.debug("<<store_num>>" + store_num);
		
		MemberVO vo = (MemberVO)session.getAttribute("user");
		
		PayVO pay = new PayVO();
		pay.setStore_num(store_num);
		pay.setOrder_quantity(order_quantity);
		pay.setTotal_price(total_price);
		pay.setStore_title(store_title);
		pay.setMem_num(vo.getMem_num());
		payService.insertPay(pay);
		pay.setPay_date(pay_date);
		
		model.addAttribute("storePay", pay);
		
	 return "storePayDetail";
	}
	
	//process5
	/*
	 * @RequestMapping("/store/storePayMain") public String
	 * sotrePayMain(@RequestParam(value="pageNum",defaultValue = "1") int
	 * currentPage, HttpSession session, Model model) { MemberVO vo =
	 * (MemberVO)session.getAttribute("user");
	 * 
	 * List<PayVO> list = payService.selectList(vo.getMem_num());
	 * log.debug("<<스토어 결제 저장리스트>>");
	 * 
	 * model.addAttribute("list", list);
	 * 
	 * return "storePayMain"; }
	 */
	
}
