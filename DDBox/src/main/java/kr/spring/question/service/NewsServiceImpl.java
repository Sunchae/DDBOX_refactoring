package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.NewsMapper;
import kr.spring.question.vo.NewsVO;

@Service
@Transactional
public class NewsServiceImpl implements NewsService{
	@Autowired
	NewsMapper newsMapper;
	
	@Override
	public List<NewsVO> selectList(Map<String, Object> map) {
		return newsMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return newsMapper.selectRowCount(map);
	}

	@Override
	public void insertNews(NewsVO news) {
		newsMapper.insertNews(news);
	}

	@Override
	public NewsVO selectNews(int news_num) {
		return newsMapper.selectNews(news_num);
	}

	@Override
	public void updateHit(int news_hit) {
		newsMapper.updateHit(news_hit);
	}

	@Override
	public void updateNews(NewsVO news) {
		newsMapper.updateNews(news);
	}

	@Override
	public void deleteNews(int news_num) {
		newsMapper.deleteNews(news_num);
	}

}
