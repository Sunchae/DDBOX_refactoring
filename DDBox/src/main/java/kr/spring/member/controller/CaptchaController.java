package kr.spring.member.controller;

import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/captcha")
public class CaptchaController {

    private final String clientId = "htHEDCZDbqVdUcr2Jjty"; // 애플리케이션 클라이언트 아이디값
    private final String clientSecret = "UMutNOYHPV"; // 애플리케이션 클라이언트 시크릿값
  
    @GetMapping("/generate")
    public String generateCaptcha() {
        String code = "0"; // 키 발급시 0
        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);

        String responseBody = get(apiURL, requestHeaders);
        // responseBody는 캡차 키를 포함하고 있음, 예: {"key":"CAPTCHA_KEY"}
        return responseBody; // 클라이언트에 캡차 키 반환
    }

    @GetMapping("/image")
    public void getCaptchaImage(@RequestParam("key") String key, HttpServletResponse response) throws IOException {
        String apiURL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + key;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);

        byte[] captchaImage = getImage(apiURL, requestHeaders);
        response.setContentType("image/jpeg");
        response.getOutputStream().write(captchaImage);
    }

    @PostMapping("/validate")
    public String validateCaptcha(@RequestParam("key") String key, @RequestParam("value") String value) {
        String code = "1"; // 캡차 이미지 비교시 1로 설정
        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code + "&key=" + key + "&value=" + value;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);

        String responseBody = get(apiURL, requestHeaders);
        return responseBody; // 클라이언트에 검증 결과 반환
    }

    private String get(String apiUrl, Map<String, String> requestHeaders) {
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header : requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }

    private HttpURLConnection connect(String apiUrl) {
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection) url.openConnection();
        } catch (IOException e) {
            throw new RuntimeException("연결 실패: " + apiUrl, e);
        }
    }

    private String readBody(InputStream body) {
        try (BufferedReader lineReader = new BufferedReader(new InputStreamReader(body))) {
            StringBuilder responseBody = new StringBuilder();
            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }
            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("응답 읽기 실패", e);
        }
    }

    private byte[] getImage(String apiUrl, Map<String, String> requestHeaders) throws IOException {
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header : requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return con.getInputStream().readAllBytes();
            } else { // 에러 발생
                throw new RuntimeException("API 요청과 응답 실패: " + readBody(con.getErrorStream()));
            }
        } finally {
            con.disconnect();
        }
    }
}
