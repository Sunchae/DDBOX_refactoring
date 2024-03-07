package kr.spring.event.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.catalina.connector.Request;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.event.service.EventService;
import kr.spring.event.vo.Rentry_listVO;
import kr.spring.event.vo.Entry_listVO;
import kr.spring.event.vo.Event_listVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EventController {
	@Autowired
	private EventService eventService;
	
	
	
	/*========================
	 * Main Page 이벤트
	 *========================*/
	@RequestMapping("/main/eventMain")
	public ModelAndView mainprosess() {
		List<Event_listVO> list = eventService.selectMainEvent();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventMain");
		mav.addObject("list", list);
		
		
		
		return mav;
	}
	
	/*========================
	 * 이벤트 글등록
	 *========================*/
	//자바빈(VO)초기화
	@ModelAttribute
	public Event_listVO initCommand() {
		return new Event_listVO();
	}
	//등록 폼 호출
	@GetMapping("/event/write")
	public String form() {
		return "eventWrite";//tiles설정명
	}
	
	//전송된 데이터 처리
	@PostMapping("/event/write")
	public String submit(@Valid Event_listVO event_listVO,BindingResult result,
			 HttpSession session, HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 저장>> : " + event_listVO);
		//유효성 체크
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호
		MemberVO vo = (MemberVO)session.getAttribute("user");
		event_listVO.setMem_num(vo.getMem_num());
		
		event_listVO.setEvent_photo1(FileUtil.createFile(request, event_listVO.getUpload1()));
		event_listVO.setEvent_photo2(FileUtil.createFile(request, event_listVO.getUpload2()));
		
		//글쓰기
		eventService.insertEvent(event_listVO);
		
		//view에 표시할 메시지
		model.addAttribute("message", "글 작성이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/event/main");		
		
		return "event/resultAlert";
	}
	
	/*========================
	 * 이벤트 글상세
	 *========================*/
	@RequestMapping("/event/detail")
	public ModelAndView process(@RequestParam int event_num) {
		log.debug("<<게시판 글 상세 event_num>> : " + event_num);
		
		//해당글의 조회수 증가
		eventService.updateHit(event_num);
		
		Event_listVO event_list = eventService.selectEvent(event_num);
		
		
		//제목에 태그를 허용하지 않음
		event_list.setEvent_title(StringUtil.useNoHtml(event_list.getEvent_title()));
								//타일스 설정명,속성명	,속성값
		return new ModelAndView("eventView","event_list",event_list);
	}
	/*========================
	 * 이벤트 글 수정
	 *========================*/
	//수정 폼 호출
	@GetMapping("/event/update")
	public String formUpdate(@RequestParam int event_num,Model model) {
		Event_listVO event_listVO = eventService.selectEvent(event_num);
		
		model.addAttribute("event_listVO", event_listVO);
		
		return "eventModify";
	}
	
	//전송된 데이터 처리
	@PostMapping("/event/update")
	public String submitUpdate(int event_num,@Valid Event_listVO event_listVO,BindingResult result,HttpSession session,
			  HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 저장>> : " + event_listVO);
		//유효성 체크
		if(result.hasErrors()) {
			Event_listVO vo = eventService.selectEvent(event_listVO.getEvent_num());
			event_listVO.setEvent_photo1(vo.getEvent_photo1());
			event_listVO.setEvent_photo2(vo.getEvent_photo2());
			return "eventModify";
		}
		
		//회원번호
		MemberVO vo = (MemberVO)session.getAttribute("user");
		event_listVO.setMem_num(vo.getMem_num());
		
		//DB에 저장된 파일 정보 구하기
		Event_listVO db_event = eventService.selectEvent(event_listVO.getEvent_num());
		
		//파일명 셋팅
		event_listVO.setEvent_photo1(FileUtil.createFile(request, event_listVO.getUpload1()));
		event_listVO.setEvent_photo2(FileUtil.createFile(request, event_listVO.getUpload2()));
		
		//글 수정
		eventService.updateEvent(event_listVO);
		
		//전송된 파일이 있을 경우 이전 파일 삭제
		if(event_listVO.getUpload1() != null && !event_listVO.getUpload1().isEmpty()) {
			FileUtil.removeFile(request, db_event.getEvent_photo1());
		}
		if(event_listVO.getUpload2() != null && !event_listVO.getUpload2().isEmpty()) {
			FileUtil.removeFile(request, db_event.getEvent_photo2());
		}
		
		//View에 표시할 메시지
		model.addAttribute("message", "글수정 완료");
		model.addAttribute("url", request.getContextPath() + "/event/detail?event_num=" + event_listVO.getEvent_num());
		
		
		return "common/resultAlert";
	}
	
	
	/*========================
	 * 이벤트 main
	 *========================*/
	@RequestMapping("/event/main")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="order",defaultValue="1") int order ,String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체 /검색 레코드수
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventMain");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 이벤트 special
	 *========================*/
	@RequestMapping("/event/special")
	public ModelAndView specialpro(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="order",defaultValue="1") int order ,String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체 /검색 레코드수
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("event_special");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 이벤트 entry
	 *========================*/
	@RequestMapping("/event/entry")
	public ModelAndView entrypro(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="order",defaultValue="1") int order ,String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체 /검색 레코드수
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("event_entry");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 이벤트 membership
	 *========================*/
	@RequestMapping("/event/membership")
	public ModelAndView membershippro(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="order",defaultValue="1") int order ,String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체 /검색 레코드수
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("event_membership");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 이벤트 theater
	 *========================*/
	@RequestMapping("/event/theater")
	public ModelAndView theaterpro(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="order",defaultValue="1") int order ,String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체 /검색 레코드수
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("event_theater");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 이벤트 discount
	 *========================*/
	@RequestMapping("/event/discount")
	public ModelAndView discountpro(@RequestParam(value="pageNum",defaultValue="1") int currentPage,String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체 /검색 레코드수
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"discount");
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("event_discount");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 이벤트 roulette
	 *========================*/
	//roulette 폼 호출
	@GetMapping("/event/roulette")
	public String rouletteform() {
		return "event_roulette";//tiles설정명
	}
	@PostMapping("/event/rouletteAjax")//ajax통신따로 만들어줌
	@ResponseBody
	public Map<String,String> roulettepro(@Valid Rentry_listVO entry_listVO,HttpSession session) {
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인 안됨
			mapJson.put("result", "logout");
		}else {
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	/*========================
	 * roulette 참여자 리스트 등록
	 *========================*///하루에 한번만 돌릴수 있도록 
	@RequestMapping("/event/rouletteinsertAjax")//ajax통신따로 만들어줌
	@ResponseBody
	public Map<String,Object> rouletteinsert(Rentry_listVO rentry_listVO,HttpSession session) {
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인이 안됨
			mapJson.put("result", "logout");
		}else {
			//회원번호 등록
			rentry_listVO.setMem_num(user.getMem_num());
			
			int mem_num = user.getMem_num();
			Rentry_listVO rentry_list = eventService.selectRentryEvent(mem_num);
			log.debug("<<rentry_list>> : " + rentry_list);
			
			if(rentry_list == null) {
				eventService.insertRentry(rentry_listVO);
				mapJson.put("result", "success");
			}
			
			
			
		}
		
		return mapJson;
	}
	
	 
	 
	/*========================
	 * 응모권 참여자 리스트 목록
	 *========================*/
	@RequestMapping("/event/entryEventList")
	public ModelAndView entryEventList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								@RequestParam(value="order",defaultValue="1") int order,
								String keyword, String keyfield) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체,검색 레코드 수
		int count = eventService.selectRowCount(map);
		log.debug("<<이벤트 참여 글 목록 count>> : " + count);
		
		//페이지처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 20, 10, "list","&order="+order);
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());		
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("entryEventList");//타일즈 설정명으로 호출
		mav.addObject("count", count);
		mav.addObject("list", list);
		log.debug("event_num", list);
		mav.addObject("page", page.getPage());
		
		
		return mav;
	}
	 
	/*========================
	 * 응모권 참여자 리스트 목록
	 *========================*/
	@RequestMapping("/event/memberEntryList")
	public ModelAndView mentryEventList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								@RequestParam(value="order",defaultValue="1") int order,
								String keyword, String keyfield) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체,검색 레코드 수
		int count = eventService.selectRowCount(map);
		log.debug("<<이벤트 참여 글 목록 count>> : " + count);
		
		//페이지처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 20, 10, "list","&order="+order);
		
		List<Event_listVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());		
			list = eventService.selectList(map);
		}
	
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberEntryList");//타일즈 설정명으로 호출
		mav.addObject("count", count);
		mav.addObject("list", list);
		log.debug("event_num", list);
		mav.addObject("page", page.getPage());
		
		
		return mav;
	}
	/*========================
	 * 응모권 참여자 리스트 등록
	 *========================*/
	@RequestMapping("/event/entryinsertAjax")//ajax통신따로 만들어줌
	@ResponseBody
	public Map<String,Object> entryinsert(@RequestParam int event_num,Entry_listVO entry_listVO, HttpSession session) {
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
				
		
		
		if(user == null) {
			//로그인이 안됨
			mapJson.put("result", "logout");
		}else {
			entry_listVO.setMem_num(user.getMem_num());
			entry_listVO.setEvent_num(event_num);
			entry_listVO.setWin_type(0);
			
			
			//중복 방지 mem_num/event_num으로 조회하는 로직 추가
			int mem_num = user.getMem_num();
			Entry_listVO entry_list = eventService.selectEntryEvent(event_num,mem_num);
			log.debug("<<entry_list>> : " + entry_list);
			
			//만약에 값이 존재하면 참여 방지하고 값이 없으면 이벤트 등록
			if(entry_list  == null) {
				eventService.insertEntry(entry_listVO);
				mapJson.put("result", "success");
			}else {
				mapJson.put("result", "already");
				
			}
			
			
		}
		
		return mapJson;
	}
	/*========================
	 * 응모권 이벤트 참여자 상세
	 *========================*/
	@RequestMapping("/event/entryName")
	public ModelAndView entryprocess(@RequestParam int event_num,@RequestParam(value="pageNum",defaultValue="1") int currentPage,
                           String keyword, String keyfield) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		log.debug("<<응모자 상세 event_num>> : " + event_num);
		//전체,검색 레코드 수
		int count = eventService.selectRowCount(map);
		//페이지처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 20, 10, "entryName");
      
		List<Entry_listVO> entry_list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());      
			entry_list = eventService.selectEntry(map, event_num);
		}
		//event_list 에서 해당 이벤트의 event_status 값 불러오기 (추첨전이면 진행, 추첨후면 기존 결과 반환)
		 Event_listVO event_list = eventService.selectEvent(event_num);//이벤트 리스트 VO에 담아줌
		
		 int event_status = event_list.getEvent_status();
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("entryName");//타일즈 설정명으로 호출
		mav.addObject("count", count);
		mav.addObject("list", entry_list);
		mav.addObject("event_num", event_num);
		mav.addObject("page", page.getPage());
        mav.addObject("event_status", event_status);
      
		return mav;
	}
	/*========================
	 * 응모권 이벤트 회원 상세
	 *========================*/
	@RequestMapping("/event/winName")
	public ModelAndView winprocess(@RequestParam int event_num,@RequestParam(value="pageNum",defaultValue="1") int currentPage,
                           String keyword, String keyfield) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		log.debug("<<응모자 상세 event_num>> : " + event_num);
		//전체,검색 레코드 수
		int count = eventService.selectRowCount(map);
		//페이지처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 20, 10, "winName");
      
		List<Entry_listVO> entry_list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());      
			entry_list = eventService.selectEntry(map, event_num);
		}
		//event_list 에서 해당 이벤트의 event_status 값 불러오기 (추첨전이면 진행, 추첨후면 기존 결과 반환)
		 Event_listVO event_list = eventService.selectEvent(event_num);//이벤트 리스트 VO에 담아줌
		
		 int event_status = event_list.getEvent_status();
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("winName");//타일즈 설정명으로 호출
		mav.addObject("count", count);
		mav.addObject("list", entry_list);
		mav.addObject("event_num", event_num);
		mav.addObject("page", page.getPage());
        mav.addObject("event_status", event_status);
      
		return mav;
	}
	/*========================
	 * 당첨자
	 *========================*/
	
	 @RequestMapping("/event/winnerEntry") 
	 public ModelAndView entryWinner(@RequestParam("entry_num") List<Integer> list,@RequestParam("mem_num") List<Integer> list2, int event_num) { 
		  
	 //log.debug("<<당첨자 entry_num>> : " + entry_num); 
	 //List<Entry_listVO> list = null; 
	 //list = eventService.winnerEntry(entry_num);
	 //log.debug("list size : " + list.size());
	 log.debug("<<event_num >> : " +event_num);

	 
	 int ran = (int)(Math.random()*list.size());	 
	 int winner = list.get(ran);
	 
	 //event_list 에서 해당 이벤트의 event_status 값 불러오기 (추첨전이면 진행, 추첨후면 기존 결과 반환)
	 Event_listVO event_list = eventService.selectEvent(event_num);//이벤트 리스트 VO에 담아줌
	
	 int event_status = event_list.getEvent_status();
	 
	 
	 
	 //event status 1?
	 
		//event_list 에서 해당 이벤트의 event_status 값 변경 (추첨전->추첨후)
		 event_list.setEvent_status(event_status);
		 eventService.updateEventStatus(event_num);
		 
		 //지금 불러온 winner의 값은 당첨자의 mem_num, 이 mem_num으로 당첨자의 정보 불러오기
		 //Entry_listVO entry_list = new Entry_listVO();
		 
		 //entry_list.setEvent_num(event_num);
		 //entry_list.setMem_num(winner);
		 eventService.updateWinType(event_num,list2.get(ran));
	 
	 //event status 0?
		 
	 
	 
	 
	 ModelAndView mav = new ModelAndView(); 
	 mav.setViewName("winnerEntry");
	 mav.addObject("list", event_list);
	 mav.addObject("event_status", event_status);
	 mav.addObject("winner", winner);
	 return mav; 
	  
	 }
	 
	
	/*========================
	 * 응모권 이벤트 참여자update
	 *========================*/
	@RequestMapping("/event/winnerUpdateAjax")//ajax통신따로 만들어줌
	@ResponseBody
	public Map<String,Object> winnerAdmin(Entry_listVO entry,HttpSession session,HttpServletRequest request) {
		log.debug("<<win_type 수정>> : " + entry);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인이 안됨
			mapJson.put("result", "logout");
		}else {
			eventService.updateEntryAdmin(entry);
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
}
