package kr.spring.question.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.EmailService;
import kr.spring.question.vo.EmailVO;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.util.FileUtil;
import kr.spring.util.MailUtil;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EmailController {
	@Autowired
    private JavaMailSender javaMailSender;
	@Autowired
	private EmailService emailService;
	@Autowired
	private MemberService memberService;
	
	
	/*===========================
	 * 이메일 글 목록
	 * ==========================*/
	@RequestMapping("/faq/email")
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
		int count = emailService.selectRowCount(map);
		log.debug("<<이메일 글목록 count>> : " + count);
		
		//페이지처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 10, 5, "list","&order="+order);
		
		
		List<EmailVO> list = null;
		List<ScreenVO> screenList = null;
		
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = emailService.selectList(map);
			screenList = emailService.getAllScreens();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("email");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("screenList", screenList);
		mav.addObject("page", page.getPage());
		
		return mav;
		}
	
	
	//이메일 목록 (관리자)
	@RequestMapping("/faq/email/email_admin")
	public String adminProcess(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
						       @RequestParam(value="order",defaultValue="1") int order,
						       String keyword, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num()); //관리자 인증
		
		//전체,검색 레코드 수
		int count = emailService.selectRowCountForAdmin(map);
		log.debug("<<대관 글목록 count>>" + count);
		
		//페이지 처리
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 10, 5, "list");
		
		List<EmailVO> list = null;
		if(count > 0) {
		map.put("order", order);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
			list = emailService.selectListForAdmin(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "email_admin";
	}

	
	
	
	
	/*==========================
	 * 이메일 문의 글등록
	 *==========================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public EmailVO initCommand() {
		return new EmailVO();
	}
	
	//등록 폼 호출
	@GetMapping("/faq/email/write")
	public String form(Model model) {
		List<ScreenVO> list = emailService.getAllScreens();
		model.addAttribute("list", list);
		
		log.debug("<<영화관 list>> : " + list);
		return "email_write";
	}
	
	//글 등록
	@PostMapping("/faq/email/write")
	public String submit(@Valid EmailVO emailVO, BindingResult result,
						 HttpSession session, HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<이메일 문의 작성>> : " + emailVO);
		
		if(emailVO.getScr_num()!=null && emailVO.getScr_num()==0) {
			emailVO.setScr_num(null);
		}
		
		List<ScreenVO> list = emailService.getAllScreens();
		
		log.debug("<<영화관 list>> : " + list);
		
		//유효성 체크 
		if(result.hasErrors()) {
			for(FieldError error : result.getFieldErrors()) {
				log.debug("<<에러 필드>> : " + error.getField());
			}
			
			model.addAttribute("emailVO", emailVO); // 입력된 데이터를 다시 전달
	        model.addAttribute("list", list); // 영화관 정보를 다시 전달
	        return "email_write";
		}
		
		//회원번호
		MemberVO vo = (MemberVO)session.getAttribute("user");
		emailVO.setMem_num(vo.getMem_num());
		
		//파일업로드
		emailVO.setQuestion_file(FileUtil.createFile(request, emailVO.getUpload()));
		
		log.debug("<<이메일 QNA>> EmailVO : " + emailVO);
		
		//글쓰기
		emailService.insertEmail(emailVO);
		
		//view에 표시할 메시지
		model.addAttribute("message", "문의 작성이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/email");
		model.addAttribute("screens", emailService.getAllScreens());
		
		return "common/resultAlert";
	}

	
	/*==========================
	 * 글상세
	 *==========================*/
	@RequestMapping("/faq/email/detail")
	public ModelAndView detailProcess(@RequestParam int qna_num) {
		log.debug("<<이메일 글 상세 qna_num>> : " + qna_num);
		
		EmailVO email = emailService.selectEmail(qna_num);
		MemberVO member = memberService.selectMember(qna_num); //여기 멤버 이름 나와야되는데 안나오는중....
		
		//제목에 태그 허용 X
		//email.setQna_title(StringUtil.useNoHtml(email.getQna_title()));
		
		return new ModelAndView("email_detail", "email", email);
	}
	
	
	/*===========================
	 * 파일 다운로드
	 * ==========================*/
	@RequestMapping("/faq/email/file")
	public ModelAndView download(@RequestParam int qna_num, HttpServletRequest request) {
		EmailVO email = emailService.selectEmail(qna_num);
		
		byte[] downloadFile = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")+"/"+email.getQuestion_file());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView");
		mav.addObject("downloadFile", downloadFile);
		mav.addObject("filename", email.getQuestion_file());
		
		return mav;
	}
	
	/*==========================
	 * 글수정 (답글 작성) 
	 *==========================*/
	//답글 작성폼 호출
	@GetMapping("/faq/email/update")
	public String formUpdate(@RequestParam int qna_num, Model model) {
		EmailVO emailVO = emailService.selectEmail(qna_num);
		
		model.addAttribute("emailVO", emailVO);
		
		return "email_update";
	}
	
	//수정 데이터 처리 (답글달기)
	@PostMapping("/faq/email/update")
	public String submitUpdate(@Valid EmailVO emailVO, BindingResult result,
							   HttpServletRequest request, Model model) {
		log.debug("<<글 수정>> : " + emailVO);
		
		//유효성 체크 결과 오류가 있으면 폼 재호출
		if(result.hasFieldErrors("ask_content")) {
			return "email_update";
		}   
		
		emailService.updateEmail(emailVO);

		MemberVO member = memberService.selectMember(emailVO.getMem_num());
    	log.debug("<<이메일>> : " + member.getMem_email());
    	MailUtil.send(javaMailSender, member.getMem_email(), "[DDBOX] 문의하신 글에 답변이 등록되었습니다.","안녕하세요, 고객님 :)\n문의하신 글에 답변이 등록되었습니다.\n홈페이지에서 확인 부탁드립니다.");

		model.addAttribute("message", "답변이 등록되었습니다");
		model.addAttribute("url", request.getContextPath()+"/faq/email/detail?qna_num="+emailVO.getQna_num());
		
		return "redirect:/faq/email/email_admin";
	}
	
	
	/*==========================
	 * 글삭제
	 *==========================*/
	@RequestMapping("/faq/email/delete")
	public String submitDelete(@RequestParam int qna_num, HttpServletRequest request) {
		log.debug("<<문의글 삭제 qna_num>> : " + qna_num);
		
		EmailVO db_email = emailService.selectEmail(qna_num);
		
		emailService.deleteEmail(qna_num);
		
		if(db_email.getQuestion_file() != null) {
			FileUtil.removeFile(request, db_email.getQuestion_file());
		}
		return "redirect:/faq/email";
	}
	
	
	
}
