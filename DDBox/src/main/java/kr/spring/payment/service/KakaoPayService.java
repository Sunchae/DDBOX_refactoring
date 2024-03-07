package kr.spring.payment.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import kr.spring.payment.vo.KakaoPayApprovalVO;
import kr.spring.payment.vo.KakaoPayReadyVO;
import lombok.extern.java.Log;

@Service
@Log
public class KakaoPayService {
	private static final String HOST = "http://kapi.kakao.com";
	
	private KakaoPayReadyVO kakaoPayReadyVO;
	private KakaoPayApprovalVO kakaoPayApprovalVO;
	
	public String KakaoPayReady() {
		RestTemplate restTemplate = new RestTemplate();
		
		//서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + "ac455968d722e570e208856edc99e3c7");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		//서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid","TC0ONETIME");
		params.add("partner_order_id", "1001");
        params.add("partner_user_id", "gorany");
        params.add("item_name", "${store.store_title}");
        params.add("quantity", "1");
        params.add("total_amount", "${store.store_price}");
        params.add("tax_free_amount", "100");
        params.add("approval_url", "http://localhost:8080/kakaoPaySuccess");
        params.add("cancel_url", "http://localhost:8080/kakaoPayCancel");
        params.add("fail_url", "http://localhost:8080/kakaoPaySuccessFail");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String,String>>(params, headers);
        
        try {
        	kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
        	
        	log.info("" + kakaoPayReadyVO);
        	return kakaoPayReadyVO.getNext_redirect_pc_url();
        } catch(RestClientException e) {
        	e.printStackTrace();
        } catch(URISyntaxException e) {
        	e.printStackTrace();
        }
		return "/pay";
	}
	
	public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {
		log.info("KakaoInfoVO...............................");
		log.info("-----------------------------");
		
		RestTemplate restTemplate = new RestTemplate();
		
		//서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK" + "ac455968d722e570e208856edc99e3c7");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		//서버로 요청할 Body
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("tid", kakaoPayReadyVO.getTid());
		params.add("partner_order_id", "1001");
		params.add("partner_user_id", "gorany");
        params.add("pg_token", pg_token);
        params.add("total_amount", "${store.store_price}");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String,String>>(params, headers);
        
        try {
        	kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
        	log.info("" + kakaoPayApprovalVO);
        	
        	return kakaoPayApprovalVO;
        } catch (RestClientException e) {
        	e.printStackTrace();
        } catch (URISyntaxException e) {
        	e.printStackTrace();
        }
        return null;
	}
}
