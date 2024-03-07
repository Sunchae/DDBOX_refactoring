package kr.spring.question.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.VipService;
import kr.spring.question.vo.VipVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class VipController {
	@Autowired
	private VipService vipService;
	
	/*==========================
	 * 글 목록
	 *==========================*/
	@RequestMapping("/faq/vip")
	public ModelAndView vippro(@RequestParam(value="pageNum",defaultValue="1") int currentPage) {
		Map<String,Object> map = new HashMap<String,Object>();
		/*
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);*/
		
		//전체, 검색 레코드 수
		int count = vipService.selectRowCount(map);
		log.debug("<<vip 글목록 count>> : " + count);
		
		//페이지 처리
		PageUtil page = new PageUtil(currentPage,count,10, 5,"list");
		
		List<VipVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = vipService.selectList(map);
		}
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("vip");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}	
	
	
	/*==========================
	 * 글 등록
	 *==========================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public VipVO initCommand() {
		return new VipVO();
	}
	
	//등록폼 호출
	@GetMapping("/faq/vip/write")
	public String form() {
		return "vip_write";
	}
	
	//글 등록
	@PostMapping("/faq/vip/write")
	public String submit(@Valid VipVO vipVO, BindingResult result,
						 HttpSession session, HttpServletRequest request, Model model) {
		
		log.debug("<<공지/뉴스 작성 확인>> : " + vipVO);
		
		//유효성 체크 
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호
		MemberVO vo = (MemberVO)session.getAttribute("user");
		vipVO.setMem_num(vo.getMem_num());
		
		//글쓰기
		vipService.insertVip(vipVO);
		
		//view에 표시할 메시지
		model.addAttribute("message", "글 작성이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/vip");
		
		return "common/resultAlert";
	}
	
	
	
	
	
	/*==========================
	 * 글 상세
	 *==========================*/
	@RequestMapping("/faq/vip/detail")
	public ModelAndView process(@RequestParam int vip_num) {
		log.debug("<<VIP 글 상세 vip_num>> : " + vip_num);
		
		VipVO vip = vipService.selectVip(vip_num);
		
		return new ModelAndView("vip_detail", "vip", vip);//tiles설정명,속성명,속성값
	}
	
	
	
	
	/*==========================
	 * 글 수정
	 *==========================*/
	//수정폼 호출
	@GetMapping("/faq/vip/update")
	public String formUpdate(@RequestParam int vip_num, Model model) {
		VipVO vipVO = vipService.selectVip(vip_num);
		
		model.addAttribute("vipVO", vipVO);
		
		return "vip_update";
	}
	
	//수정 데이터 처리
	@PostMapping("/faq/vip/update")
	public String submitUpdate(@Valid VipVO vipVO, BindingResult result,
								HttpServletRequest request, Model model) {
		log.debug("<<글 수정>> : " + vipVO);
		
		if(result.hasErrors()) {
			return "vip_update";
		}
		
		vipService.updateVip(vipVO);
		
		model.addAttribute("message", "수정 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/vip/detail?vip_num="+vipVO.getVip_num());
		
		return "common/resultAlert";
	}
	
	
	
	/*==========================
	 * 글 삭제
	 *==========================*/
	@RequestMapping("/faq/vip/delete")
	public String submitDelete(@RequestParam int vip_num, HttpServletRequest request) {
		log.debug("<<공지글 삭제 vip_num>> : " + vip_num);
		
		vipService.deleteVip(vip_num);
		
		return "redirect:/faq/vip";
	}
	
	
	
	
	
}
