package cn.com.cippus.web.common;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

public class SendMail {
	public SendMail(String email,String subject,String text){
		@SuppressWarnings("resource")
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("./resources/spring/joa-applicationContext.xml");  
        //取得配置  
        JavaMailSender mailSender = (JavaMailSender) context.getBean("mailSender");  
        SimpleMailMessage mail = new SimpleMailMessage();  
        mail.setFrom("hhyyjjkkzz@126.com");  
        mail.setTo(email);  
        mail.setSubject(subject);   
        mail.setText(text);  
        mailSender.send(mail);
	}

}
