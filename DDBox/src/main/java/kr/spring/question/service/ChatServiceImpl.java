package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.ChatMapper;
import kr.spring.question.vo.ChatVO;
import kr.spring.question.vo.ChatroomVO;

@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired
	ChatMapper chatMapper;

	@Override
	public List<ChatroomVO> selectChatRoomList(Map<String, Object> map) {
		return chatMapper.selectChatRoomList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return chatMapper.selectRowCount(map);
	}

	@Override
	public ChatroomVO checkChatRoom(int user_num) {
		return chatMapper.checkChatRoom(user_num);
	}
	
	@Override
	public ChatroomVO insertChatRoom(ChatroomVO chatroomVO) {
		chatMapper.insertChatRoom(chatroomVO);
		return checkChatRoom(chatroomVO.getUser_num());
	}

	@Override
	public List<ChatroomVO> getChattingListForUser(int mem_num) {
		return chatMapper.getChattingListForUser(mem_num);
	}

	@Override
	public List<ChatroomVO> getChattingListForAdmin(int mem_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getReadCountUser(int mem_num, int chatroom_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getReadCountAdmin(int mem_num, int chatroom_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertChat(ChatVO chat) {
		chatMapper.insertChat(chat);
	}

	@Override
	public List<ChatVO> getChattingListForAdmin(int chatroom_num, int mem_num) {
		return null;
	}

	@Override
	public ChatroomVO getChatroomInfo(int chatroom_num) {
		return chatMapper.getChatroomInfo(chatroom_num);
	}

	@Override
	public List<ChatVO> selectChatDetail(Map<String, Integer> map) {
		
		chatMapper.updateReadCheck(map);
		
		return chatMapper.selectChatDetail(map);
	}




}
