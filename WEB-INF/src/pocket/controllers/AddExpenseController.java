package pocket.controllers;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.JSONObject;
import org.json.JSONArray;
import com.google.gson.Gson;

import pocket.beans.*;
import pocket.dao.*;

public class AddExpenseController extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try{
			ArrayList<String> paid_for = new ArrayList<String>();
			HashMap<String,Double> paid_for_amount = new HashMap<String,Double>();
			String added_by = request.getParameter("added_by");
			String expense_title = request.getParameter("expense_title");
			String paid_by = request.getParameter("paid_by");
			String expense_category = request.getParameter("expense_category");
			String added_date = request.getParameter("added_date");
			String expense_note = null;
			String image = request.getParameter("expense_image"); ; 
			double total = Double.parseDouble(request.getParameter("total"));
			int group_id = Integer.parseInt(request.getParameter("group_id"));
			if(request.getParameter("expense_note") != null)
			{
				expense_note = request.getParameter("expense_note");
			}
			
			Enumeration en=request.getParameterNames();
	 
			 while(en.hasMoreElements())
			 {
				 Object objOri=en.nextElement();
				 String param=(String)objOri;
				 if(param.contains("@"))
				 {
					double value=Double.parseDouble(request.getParameter(param));	
					paid_for.add(param);
					paid_for_amount.put(param,value);
					System.out.println("Parameter Name is '"+param+"' and Parameter Value is '"+value+"'");
				 }
			 } 
			 ExpenseDao expensedao = new ExpenseDao();
			 int expense_id = expensedao.getId()+1;
			 DateFormat df = new SimpleDateFormat("yyyy/MM/dd"); 
			 ExpenseDetail expensedetail = new ExpenseDetail();
			 expensedetail.setExpenseId(expense_id);
			 expensedetail.setGroupId(group_id);
			 expensedetail.setAddedById(added_by);
			 expensedetail.setPaidById(paid_by);
			 expensedetail.setPaidForId(paid_for);
			 expensedetail.setAmount(paid_for_amount);
			 expensedetail.setName(expense_title);
			 expensedetail.setAddedDate(new Date());
			 expensedetail.setCategory(expense_category);
			 expensedetail.setImage(image);
			 expensedetail.setActivationFlag("A");
			 expensedetail.setTotalAmount(total);
			 expensedetail.setSysCreationDate(new Date());
			 expensedetail.setNote(expense_note);
			 
			 int status = expensedao.addExpense(expensedetail);
			Gson gson=new Gson();
			response.setContentType("application/json");
			String jsonString=gson.toJson(status+"");
			response.getWriter().println(jsonString);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}		
		
	}
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try{
			ArrayList<String> paid_for = new ArrayList<String>();
			HashMap<String,Double> paid_for_amount = new HashMap<String,Double>();
			String added_by = request.getParameter("added_by");
			String expense_title = request.getParameter("expense_title");
			String paid_by = request.getParameter("paid_by");
			String spaid_for = request.getParameter("paid_for");
			String expense_category = request.getParameter("expense_category");
			String added_date = request.getParameter("added_date");
			String image = request.getParameter("expense_file2");
			String expense_note = null;
			double total = Double.parseDouble(request.getParameter("total"));
			int group_id = Integer.parseInt(request.getParameter("group_id"));
			
			if(request.getParameter("expense_note") != null)
			{
				expense_note = request.getParameter("expense_note");
			}
			
			paid_for.add(spaid_for);
			paid_for_amount.put(spaid_for,total);
			
			 ExpenseDao expensedao = new ExpenseDao();
			 int expense_id = expensedao.getId()+1;
			 DateFormat df = new SimpleDateFormat("yyyy/MM/dd"); 
			 ExpenseDetail expensedetail = new ExpenseDetail();
			 expensedetail.setExpenseId(expense_id);
			 expensedetail.setGroupId(group_id);
			 expensedetail.setAddedById(added_by);
			 expensedetail.setPaidById(paid_by);
			 expensedetail.setPaidForId(paid_for);
			 expensedetail.setAmount(paid_for_amount);
			 expensedetail.setName(expense_title);
			 expensedetail.setAddedDate(new Date());
			 expensedetail.setCategory(expense_category);
			 expensedetail.setImage(image);
			 expensedetail.setActivationFlag("A");
			 expensedetail.setTotalAmount(total);
			 expensedetail.setSysCreationDate(new Date());
			 expensedetail.setNote(expense_note);
			 
			 int status = expensedao.addExpense(expensedetail);
			response.sendRedirect("jsp/dashboard.jsp");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}		
		
	}
}