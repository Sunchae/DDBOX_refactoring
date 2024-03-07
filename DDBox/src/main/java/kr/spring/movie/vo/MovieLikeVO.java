package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MovieLikeVO {
	private int movie_num;
	private int mem_num;
	private int like_cnt;
}
