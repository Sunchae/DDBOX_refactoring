package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;

import kr.spring.question.vo.RentalVO;
import kr.spring.reserve.vo.ScreenVO;

public interface RentalService {
	public List<RentalVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//관리자
	public List<RentalVO> selectListForAdmin(Map<String,Object> map);
	public int selectRowCountForAdmin(Map<String,Object> map);
	
	public void insertRental(RentalVO rental);
	public RentalVO selectRental(int rental_num);
	public void updateRental(RentalVO rental);
	@Delete("DELETE FROM rental WHERE rental_num=#{rental_num}")
	public void deleteRental(int rental_num);
	
	//상태 변경
	public void updateRentalStatus(int rental_status, int rental_num);
	
	public List<ScreenVO> getAllScreens();
}
