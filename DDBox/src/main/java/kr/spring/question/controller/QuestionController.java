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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.QuestionService;
import kr.spring.question.vo.QuestionVO;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class QuestionController {
	@Autowired
	private QuestionService questionService;
	
	/*==========================
	 * 메인페이지 
	 *==========================*/
	@RequestMapping("/faq/main")
	public String process() {
		return "faqMain";
	}
	
	
	
	/*==========================
	 * 자주묻는 질문 글 목록
	 *==========================*/
	@RequestMapping("/faq/question")
	public ModelAndView questionprocess(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
										@RequestParam(value="order",defaultValue="1") int order,
										 Integer board_category,
										String keyword) {
		
		Map<String,Object> map = new HashMap<>();
		
		map.put("keyword", keyword);
		map.put("board_category", board_category);
		
		//전체,검색 레코드 수
		int count = questionService.selectRowCount(map);
		log.debug("<<글목록 count>> : " + count);

		PageUtil page;
		//페이지처리
		if(board_category != null) {
			page = new PageUtil(null, keyword, currentPage, count, 10, 5, "question","&order="+order+"&board_category="+board_category);
			
		} else {
			page =  new PageUtil(null, keyword, currentPage, count, 10, 5, "question","&order="+order);
		}
		
		List<QuestionVO> list = null;
		
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = questionService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("faq_question");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	

	
	/*==========================
	 * 자주묻는 질문 글 등록
	 *==========================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public QuestionVO initCommand() {
		return new QuestionVO();
	}
	
	//등록 폼 호출
	@GetMapping("/faq/question/write")
	public String form() {
		return "question_write";
	}
	
	//글 등록
	@PostMapping("/faq/question/write")
	public String submit(@Valid QuestionVO questionVO, BindingResult result,
						 HttpSession session, HttpServletRequest request, Model model) {
		log.debug("<<자주묻는 질문 글 작성 확인>> : " + questionVO);
		
		//유효성 체크 
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호
		MemberVO vo = (MemberVO)session.getAttribute("user");
		questionVO.setMem_num(vo.getMem_num());
		
		//글쓰기
		questionService.insertQuestion(questionVO);
		
		//view에 표시할 메시지
		model.addAttribute("message", "글 작성이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/question");
		
		return "common/resultAlert";
	}
	
	
	
	
	/*==========================
	 * 게시판 글상세 
	 *==========================*/
	@RequestMapping("/faq/question/detail")
	public ModelAndView process(@RequestParam int board_num) {
		log.debug("<<게시판 글 상세 board_num>> : " + board_num);
		
		//해당 글 조회수 +
		questionService.updateHit(board_num);
		QuestionVO question = questionService.selectQuestion(board_num);
		question.setBoard_title(StringUtil.useNoHtml(question.getBoard_title()));
		
		return new ModelAndView("question_detail", "question", question);//tiles설정명,속성명,속성값
	}
	


	/*==========================
	 * 게시판 글 수정
	 *==========================*/
	//수정폼 호출
	@GetMapping("/faq/question/update")
	public String formUpdate(@RequestParam int board_num, Model model) {
		QuestionVO questionVO = questionService.selectQuestion(board_num);
		
		model.addAttribute("questionVO", questionVO);
		
		return "question_update";
	}
	
	//수정 데이터 처리
	@PostMapping("/faq/question/update")
	public String submitUpdate(@Valid QuestionVO questionVO, BindingResult result,
							   HttpServletRequest request, Model model) {
		log.debug("<<글 수정>> : " + questionVO);
		
		if(result.hasErrors()) {
			return "question_update";
		}
		
		questionService.updateQuestion(questionVO);
		
		model.addAttribute("message", "수정 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/question/detail?board_num="+questionVO.getBoard_num());
		
		return "common/resultAlert";
	}
	
	
	/*==========================
	 * 게시판 글 삭제
	 *==========================*/
	@RequestMapping("/faq/question/delete")
	public String submitDelete(@RequestParam int board_num, HttpServletRequest request) {
		log.debug("<<질문글 삭제 board_num>> : " + board_num);
		
		questionService.deleteQuestion(board_num);
		
		return "redirect:/faq/question";
	}
	
	
}
