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
import kr.spring.question.service.NewsService;
import kr.spring.question.vo.NewsVO;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NewsController {
	@Autowired
	private NewsService newsService;
	
	/*==========================
	 * 공지/뉴스 글 목록
	 *==========================*/
	@RequestMapping("/faq/news")
	public ModelAndView questionprocess(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
										@RequestParam(value="order",defaultValue="1") int order,
										Integer news_category,
										String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("keyword", keyword);
		map.put("news_category", news_category);
		
		//전체,검색 레코드 수
		int count = newsService.selectRowCount(map);
		log.debug("<<글목록 count>> : " + count);
		
		//페이지처리
		PageUtil page;
		if(news_category != null) {
			page = new PageUtil(null, keyword, currentPage, count, 10, 5, "news","&order="+order+"&news_category="+news_category);
		}else {
			page = new PageUtil(null, keyword, currentPage, count, 10, 5, "news","&order="+order);
		}
		
		List<NewsVO> list = null;
		
		if(count > 0) {
		map.put("order", order);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
		list = newsService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("news");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
		}
	

	/*==========================
	 * 공지/뉴스 글 등록
	 *==========================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public NewsVO initCommand() {
		return new NewsVO();
	}	
	
	//등록 폼 호출
	@GetMapping("/faq/news/write")
	public String form() {
		return "news_write";
	}
	
	//글 등록
	@PostMapping("/faq/news/write")
	public String submit(@Valid NewsVO newsVO, BindingResult result,
						 HttpSession session, HttpServletRequest request, Model model) {
		log.debug("<<공지/뉴스 작성 확인>> : " + newsVO);
		
		//유효성 체크 
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호
		MemberVO vo = (MemberVO)session.getAttribute("user");
		newsVO.setMem_num(vo.getMem_num());
		
		//글쓰기
		newsService.insertNews(newsVO);
		
		//view에 표시할 메시지
		model.addAttribute("message", "글 작성이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/news");
		
		return "common/resultAlert";
	}
	
	
	
	
	/*==========================
	 * 글상세 
	 *==========================*/
	@RequestMapping("/faq/news/detail")
	public ModelAndView process(@RequestParam int news_num) {
		log.debug("<<공지 글 상세 news_num>> : " + news_num);
		
		//해당 글 조회수
		newsService.updateHit(news_num);
		NewsVO news = newsService.selectNews(news_num);
		news.setNews_title(StringUtil.useNoHtml(news.getNews_title()));
		
		return new ModelAndView("news_detail", "news", news);//tiles설정명,속성명,속성값
	}
	
	
	/*==========================
	 * 게시판 글 수정
	 *==========================*/
	//수정폼 호출
	@GetMapping("/faq/news/update")
	public String formUpdate(@RequestParam int news_num, Model model) {
		NewsVO newsVO = newsService.selectNews(news_num);
		
		model.addAttribute("newsVO", newsVO);
		
		return "news_update";
	}
	
	//수정 데이터 처리
	@PostMapping("/faq/news/update")
	public String submitUpdate(@Valid NewsVO newsVO, BindingResult result,
							   HttpServletRequest request, Model model) {
		log.debug("<<글 수정>> : " + newsVO);
		
		if(result.hasErrors()) {
			return "news_update";
		}
		
		newsService.updateNews(newsVO);
		
		model.addAttribute("message", "수정 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/news/detail?news_num="+newsVO.getNews_num());
		
		return "common/resultAlert";
	}
	
	
	/*==========================
	 * 게시판 글 삭제
	 *==========================*/
	@RequestMapping("/faq/news/delete")
	public String submitDelete(@RequestParam int news_num, HttpServletRequest request) {
		log.debug("<<질문글 삭제 news_num>> : " + news_num);
		
		newsService.deleteNews(news_num);
		
		return "redirect:/faq/news";
	}
	
	
}
