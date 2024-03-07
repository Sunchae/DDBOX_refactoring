package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;
import kr.spring.websocket.SocketHandler;
//자바코드 기반 설정 클래스
@Configuration
@EnableWebSocket 
public class AppConfig implements WebMvcConfigurer, WebSocketConfigurer{
	private AutoLoginCheckInterceptor autoLoginCheck;
	private LoginCheckInterceptor loginCheck;
	
	@Bean
	public AutoLoginCheckInterceptor interceptor() {
		autoLoginCheck = new AutoLoginCheckInterceptor();
		return autoLoginCheck;
	}
	
	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	} 
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//AutoLoginCheckInterceptor 설정
		registry.addInterceptor(autoLoginCheck)
				.addPathPatterns("/**")
				.excludePathPatterns("/member/login")
				.excludePathPatterns("/member/logout");
		
		
		//LoginCheckInterceptor 설정
		registry.addInterceptor(loginCheck)
		        .addPathPatterns("/member/myPage")
		        .addPathPatterns("/board/write")
		        .addPathPatterns("/board/update")
		        .addPathPatterns("/board/delete")
		        .addPathPatterns("/faq/question/write")
		        .addPathPatterns("/faq/question/update")
		        .addPathPatterns("/faq/question/delete")
		        .addPathPatterns("/faq/news/write")
		        .addPathPatterns("/faq/news/update")
		        .addPathPatterns("/faq/news/delete")
		        .addPathPatterns("/faq/email")
		        .addPathPatterns("/faq/email/email_admin")
		        .addPathPatterns("/faq/email/write")
		        .addPathPatterns("/faq/email/detail")
		        .addPathPatterns("/faq/email/update")
		        .addPathPatterns("/faq/email/delete")
		        .addPathPatterns("/faq/rental")
		        .addPathPatterns("/faq/rental/rental_admin")
		        .addPathPatterns("/faq/rental/write")
		        .addPathPatterns("/faq/rental/detail")
		        .addPathPatterns("/faq/rental/update")
		        .addPathPatterns("/faq/rental/delete")
		        .addPathPatterns("/faq/rental/updateStatus")
		        .addPathPatterns("/faq/vip/write")
		        .addPathPatterns("/faq/vip/update")
		        .addPathPatterns("/faq/vip/delete")
		        .addPathPatterns("/faq/chat/chatUser")
		        .addPathPatterns("/faq/chat/chatUserRoom_detail")
		        .addPathPatterns("/faq/chat/chattingListForUser")
		        .addPathPatterns("/faq/chat/chattingListForAdmin")
		        .addPathPatterns("/reserve/seatMain")
		        .addPathPatterns("/reserve/payMain")
				.addPathPatterns("/movie/toggleLike")
				.addPathPatterns("/store/storePay");
		
	}
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer = new TilesConfigurer();
		//tilesdef.xml의 경로와 파일명 지정
		configurer.setDefinitions(
			 new String[] {
					 "/WEB-INF/tiles-def/main.xml",
					 "/WEB-INF/tiles-def/mainpage.xml",
					 "/WEB-INF/tiles-def/admin.xml",
					 "/WEB-INF/tiles-def/YSC.xml",
					 "/WEB-INF/tiles-def/PIH.xml",
					 "/WEB-INF/tiles-def/SSH.xml",
					 "/WEB-INF/tiles-def/KJY.xml",
					 "/WEB-INF/tiles-def/JAR.xml",
					 "/WEB-INF/tiles-def/SSY.xml"
					 });
		configurer.setCheckRefresh(true);
		return configurer;
	}
	
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}
	
	//웹소켓 셋팅
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
																//허용 도메인 지정
		registry.addHandler(new SocketHandler(), "message-ws").setAllowedOrigins("*");
	} 
	
}







