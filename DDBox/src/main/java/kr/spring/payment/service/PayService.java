package kr.spring.payment.service;

import java.util.List;
import java.util.Map;

import kr.spring.payment.vo.PayVO;
import kr.spring.store.vo.StoreVO;

public interface PayService {
	public void insertPay(PayVO pay);
	
	public StoreVO selectPay(int store_num, String store_title , String store_photo);
	
	public StoreVO selectStore(int store_num);
	//기프트샵에 표시될 구매완료된 목록
	public List<PayVO> selectList(Map<String, Object> map);
	
	public int selectRowCount(Map<String, Object> map, int mem_num);
}
