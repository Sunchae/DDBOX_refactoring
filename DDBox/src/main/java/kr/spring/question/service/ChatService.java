package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import kr.spring.question.vo.ChatVO;
import kr.spring.question.vo.ChatroomVO;

public interface ChatService {
	//채팅방 목록
		public List<ChatroomVO> selectChatRoomList(Map<String,Object> map);
		public int selectRowCount(Map<String,Object> map);

		//채팅방 유무 체크
		public ChatroomVO checkChatRoom(int user_num);
		//채팅방 생성
		public ChatroomVO insertChatRoom(ChatroomVO chatroomVO);
		
		//회원 채팅방 입장
		public List<ChatroomVO> getChattingListForUser(int mem_num);
		
		//회원 read count 개수
		public int getReadCountUser(int mem_num, int chatroom_num);
		//관리자 read count 개수
		public int getReadCountAdmin(int mem_num, int chatroom_num);
		//채팅 메시지 입력
		public void insertChat(ChatVO chat);
		//채팅 메시지 읽기
		public List<ChatVO> selectChatDetail(Map<String,Integer> map);
		
		//채팅방 정보 읽어오기
		public ChatroomVO getChatroomInfo(int chatroom_num);
		//채팅 목록 불러오기 (관리자)
		public List<ChatVO> getChattingListForAdmin(int chatroom_num, int mem_num);
		//관리자 채팅방 입장 ?????
		public List<ChatroomVO> getChattingListForAdmin(int mem_num);
}
