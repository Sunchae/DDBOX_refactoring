package kr.spring.reserve.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;

import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

public interface ShowService {
   //예매 리스트
   public List<ShowVO> selectShowList(Map<String,Object> map);
   public int selectRowShowCount(Map<String,Object> map);
 
   //예매 등록
   public void insertShow(ShowVO show);
   //한건의 예매 읽기
   public ShowVO selectShow(int movie_num, String scr_name);
   
   public List<ShowVO> selectShowListForRev(int movie_num);

   //예매 수정
   public void updateShow(ShowVO show);
   //예매 삭제
   @Delete("DELETE FROM show WHERE shw_num=#{shw_num}")
   public void deleteShow(int shw_num);
   
   
   //상영시간 호출
   public List<ShowVO> selectShowTimeList(int choice_num, int choice_screen, String choice_date);
      
   
   public ShowVO selectedTime(int shw_num);
}