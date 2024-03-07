package kr.spring.util;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
    
public class MailUtil {
	public static void send(JavaMailSender javaMailSender,String toMail,String subject,String text) {
		SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setTo(toMail);
        simpleMailMessage.setSubject(subject);
        simpleMailMessage.setText(text); 

        // 이메일 발신
        javaMailSender.send(simpleMailMessage);  
	}
}
