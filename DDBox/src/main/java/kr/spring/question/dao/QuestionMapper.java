package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.QuestionVO;

@Mapper
public interface QuestionMapper {
	public List<QuestionVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertQuestion(QuestionVO question);
	public QuestionVO selectQuestion(int board_num); //한건의 레코드 반환
	@Update("UPDATE question_board SET board_hit=board_hit+1 WHERE board_num=#{board_num}")
	public void updateHit(int board_hit);
	public void updateQuestion(QuestionVO question);
	@Delete("DELETE FROM question_board WHERE board_num=#{board_num}")
	public void deleteQuestion(int board_num);
}
