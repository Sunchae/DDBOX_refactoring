package kr.spring.reserve.service;


import kr.spring.reserve.vo.ScreenVO;
import kr.spring.reserve.vo.ShowVO;

public interface ScreenService {
	//극장 선택 
	public ScreenVO selectedScreen(int scr_num);

}
