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

public class GroupController extends HttpServlet {

	// private static final long serialVersionUID = 1L;
	GroupDao groupDao = new GroupDao();
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		PrintWriter out = response.getWriter();
		
		if (request.getParameter("action")!=null && request.getParameter("action").equalsIgnoreCase("creategroup")) 
		{
			int groupid = groupDao.getid();
			System.out.println("returned groupid:"+groupid);
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupName(request.getParameter("Name"));
			
			groupDetail.setGroupId(groupid+1);
			// Returns an array of String objects containing all of the values the given request parameter has, or null if the parameter does not exist.
			String[] emailid=request.getParameterValues("email_id");

			// Convert String array to arrayList. You can assign this to variable and use.
			groupDetail.setEmailid(new ArrayList<String>(Arrays.asList(emailid)));
			
			//groupDetail.setGroupId();
			//GroupDao groupDao = new GroupDao();
			if (groupDao.addGroup(groupDetail)) 
			{
				
				HttpSession session = request.getSession();
				session.setAttribute("Status","Success");
				session.setAttribute("PrintMsg", "Group created Successfully! Start adding your expenses!");
				session.setAttribute("Action","CreateGroup");
				session.setAttribute("groupDetail",groupDetail);
				//request.getRequestDispatcher("jsp/index.jsp").forward(request, response); 
				response.sendRedirect("jsp/dashboard.jsp");
			}
			
			
			else{
				System.out.println("error occured");
			}
		}
		
		
		
		if (request.getParameter("action").equalsIgnoreCase("updategroup")) 
		{
			int groupid = groupDao.getid();
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupName(request.getParameter("Name"));
			
			groupDetail.setGroupId(Integer.parseInt(request.getParameter("group_id")));
			// Returns an array of String objects containing all of the values the given request parameter has, or null if the parameter does not exist.
			String[] emailid=request.getParameterValues("email_id");

			// Convert String array to arrayList. You can assign this to variable and use.
			groupDetail.setEmailid(new ArrayList<String>(Arrays.asList(emailid)));
			
			//groupDetail.setGroupId();
			//GroupDao groupDao = new GroupDao();
			if (groupDao.updateGroup(groupDetail)) 
			{
				
				HttpSession session = request.getSession();
				session.setAttribute("Status","Success");
				session.setAttribute("PrintMsg", "Group updated Successfully!");
				session.setAttribute("Action","UpdateGroup");
				session.setAttribute("groupDetail",groupDetail);
				response.sendRedirect("jsp/updategroup.jsp?group_id="+request.getParameter("group_id"));
			}
			
			
			else{
				System.out.println("error occured");
			}
		}
		
		
		if (request.getParameter("action").equalsIgnoreCase("deletemember")) 
		{
			
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupId(Integer.parseInt(request.getParameter("group_id")));
			
			// Returns an array of String objects containing all of the values the given request parameter has, or null if the parameter does not exist.
			String[] emailid=request.getParameterValues("email_id");

			// Convert String array to arrayList. You can assign this to variable and use.
			groupDetail.setEmailid(new ArrayList<String>(Arrays.asList(emailid)));
			
			if (groupDao.deleteMembers(groupDetail)) 
			{
				/*Sending A mail to user for Email Confirmation*/
				//SendMail.send(groupdetail,"pocketSignUp",SUBJECT);
				//request.setAttribute("registerSuccess","registerSuccess");
				//request.setAttribute("email",groupdetail.getEmailId());
				//request.setAttribute("token",groupdetail.getVerificationToken());
				// request.getRequestDispatcher("jsp/index.jsp").forward(request, response);
				HttpSession session = request.getSession();
				session.setAttribute("Status","Success");
				session.setAttribute("PrintMsg", "Member deleted Successfully!");
				session.setAttribute("Action","DeleteMember");
				session.setAttribute("groupDetail",groupDetail);
				response.sendRedirect("jsp/updategroup.jsp?group_id="+request.getParameter("group_id"));
			}
			
			
			else{
				System.out.println("error occured");
			}
		}
		
		if (request.getParameter("action").equalsIgnoreCase("deletegroup")) 
		{
			//before deleting group check for any outstanding expenses
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupId(Integer.parseInt(request.getParameter("group_id")));
			if (groupDao.deleteGroup(groupDetail)) 
			{
				
				//request.getRequestDispatcher("jsp/.jsp").forward(request, response);
				HttpSession session = request.getSession();
				session.setAttribute("Status","Success");
				session.setAttribute("PrintMsg", "Group deleted Successfully!");
				session.setAttribute("Action","DeleteGroup");
				session.setAttribute("groupDetail",groupDetail);
				response.sendRedirect("jsp/dashboard.jsp");
			}
			
			
			else{
				System.out.println("error occured");
			}
		}
		
	}

	
}