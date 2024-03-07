package kr.spring.movie.controller;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class MovieTest2 {
	
	
	
		
	public static void main(String[] args) throws Exception {
		
	
		HttpRequest request = HttpRequest.newBuilder()
			    .uri(URI.create("https://api.themoviedb.org/3/movie/787699?language=ko-KR"))
			    .header("accept", "application/json")
			    .header("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYTQ0ZjdiYTIyZTdiN2E1YTdkNDFkNmZlYWYzOWNlYSIsInN1YiI6IjY1YWVhODc1YWFkOWMyMDBjYTVhMGY5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QSYL0JwzjYqHZIIl_kZIu9S6ZTo5EAJUyc2FrTSsNMk")
			    .method("GET", HttpRequest.BodyPublishers.noBody())
			    .build();
			HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
			System.out.println(response.body());
	

		String jsonString = response.body(); // API 응답에서 받은 JSON 문자열
		JSONParser parser = new JSONParser();

		try {
		    JSONObject jsonObj = (JSONObject) parser.parse(jsonString);

		    // "genres" JSON 배열 가져오기
		    JSONArray genresArray = (JSONArray) jsonObj.get("genres");

		    StringBuilder genresStringBuilder = new StringBuilder();
		    for (Object o : genresArray) {
		        JSONObject genreObj = (JSONObject) o;
		        String genreName = (String) genreObj.get("name");
		        genresStringBuilder.append(genreName).append(", ");
		    }

		    // 마지막 쉼표 제거하기
		    if (genresStringBuilder.length() > 0) {
		        genresStringBuilder.setLength(genresStringBuilder.length() - 2);
		    }

		    String genres = genresStringBuilder.toString();
		    System.out.println("장르: " + genres);
		} catch (ParseException e) {
		    e.printStackTrace();
		}

	}

}
