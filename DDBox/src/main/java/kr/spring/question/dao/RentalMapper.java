package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.RentalVO;
import kr.spring.reserve.vo.ScreenVO;

@Mapper
public interface RentalMapper {
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
	@Update("UPDATE rental SET rental_status=#{rental_status} WHERE rental_num=#{rental_num}")
	public void updateRentalStatus(int rental_status, int rental_num);
	
	//영화관
	@Select("SELECT * FROM screen")
	public List<ScreenVO> getAllScreens();
}
