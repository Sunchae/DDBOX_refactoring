package kr.spring.store.controller;


import java.io.IOException;
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
import kr.spring.store.service.StoreService;
import kr.spring.store.vo.StoreVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class StoreController {
	@Autowired
	private StoreService storeService;

	/*=================================
	 *	스토어 메인 글 목록 
	 *=================================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public StoreVO initCommand() {
		return new StoreVO();
	}
	
	/*
	 * @RequestMapping(value="/store/storeMainTest", method={RequestMethod.POST,
	 * RequestMethod.GET}) public String storeMain(HttpSession session, Model model)
	 * {
	 * 
	 * Map<String, Object> map = new HashMap<String, Object>();
	 * 
	 * List<StoreVO> list = storeService.selectList(map);
	 * 
	 * 
	 * model.addAttribute("list", list);
	 * 
	 * return "storeMainTest"; }
	 */
	
	@RequestMapping("/store/storeMainTest")
	public String storeMain(Model model) {
		List<StoreVO> ticketlist = storeService.selectMainTicketList();
		log.debug("<<스토어 메인 티켓 리스트>>");
		List<StoreVO> popcornlist = storeService.selectMainPopcornList();
		
		model.addAttribute("ticketlist", ticketlist);
		model.addAttribute("popcornlist", popcornlist);
		

		return "storeMainTest";
	}
	
	/*=================================
	 *	스토어 글 등록
	 *=================================*/
	//등록 폼 호출
	@GetMapping("/store/write")
	public String form() {

		return "storeWrite";	//타일스 설정명
	}
	@PostMapping("/store/write")
	public String submit(@Valid StoreVO storeVO, BindingResult result, HttpServletRequest request, HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<스토어 글 저장>> : " + storeVO);

		//유효성 체크
		if(result.hasErrors()) {
			return form();
		}

		//회원 번호 세팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		storeVO.setMem_num(vo.getMem_num());
		//ip세팅
		storeVO.setStore_ip(request.getRemoteAddr());
		//파일 업로드
		storeVO.setStore_photo(FileUtil.createFile(request, storeVO.getUpload()));
		//글쓰기
		storeService.insertStore(storeVO);

		//뷰에 표시할 메세지
		model.addAttribute("message", "상품등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/store/storeMainTest");

		return "common/resultAlert";
	}

	
	/*=================================
	 *	스토어 글 상세
	 *=================================*/
	@RequestMapping("/store/detail")
	public ModelAndView detail(@RequestParam int store_num) {
		log.debug("<<스토어 게시글 상세 store_num>> : " + store_num);
		
		StoreVO store = storeService.selectStore(store_num);
		
		//제목,상품이름에 태그를 허용하지 않음
		store.setStore_title(StringUtil.useNoHtml(store.getStore_title()));
		
		return new ModelAndView("storeDetail","store",store);
	}

	
	/*=================================
	 *	스토어 티켓 글 목록 
	 *=================================*/
	@RequestMapping("/store/ticketList")
	public String ticket(@RequestParam(value="pageNum",defaultValue="1") int currentPage, HttpSession session, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = storeService.selectRowCount(map,0);
		
		PageUtil page = new PageUtil(currentPage, count, 12,10,"ticketList");
		
		List<StoreVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = storeService.selectTicketList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		log.debug("<<스토어 티켓 글 목록 list>> : " + list);
		
		return "storeTicketList";
	}
	
	/*=================================
	 *	팝콘 메뉴 목록
	 *=================================*/
	@RequestMapping("/store/storePopcorn")
	public String popcorn(@RequestParam (value="pageNum",defaultValue="1") int currentPage, HttpSession session, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		int count = storeService.selectRowCount(map,1);

		PageUtil page = new PageUtil(currentPage, count, 12,10,"storePopcorn");
		
		List<StoreVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = storeService.selectPopcornList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		log.debug("<<팝콘 글 목록 list>> : " + list);
		
		return "storePopcorn";
	}
	
	/*=================================
	 *	스토어 글 수정
	 *=================================*/
	//수정 폼 호출
	@GetMapping("/store/update")
	public String formUpdate(@RequestParam int store_num, Model model) {
		StoreVO storeVO = storeService.selectStore(store_num);
		
		model.addAttribute("storeVO", storeVO);
		
		return "storeModify";
	}
	
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/store/update")
	public String submitUpadte(@Valid StoreVO storeVO, BindingResult result, HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<스토어 글 수정>> : " + storeVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			StoreVO vo = storeService.selectStore(storeVO.getStore_num());
			storeVO.setStore_photo(vo.getStore_photo());
			
			return "storeModify";
		}
		//DB에 저장된 파일 정보 구하기						이전 글을 가져오기위함
		StoreVO db_store = storeService.selectStore(storeVO.getStore_num());
		
		//파일명 세팅
		storeVO.setStore_photo(FileUtil.createFile(request, storeVO.getUpload()));
		//ip 세팅
		storeVO.setStore_ip(request.getRemoteAddr());
		
		//글 수정
		storeService.updateStore(storeVO);
		
		//전송된 파일이 있을 경우 이전 파일 삭제
		if(storeVO.getUpload() != null && !storeVO.getUpload().isEmpty()) {
			//수정된 파일 삭제 처리
			FileUtil.removeFile(request, db_store.getStore_photo());
		}
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url", request.getContextPath() + "/store/detail?store_num=" + storeVO.getStore_num());
		return "common/resultAlert";
	}
	
	/*=================================
	 *	게시판 글 삭제 
	 *=================================*/
	@RequestMapping("/store/delete")
	public String submitDelete(@RequestParam int store_num, HttpServletRequest request) {
		log.debug("<<스토어 글 삭제 store_num>> : " + store_num);
		
		//DB에 저장된 파일 정보 구하기 -> 안해도 되지만 쓰레기가 쌓이기 때문에 하는게 좋다
		StoreVO db_store = storeService.selectStore(store_num);
		
		//글 삭제
		storeService.deleteStore(store_num);
		
		if(db_store.getStore_photo() != null) {
			//파일 삭제
			FileUtil.removeFile(request, db_store.getStore_photo());
		}
		return "redirect:/store/storeMainTest";
	}
}
