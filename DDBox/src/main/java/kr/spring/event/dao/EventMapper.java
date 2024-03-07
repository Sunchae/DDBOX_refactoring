package kr.spring.event.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.event.vo.Rentry_listVO;
import kr.spring.event.vo.Entry_listVO;
import kr.spring.event.vo.Event_listVO;

@Mapper
public interface EventMapper {
	//이벤트 글 등록
	public List<Event_listVO> selectList(Map<String,Object> map);//이벤트 전체 목록/검색 목록
	public int selectRowCount(Map<String,Object> map);//이벤트 글의 총개수/검색 개수
	public void insertEvent(Event_listVO event);//이벤트 글등록
	public Event_listVO selectEvent(int event_num);//이벤트 글상세
	public void updateEvent(Event_listVO event);//이벤트 글수정
	//public void deleteEvent(int event_num);//이벤트 글 삭제
	//public void deleteFile(int event_num);//특정 경로의 파일 올렸을때 삭제(filename을 event_photo1,2)
	@Update("UPDATE event_list SET hit=hit+1 WHERE event_num=#{event_num}")
	public void updateHit(int event_num);//조회수
	
	//메인페이지
	@Select("SELECT * FROM (SELECT * FROM event_list ORDER BY hit DESC) WHERE ROWNUM<=4")
	public List<Event_listVO> selectMainEvent();//MainPage 이벤트
	
	//룰렛 참여자 리스트
	//public List<Rentry_listVO> selectRentryList(Map<String,Object> map);//룰렛 이벤트 참여자 리스트 목록
	public void insertRentry(Rentry_listVO rentry);//이벤트 참여자 등록
	public Rentry_listVO selectRentry(int rentry_num);//참여자 등록 상세
	public Rentry_listVO selectRentryEvent(int mem_num);//이벤트에 참여여부(수정)
	
	//응모권 참여자
	public List<Entry_listVO> selectEntryList(Map<String,Object> map);//맴버별 참여 이벤트 목록
	public void insertEntry(Entry_listVO entry);//응모권 이벤트 참여자 등록
	public void updateEntryAdmin(Entry_listVO entry);//관리자 이벤트 참여타입 변경
	public List<Entry_listVO> winnerEntry(int entry_num);//당첨자 리스트
	public List<Entry_listVO> selectEntry(Map<String,Object> map,int event_num);//응모권 이벤트 참여자 상세
	public Entry_listVO selectEntryEvent(int event_num,int mem_num);//이벤트 참여했는지 
	
	//이벤트 추첨 후 처리
	public void updateEventStatus(int evnet_num);//이벤트 스테이터스 값 변경
	public void updateWinType(int event_num,int mem_num);//담청자 타입 변경
}
