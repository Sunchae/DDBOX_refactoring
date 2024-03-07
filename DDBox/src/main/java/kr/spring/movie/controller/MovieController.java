package kr.spring.movie.controller;

import java.math.BigDecimal;
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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.event.service.EventService;
import kr.spring.event.vo.Event_listVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieVO;
import kr.spring.store.service.StoreService;
import kr.spring.store.vo.StoreVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MovieController {
	    @Autowired
	    private MovieService movieService;
	    @Autowired
		private EventService eventService;
	    @Autowired
		private StoreService storeService;
	    
	    @GetMapping("/main/main")
	    public ModelAndView getMainMovieList() {
	    	
	    	List<MovieVO> movieList = movieService.selectMainMovieList();
	    	log.debug("<<영화 목록 반환 >> : " + movieList);
	    	List<Event_listVO> eventList = eventService.selectMainEvent();
	    	log.debug("<<시작페이지 이벤트 목록 반환 >> : " + eventList);
	    	List<StoreVO> storeList = storeService.selectMainList();
	    
	    	  
	    	ModelAndView mav = new ModelAndView();
	    	mav.setViewName("mainpage");
	    	mav.addObject("movieList", movieList); // 영화 목록 추가
	        mav.addObject("eventList", eventList); // 이벤트 목록 추가
	        mav.addObject("storeList", storeList); // 스토어 목록 추가
	     
	    	
	    	return mav;
	    	
	    }
	    
	    @GetMapping("/movie/main")
	    public ModelAndView getMovieList() {
	    	
	    	List<MovieVO> movieList = movieService.selectMovieListWithLikes();
	    	log.debug("<<영화 목록 반환 >> + " + movieList);
	    	
	    	
	    	ModelAndView mav = new ModelAndView();
	    	mav.setViewName("movieMain");
	    	mav.addObject("list",movieList);
	    	
	        return mav;
	        
	    }
	
	    
	
	  @RequestMapping("/movie/movieDetail") 
	  public String movieDetail(@RequestParam("movie_num") int movie_num, Model model) {
		    MovieVO movie = movieService.selectMovie(movie_num);
		    int likesCount = movieService.countLikes(movie_num); // 좋아요 개수 조회
		    model.addAttribute("movie", movie);
		    model.addAttribute("likesCount", likesCount);
		    return "movieDetail";
		}
	  
	  //좋아요 처리
	  
	  @PostMapping("/movie/checkLikeStatus")
	  @ResponseBody
	  public Map<String, Object> checkLikeStatus(@RequestParam("movie_num") int movie_num, HttpSession session) {
	      Map<String, Object> resultMap = new HashMap<>();
	      MemberVO member = (MemberVO) session.getAttribute("user");
	      if (member == null) {
	          resultMap.put("status", "logout");
	      } else {
	          int isLiked = movieService.checkLike(member.getMem_num(), movie_num);
	          log.debug("<<하트 상태 체크>>" + isLiked);
	          if(isLiked > 0) {
	        	  resultMap.put("status", "liked");
	          }else {
	        	  resultMap.put("status", "notLiked");
	          }
	          
	      }
	      return resultMap;
	  }
	  
	  @PostMapping("/movie/toggleLike")
	  @ResponseBody
	  public Map<String, Object> toggleLike(@RequestParam("movie_num") int movie_num, HttpSession session) {
	      
		  
		  Map<String, Object> resultMap = new HashMap<>();
		 
		  MemberVO member = (MemberVO) session.getAttribute("user");
	      log.debug("<<좋아요 토글 로그인 상태 체크>>" + member);
	      if (member == null) {
	          resultMap.put("status", "logout");
	          resultMap.put("message", "로그인 후 이용할 수 있습니다.");
	          return resultMap;
	      }

	      
	      boolean isLiked = false;
	      int likesCount = 0;
	      
	      // 좋아요 토글 처리를 위한 서비스 호출
	       isLiked = movieService.toggleLike(member.getMem_num(), movie_num);
	       likesCount = movieService.countLikes(movie_num);
	       log.debug("<<isLiked 좋아요 상태>> : " + isLiked);
	       log.debug("<<likesCount 좋아요 개수>> : " + likesCount);
	      resultMap.put("liked", isLiked);
	      resultMap.put("likesCount", likesCount);

	      return resultMap;
	      }
	  
	  //차트 데이터 처리
	  
	  @GetMapping("/movie/likesByAgeGroup")
	  @ResponseBody
	  public Map<String, Object> getLikesByAgeGroup(@RequestParam("movie_num") int movieNum) {
	      Map<String, Object> resultMap = new HashMap<>();
	      try {
	         Map<String, Object> likesByAgeGroupData = movieService.countLikesByAgeGroup(movieNum);
	          resultMap.put("status", "success");
	          resultMap.put("data", likesByAgeGroupData);
	          
	          
	          log.debug("<<영화 데이터 차트 연령대>>" + likesByAgeGroupData);
	      } catch (Exception e) {
	          resultMap.put("status", "error");
	          resultMap.put("message", "Failed to fetch likes by age group data");
	          log.error("Error fetching likes by age group", e);
	      }
	      return resultMap;
	  }
	  
	  @GetMapping("/movie/likesByGender")
	  @ResponseBody
	  public Map<String, Object> getLikesByGender(@RequestParam("movie_num") int movieNum) {
	      Map<String, Object> resultMap = new HashMap<>();
	      try {
	          Map<String, Object> likesByGenderData = movieService.countLikesByGender(movieNum);
	          resultMap.put("status", "success");
	          resultMap.put("data", likesByGenderData);
	       // 남성 좋아요, 여성 좋아요 추출 (BigDecimal에서 Integer로 변환)
	          Integer maleCount = ((BigDecimal) likesByGenderData.get("MALE_COUNT")).intValue();
	          Integer femaleCount = ((BigDecimal) likesByGenderData.get("FEMALE_COUNT")).intValue();
	          resultMap.put("Male", maleCount);
	          resultMap.put("Female", femaleCount);
	          log.debug("<<영화 데이터 차트 성별>>" + likesByGenderData);
	          log.debug("<<성별 데이터 남자 Male>>" + maleCount);
	          log.debug("<<성별 데이터 여자 Female>>" + femaleCount);
	      } catch (Exception e) {
	          resultMap.put("status", "error");
	          resultMap.put("message", "Failed to fetch likes by gender data");
	          log.error("Error fetching likes by gender", e);
	      }
	      return resultMap;
	  }
	  
	  
	  //영화 검색
		@GetMapping("/movie/search")
		@ResponseBody
		public List<MovieVO> searchMovies(@RequestParam("keyword") String keyword) {
			// 검색 서비스를 호출하여 검색 결과 목록을 조회
			List<MovieVO> searchResults = movieService.searchMoviesByKeyword(keyword);
			log.debug("<<searchResults>> : " + searchResults);
			return searchResults; // 검색 결과를 JSON 형태로 반환
		}
	  
	  
}