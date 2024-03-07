package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieLikeVO;
import kr.spring.movie.vo.MovieVO;


public interface MovieService {
	//영화 데이터 삽입
	void saveMovieDataFromList(List<MovieVO> movieList);
	
	//영화 리스트 뽑기
	public List<MovieVO> selectList(Map<String, Object> map);
	public List<MovieVO> selectMovieList();
	public List<MovieVO> selectMovieListWithLikes();
	public List<MovieVO> selectMainMovieList();
	public MovieVO selectMovie(int movie_num);
	public List<MovieVO> selectMoviesByDate(String date);
	//영화 좋아요 처리 
	public int checkLike(int mem_num, int movie_num);
	public boolean toggleLike(int mem_num, int movie_num);
	public int countLikes(int movie_num);
	

	//영화 데이터 차트
	// 성별에 따른 좋아요 수 조회
    public Map<String, Object> countLikesByGender(int movie_num);
    // 연령대별 좋아요 수 조회
    public Map<String, Object> countLikesByAgeGroup(int movie_num);
    
  //영화검색
    public List<MovieVO> searchMoviesByKeyword(String keyword);
}
