package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import kr.spring.question.vo.VipVO;

public interface VipService {
	public List<VipVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertVip(VipVO vip);
	public VipVO selectVip(int vip_num); //한건의 레코드 반환
	public void updateVip(VipVO vip);
	public void deleteVip(int vip_num);
}
