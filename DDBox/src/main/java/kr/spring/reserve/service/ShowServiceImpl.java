package kr.spring.reserve.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.reserve.dao.ShowMapper;
import kr.spring.reserve.vo.ShowVO;
import kr.spring.reserve.vo.TicketVO;

@Service
@Transactional
public class ShowServiceImpl implements ShowService{
   @Autowired
   private ShowMapper showMapper;

   @Override
   public List<ShowVO> selectShowList(Map<String, Object> map) {
      return showMapper.selectShowList(map);
   }

   @Override
   public int selectRowShowCount(Map<String, Object> map) {
      return showMapper.selectRowShowCount(map);
   }

   @Override
   public void insertShow(ShowVO show) {
      showMapper.insertShow(show);
   }


   @Override
   public void updateShow(ShowVO show) {
      // TODO Auto-generated method stub
      
   }

   @Override
   public void deleteShow(int shw_num) {
      // TODO Auto-generated method stub
      
   } 

   @Override
   public List<ShowVO> selectShowListForRev(int movie_num) {
      return showMapper.selectShowListForRev(movie_num);
   }

   @Override
   public ShowVO selectShow(int movie_num, String scr_name) {
      return showMapper.selectShow(movie_num, scr_name);
   }

   @Override
   public List<ShowVO> selectShowTimeList(int choice_num, int choice_screen, String choice_date) {
      return showMapper.selectShowTimeList(choice_num, choice_screen, choice_date);
   }

   @Override
   public ShowVO selectedTime(int shw_num) {
	   return showMapper.selectedTime(shw_num);
   }

}