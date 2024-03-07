package kr.spring.reserve.service;

import java.util.List;
import java.util.Map;

import kr.spring.movie.vo.MovieVO;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

public interface ReserveService {
	
	public List<ScreenVO> selectSeoulList(Map<String,Object> map);
}
