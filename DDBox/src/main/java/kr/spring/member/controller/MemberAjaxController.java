package kr.spring.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberAjaxController {
	@Autowired
	private MemberService memberService;
	/*======================================
	 * 		아이디 중복 체크
	 =======================================*/
	@RequestMapping("/member/confirmId")
	@ResponseBody
	public Map<String,String> process(@RequestParam String mem_id){
		log.debug("<<아이디 중복 체크>> : " + mem_id);
		
		Map<String,String> mapAjax = new HashMap<String, String>();
		
		MemberVO member = memberService.selectCheckMember(mem_id);
		if(member != null) {
			//아이디 중복
			mapAjax.put("result", "idDuplicated");
		}else {
			if(!Pattern.matches("^[A-Za-z0-9]{4,12}$", mem_id)) {
			//패턴 불일치
			mapAjax.put("result", "notMatchPattern");
			}else {
				//패턴 일치하면서 아이디 미중복
				mapAjax.put("result", "idNotFound");
			}
		}
		return mapAjax;
	}
	
	/*==============================
	 * 프로필 사진 업로드
	 *==============================*/
	@RequestMapping("/member/updateMyPhoto")
	@ResponseBody
	public Map<String,String> processProfile(MemberVO memberVO,
			                                 HttpSession session){
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapAjax.put("result", "logout");
		}else {
			memberVO.setMem_num(user.getMem_num());
			memberService.updateProfile(memberVO);
			
			mapAjax.put("result", "success");
		}
		return mapAjax;
	}
	
	/*==============================
	 * 닉네임 변경
	 *==============================*/
	@PostMapping("/member/changeNickname")
	@ResponseBody
	public Map<String, Object> changeNickname(HttpSession session, @RequestParam("nickname") String nickname) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 현재 로그인된 사용자의 정보를 세션에서 가져옵니다.
	        MemberVO currentUser = (MemberVO) session.getAttribute("member");
	        log.debug("<<currentUser>> : " + currentUser);
	        if (currentUser == null) {
	            // 사용자가 로그인되어 있지 않은 경우
	            response.put("success", false);
	            response.put("message", "로그인이 필요한 기능입니다.");
	            return response;
	        }

	        // 닉네임 변경을 위해 MemberVO 객체를 생성하거나, 현재 사용자 객체에 닉네임을 업데이트합니다.
	        currentUser.setMem_nickname(nickname);
	        
	        // 서비스 계층의 닉네임 변경 메소드 호출
	        memberService.changeNickname(currentUser);

	        response.put("success", true);
	        response.put("message", "닉네임이 성공적으로 변경되었습니다.");
	    } catch(Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	        response.put("message", "서버 오류로 인한 닉네임 변경 실패.");
	    }
	    return response;
	}
	
}
























