package pocket.controllers;

import java.io.IOException;
import java.util.UUID;
import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pocket.beans.*;
import pocket.dao.*;
import pocket.utility.*;


public class LoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//System.out.println("in get method");
	
		  if (request.getParameter("submit").equals("CONfirmMation")) 
		  {	   
			  UserDetail detail = new UserDetail();
			  detail.setEmailId(request.getParameter("email"));
			  detail.setActivationFlag("A");
			  detail.setVerificationToken(request.getParameter("token"));
			  LoginDao loginDAO = new LoginDao();		  
			  if(loginDAO.updateActivationFlag(detail)==true)
			  {
					UserDetail user=new LoginDao().getUserDetail(detail); 
					HttpSession session = request.getSession();
					session.setAttribute("User", user);
					request.setAttribute("emailVerified","emailVerified");
					//RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/index.jsp");
					//dispatcher.forward(request, response);
					response.sendRedirect("jsp/dashboard.jsp");
					//response.sendRedirect("JSP/EmailVerified.jsp");  
			  }
			  else
			  {  
				  	System.out.println("Error in verifing Your email.");
					HttpSession session = request.getSession();
					session.setAttribute("errorMsg", "Something went wrong!Please try again!"); 
					response.sendRedirect("jsp/index.jsp");
			  }	  
		  }	  
		  /*============================================================
		   * 
		   * 
		   * 
		   ===============================================================*/
		  
		  if (request.getParameter("submit").equals("NEWPASSWORD")) 
		  {	  
			/*  System.out.println("IN GET .. NEWPASSWORD METHOD EMAIL TOKEN :"+request.getParameter("token"));
			  	System.out.println("IN GET .. NEWPASSWORD METHOD DB FORGOT TOKEN :"+userDetail.getForgotToken());*/ 
				 UserDetail userDetail1 = new UserDetail();
				 userDetail1.setEmailId(request.getParameter("email"));
				 UserDetail detail = new LoginDao().getUserDetail(userDetail1);
				 //System.out.println("DB TOKEN :"+detail.getForgotToken());
				 if(request.getParameter("token").equalsIgnoreCase(detail.getVerificationToken()))
				 {  
					HttpSession session = request.getSession();
				  	session.setAttribute("userDetail",detail);
					/*RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/NewPassword.jsp");
					dispatcher.forward(request, response);*/
					response.sendRedirect("jsp/NewPassword.jsp");
				 }  
		   }	
		  
		
}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		System.out.println("in post method");
		System.out.println("action ======"+request.getParameter("action"));
		PrintWriter out = response.getWriter();
		/*String stepLogin = request.getParameter("stepLogin");*/
		
		
		
		if (request.getParameter("action").equalsIgnoreCase("pocketSignUp")) 
		{
		    String  SUBJECT= "Welcome to Pocket! Activate your account now";
			String encryptAuthLoginToken = null;
			UserDetail userDetail = new UserDetail();
			userDetail.setFirstName(request.getParameter("fName"));
			userDetail.setLastName(request.getParameter("lName"));
			userDetail.setEmailId(request.getParameter("email"));
			userDetail.setPassword(request.getParameter("password"));
			userDetail.setActivationFlag("I");
			userDetail.setSignupFlag("P");
			userDetail.setFbId("");
			userDetail.setGmailId("");
			userDetail.setProfilePic("user.jpg");
			userDetail.setExpenseLimit(0.0);
			String confirmPassword = request.getParameter("confirmPassword");
			/* KEY - Random Number Generated Using UUID*/
			String key = UUID.randomUUID().toString().toUpperCase() + "|"+ "pocket" + "|" + request.getParameter("email");
			try {
				/*Encrypt Method Called of Checker Class To Encrypt KEY using AES Algorithm */
				encryptAuthLoginToken = key;
			} catch (Exception e) {
				e.printStackTrace();
			}
			userDetail.setVerificationToken(encryptAuthLoginToken);   
			           // Setting login token 
			if (request.getParameter("password").equals(confirmPassword)) 
			{
					LoginDao loginDAO = new LoginDao();
					if (!loginDAO.existsEmail(userDetail))
					{
						if (loginDAO.insertUserDetail(userDetail)) 
						{
							/*Sending A mail to user for Email Confirmation*/
							SendMail.send(userDetail,"pocketSignUp",SUBJECT);
							request.setAttribute("registerSuccess","registerSuccess");
							System.out.println("in dispatcher " + request.getAttribute("registerSuccess").toString());
							HttpSession session = request.getSession();
							session.setAttribute("errorMsg", "Registration Successful! Please check your email to activate pocket account!"); 
							response.sendRedirect("jsp/index.jsp");
						}
					}	
					else{
						HttpSession session = request.getSession();
						session.setAttribute("errorMsg", "Email address already exist! Please enter another email address!");
						System.out.println("Email already exists");
						response.sendRedirect("jsp/index.jsp");
						//send back to registration page and print error "email exists!select another email"
					}
				
			}
			else {
				HttpSession session = request.getSession();
				session.setAttribute("errorMsg", "Password and Confirm Password should match!");
				System.out.println("confirm password should be same as password");
				response.sendRedirect("jsp/index.jsp");
				//send back to registration page and print error "password and confirm password doesn't match"
			}
		}

		if (request.getParameter("action").equalsIgnoreCase("userActivation")) 
		{
		    String email = request.getParameter("email");
		    String verificationToken = request.getParameter("token");
			
			UserDetail userDetail = new UserDetail();
			userDetail.setEmailId(email);
			userDetail.setVerificationToken(verificationToken);
		    LoginDao loginDAO = new LoginDao();
		    boolean res = loginDAO.checkToken(userDetail);
			
		    if(res){
				userDetail.setActivationFlag("A");
		    	loginDAO.updateActivationFlag(userDetail);
		    	UserDetail user = loginDAO.getUserDetail(userDetail);
		    	 HttpSession session = request.getSession();
            	session.setAttribute("User", user);
				response.sendRedirect("jsp/dashboard.jsp");
				//dispatch to dashboard
		    	//request.getRequestDispatcher("jsp/HomePage.jsp").forward(request, response); 
		    }
		}

		if (request.getParameter("action").equalsIgnoreCase("pocketLogin")) 
		{
			System.out.println("inside pocketLogin");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			UserDetail user = new UserDetail();
			user.setEmailId(email);
			user.setSignupFlag("P");
			LoginDao loginDAO = new LoginDao();
			UserDetail userDetail = null;
			if(loginDAO.existsEmailAndFlag(user))
			{
				userDetail = loginDAO.getUserDetail(user);	
			}
			
			
			if(userDetail != null)
			{	
				if(userDetail.getPassword().equals(password)){
					System.out.println("password matched");
					if(userDetail.getActivationFlag().equals("A")){
						HttpSession session = request.getSession();
						session.setAttribute("User", userDetail);
						System.out.println(userDetail.getFirstName());
						//request.getRequestDispatcher("jsp/HomePage.jsp").forward(request, response);
						//take to dashboard
						response.sendRedirect("jsp/dashboard.jsp");
					}else if(userDetail.getActivationFlag().equals("I")){
						HttpSession session = request.getSession();
						session.setAttribute("errorMsg", "Please Check Your Email to Activate Pocket Account First!");
						response.sendRedirect("jsp/index.jsp");
					}
				}
				else{
					HttpSession session = request.getSession();
					session.setAttribute("errorMsg", "Wrong Password! Please Login again with proper credentials!");
					System.out.println("Wrong Password");
					response.sendRedirect("jsp/index.jsp");
					//take to login page and print error message "Wrong password"
				}
			}
			else{
				HttpSession session = request.getSession();
				session.setAttribute("errorMsg", "Wrong Email Address! Please Login again with proper credentials!");
					
				//out.println("Wrong email");
				response.sendRedirect("jsp/index.jsp");
					//take to login page and print error message "Wrong email"
			}	
		}

		if(request.getParameter("action").equalsIgnoreCase("sendNewPassword")){
			String  SUBJECT= "Pocket Account - Verification code to reset Pocket password";
			UserDetail userDetail = new UserDetail();
			userDetail.setEmailId(request.getParameter("email"));
			userDetail.setSignupFlag("P");
			/* KEY - Random Number Generated Using UUID*/
			String encryptAuthLoginToken = null;
			String key = UUID.randomUUID().toString().toUpperCase() + "|"
						+ request.getParameter("email").replace(".", "") + "|" ;
			try 
			{
				/*Encrypt Method Called of Checker Class To Encrypt KEY using AES Algorithm */
				encryptAuthLoginToken = key;
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
			userDetail.setVerificationToken(encryptAuthLoginToken);   // Setting forgot token
			LoginDao loginDAO = new LoginDao();
			if(loginDAO.existsEmailAndFlag(userDetail))
			{
				if(loginDAO.updateVerificationToken(userDetail))
				{
					/*Sending mail to user for Email Confirmation*/
					SendMail.send(userDetail,"sendNewPassword",SUBJECT);
					request.setAttribute("sendNewPassword","sendNewPassword");
					System.out.println("in dispatcher " + request.getAttribute("sendNewPassword").toString());
					HttpSession session = request.getSession();
					session.setAttribute("errorMsg", "An email has been sent with reset link for password! Kindly Verify your Email!");
					/*RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/index.jsp");
					dispatcher.forward(request, response);*/
					response.sendRedirect("jsp/index.jsp");
				}			
			}	
			else{
				HttpSession session = request.getSession();
				session.setAttribute("errorMsg", "Email address doesn't exists! Please Signup first!");
				response.sendRedirect("jsp/ForgotPassword.jsp");
			}
		}

		if(request.getParameter("action").equalsIgnoreCase("setNewPassword"))
		{
			UserDetail user =new UserDetail();
			user.setEmailId(request.getParameter("email"));
			boolean flag=false;
			if(request.getParameter("newPassword").equals(request.getParameter("confirmPassword")))
			{
				flag=new LoginDao().setNewPassword(user, request.getParameter("newPassword"));
				if(flag)
				{
					System.out.println("success : password updated successfully.");
					request.setAttribute("setNewPassword","setNewPassword");
					HttpSession session = request.getSession();
					session.setAttribute("errorMsg", "Password updated successfully! Please login with new credentials!");
					response.sendRedirect("jsp/index.jsp");
					
				}
				else
				{
					System.out.println("error: in setting new password in setNewPassword method");
					HttpSession session = request.getSession();
					session.setAttribute("errorMsg", "Something went wrong!Please try again!");
					response.sendRedirect("jsp/index.jsp");
					
				}
			}
			else
			{
				System.out.println("password not mathch please enter it correctly");
				HttpSession session = request.getSession();
				session.setAttribute("errorMsg", "New Password and Confirm Password should match!");
				response.sendRedirect("jsp/NewPassword.jsp");
				
			}
		}	
		
			
	}
	
}
