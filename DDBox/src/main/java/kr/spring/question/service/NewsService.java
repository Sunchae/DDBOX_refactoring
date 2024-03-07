package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import kr.spring.question.vo.NewsVO;

public interface NewsService {
	public List<NewsVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertNews(NewsVO news);
	public NewsVO selectNews(int news_num); //한건의 레코드 반환
	public void updateHit(int news_hit);
	public void updateNews(NewsVO news);
	public void deleteNews(int news_num);
}
