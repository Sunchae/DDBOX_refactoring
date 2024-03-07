package kr.spring.reserve.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieVO;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

@Mapper
public interface TicketMapper {
	//예매 인원 티켓 가격 insert 
	@Insert("INSERT INTO ticket (res_num,res_mem_total,res_pay,mem_num,shw_num,scr_num,movie_num,res_regdate) VALUES (ticket_seq.nextval,#{res_mem_total},#{res_pay},#{mem_num},#{shw_num},#{scr_num},#{movie_num},SYSDATE)")
	public void insertTicket(TicketVO ticket);
	
	public List<TicketVO> selectList(Map<String, Object> map);
	
	//public int selectRowCount(Map<String, Object> map);
	
	
	@Select("SELECT movie_title,scr_name,shw_time FROM show LEFT OUTER JOIN (SELECT * FROM screen) USING(scr_num) LEFT OUTER JOIN (SELECT * FROM movie) USING(movie_num)WHERE movie_num= #{choice_num} AND scr_num = #{choice_screen} AND shw_num=#{choice_time}")
	public ShowVO selectTicket(int choice_num,int choice_screen,int choice_time);
	
	@Select("SELECT movie_num, movie_title FROM movie WHERE movie_num=#{choice_num} ")
	public MovieVO selectedMoive(int choice_num);
	
	@Select("SELECT scr_num, scr_name FROM screen WHERE scr_num=#{choice_screen}")
	public ScreenVO selectedScreen(int choice_screen);
	
	@Select("SELECT shw_num, shw_time FROM show WHERE shw_num=#{choice_time}")
	public ShowVO selectedShow(int choice_time);
	
	@Select("SELECT res_num, res_mem_total FROM ticket WHERE res_mem_total=#{choice_people}")
	public TicketVO selectedPPL(int choice_people);
	
	@Select("SELECT res_num, res_pay FROM ticket WHERE res_pay=#{choice_price}")
	public TicketVO selectedPrice(int choice_price);
	
	@Select("SELECT * FROM ticket WHERE res_num=#{res_num}")
	public TicketVO selectTicketInfo(int res_num);
}
