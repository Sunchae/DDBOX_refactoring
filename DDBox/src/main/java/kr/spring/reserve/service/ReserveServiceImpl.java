package kr.spring.reserve.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.vo.MovieVO;
import kr.spring.reserve.dao.ReserveMapper;
import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

@Service
@Transactional
public class ReserveServiceImpl implements ReserveService{
	@Autowired
	private ReserveMapper reserveMapper;

	@Override
	public List<ScreenVO> selectSeoulList(Map<String, Object> map) {
		return reserveMapper.selectSeoulList(map);
	}

	


	
	
	
}
