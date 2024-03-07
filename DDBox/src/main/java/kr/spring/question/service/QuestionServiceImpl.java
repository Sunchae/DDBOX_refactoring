package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.QuestionMapper;
import kr.spring.question.vo.QuestionVO;

@Service
@Transactional
public class QuestionServiceImpl implements QuestionService{
	@Autowired
	QuestionMapper questionMapper;

	@Override
	public List<QuestionVO> selectList(Map<String, Object> map) {
		return questionMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return questionMapper.selectRowCount(map);
	}

	@Override
	public void insertQuestion(QuestionVO question) {
		questionMapper.insertQuestion(question);
	}

	@Override
	public QuestionVO selectQuestion(int board_num) {
		return questionMapper.selectQuestion(board_num);
	}

	@Override
	public void updateHit(int board_hit) {
		questionMapper.updateHit(board_hit);
	}

	@Override
	public void updateQuestion(QuestionVO question) {
		questionMapper.updateQuestion(question);
	}

	@Override
	public void deleteQuestion(int board_num) {
		questionMapper.deleteQuestion(board_num);
	}

}
