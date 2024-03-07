package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import kr.spring.question.vo.EmailVO;
import kr.spring.reserve.vo.ScreenVO;

public interface EmailService {
	public List<EmailVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertEmail(EmailVO email);
	public EmailVO selectEmail(int qna_num); //한건의 레코드 반환
	public void updateEmail(EmailVO email);
	public void deleteEmail(int qna_num);
	public void deleteFile(int qna_num); //쓰레기파일 삭제
	
	//관리자
	public List<EmailVO> selectListForAdmin(Map<String,Object> map);
	public int selectRowCountForAdmin(Map<String,Object> map);
	
	public List<ScreenVO> getAllScreens();
}
