package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.EmailMapper;
import kr.spring.question.vo.EmailVO;
import kr.spring.reserve.vo.ScreenVO;

@Service
@Transactional
public class EmailServiceImpl implements EmailService{
	@Autowired
	EmailMapper emailMapper;
	
	@Override
	public List<EmailVO> selectList(Map<String, Object> map) {
		return emailMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return emailMapper.selectRowCount(map);
	}

	@Override
	public void insertEmail(EmailVO email) {
		emailMapper.insertEmail(email);
	}

	@Override
	public EmailVO selectEmail(int qna_num) {
		return emailMapper.selectEmail(qna_num);
	}

	@Override
	public void updateEmail(EmailVO email) {
		emailMapper.updateEmail(email);
	}

	@Override
	public void deleteEmail(int qna_num) {
		emailMapper.deleteEmail(qna_num);
	}

	@Override
	public void deleteFile(int qna_num) {
		emailMapper.deleteFile(qna_num);
	}

	/*-------영화관 정보---------*/
	
	@Override
	public List<ScreenVO> getAllScreens() {
		return emailMapper.getAllScreens();
	}

	@Override
	public List<EmailVO> selectListForAdmin(Map<String, Object> map) {
		return emailMapper.selectListForAdmin(map);
	}

	@Override
	public int selectRowCountForAdmin(Map<String, Object> map) {
		return emailMapper.selectRowCountForAdmin(map);
	}

}
