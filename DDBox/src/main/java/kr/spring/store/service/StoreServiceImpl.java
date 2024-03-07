package kr.spring.store.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.store.dao.StoreMapper;
import kr.spring.store.vo.StoreVO;

@Service
@Transactional
public class StoreServiceImpl implements StoreService{
	@Autowired
	private StoreMapper storeMapper;

	@Override
	public List<StoreVO> selectList(Map<String, Object> map) {
		return storeMapper.selectList(map);
	}

	@Override
	public void insertStore(StoreVO store) {
		storeMapper.insertStore(store);
	}

	@Override
	public StoreVO selectStore(int store_num) {
		return storeMapper.selectStore(store_num);
	}

	@Override
	public void updateStore(StoreVO store) {
		storeMapper.updateStore(store);
	}

	@Override
	public void deleteStore(int store_num) {
		storeMapper.deleteStore(store_num);
	}

	@Override
	public int selectRowCount(Map<String, Object> map, int store_type) {
		return storeMapper.selectRowCount(map, store_type);
	}

	@Override
	public void deleteFile(int store_num) {
		storeMapper.deleteFile(store_num);
	}

	@Override
	public List<StoreVO> selectMainList() {
		return storeMapper.selectMainList();
	}

	@Override
	public List<StoreVO> selectTicketList(Map<String, Object> map) {
		return storeMapper.selectTicketList(map);
	}

	@Override
	public List<StoreVO> selectPopcornList(Map<String, Object> map) {
		return storeMapper.selectPopcornList(map);
	}

	@Override
	public List<StoreVO> selectMainTicketList() {
		return storeMapper.selectMainTicketList();
	}

	@Override
	public List<StoreVO> selectMainPopcornList() {
		return storeMapper.selectMainPopcornList();
	}

}
