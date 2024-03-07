package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.EmailVO;
import kr.spring.reserve.vo.ScreenVO;

@Mapper
public interface EmailMapper {
	public List<EmailVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//관리자
	public List<EmailVO> selectListForAdmin(Map<String,Object> map);
	public int selectRowCountForAdmin(Map<String,Object> map);
	
	public void insertEmail(EmailVO email);
	public EmailVO selectEmail(int qna_num); //한건의 레코드 반환
	public void updateEmail(EmailVO email);
	@Delete("DELETE FROM email_faq WHERE qna_num=#{qna_num}")
	public void deleteEmail(int qna_num);
	@Update("UPDATE email_faq SET question_file='' WHERE qna_num=#{qna_num}")
	public void deleteFile(int qna_num);
	
	//영화관 
	@Select("SELECT * FROM screen")
	public List<ScreenVO> getAllScreens();
}
