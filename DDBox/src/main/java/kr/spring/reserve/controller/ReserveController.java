package kr.spring.reserve.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieVO;
import kr.spring.reserve.service.ReserveService;
import kr.spring.reserve.service.ShowService;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReserveController {

	@Autowired
	private ReserveService reserveService;

	@Autowired
	private MovieService movieService;
	
	@Autowired
	private ShowService showService;

	//자바빈 초기화
	@ModelAttribute 
	public MovieVO initCommand() {
		return new MovieVO();
	}

	@RequestMapping("/reserve/reserveMain")
	public String moive(Model model, HttpSession session) {

		Map<String,Object> map = new HashMap<String,Object>();
		
		List<MovieVO> list =null;
		list = movieService.selectList(map);
		log.debug("개봉 영화 list : " + list);

		List<ScreenVO> list3 = null;
		list3 = reserveService.selectSeoulList(map);

		model.addAttribute("list", list);
		model.addAttribute("list3", list3);

		return "reserveMain";
	}
	
	

	/*====================
	 * 	  예매 영화 목록
	 ====================*/


	/*====================
	 * 	  예매 극장 목록
	 ====================*/


	/*====================
	 * 	  예매 시간 목록
	 ====================*/


}
