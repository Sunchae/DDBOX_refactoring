package kr.spring.movie.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieApiController {
	@Autowired
	MovieService movieService;

	@RequestMapping("/movie/movieApi")
	public String getMovieInfo(String[] args) throws IOException, InterruptedException, ParseException {


		//public void fetchAndSaveMovieData() throws IOException, InterruptedException, ParseException {

		//영화 now-playing 리스트 호출 api
		HttpRequest request = HttpRequest.newBuilder()
				.uri(URI.create("https://api.themoviedb.org/3/movie/now_playing?language=ko-KR&page=1&region=KR"))
				.header("accept", "application/json")
				.header("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYTQ0ZjdiYTIyZTdiN2E1YTdkNDFkNmZlYWYzOWNlYSIsInN1YiI6IjY1YWVhODc1YWFkOWMyMDBjYTVhMGY5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QSYL0JwzjYqHZIIl_kZIu9S6ZTo5EAJUyc2FrTSsNMk")
				.method("GET", HttpRequest.BodyPublishers.noBody())
				.build();
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		

		// json형태의 string일 경우
		String jsonData = response.body();
		// reader를 Object로 parse
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(jsonData); 

		// obj를 우선 JSONObject에 담음
		JSONObject jsonMain = (JSONObject)obj;

		// jsonObject에서 jsonArray를 get함
		JSONArray jsonArr = (JSONArray)jsonMain.get("results");



		// jsonArr에서 하나씩 JSONObject로 cast해서 사용
		if (jsonArr.size() > 0){
			List<MovieVO> list = new ArrayList<MovieVO>();
			for(int i=0; i<jsonArr.size(); i++){
				JSONObject jsonObj = (JSONObject)jsonArr.get(i);

				
				MovieVO movie = new MovieVO();

				movie.setMovie_num(Math.toIntExact((Long) jsonObj.get("id")));
				movie.setMovie_title((String) jsonObj.get("title"));
				movie.setMovie_poster((String) jsonObj.get("poster_path"));
				movie.setMovie_original_title((String)jsonObj.get("original_title"));
				movie.setMovie_overview((String)jsonObj.get("overview"));
				movie.setMovie_popularity((Double) jsonObj.get("popularity"));
				
				//release_date를 파싱하여 Date 형태로 변환
				String releaseDateStr = (String) jsonObj.get("release_date");
				Date releaseDate = Date.valueOf(releaseDateStr);
				movie.setMovie_opendate(releaseDate);

				//=========2번쨰 api호출=================
				
				  HttpRequest request2 = HttpRequest.newBuilder() //영화 id
				  .uri(URI.create("https://api.themoviedb.org/3/movie/" + movie.getMovie_num()
				  + "?language=ko-KR")) .header("accept", "application/json")
				  .header("Authorization",
				  "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYTQ0ZjdiYTIyZTdiN2E1YTdkNDFkNmZlYWYzOWNlYSIsInN1YiI6IjY1YWVhODc1YWFkOWMyMDBjYTVhMGY5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QSYL0JwzjYqHZIIl_kZIu9S6ZTo5EAJUyc2FrTSsNMk"
				  ) .method("GET", HttpRequest.BodyPublishers.noBody()) .build();
				  HttpResponse<String> response2 = HttpClient.newHttpClient().send(request2,HttpResponse.BodyHandlers.ofString());
				  
				  
				  String jsonData2 = response2.body(); 
				  // reader를 Object로 parse 
				  JSONParser parser2 = new JSONParser();
				  Object obj2 = parser2.parse(jsonData2);
				  
				  JSONObject jsonObj2 = (JSONObject)obj2;
				  
				 // movie.setMovie_num(Math.toIntExact((Long) jsonObj2.get("id")));
				  movie.setMovie_runtime(Math.toIntExact((Long)jsonObj2.get("runtime")));
				  movie.setMovie_status((String)jsonObj2.get("status"));
				  movie.setMovie_tagline((String)jsonObj2.get("tagline"));
				 
				list.add(movie);
				log.debug("<<List>> :" + list);
				log.debug("<<List size>> :" + list.size());
				
				//log.debug("<<status>> :" + jsonObj2.get("status"));
				
				
			}
			
			movieService.saveMovieDataFromList(list);
			
		}
		
		return "movie/movieApi";
	}
	
	
	
}
