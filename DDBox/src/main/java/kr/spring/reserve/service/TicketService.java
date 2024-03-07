package kr.spring.reserve.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieVO; 
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

public interface TicketService {
	public void insertTicket(TicketVO ticket);
	
	public List<TicketVO> selectList(Map<String, Object> map);
	
	public ShowVO selectTicket(int choice_num,int choice_screen,int choice_time);
	
	public MovieVO selectedMoive(int choice_num);
	
	public ScreenVO selectedScreen(int choice_screen);
	
	public ShowVO selectedShow(int choice_time);
	
	public TicketVO selectedPPL(int choice_people);
	
	public TicketVO selectedPrice(int choice_price);
	
	public TicketVO selectTicketInfo(int res_num);
}
