package kr.spring.reserve.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.vo.MovieVO;
import kr.spring.reserve.dao.ShowMapper;
import kr.spring.reserve.dao.TicketMapper;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

@Service
@Transactional
public class TicketServiceImpl implements TicketService{
	
	@Autowired
	private TicketMapper ticketMapper;
	
	@Override
	public void insertTicket(TicketVO ticket) {
		ticketMapper.insertTicket(ticket);
	}

	@Override
	public ShowVO selectTicket(int choice_num, int choice_screen, int choice_time) {
		return ticketMapper.selectTicket(choice_num, choice_screen, choice_time);
	}

	@Override
	public MovieVO selectedMoive(int choice_num) {
		return ticketMapper.selectedMoive(choice_num);
	}

	@Override 
	public ScreenVO selectedScreen(int choice_screen) {
		return ticketMapper.selectedScreen(choice_screen);
	}

	@Override
	public ShowVO selectedShow(int choice_time) {
		return ticketMapper.selectedShow(choice_time);
	}

	@Override
	public TicketVO selectedPPL(int choice_people) {
		return ticketMapper.selectedPPL(choice_people);
	}

	@Override
	public TicketVO selectedPrice(int choice_price) {
		return ticketMapper.selectedPrice(choice_price);
	}

	@Override
	public TicketVO selectTicketInfo(int res_num) {
		return ticketMapper.selectTicketInfo(res_num);
	}

	@Override
	public List<TicketVO> selectList(Map<String, Object> map) {
		return ticketMapper.selectList(map);
	}

	
	

}
