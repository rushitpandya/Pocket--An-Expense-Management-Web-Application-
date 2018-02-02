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

public class ExpenseController extends HttpServlet {

	// private static final long serialVersionUID = 1L;
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		PrintWriter out = response.getWriter();
		
		if (request.getParameter("action").equalsIgnoreCase("viewgroupexpense")) 
		{
			HttpSession session = request.getSession();
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupId(Integer.parseInt(request.getParameter("id")));
			GroupDao groupDao = new GroupDao();
			GroupDetail group = groupDao.getGroupDetailById(groupDetail);
			
			ExpenseDao expenseDao = new ExpenseDao();
			Map<Integer, HashMap<Integer,ExpenseDetail>> monthMap = expenseDao.getExpensesByMonth(groupDetail); 
			
			System.out.println("++++++++++"+group.getEmailid());
			session.setAttribute("group_obj",group);
			session.setAttribute("expense_map",monthMap);
			response.sendRedirect("jsp/expenseview.jsp");

		}

		if (request.getParameter("action").equalsIgnoreCase("viewfriendexpense")) 
		{
			HttpSession session = request.getSession();
			System.out.println("inside viewfriendexpense");
			UserDetail friend = new UserDetail();
			friend.setEmailId(request.getParameter("id"));

			

			ExpenseDao expenseDao = new ExpenseDao();
			Map<Integer, HashMap<Integer,ExpenseDetail>> monthMap = expenseDao.getFriendExpensesByMonth(request.getParameter("id")); 
			System.out.println(monthMap.toString());
			
			session.setAttribute("friend_obj",friend);
			session.setAttribute("expense_map",monthMap);
			response.sendRedirect("jsp/friendview.jsp");

		}

		

		

		
		
		
	}

	
}