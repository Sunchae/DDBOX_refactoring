package kr.spring.reserve.service;

 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.reserve.dao.ScreenMapper;
import kr.spring.reserve.vo.ScreenVO;

@Service  
@Transactional
public class ScreenServieImpl implements ScreenService{
	@Autowired
	private ScreenMapper screenMapper;

	@Override
	public ScreenVO selectedScreen(int scr_num) {
		return screenMapper.selectedScreen(scr_num);
	}
	
}
