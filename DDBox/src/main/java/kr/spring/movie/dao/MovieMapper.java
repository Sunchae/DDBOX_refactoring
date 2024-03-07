package kr.spring.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieLikeVO;
import kr.spring.movie.vo.MovieVO;

@Mapper
public interface MovieMapper {
	//영화 데이터 삽입
	public void insertMovieData(MovieVO movie);
	//영화 데이터 2차 삽입(정보 업데이트)
	public void updateMovieData(MovieVO movie);
	
	
	//movie pk 겹치는지 확인
	@Select("SELECT * FROM movie WHERE movie_num = #{movie_num}")
	public MovieVO selectByMovieNum(int movie_num);
	
	//영화 리스트 뽑기
	@Select("SELECT * FROM (SELECT * FROM movie ORDER BY movie_popularity DESC) WHERE ROWNUM <= 10")
	public List<MovieVO> selectList(Map<String, Object> map);
	//예매페이지 날짜 선택 후 영화 리스트 뽑기 
	public List<MovieVO> selectMoviesByDate(String date);
	
	
	

	@Select("SELECT * FROM (SELECT * FROM movie ORDER BY movie_popularity DESC) WHERE ROWNUM <= 10")
	public List<MovieVO> selectMovieList();
	@Select("SELECT * FROM (SELECT * FROM movie ORDER BY movie_popularity DESC) WHERE ROWNUM <= 3")
	public List<MovieVO> selectMainMovieList();
	@Select("SELECT * FROM movie WHERE movie_num=#{movie_num}")
	public MovieVO selectMovie(int movie_num);
	
	public List<MovieVO> selectMovieListWithLikes();
	
	
	//영화 좋아요 삽입 

	@Select("SELECT count(*) FROM movie_fav WHERE mem_num=#{mem_num} AND movie_num=#{movie_num}")
	public int checkLike(int mem_num, int movie_num);
	@Insert("INSERT INTO movie_fav (mem_num, movie_num) VALUES (#{mem_num},#{movie_num})")
	public void insertLike(int mem_num, int movie_num);
	@Delete("DELETE FROM movie_fav WHERE mem_num=#{mem_num} AND movie_num=#{movie_num}")
	public void deleteLike(int mem_num, int movie_num);
	@Select("SELECT count(*) FROM movie_fav WHERE movie_num=#{movie_num}")
	public int countLikes(int movie_num);
	
	//영화 데이터 차트
	// 성별에 따른 좋아요 수 조회
    public Map<String, Object> countLikesByGender(int movie_num);
    // 연령대별 좋아요 수 조회
    public Map<String, Object> countLikesByAgeGroup(int movie_num);
		
	
	//영화검색
    public List<MovieVO> searchMoviesByKeyword(String keyword);
    	
    
}




