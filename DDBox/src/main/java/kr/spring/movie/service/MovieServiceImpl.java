package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.dao.MovieMapper;
import kr.spring.movie.vo.MovieLikeVO;
import kr.spring.movie.vo.MovieVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class MovieServiceImpl implements MovieService{
	@Autowired
	private MovieMapper movieMapper;
	
	@Override
	public List<MovieVO> selectList(Map<String, Object> map) {
		return movieMapper.selectList(map);
	}

	@Override
	public List<MovieVO> selectMovieListWithLikes() {
		return movieMapper.selectMovieListWithLikes();
	}



	@Override
	public MovieVO selectMovie(int movie_num) {
		return movieMapper.selectMovie(movie_num);
	}
	
	@Override
	public List<MovieVO> selectMovieList() {
		return movieMapper.selectMovieList();
	}
	@Override
	public List<MovieVO> selectMainMovieList() {
		return movieMapper.selectMainMovieList();
	}

	@Override
	public void saveMovieDataFromList(List<MovieVO> movieList) {
		log.debug("==============영화 저장 서비스 진입================");
		for (MovieVO movie : movieList) {
			MovieVO vo = movieMapper.selectByMovieNum(movie.getMovie_num());
			if(vo==null) {
				movieMapper.insertMovieData(movie);
			}else {
				log.debug("중복된 데이터 : " + movie.getMovie_num());
			}
			
		}
		
	}

	

	@Override
	public List<MovieVO> selectMoviesByDate(String date) {
		return movieMapper.selectMoviesByDate(date);
	}
	
	
	/*==================================
	 * 영화 좋아요 PART
	 ===================================*/
	 @Override
	    public boolean toggleLike(int mem_num, int movie_num) {
	        // 이미 좋아요를 눌렀는지 확인
	        int result = movieMapper.checkLike(mem_num, movie_num);
			log.debug("<<좋아요 토글 result>>" + result);
			if (result > 0) {
				// 좋아요를 이미 누른 상태 -> 삭제
				movieMapper.deleteLike(mem_num, movie_num);
				return false; // 좋아요 해제 상태로 변경
			} else {
				// 좋아요를 누르지 않았다면 추가
				movieMapper.insertLike(mem_num, movie_num);
				return true; // 좋아요 상태로 변경됨
			}
		}

	    @Override
	    public int countLikes(int movie_num) {
	        return movieMapper.countLikes(movie_num);
	    }



		@Override
		public int checkLike(int mem_num, int movie_num) {
			return movieMapper.checkLike(mem_num, movie_num);
		}

		
		/*==================================
		 * 영화 차트 PART
		 ===================================*/
		@Override
		public Map<String, Object> countLikesByGender(int movie_num) {
			return movieMapper.countLikesByGender(movie_num);
		}

		@Override
		public Map<String, Object> countLikesByAgeGroup(int movie_num) {
			return movieMapper.countLikesByAgeGroup(movie_num);
		}
		/*==================================
		 * 영화 키워드 검색 PART
		 ===================================*/
		@Override
		public List<MovieVO> searchMoviesByKeyword(String keyword) {
			return movieMapper.searchMoviesByKeyword(keyword);
		}



		


	



	
}	
	
	 


