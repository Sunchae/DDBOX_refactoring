package kr.spring.store.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.store.vo.StoreVO;

@Mapper
public interface StoreMapper {
	@Select("SELECT store_num,store_title,store_content,store_price,store_photo FROM store")
	public List<StoreVO> selectList(Map<String, Object> map);
	
	@Select("SELECT COUNT(*) FROM store WHERE store_type=#{store_type}")
	public int selectRowCount(Map<String, Object> map, int store_type);
	
	public void insertStore(StoreVO store);							//xml
	@Select("SELECT * FROM store JOIN member USING(mem_num) WHERE store_num=#{store_num}")
	public StoreVO selectStore(int store_num);						
	
	public void updateStore(StoreVO store);							//xml
	
	@Delete("DELETE FROM store WHERE store_num=#{store_num}")
	public void deleteStore(int store_num);
	
	@Update("UPDATE store SET store_photo='' WHERE store_num=#{store_num}")
	public void deleteFile(int store_num);
	
	@Select("SELECT * FROM (SELECT * FROM store ORDER BY store_num DESC) WHERE ROWNUM <= 4")
	public List<StoreVO> selectMainList();
	
	public List<StoreVO> selectTicketList(Map<String, Object> map);
	
	public List<StoreVO> selectPopcornList(Map<String, Object> map);
	
	@Select("SELECT store_num,store_title,store_content,store_price,store_photo FROM (SELECT * FROM store WHERE store_type=0 ORDER BY store_num DESC) WHERE ROWNUM <= 4")
	public List<StoreVO> selectMainTicketList();
	
	@Select("SELECT store_num,store_title,store_content,store_price,store_photo FROM (SELECT * FROM store WHERE store_type=1 ORDER BY store_num DESC) WHERE ROWNUM <= 4")
	public List<StoreVO> selectMainPopcornList();
	
	
}
