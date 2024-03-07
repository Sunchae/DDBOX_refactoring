package kr.spring.reserve.controller;

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

import kr.spring.movie.vo.MovieVO;
import kr.spring.movie.service.MovieService;
import kr.spring.reserve.service.ReserveService;
import kr.spring.reserve.service.ShowService;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ShowController {
	@Autowired
	private ShowService showService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private ReserveService reserveService;

	/*====================
	 * 	  상영 정보 등록
	 ====================*/
	//자바빈 초기화
	@ModelAttribute
	public ShowVO initCommand() {
		return new ShowVO();
	}

	@GetMapping("/reserve/addReserve")
	public String form(Model model,HttpSession session) {

		Map<String,Object> map = new HashMap<String,Object>();
		
		List<MovieVO> list =null;
		list = movieService.selectList(map);
		log.debug("개봉 영화 list : " + list);
		
		List<ScreenVO> list3 = null;
		list3 = reserveService.selectSeoulList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("list3", list3);

		return "addReserve";
	}

	//전송된 데이터 처리
	@PostMapping("/reserve/addReserve")
	public String submit(@Valid ShowVO showVO, BindingResult result, HttpServletRequest request,HttpSession session,Model model) {
		log.debug("<<상영정보 저장>> : " + showVO);
		if(result.hasErrors()) {
			return "addReserve";
		}

		showService.insertShow(showVO);

		model.addAttribute("message","상영정보가 등록되었습니다");
		model.addAttribute("url",request.getContextPath()+"/reserve/reserveList");

		return "common/resultAlert";
	}

	/*====================
	 * 	  상영 정보 목록
	 ====================*/
	@RequestMapping("/reserve/reserveList")
	public ModelAndView process(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		int count = showService.selectRowShowCount(map);

		log.debug("<<count>> : " + count);
 
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);

		List<ShowVO> list = null;
		if(count>0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = showService.selectShowList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("reserveList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());

		return mav;
	}

}
