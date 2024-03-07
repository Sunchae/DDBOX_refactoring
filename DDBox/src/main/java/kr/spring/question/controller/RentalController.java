package kr.spring.question.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.RentalService;
import kr.spring.question.vo.RentalVO;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class RentalController {
	@Autowired
	private RentalService rentalService;
	
	/*==========================
	 * 대관 글등록
	 *==========================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public RentalVO initCommand() {
		return new RentalVO();
	}
	
	//등록폼 호출
	@GetMapping("faq/rental/write")
	public String form(Model model) {
		List<ScreenVO> list = rentalService.getAllScreens();
		model.addAttribute("list", list);
		
		log.debug("<<영화관 list>> : " + list);
		return "rental_write";
	}
	
	//글 등록
	@PostMapping("faq/rental/write")
	public String submit(@Valid RentalVO rentalVO, BindingResult result,
						 HttpSession session, HttpServletRequest request, Model model) {
		log.debug("<<단체/대관 문의 작성>> : " + rentalVO);
		
		if(result.hasErrors()) {
			return "rental_write";
		}
		
		//회원번호
		MemberVO vo = (MemberVO)session.getAttribute("user");
		rentalVO.setMem_num(vo.getMem_num());
		
		log.debug("<<대관>> rentalVO : " + rentalVO);
		
		//글쓰기
		rentalService.insertRental(rentalVO);
		
		model.addAttribute("message", "예약 신청이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/rental");
		
		return "common/resultAlert";
	}
	
	/*===========================
	 * 글 목록
	 * ==========================*/
	//회원
	@RequestMapping("/faq/rental")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								@RequestParam(value="order",defaultValue="1") int order,
								HttpSession session,
								String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		//회원
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num());
		
		//전체,검색 레코드 수
		int count = rentalService.selectRowCount(map);
		log.debug("<<대관 글목록 count>>" + count);
		
		//페이지 처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 10, 5, "list");
		
		List<RentalVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = rentalService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("rental");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//대관 목록 (관리자)
	@RequestMapping("/faq/rental/rental_admin")
	public String adminProcess(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									 @RequestParam(value="order",defaultValue="1") int order,
									 String keyword, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num()); //관리자 인증
		
		//전체,검색 레코드 수
		int count = rentalService.selectRowCountForAdmin(map);
		log.debug("<<대관 글목록 count>>" + count);
		
		//페이지 처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 10, 5, "list");
		
		List<RentalVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = rentalService.selectListForAdmin(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "rental_admin";
	}
	
	
	
	/*==========================
	 * 글상세
	 *==========================*/
	@RequestMapping("/faq/rental/detail")
	public ModelAndView detailProcess(@RequestParam int rental_num) {
		log.debug("<<렌탈 글 상세>> : " + rental_num);
		
		RentalVO rental = rentalService.selectRental(rental_num);
		
		return new ModelAndView("rental_detail", "rental", rental);
	}
	
	
	/*==========================
	 * 글삭제
	 *==========================*/
	@RequestMapping("/faq/rental/delete")
	public String submitDelete(@RequestParam int rental_num, HttpServletRequest request) {
		log.debug("<<렌탈 글 삭제>> : " + rental_num);
		
		rentalService.deleteRental(rental_num);
		
		return "redirect:/faq/rental";
	}
	
	/*==========================
	 * 상태 변경
	 *==========================*/
	 //상태 수정폼 호출
	@GetMapping("/faq/rental/update")
	public String formUpdate(@RequestParam int rental_num, Model model) {
		RentalVO rentalVO = rentalService.selectRental(rental_num);
		
		model.addAttribute("rentalVO", rentalVO);
		return "rental_update";
	}
	
	@PostMapping("faq/rental/update")
	public String submitUpdate(@Valid RentalVO rentalVO, BindingResult result,
								HttpServletRequest request, Model model) {
		log.debug("<<글 수정>> : " + rentalVO);
		
		if(result.hasFieldErrors("scr_num") || result.hasFieldErrors("rental_per") || result.hasFieldErrors("rental_content") || result.hasFieldErrors("rental_name") 
			    || result.hasFieldErrors("rental_phone") || result.hasFieldErrors("rental_email") || result.hasFieldErrors("rental_date")) {
			    return "rental_update";
			}
		
		rentalService.updateRental(rentalVO);
		
		model.addAttribute("message", "수정 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/rental/detail?rental_num"+rentalVO.getRental_num());
		
		return "redirect:/faq/rental/detail?rental_num="+rentalVO.getRental_num();
	}
	
	@RequestMapping("/faq/rental/updateStatus")
	public String execute(@RequestParam int rental_num, @RequestParam int rental_status){
		
		//rental status update 메서드
		rentalService.updateRentalStatus(rental_status, rental_num);
		
		return "redirect:/faq/rental/detail?rental_num="+rental_num;
	}
	
	
}
