package cn.com.cippus.web.mail;

public class MailSender {

	public static void sendMail(String to, String content) {
		 MailSenderInfo mailInfo = new MailSenderInfo();    
	      mailInfo.setMailServerHost("smtp.qq.com");    
	      mailInfo.setMailServerPort("25");    
	      mailInfo.setValidate(true);    
	      mailInfo.setUserName("1518302968@qq.com");    
	      mailInfo.setPassword("mingyu080017");//您的邮箱密码    
	      mailInfo.setFromAddress("1518302968@qq.com");    
	      mailInfo.setToAddress(to);    
	      mailInfo.setSubject("创新中心官网提示信息");    
	      mailInfo.setContent(content);
	         //这个类主要来发送邮件   
	      SimpleMailSender sms = new SimpleMailSender();   
	      sms.sendTextMail(mailInfo);//发送文体格式    
	}
}
