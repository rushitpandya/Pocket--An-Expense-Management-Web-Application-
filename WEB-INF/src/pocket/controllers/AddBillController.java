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

public class AddBillController extends HttpServlet {

	ArrayList<String> usersList,groupsList;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		usersList = new ArrayList<String>();
		JSONObject obj =null;
		JSONArray arr = new JSONArray();
		
	try{
		if(request.getParameter("search_keyword") != null)
		{	
			String search_keyword= request.getParameter("search_keyword");
			HttpSession session = request.getSession();
			String email1=null;
			if(session.getAttribute("User")!= null)
			{ 
				UserDetail sessionuser = (UserDetail)session.getAttribute("User");
				email1 = sessionuser.getEmailId();
			}
			
			if(!search_keyword.equals(""))
			{
				ExpenseDao dao1 = new ExpenseDao();
				LoginDao dao = new LoginDao();
				HashMap<String,UserDetail> users=dao1.getFriendListByEmail(email1);
				
				GroupDao groupdao = new GroupDao();
				ArrayList<GroupDetail> groups=groupdao.getAllGroups();
				for(Map.Entry<String,UserDetail> entry : users.entrySet())
				{
					UserDetail user = (UserDetail)entry.getValue();
					
					String email= user.getEmailId();
					
					if (email.toLowerCase().startsWith(search_keyword.toLowerCase()))
					{
						if(!usersList.contains(email))
						{
							usersList.add(email);
							obj = new JSONObject();
							obj.put("id","user");
							obj.put("name",email);
							arr.put(obj);
						}
					}
				}
				
				
				for(GroupDetail group: groups)
				{
					String group_name= group.getGroupName();
					//System.out.println(search_keyword.toLowerCase());
					
					if (group_name.toLowerCase().startsWith(search_keyword.toLowerCase()))
					{
						
						if(!usersList.contains(group_name))
						{
							usersList.add(group_name);
							obj = new JSONObject();
							obj.put("id",group.getGroupId());
							obj.put("name",group_name);
							arr.put(obj);
						}
					}
				}
				
			//Gson gson=new Gson();
			response.setContentType("application/json");
			//String jsonString=gson.toJson(arr);
			
			response.getWriter().println(arr.toString());
			}
		}

		
		
		
		
		
		if(request.getParameter("addGroupFriends") != null)
		{
			String group_name=request.getParameter("addGroupFriends");
			groupsList = new ArrayList<String>();
			GroupDao groupdao = new GroupDao();
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupName(group_name);
			GroupDetail group=groupdao.getGroupMembersByName(groupDetail);
			ArrayList<String> emails = new ArrayList<String>();
			
				for(String groupemail : group.getEmailid())
				{
					groupsList.add(groupemail);
				}
			Gson gson=new Gson();
			response.setContentType("application/json");
			String jsonString=gson.toJson(groupsList);
			response.getWriter().println(jsonString);
		}	

		
		if(request.getParameter("getGroupId") != null)
		{
			String group_name=request.getParameter("getGroupId");
			groupsList = new ArrayList<String>();
			GroupDao groupdao = new GroupDao();
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupName(group_name);
			GroupDetail group=groupdao.getGroupMembersByName(groupDetail);
			
			
				
					groupsList.add(group.getGroupId()+"");
				
				
			Gson gson=new Gson();
			response.setContentType("application/json");
			String jsonString=gson.toJson(groupsList);
			response.getWriter().println(jsonString);
		}	

		
		if(request.getParameter("removeGroupFriends") != null)
		{
			int group_id=Integer.parseInt(request.getParameter("removeGroupFriends"));
			groupsList = new ArrayList<String>();
			GroupDao groupdao = new GroupDao();
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupId(group_id);
			GroupDetail group=groupdao.getGroupMembersById(groupDetail);
			
			
				for(String groupemail : group.getEmailid())
				{
					groupsList.add(groupemail);
				}
			
			Gson gson=new Gson();
			response.setContentType("application/json");
			String jsonString=gson.toJson(groupsList);
			response.getWriter().println(jsonString);
		}	

		if(request.getParameter("removeGroupName") != null)
		{
			int group_id=Integer.parseInt(request.getParameter("removeGroupName"));
			groupsList = new ArrayList<String>();
			GroupDao groupdao = new GroupDao();
			GroupDetail groupDetail = new GroupDetail();
			groupDetail.setGroupId(group_id);
			GroupDetail groups=groupdao.getGroupNameByGroupId(groupDetail);
			
		
					groupsList.add(groups.getGroupName());
				
			
			Gson gson=new Gson();
			response.setContentType("application/json");
			String jsonString=gson.toJson(groupsList);
			response.getWriter().println(jsonString);
		}		
	}catch(Exception e){
		e.getMessage();
	}	
	}
}	