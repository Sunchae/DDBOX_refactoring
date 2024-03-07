package kr.spring.email.message;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.validation.constraints.Email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.EmailService;
import kr.spring.question.vo.EmailVO;
import kr.spring.util.MailUtil;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class MailController {

    @Autowired
    private JavaMailSender javaMailSender;
	@Autowired
	private MemberService memberService;
	@Autowired
	private EmailService emailService;
    @GetMapping("/send")
    public ResponseEntity<Object> send(EmailVO emailVO, HttpServletRequest request, Model model) {
    	
    	log.debug("<< 메일 api 정상 작동 >>");
    	
    	
    	//1. 변수 설정
    	//MemberVO member = memberService.selectMember(emailVO.getMem_num());
    	//log.debug("<<이메일>> : " + member.getMem_email());
    	//MailUtil.send(javaMailSender, member.getMem_email(), "[DDBOX'] 문의하신 글에 답변이 등록되었습니다.","안녕하세요, 고객님 :)\n문의하신 글에 답변이 등록되었습니다.\n 확인 url: <a href=\"http://localhost:8000/main/main\">홈페이지</a>");
    	
    	//2. 이메일 발신될 데이터 적재
        MailUtil.send(javaMailSender, "star_sh0620@naver.com", 
        	"[DDBOX] 문의하신 글에 답변이 등록되었습니다.", "안녕하세요, 고객님 :) \n문의하신 글에 답변이 등록되었습니다. \n 홈페이지에서 확인 부탁드립니다.");

 	   // 결과 반환
       return ResponseEntity.ok("답변 작성 완료 메일이 전송되었습니다");
    }
    
}