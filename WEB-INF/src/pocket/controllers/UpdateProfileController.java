package pocket.controllers;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import pocket.beans.*;
import pocket.dao.*;

// Author: Preyang Shah

//  File is for update profile for user.




public class UpdateProfileController extends HttpServlet {

	//private static final long serialVersionUID = 1L;

	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		System.out.println("in post method");
		System.out.println("action ======"+request.getParameter("action"));
		PrintWriter out = response.getWriter();
		/*String stepLogin = request.getParameter("stepLogin");*/
		 LoginDao loginDAO = new LoginDao();
		 HttpSession session = request.getSession();
		 
		 
		if (request.getParameter("action").equalsIgnoreCase("profileupdate")) 
		{
			UserDetail userDetail=null;
			if(session.getAttribute("User")!= null)
			{
				userDetail = (UserDetail)session.getAttribute("User");	
			}
			
			userDetail.setFirstName(request.getParameter("UpdatefName"));
			userDetail.setLastName(request.getParameter("UpdatelName"));
			userDetail.setEmailId(request.getParameter("useremail"));
			loginDAO.updateProfile(userDetail);
			session.setAttribute("User",userDetail);
			/*System.out.println(request.getParameter("useremail"));
			System.out.println(request.getParameter("UfName"));
			System.out.println(request.getParameter("UlName"));*/
			System.out.println(" userdetail updated");
			//HttpSession session = request.getSession();
			session.setAttribute("errorMsg", "Profile Details Updated Successfully!");
			response.sendRedirect("jsp/profile.jsp");
		
		}
		 
		if (request.getParameter("action").equalsIgnoreCase("setlimit")) 
		{
			UserDetail userDetail=null;
			if(session.getAttribute("User")!= null)
			{
				userDetail = (UserDetail)session.getAttribute("User");	
			}
			userDetail.setExpenseLimit(Double.parseDouble(request.getParameter("limit")));
			userDetail.setEmailId(request.getParameter("useremail"));
			loginDAO.updateLimit(userDetail);
			session.setAttribute("User",userDetail);
			System.out.println(request.getParameter("useremail"));
			System.out.println(request.getParameter("limit"));
			System.out.println(" limit updated");
			session.setAttribute("errorMsg", "Limit Updated Successfully!");
			response.sendRedirect("jsp/profile.jsp");
		}
		
		//System.out.println(request.getParameter("UfName"));
		if (request.getParameter("action").equalsIgnoreCase("changepassword")) 
		{
			UserDetail userDetail=null;
			if(session.getAttribute("User")!= null)
			{
				userDetail = (UserDetail)session.getAttribute("User");	
			}
			String pass= request.getParameter("newpassword");
			String cpass= request.getParameter("comfirmpassword");
			if(pass.equals(cpass))
			{
			userDetail.setPassword(request.getParameter("newpassword"));
			userDetail.setEmailId(request.getParameter("useremail"));
			loginDAO.updatePassword(userDetail);
			session.setAttribute("User",userDetail);
			System.out.println(request.getParameter("useremail"));
			System.out.println(request.getParameter("limit"));
			System.out.println(" password  updated");
			session.setAttribute("errorMsg", "Password Updated Successfully!");
			response.sendRedirect("jsp/profile.jsp");
			}
			else
			{
				System.out.println("Wrong password. Please type same password.");
				//out.println("Wrong password. Please type same password.");
				session.setAttribute("errorMsg", "New Password and Confirm Password should match!");
				response.sendRedirect("jsp/profile.jsp");
			}
		}
			
	}
	
}
