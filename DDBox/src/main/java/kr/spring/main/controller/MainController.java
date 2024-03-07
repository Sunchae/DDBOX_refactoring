package kr.spring.main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	@RequestMapping("/")
	public String init(HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//관리자로 로그인하면 관리자 메인으로 이동 처리
		if(user!=null && user.getMem_auth() == 9) {
			return "redirect:/member/AdminPageMain";
		}
		return "redirect:/main/main";
	}
	
	@RequestMapping("/main/main")
	public String main(Model model) {
		
		log.debug("<<메인 실행>>");
		
		return "mainpage";//타일스 설정명
	}
	@RequestMapping("/member/AdminPageMain")
	public String admin(Model model) {
		
		log.debug("<<관리자 메인 실행>>");
		
		return "admin";//타일스 설정명
	}
	@RequestMapping("/movie/main")
	public String movie(Model model) {
		
		log.debug("<<관리자 메인 실행>>");
		
		return "movieMain";//타일스 설정명
	}
}






