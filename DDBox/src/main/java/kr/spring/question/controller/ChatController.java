package kr.spring.question.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.ChatService;
import kr.spring.question.vo.ChatVO;
import kr.spring.question.vo.ChatroomVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController {
	@Autowired
	private ChatService chatService;
	@Autowired
	private MemberService memberService;

	/* ============================
	 * 채팅방 목록
	 * ============================*/
	//채팅방 목록 (회원)
	@RequestMapping("/faq/chat/chatUser")
	public String process() {
		return "chatUser";
	}
	
	//채팅방 목록 (관리자)
	@RequestMapping("/faq/chat/chattingListForAdmin")
	public String chatList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
							String keyword, HttpSession session, Model model) {
		
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num()); //관리자 인증
		
		int count = chatService.selectRowCount(map);
		
		PageUtil page = new PageUtil(null,keyword,currentPage,count,10,5,"chattingListForAdmin");
		
		List<ChatroomVO> list = null;
		if(count>0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = chatService.selectChatRoomList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "chattingListForAdmin";
	}
	
	
	/*==================================
	 * 채팅방 생성
	 *================================== */
	
	//채팅방 생성  
	@GetMapping("/faq/chat/chattingListForUser")
	public String insertChatRoom(HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<MemberVO>> : " + user);
		ChatroomVO vo = chatService.checkChatRoom(user.getMem_num());
		log.debug("<<chatroom_num>>");
		int chatroom_num=0;
		if(vo == null) {
			ChatroomVO ChatroomVO = new ChatroomVO();
			ChatroomVO.setUser_num(user.getMem_num());
			ChatroomVO.setAdmin_num(2);
			ChatroomVO chatroom = chatService.insertChatRoom(ChatroomVO);
			chatroom_num = chatroom.getChatroom_num();
		}else {
			chatroom_num = vo.getChatroom_num();
		}
		return "redirect:/faq/chat/chatUserRoom_detail?chatroom_num="+chatroom_num;
	}
	
	//채팅방 진입
	@RequestMapping("/faq/chat/chatUserRoom_detail")
	public String chatUserRoomDetail(@RequestParam("chatroom_num") int chatroom_num, Model model,HttpSession session) {
		
		ChatroomVO chatroomVO = chatService.getChatroomInfo(chatroom_num);
		model.addAttribute("chatroomVO", chatroomVO);
		
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_auth()==9) {
			return "chatUserRoom_detailForAdmin";
		}else {
			return "chatUserRoom_detailForUser";
		}
	}
	
	
	/*==================================
	 * 채팅하기
	 *================================== */
	//채팅 메시지 등록 (전송)
	@RequestMapping("/faq/chat/writeChat")
	@ResponseBody
	public Map<String, Object> writeChatAjax(ChatVO vo, HttpSession session){
		Map<String, Object> mapAjax = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapAjax.put("result", "logout");
		}else {
			vo.setMem_num(user.getMem_num());

			log.debug("<<채팅 메시지 등록 ChatVO>> : " + vo);
			chatService.insertChat(vo);

			mapAjax.put("result", "success");
		}
		return mapAjax;
	}
	
	
	
	/* ============================
	 * 채팅 메시지 처리
	 * ============================*/
	//채팅 메시지 읽기(ajax 통신)
	@RequestMapping("/faq/chat/chatReadAjax")
	@ResponseBody
	public Map<String,Object> talkDetailAjax(@RequestParam int chatroom_num,
											 HttpSession session){
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapAjax.put("result", "logout");
		}else {
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("chatroom_num", chatroom_num);
			map.put("mem_num", user.getMem_num());
			List<ChatVO> list = chatService.selectChatDetail(map);
			
			log.debug("<<ChatVO 리스트 >>" + list);
			
			mapAjax.put("result", "success");
			mapAjax.put("list", list);
			mapAjax.put("user_num", user.getMem_num());
		}
		return mapAjax;
	}
	
	
}
