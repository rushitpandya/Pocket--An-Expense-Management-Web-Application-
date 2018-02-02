package pocket.controllers;


import java.io.*;

import java.net.*;
import javax.servlet.http.*;
import javax.servlet.*;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import javax.servlet.annotation.WebServlet;
import pocket.beans.*;
import pocket.dao.*;
import org.json.JSONException;
import org.json.JSONObject;


@WebServlet("/GmailLoginController")

public class GmailLoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private String code="";
	 String access_token=""; 
	
	public GmailLoginController()
	{
		super();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	        try {
				System.out.println("get");
	            // get code
	            String code = request.getParameter("code");
	            // format parameters to post
	            String urlParameters = "code="
	                    + code
	                    + "&client_id=88196211357-vl6vl38tdtd2geaap9ih7easi7tkhovj.apps.googleusercontent.com"
	                    + "&client_secret=smoJu1Uur6kVQeKneUKEEw2B"
	                    + "&redirect_uri=http://localhost:8080/Pocket/GmailLoginController"
	                    + "&grant_type=authorization_code";
	           
			   
			  System.out.println(urlParameters);
	            //post parameters
	            URL url = new URL("https://accounts.google.com/o/oauth2/token");
	            URLConnection urlConn = url.openConnection();
	            urlConn.setDoOutput(true);
	            OutputStreamWriter writer = new OutputStreamWriter(urlConn.getOutputStream());
	            writer.write(urlParameters);
	            writer.flush();
	            System.out.println(url);
	            //get output in outputString 
	            String line, outputString = "";
	            BufferedReader reader = new BufferedReader(new InputStreamReader(
	                    urlConn.getInputStream()));
	            while ((line = reader.readLine()) != null) {
	                outputString += line;
	            }
	           System.out.println(outputString);
	            
	            //get Access Token 
	           JsonObject json = (JsonObject)new JsonParser().parse(outputString);
	           access_token = json.get("access_token").getAsString();
	             System.out.println("123"+access_token);

	            //get User Info 
	            url = new URL("https://www.googleapis.com/oauth2/v1/userinfo?access_token="+access_token);
	            urlConn = url.openConnection();
	            outputString = "";
	            reader = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
	            while ((line = reader.readLine()) != null)
	            {
	                outputString += line;
	            }
	             System.out.println(outputString);
	         
			 
				JSONObject gmailjson = new JSONObject(outputString);
				
				UserDetail user = new UserDetail();
				user.setEmailId(gmailjson.getString("email"));
				user.setFirstName(gmailjson.getString("given_name"));
				user.setLastName(gmailjson.getString("family_name"));
				user.setActivationFlag("A");
				user.setVerificationToken(access_token);
				user.setGmailId(gmailjson.getString("id"));
				user.setSignupFlag("G");
				user.setProfilePic(gmailjson.getString("picture"));
				user.setExpenseLimit(0.0);
				
				LoginDao logindao = new LoginDao();
				if(logindao.existsEmail(user))
				{
					if(logindao.existsEmailAndFlag(user))
					{
						UserDetail user1 = (UserDetail)logindao.getUserDetail(user);
						setUserSession(user1,request);
						System.out.println("login and redirect to dashboard");
						response.sendRedirect("jsp/dashboard.jsp");
						//redirect to dashboard
					}	
					else
					{
						HttpSession session = request.getSession();
						session.setAttribute("errorMsg", "Wrong Login Type!You have been already registered with Facebook!Try with FB Login"); 
						response.sendRedirect("jsp/index.jsp");
						System.out.println("if-else");
						//take back to login page and print wrong login type error message
					}	
				}	
				else
				{
					//System.out.println(fbProfileData.get("first_name")+" "+fbProfileData.get("last_name"));
					logindao.insertUserDetail(user);
					
					setUserSession(user,request);
					//Dispatch to dashboard
					response.sendRedirect("jsp/dashboard.jsp");
					System.out.println("registered and dispatch to dashboard");
				}
				
	            writer.close();
	            //request.getRequestDispatcher("jsp/success.jsp").forward(request, response);
	        } catch (Exception e) {
	            System.out.println( e);
	        } 
	
	}
	public void setUserSession(UserDetail user,HttpServletRequest request)
	{
		
		HttpSession session = request.getSession();
		session.setAttribute("User",user);		
	}

}