package pocket.controllers;

import pocket.utility.*;
import java.io.IOException;
import java.util.Map;
import pocket.dao.*;
import pocket.beans.*;

import javax.servlet.*;

import javax.servlet.http.*;

public class FacebookLoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private String fbcode="";
	String accessToken="";
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	

		fbcode = request.getParameter("code");	
		try{
			if (fbcode == null || fbcode.equals("")) {
					throw new RuntimeException(
							"ERROR: Didn't get code parameter in callback.");
				}
				FacebookConnectionUtility fbConnection = new FacebookConnectionUtility();
				accessToken = fbConnection.getAccessToken(fbcode);

				FBGraph fbGraph = new FBGraph(accessToken);
				String graph = fbGraph.getFBGraph();
				Map<String, String> fbProfileData = fbGraph.getGraphData(graph);
				ServletOutputStream out = response.getOutputStream();
				
				UserDetail user = new UserDetail();
				user.setEmailId(fbProfileData.get("email"));
				user.setFirstName(fbProfileData.get("first_name"));
				user.setLastName(fbProfileData.get("last_name"));
				user.setActivationFlag("A");
				user.setVerificationToken(accessToken);
				user.setFbId(fbProfileData.get("id"));
				user.setSignupFlag("F");
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
						session.setAttribute("errorMsg", "Wrong Login Type!You have been already registered with Google!Try with Google Login"); 
						response.sendRedirect("jsp/index.jsp");
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
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}		
	}
	
	public void setUserSession(UserDetail user,HttpServletRequest request)
	{
		
		HttpSession session = request.getSession();
		session.setAttribute("User",user);		
	}

}