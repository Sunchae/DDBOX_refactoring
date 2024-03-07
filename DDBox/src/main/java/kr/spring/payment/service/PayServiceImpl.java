package kr.spring.payment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.payment.dao.PayMapper;
import kr.spring.payment.vo.PayVO;
import kr.spring.store.vo.StoreVO;

@Service
@Transactional
public class PayServiceImpl implements PayService{
	@Autowired
	private PayMapper payMapper;
	
	@Override
	public void insertPay(PayVO pay) {
		payMapper.insertPay(pay);
	}

	@Override
	public StoreVO selectPay(int store_num, String store_title, String store_photo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StoreVO selectStore(int store_num) {
		return payMapper.selectStore(store_num);
	}

	@Override
	public List<PayVO> selectList(Map<String, Object> map) {
		
		return payMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map, int mem_num) {
		return payMapper.selectRowCount(map, mem_num);
	}

}
