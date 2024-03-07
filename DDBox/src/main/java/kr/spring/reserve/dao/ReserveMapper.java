package kr.spring.reserve.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

@Mapper
public interface ReserveMapper {
	
	/*====================
	 * 	  	예매 영화
	 ====================*/
	//예매 영화 정보
	  //영화 선택 -> ajax 처리 
	  public MovieVO selectMovie(Map<String, Object> map); 
	  //선택 영화 출력 
	  public MovieVO selectMovieDetail(int movie_num);
	 public String selectScr_name();
	
	
	/*====================
	 * 	  	예매 극장
	 ====================*/
	//예매 극장 정보
	//서울시 극장정보 list
	public List<ScreenVO> selectSeoulList(Map<String,Object> map);
	//극장 목록처리(도)
	public List<ScreenVO> selectScreenList(Map<String,Object> map);
	//극장 선택1(도)
	public int selectMovieDO(Map<String,Object> map);
	
	//극장 목록처리(시)
	public List<ScreenVO> selectScreenSiList(Map<String,Object> map);
	//극장 선택2(시)
	public int selectMovieSI(Map<String,Object> map);
	
	//선택 극장 정보 출력
	public ScreenVO selectScreenDetail(int scr_num);
	
	/*====================
	 * 	 	 예매 시간
	 ====================*/
	//예매 시간 정보
	//예매 정보 출력(날짜)
	public List<ShowVO> selectDateList(Map<String,Object> map);
	//예매 정보 선택(날짜)
	public int selectDate(Map<String,Object> map);
	//예매 정보 출력(시간)
	public List<ShowVO> selectTimeList(Map<String,Object> map);
	//예매 정보 선택(시간)
	public int selectTime(Map<String,Object> map);
	
	//예매 정보 출력
	public ShowVO selectShowDetail(int shw_num);
	
	
	//상영정보 넣기
	public void insertShow(ShowVO board);
	//상영정보 수정
	public void updateShow(ShowVO show);
	//상영정보 삭제
	public void deleteShow(int shw_num);
	
	/*====================
	 * 	   예매 정보 저장
	 ====================*/
	
}
