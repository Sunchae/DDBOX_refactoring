package kr.spring.reserve.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieVO;
import kr.spring.reserve.service.ReserveService;
import kr.spring.reserve.service.ScreenService;
import kr.spring.reserve.service.ShowService;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReserveAjaxController {
   @Autowired
   private ReserveService reserveService;
   
   @Autowired
   private MovieService movieService;
   
   @Autowired
   private ShowService showService;
   
   @Autowired
   private ScreenService screenService;
   
   
   /*=============================
    *       영화   
    ============================*/
   @RequestMapping("/reserve/getMovie")
   @ResponseBody
   public Map<String,Object> getMovie(@RequestParam int movie_num, HttpSession session){
      log.debug("<<영화 등록/삭제>> : "+ movie_num);

      Map<String,Object> mapJson = new HashMap<String, Object>();
      
      
      //영화 번호로 가져오는 파트
      MovieVO movieVO = movieService.selectMovie(movie_num);
      
      List<ShowVO> showVO = showService.selectShowListForRev(movie_num);
      
      

      if(movieVO != null) {
         mapJson.put("status", "yesMovie");
      }else {
         mapJson.put("status", "noMovie");
      }
      mapJson.put("movieVO", movieVO);
      mapJson.put("list", showVO);
      
      mapJson.put("result", "success");
      

      return mapJson;
   }

   @RequestMapping("/reserve/getMoviesByDate")
   @ResponseBody
   public Map<String,Object> getMoviesByDate(@RequestParam String date, HttpSession session) {
       log.debug("<<날짜별 영화 목록 조회>> : " + date);
       Map<String,Object> mapJson = new HashMap<String, Object>();
       // 해당 날짜에 상영하는 영화 목록을 가져오는 서비스 메서드 호출
       List<MovieVO> movielist = movieService.selectMoviesByDate(date);
       
       mapJson.put("movielist", movielist);
       return mapJson; 
   }
   @RequestMapping("/reserve/getScreen")
   @ResponseBody
   public Map<String,Object> getScreen(@RequestParam int scr_num, HttpSession session) {
      log.debug("<<선택한 극장>> : " + scr_num);
      Map<String,Object> mapJson = new HashMap<String, Object>();
      // 해당 날짜에 상영하는 영화 목록을 가져오는 서비스 메서드 호출
      ScreenVO screen = screenService.selectedScreen(scr_num);
      
      mapJson.put("screen", screen);
      return mapJson;
   }
   
   @RequestMapping("/reserve/getTime")
   @ResponseBody
   public Map<String,Object> getTime(@RequestParam int shw_num,HttpSession session){
	   log.debug("<<선택한 시간>> : " + shw_num);
	   Map<String,Object> mapJson = new HashMap<String, Object>();
	   
	   ShowVO selectedTime = showService.selectedTime(shw_num);
	   
	   mapJson.put("selectedTime", selectedTime);
	   return mapJson;
   }
   
   
   @RequestMapping("/reserve/getMovieSchedule")
   @ResponseBody
   public Map<String, Object> getMovieSchedule(@RequestParam int choice_num, @RequestParam int choice_screen, @RequestParam String choice_date, HttpSession session) {
       log.debug("<<상영 시간표 조회>> : choice_num=" + choice_num + ", choice_screen=" + choice_screen + ", choice_date=" + choice_date);
       
       // 해당 조건에 맞는 상영 시간표를 가져오는 서비스 메서드 호출
       List<ShowVO> scheduleList = showService.selectShowTimeList(choice_num, choice_screen, choice_date);

       Map<String, Object> mapJson = new HashMap<>();
       mapJson.put("scheduleList", scheduleList);
       return mapJson;
   }
   
   
   
   
}











