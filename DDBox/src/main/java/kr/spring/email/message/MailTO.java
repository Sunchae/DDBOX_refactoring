package kr.spring.email.message;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MailTO {
    private String address;
    private String title;
    private String message;
    
}