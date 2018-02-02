package pocket.controllers;

import java.io.IOException;
import java.util.UUID;
import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import pocket.beans.*;
import pocket.dao.*;

// Author: Preyang Shah

//  File is for Commenting Tests.




public class CommentExpenseController extends HttpServlet {

	//private static final long serialVersionUID = 1L;

	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		System.out.println("in post method");
		System.out.println("action ======"+request.getParameter("action"));
		PrintWriter out = response.getWriter();
		/*String stepLogin = request.getParameter("stepLogin");*/
		// LoginDao loginDAO = new LoginDao();
		 HttpSession session = request.getSession();
		 
		 String expense_id = request.getParameter("expense_id");
		 String username = request.getParameter("username");
		 String comment = request.getParameter("comment");
		 String commentid = request.getParameter("commentid");

		 if (request.getParameter("action").equals("commentAdd")) 
		  {
		 
		 	MongodbDao mg = new MongodbDao();
			mg.insertComment(expense_id,username,comment);
			System.out.println("added to mongodb");
			
			
			
				
			response.sendRedirect("jsp/expenseview.jsp");
		
			}
			if (request.getParameter("action").equals("delete_comment")) 
			{
				System.out.println("cid" + commentid);
				 MongodbDao mg = new MongodbDao();
				mg.deleteComment(Integer.parseInt(commentid));
				System.out.println("deleted from mongodb");
				response.sendRedirect("jsp/expenseview.jsp");
        
            }
			
	}
	
}
