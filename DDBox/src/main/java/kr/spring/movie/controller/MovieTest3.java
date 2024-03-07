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
public class MovieTest3 {
	
	
	
		
	public static void main(String[] args) throws Exception {
		
	
		HttpRequest request = HttpRequest.newBuilder()
			    .uri(URI.create("https://api.themoviedb.org/3/movie/787699/credits?language=ko-KR"))
			    .header("accept", "application/json")
			    .header("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYTQ0ZjdiYTIyZTdiN2E1YTdkNDFkNmZlYWYzOWNlYSIsInN1YiI6IjY1YWVhODc1YWFkOWMyMDBjYTVhMGY5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QSYL0JwzjYqHZIIl_kZIu9S6ZTo5EAJUyc2FrTSsNMk")
			    .method("GET", HttpRequest.BodyPublishers.noBody())
			    .build();
			HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
			System.out.println(response.body());
	

		String jsonData = response.body(); // API 응답에서 받은 JSON 문자열
		JSONParser parser = new JSONParser();

		 try {
	            JSONObject jsonObject = (JSONObject) parser.parse(jsonData);
	            JSONArray crewArray = (JSONArray) jsonObject.get("crew");
	            
	            for (Object o : crewArray) {
	                JSONObject jsonObj = (JSONObject) o;
	                
	                String department = (String) jsonObj.get("department");
	                String job = (String) jsonObj.get("job");
	                
	                // 조건에 맞는 객체 찾기
	                if ("Directing".equals(department) && "Director".equals(job)) {
	                    String name = (String) jsonObj.get("name");
	                    System.out.println("감독 이름: " + name);
	                    // 필요한 경우 더 많은 로직 추가
	                }
	            }
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	    }
	

}
