package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;

import kr.spring.question.vo.VipVO;

@Mapper
public interface VipMapper {
	public List<VipVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertVip(VipVO vip);
	public VipVO selectVip(int vip_num); //한건의 레코드 반환
	public void updateVip(VipVO vip);
	@Delete("DELETE FROM vip_faq WHERE vip_num=#{vip_num}")
	public void deleteVip(int vip_num);
}
