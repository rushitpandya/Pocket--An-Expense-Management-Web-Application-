package pocket.utility;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import pocket.beans.*;

public class SendMail 
{ 
	
	private static final String ACTIVATIONMAIL = "http://localhost:8080/Pocket/LoginController?token=";
	private static final String SENDER = "divyapatel8401@gmail.com";
	private static final String PASSWORD = "@divyapatel@";
	
    public static void send(UserDetail userDetail, String flag , String SUBJECT)
    { 
    	String htmlText = null;
    	//create an instance of Properties Class   
    	Properties props = new Properties();

     /* Specifies the IP address of your default mail server
     	   for e.g if you are using gmail server as an email sever
           you will pass smtp.gmail.com as value of mail.smtp host. 
           As shown here in the code. 
           Change accordingly, if your email id is not a gmail id
        */
     props.put("mail.smtp.host", "smtp.gmail.com");
     //below mentioned mail.smtp.port is optional
     props.put("mail.smtp.port", "587");		
     props.put("mail.smtp.auth", "true");
     props.put("mail.smtp.starttls.enable", "true");
     
     /* Pass Properties object(props) and Authenticator object   
           for authentication to Session instance 
        */

    Session session = Session.getInstance(props,new javax.mail.Authenticator()
    {
  	  protected PasswordAuthentication getPasswordAuthentication() 
  	  {
  	 	 return new PasswordAuthentication(SENDER,PASSWORD);
  	  }
   });
    
   try
   {
 	/* Create an instance of MimeMessage, 
 	      it accept MIME types and headers 
 	   */
	   //Set email data 
	   MimeMessage message = new MimeMessage(session);
       message.setFrom(new InternetAddress(SENDER));
       message.addRecipient(Message.RecipientType.TO,new InternetAddress(userDetail.getEmailId()));
       message.setSubject(SUBJECT);
       MimeMultipart multipart = new MimeMultipart();
       BodyPart messageBodyPart = new MimeBodyPart();
       
     //Set key values
       Map<String, String> input = new HashMap<String, String>();
       input.put("USER", userDetail.getEmailId());
       //input.put("Pocket", SENDER);
       input.put("EMAILADDRESS", userDetail.getEmailId());
     
       //HTML mail content
       if(flag.equalsIgnoreCase("pocketSignUp")){
    	   //System.out.println("token:-"+userDetail.getLoginToken());
    	   input.put("TOKEN", userDetail.getVerificationToken());
    	   htmlText = readEmailFromHtml(System.getenv("CATALINA_HOME")+"/webapps/Pocket/jsp/CONFIRM_PASSWORD.html",input);
       }
       
       if(flag.equalsIgnoreCase("sendNewPassword")){
    	  // System.out.println("token:-"+userDetail.getForgotToken());
    	   input.put("TOKEN", userDetail.getVerificationToken());
    	   htmlText = readEmailFromHtml(System.getenv("CATALINA_HOME")+"/webapps/Pocket/jsp/FORGOT_PASSWORD.html",input);
       }
       messageBodyPart.setContent(htmlText, "text/html");
       multipart.addBodyPart(messageBodyPart); 
       message.setContent(multipart);
   
     //Conect to smtp server and send Email
       Transport transport = session.getTransport("smtp");            
       transport.connect("smtp.gmail.com", SENDER, PASSWORD);
       transport.sendMessage(message, message.getAllRecipients());
       transport.close();
       System.out.println("Mail sent successfully..."); 
    }
    catch(Exception e)
    {
    	 e.printStackTrace();
    }
  }

	private static String readEmailFromHtml(String filePath,Map<String, String> input) {
		 String msg = readContentFromFile(filePath);
		// System.out.println("msg file"+msg);
		    try
		    {
		    Set<Entry<String, String>> entries = input.entrySet();
		   // System.out.println("size:--"+entries.size());
		    for(Map.Entry<String, String> entry : entries) {
		        msg = msg.replace(entry.getKey().trim(), entry.getValue().trim());
		    }
		    }
		    catch(Exception exception)
		    {
		        exception.printStackTrace();
		    }
		    return msg;
	}
	
	//Method to read HTML file as a String 
	
	private static String readContentFromFile(String fileName) {
		 StringBuffer contents = new StringBuffer(); 
		    try {
		      //use buffering, reading one line at a time
		      BufferedReader reader =  new BufferedReader(new FileReader(fileName));
		      try {
		        String line = null; 
		        while (( line = reader.readLine()) != null){
		          contents.append(line);
		          contents.append(System.getProperty("line.separator"));
		        }
		      }
		      finally {
		          reader.close();
		      }
		    }
		    catch (IOException ex){
		      ex.printStackTrace();
		    }
		    return contents.toString();
	}  
		
	
	 public static boolean sendInquiry(String recipientEmail,String senderName,String senderEmail,String senderPhoneNumber,String inquiry,String bookTitle, String bookPrice, String SUBJECT)
	    { 
		 
	    	String htmlText = null;
	    	//create an instance of Properties Class   
	    	Properties props = new Properties();

	     /* Specifies the IP address of your default mail server
	     	   for e.g if you are using gmail server as an email sever
	           you will pass smtp.gmail.com as value of mail.smtp host. 
	           As shown here in the code. 
	           Change accordingly, if your email id is not a gmail id
	        */
	     props.put("mail.smtp.host", "smtp.gmail.com");
	     //below mentioned mail.smtp.port is optional
	     props.put("mail.smtp.port", "587");		
	     props.put("mail.smtp.auth", "true");
	     props.put("mail.smtp.starttls.enable", "true");
	     
	     /* Pass Properties object(props) and Authenticator object   
	           for authentication to Session instance 
	        */
	    Session session = Session.getInstance(props,new javax.mail.Authenticator()
	    {
	  	  protected PasswordAuthentication getPasswordAuthentication() 
	  	  {
	  	 	 return new PasswordAuthentication(SENDER,PASSWORD);
	  	  }
	   });
	    
	   try
	   {
	 	/* Create an instance of MimeMessage, 
	 	      it accept MIME types and headers 
	 	   */
		   //Set email data 
		   MimeMessage message = new MimeMessage(session);
	       message.setFrom(new InternetAddress(SENDER));
	       message.addRecipient(Message.RecipientType.TO,new InternetAddress(recipientEmail)); // receiver email address mentioned
	       message.setSubject(SUBJECT);
	       MimeMultipart multipart = new MimeMultipart();
	       BodyPart messageBodyPart = new MimeBodyPart();
	       
	     //Set key values
	       Map<String, String> input = new HashMap<String, String>();
	       input.put("SENDER", recipientEmail);
	       input.put("MESSAGE", inquiry);
	       input.put("EMAIL",senderEmail );
	       input.put("CONTACT", senderPhoneNumber);
	       input.put("TITLE", bookTitle);
	       input.put("PRICE", bookPrice);
	     
	       //HTML mail content
	       htmlText = readEmailFromHtml("C:/mail/SEND_INQUIRY.html",input);
	       messageBodyPart.setContent(htmlText, "text/html");
	       multipart.addBodyPart(messageBodyPart); 
	       message.setContent(multipart);
	   
	     //Conect to smtp server and send Email
	       Transport transport = session.getTransport("smtp");            
	       transport.connect("smtp.gmail.com", SENDER, PASSWORD);
	       transport.sendMessage(message, message.getAllRecipients());
	       transport.close();
	       System.out.println("Mail sent successfully...");
	       return true;
	    }
	    catch(Exception e)
	    {
	    	 e.printStackTrace();
	    	 return false;
	    }
	  }
	
	
	
}