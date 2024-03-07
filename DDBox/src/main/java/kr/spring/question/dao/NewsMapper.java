package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.NewsVO;

@Mapper
public interface NewsMapper {
	public List<NewsVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertNews(NewsVO news);
	public NewsVO selectNews(int news_num); //한건의 레코드 반환
	@Update("UPDATE news SET news_hit=news_hit+1 WHERE news_num=#{news_num}")
	public void updateHit(int news_hit);
	public void updateNews(NewsVO news);
	@Delete("DELETE FROM news WHERE news_num=#{news_num}")
	public void deleteNews(int news_num);
}
