package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.VipMapper;
import kr.spring.question.vo.VipVO;

@Service
@Transactional
public class VipServiceImpl implements VipService{
	@Autowired
	VipMapper vipMapper;
	
	@Override
	public List<VipVO> selectList(Map<String, Object> map) {
		return vipMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return vipMapper.selectRowCount(map);
	}

	@Override
	public void insertVip(VipVO vip) {
		vipMapper.insertVip(vip);
	}

	@Override
	public VipVO selectVip(int vip_num) {
		return vipMapper.selectVip(vip_num);
	}

	@Override
	public void updateVip(VipVO vip) {
		vipMapper.updateVip(vip);
	}

	@Override
	public void deleteVip(int vip_num) {
		vipMapper.deleteVip(vip_num);
	}

}
