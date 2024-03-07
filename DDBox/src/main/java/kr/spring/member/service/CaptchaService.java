package kr.spring.member.service;

import org.springframework.stereotype.Service;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

@Service
public class CaptchaService {

    private final String clientId = "htHEDCZDbqVdUcr2Jjty"; // 애플리케이션 클라이언트 아이디값
    private final String clientSecret = "UMutNOYHPV"; // 애플리케이션 클라이언트 시크릿값

    public boolean validateCaptcha(String captchaKey, String captchaValue) {
        String code = "1"; // 캡차 이미지 비교시 1로 설정
        String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code + "&key=" + captchaKey + "&value=" + captchaValue;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);

        String responseBody = get(apiURL, requestHeaders);
        // 여기서는 응답 바디의 내용에 따라 true 또는 false를 반환하는 간단한 로직을 구현합니다.
        // 실제로는 API 응답을 파싱하여 검증 결과를 정확히 처리해야 합니다.
        return responseBody.contains("true");
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
}
