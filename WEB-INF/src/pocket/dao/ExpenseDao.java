package pocket.dao;

import pocket.utility.*;
import pocket.beans.*;
import pocket.dao.*;

import java.sql.*;
import java.util.*;
import java.text.*;




public class ExpenseDao{
	
	//Created By Rushit
	public int addExpense(ExpenseDetail expensedetail)
	{
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			HashMap<String,Double> paid_for_amount= expensedetail.getAmount(); 
			for (Map.Entry<String, Double> entry : paid_for_amount.entrySet()) 
			{
				String paid_for = entry.getKey();
				double paid_for_value = entry.getValue();
				
				String sql = "insert into expensedetail (expense_id,group_id,added_by_id,paid_by_id,paid_for_id,amount,name,added_date,category,image,activation_flag,total_amount,Sys_creation_date,note) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				
				Connection connection=null;
				PreparedStatement statement=null;
				try {
						connection = DbUtil.getConnection();
						statement = connection.prepareStatement(sql);		
						statement.setInt(1,expensedetail.getExpenseId());
						statement.setInt(2,expensedetail.getGroupId());
						statement.setString(3,expensedetail.getAddedById());
						statement.setString(4,expensedetail.getPaidById());
						statement.setString(5,paid_for);
						statement.setDouble(6,paid_for_value);
						statement.setString(7,expensedetail.getName());
						statement.setDate(8,new java.sql.Date(expensedetail.getAddedDate().getTime()));
						statement.setString(9,expensedetail.getCategory());
						statement.setString(10,expensedetail.getImage());
						statement.setString(11,expensedetail.getActivationFlag());
						statement.setDouble(12,expensedetail.getTotalAmount());
						statement.setDate(13,new java.sql.Date(expensedetail.getSysCreationDate().getTime()));
						statement.setString(14,expensedetail.getNote());
						statement.execute();
						
					} 
				catch (SQLException e){
						e.printStackTrace();
						return 0;
				}
				finally {
						DbUtil.closeStatement(statement);
						DbUtil.closeConnection(connection);
				 }
				
			}
			return 1;
	}
	//Created By Rushit
	public int getId()
	{
		int expenseid=0;
		Connection conn=null;
		PreparedStatement statement=null;
		ResultSet resultSet = null;
		try{
			conn = DbUtil.getConnection();
			String sql = "SELECT MAX(expense_id) AS expenseid FROM expensedetail";
			statement = conn.prepareStatement(sql);
			resultSet = statement.executeQuery();
			if(resultSet.next())
			{
				expenseid = resultSet.getInt(1);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return expenseid;
	
	}
	
	
	//Created By Divya
	
	
	public ExpenseDetail getExpenseByExpenseId(int expense_id)
	{
		//ExpenseDetail expenseDetail= null;
		try{
			ExpenseDetail expenseDetail =null;
			Connection conn = DbUtil.getConnection();
			String query = "select * from expenseDetail where expense_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1,expense_id);
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
			ArrayList<String> tmp = new ArrayList<String>();
			HashMap<String,Double> tmpMap = new HashMap<String,Double>();
				while(rs.next()){
					expenseDetail = new ExpenseDetail();
					expenseDetail.setExpenseId(rs.getInt("expense_id"));
					expenseDetail.setGroupId(rs.getInt("group_id"));
					expenseDetail.setAddedById(rs.getString("added_by_id"));
					expenseDetail.setPaidById(rs.getString("paid_by_id"));
					tmp.add(rs.getString("paid_for_id"));
					tmpMap.put(rs.getString("paid_for_id"),rs.getDouble("amount"));
					
					expenseDetail.setName(rs.getString("name"));
					expenseDetail.setAddedDate(rs.getDate("added_date"));
					expenseDetail.setCategory(rs.getString("category"));
					expenseDetail.setImage(rs.getString("image"));
					expenseDetail.setActivationFlag(rs.getString("activation_flag"));
					expenseDetail.setTotalAmount(rs.getDouble("total_amount"));
					expenseDetail.setSysCreationDate(rs.getDate("sys_creation_date"));
					expenseDetail.setNote(rs.getString("note"));
					//expense.put(expenseDetail.getExpenseId(),expenseDetail);
					System.out.println(expenseDetail.toString());
					//System.out.println("expenseDetail.getPaidForId()"+expenseDetail.getPaidForId());
				}
				expenseDetail.setPaidForId(tmp);
				expenseDetail.setAmount(tmpMap);
			
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			return expenseDetail;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		
	}

	public Map<Integer, HashMap<Integer, ExpenseDetail>> getExpensesByMonth(GroupDetail groupDetail)
	{
		//ExpenseDetail expenseDetail= null;
		try{
			
			Connection conn = DbUtil.getConnection();
			String query = "select added_date,expense_id from expensedetail where group_id=?  order by added_date desc; ";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1,groupDetail.getGroupId());
			Map<Integer, HashMap<Integer, ExpenseDetail>> mainMap = new HashMap<Integer, HashMap<Integer, ExpenseDetail>>();
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String month = new SimpleDateFormat("MM").format(rs.getDate("added_date"));
					int expense_id = rs.getInt("expense_id");
					ExpenseDetail expense = getExpenseByExpenseId(expense_id);
					HashMap<Integer, ExpenseDetail> tmp =null;
					if(mainMap.get(Integer.parseInt(month)) != null)
						tmp = mainMap.get(Integer.parseInt(month));
					else
						tmp = new HashMap<Integer, ExpenseDetail>();

					tmp.put(expense_id,expense);
					mainMap.put(Integer.parseInt(month),tmp);

					//System.out.println("expenseDetail.getPaidForId()"+expenseDetail.getPaidForId());
				}
				
			
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			return mainMap;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		
	}

	public HashMap<String, UserDetail> getFriendListByEmail(String email){

		HashMap<String, UserDetail> friendList = new HashMap<String, UserDetail>();
		try{
			
			Connection conn = DbUtil.getConnection();

			String query = "select paid_for_id from expensedetail where paid_by_id=? ; ";

			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,email);
			ResultSet rs = ps.executeQuery();
			System.out.println("-----in 3rd");
				while(rs.next() ){
					if(!rs.getString("paid_for_id").equals(email))
					{	
						LoginDao loginDao = new LoginDao();
						UserDetail user1 = new UserDetail();
						user1.setEmailId(rs.getString("paid_for_id"));
						UserDetail user2 = loginDao.getUserDetail(user1);
						System.out.println("user2 :"+user2);
						friendList.put(user2.getEmailId(),user2);
					}
				}
				
			String query1 = "select paid_by_id from expensedetail where paid_for_id=? ; ";
			PreparedStatement ps1 = conn.prepareStatement(query1);
			ps1.setString(1,email);
			ResultSet rs1 = ps1.executeQuery();
				while(rs1.next()){
					System.out.println("-----in 3rd");
					if(!rs1.getString("paid_by_id").equals(email))
					{
						LoginDao loginDao = new LoginDao();
						UserDetail user1 = new UserDetail();
						user1.setEmailId(rs1.getString("paid_by_id"));
						UserDetail user2 = loginDao.getUserDetail(user1);
						friendList.put(user2.getEmailId(),user2);
					}	
				}
				
			String query2 = "select group_id from groupdetail where email_id=?; ";
			PreparedStatement ps2 = conn.prepareStatement(query2);
			ps2.setString(1,email);
			ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()){
					String query3 = "select email_id from groupdetail where group_id=?";
					PreparedStatement ps3 = conn.prepareStatement(query3);
					ps3.setInt(1,rs2.getInt("group_id"));
					ResultSet rs3 = ps3.executeQuery();
					while(rs3.next())
					{
						System.out.println("-----in 3rd");
						if(!(rs3.getString("email_id").equals(email)))
						{
							LoginDao loginDao = new LoginDao();
							UserDetail user1 = new UserDetail();
							user1.setEmailId(rs3.getString("email_id"));
							UserDetail user2 = loginDao.getUserDetail(user1);
							friendList.put(user2.getEmailId(),user2);
						}
					}
					
				}	
				
				
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			//System.out.println(friendList.toString());
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		return friendList;
	}

	public Map<Integer, HashMap<Integer, ExpenseDetail>> getFriendExpensesByMonth(String email)
	{
		//ExpenseDetail expenseDetail= null;
		try{
			
			Connection conn = DbUtil.getConnection();
			String query = "select added_date,expense_id from expensedetail where paid_by_id=? or paid_for_id=? order by added_date desc; ";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,email);
			ps.setString(2,email);
			Map<Integer, HashMap<Integer, ExpenseDetail>> mainMap = new HashMap<Integer, HashMap<Integer, ExpenseDetail>>();
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String month = new SimpleDateFormat("MM").format(rs.getDate("added_date"));
					int expense_id = rs.getInt("expense_id");
					ExpenseDetail expense = getExpenseByExpenseId(expense_id);
					HashMap<Integer, ExpenseDetail> tmp =null;
					if(mainMap.get(Integer.parseInt(month)) != null)
						tmp = mainMap.get(Integer.parseInt(month));
					else
						tmp = new HashMap<Integer, ExpenseDetail>();

					tmp.put(expense_id,expense);
					mainMap.put(Integer.parseInt(month),tmp);

					//System.out.println("expenseDetail.getPaidForId()"+expenseDetail.getPaidForId());
				}
				
			
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			return mainMap;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		
	}
	public double getTotalPaidBy(UserDetail user){
		double total_paid_by = 0;
		try{
			Connection conn = DbUtil.getConnection();

			String query = "select paid_by_id,sum(amount) as total from expenseDetail where paid_by_id=? group by paid_by_id";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,user.getEmailId());
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
			
				if(rs.next()){
					total_paid_by = (rs.getDouble("total"));
					
				}
				
			//System.out.println("Total paid by" + Integer.toString(total_paid_by));
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			//return total_paid_by;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return 0.0;
		}
		return total_paid_by;
	}
	public double getTotalPaidFor(UserDetail user){
		double total_paid_for = 0;
		try{
			Connection conn = DbUtil.getConnection();

			String query = "select paid_for_id,sum(amount) as total from expenseDetail where paid_for_id=? group by paid_for_id";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,user.getEmailId());
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
			
				if(rs.next()){
					total_paid_for = (rs.getDouble("total"));
					
				}
			String query1 = "select paid_for_id,sum(amount) as total from expenseDetail where paid_by_id=? and name=? group by paid_for_id";
			PreparedStatement ps1 = conn.prepareStatement(query1);
			ps1.setString(1,user.getEmailId());
			ps1.setString(2,"Ewa_Demo_Settle_Up_aaaaaaa");
			ResultSet rs1 = ps1.executeQuery();
			if(rs1.next()){
				total_paid_for -= (rs1.getDouble("total"));
					
			}
			//System.out.println("Total paid by" + Integer.toString(total_paid_by));
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			//return total_paid_by;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return 0.0;
		}
		return total_paid_for;
	}

	public Map<String,Double> getUserExpenseByCategory(UserDetail user){
		Map<String,Double> categoryChart = new HashMap<String,Double>();
		try{
			Connection conn = DbUtil.getConnection();

			String query = "select category,sum(amount) as total from expenseDetail where paid_for_id=? group by category";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,user.getEmailId());
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
			
				while(rs.next()){
					categoryChart.put(rs.getString("category"),rs.getDouble("total"));
				}
				
			//System.out.println("Total paid by" + Integer.toString(total_paid_by));
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			//return total_paid_by;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		return categoryChart;
	}
	
	public static Map<String,Double> getGroupPaidById(int group_id){
		Map<String,Double> groupPaidById = new HashMap<String,Double>();
		try{
			Connection conn = DbUtil.getConnection();

			String query = "select paid_by_id,sum(amount) as total from expenseDetail where group_id=? group by paid_by_id";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1,group_id);
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
			
				while(rs.next()){
					groupPaidById.put(rs.getString("paid_by_id"),rs.getDouble("total"));
				}
				
			//System.out.println("Total paid by" + Integer.toString(total_paid_by));
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			//return total_paid_by;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		return groupPaidById;
	}

	public static Map<String,Double> getGroupPaidForId(int group_id){
		Map<String,Double> groupPaidForId = new HashMap<String,Double>();
		try{
			Connection conn = DbUtil.getConnection();

			String query = "select paid_for_id,sum(amount) as total from expenseDetail where group_id=? group by paid_for_id";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1,group_id);
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
			
				while(rs.next()){
					groupPaidForId.put(rs.getString("paid_for_id"),rs.getDouble("total"));
				}
				
			//System.out.println("Total paid by" + Integer.toString(total_paid_by));
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			//return total_paid_by;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		return groupPaidForId;
	}
	
	//Preyang
	
	public Double getTotalPaidExpenseForGroup(int groupId,String paid_by_id) {
		PreparedStatement ps = null;
		// String queryString = "INSERT INTO Utente(Nome, "
		// boolean st =false;
		Double tAmount = 0.0;
		HashMap<String,Double> expenseGroup = new HashMap<String,Double>();
		try {
			Connection conn = DbUtil.getConnection();
			ps = conn.prepareStatement("select sum(amount) as total from pocketdb.expensedetail where group_id =? and paid_by_id = ? group by paid_by_id"); 

			ps.setInt(1,groupId);
			ps.setString(2,paid_by_id);
			
			ResultSet rs= ps.executeQuery();
			
			 while(rs.next()){
				 System.out.println(rs.getDouble("total"));
					tAmount =   rs.getDouble("total");
						
					}
				System.out.println("check" +tAmount);

		} catch (Exception e) {
			e.printStackTrace();
			return 0.0;
		} 
			return tAmount;	
	}
	public Double getTotalOweExpenseForGroup(int groupId,String paid_for_id) {
		PreparedStatement ps = null;
		// String queryString = "INSERT INTO Utente(Nome, "
		// boolean st =false;
		Double tAmount = 0.0;
		HashMap<String,Double> expenseGroup = new HashMap<String,Double>();
		try {
			Connection conn = DbUtil.getConnection();
			ps = conn.prepareStatement("select sum(amount) as total from pocketdb.expensedetail where group_id =? and paid_for_id = ? group by paid_for_id"); 

			ps.setInt(1,groupId);
			ps.setString(2,paid_for_id);
			
			ResultSet rs= ps.executeQuery();
			
			 while(rs.next()){
				 System.out.println(rs.getDouble("total"));
					tAmount =   rs.getDouble("total");
						
					}
				System.out.println("check" +tAmount);

		} catch (Exception e) {
			e.printStackTrace();
			return 0.0;
		} 
			return tAmount;	
	}
	
	public HashMap<Integer,Double> getTotalExpenseByMonth(String useremail) {
		PreparedStatement ps = null;
		// String queryString = "INSERT INTO Utente(Nome, "
		// boolean st =false;
		HashMap<Integer,Double> expense = new HashMap<Integer,Double>();
		try {
			Connection conn = DbUtil.getConnection();
			ps = conn.prepareStatement("select month(added_date) as month,sum(Amount) as total from pocketdb.expensedetail where paid_for_id =? group by month(added_date) order by month(added_Date) asc "); 

			ps.setString(1,useremail);
			
			ResultSet rs= ps.executeQuery();
			 System.out.println("-------");
			 while(rs.next()){
				 System.out.println("-------"+rs.getInt("month") + rs.getDouble("total"));
					expense.put(rs.getInt("month"),rs.getDouble("total"));
						
					}
				System.out.println(expense.toString());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} 
			return expense;	
	}
	public HashMap<Integer,Double> getTotalExpenseByMonthForGroup(int groupId) {
		PreparedStatement ps = null;
		// String queryString = "INSERT INTO Utente(Nome, "
		// boolean st =false;
		HashMap<Integer,Double> expenseGroup = new HashMap<Integer,Double>();
		try {
			Connection conn = DbUtil.getConnection();
			ps = conn.prepareStatement("select month(added_date) as month,sum(Amount) as total from pocketdb.expensedetail where group_id =? group by month(added_date) order by month(added_date) asc "); 

			ps.setInt(1,groupId);
			
			ResultSet rs= ps.executeQuery();
			
			 while(rs.next()){
				 System.out.println(rs.getInt("month") + rs.getDouble("total"));
					expenseGroup.put(rs.getInt("month"),rs.getDouble("total"));
						
					}
				System.out.println("check" +expenseGroup.toString());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} 
			return expenseGroup;	
	}
	public HashMap<String,Double> getTotalExpenseByCategoryForGroup(int groupId) {
		PreparedStatement ps = null;
		// String queryString = "INSERT INTO Utente(Nome, "
		// boolean st =false;
		HashMap<String,Double> categoryGroup = new HashMap<String,Double>();
		try {
			Connection conn = DbUtil.getConnection();
			ps = conn.prepareStatement("select category,sum(Amount) as total from pocketdb.expensedetail where group_id =? group by category order by category asc"); 

			ps.setInt(1,groupId);
			
			ResultSet rs= ps.executeQuery();
			
			 while(rs.next()){
				 System.out.println(rs.getString("category") + rs.getDouble("total"));
					categoryGroup.put(rs.getString("category"),rs.getDouble("total"));
						
					}
				System.out.println("check" +categoryGroup.toString());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} 
			return categoryGroup;	
	}

	
	
		///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           getExpensePaidForId()
// Parameters:      email id of user which is currently in session
// Purpose:         
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/12/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////


	public HashMap<String,Double> getExpensePaidForId(String email)
	{
		try{
			
			Connection conn = DbUtil.getConnection();
			String query = "select paid_for_id, sum(amount) as total from expensedetail where paid_by_id=? group by paid_for_id;";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,email);
			
			HashMap<String, Double> hashMap = new HashMap<String, Double>();
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String paid_for_id = (rs.getString("paid_for_id"));
					double total = rs.getDouble("total");
					hashMap.put(paid_for_id,total);
				}
			
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			return hashMap;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		
	}
	
	
	
	///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           getExpensePaidById()
// Parameters:      email id of user which is currently in session
// Purpose:         
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/12/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////


	public HashMap<String, Double> getExpensePaidById(String email)
	{
		try{
			
			Connection conn = DbUtil.getConnection();
			String query = " select paid_by_id, sum(amount) as total from pocketdb.expensedetail where paid_for_id=? group by paid_by_id;";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,email);
			
			HashMap<String, Double> hashMap = new HashMap<String, Double>();
			//Map<Integer,ExpenseDetail> expense = new HashMap<Integer,ExpenseDetail>();
			ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String paid_by_id = (rs.getString("paid_by_id"));
					double total = rs.getDouble("total");
					hashMap.put(paid_by_id,total);
				}
			
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			return hashMap;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		
	}
	
	

	///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           getFinalResult()
// Parameters:      HashMap of paid_by_id and paid_for_id
// Purpose:         
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/13/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////

	public HashMap<String, Double> getFinalResult(HashMap<String, Double> paidForId, HashMap<String, Double> paidbyId)
	{
		HashMap<String, Double> resultMap = new HashMap<String, Double>();
		
		for(String key :paidForId.keySet())
			resultMap.put(key,0.0);
		
		for(String key :paidbyId.keySet())
			resultMap.put(key,0.0);
		
		for(String key:resultMap.keySet()){
			double paid, paidFor;
				
			if(paidForId.containsKey(key))
				paidFor = paidForId.get(key);
			else
				paidFor = 0;
			
			if(paidbyId.containsKey(key))
				paid = paidbyId.get(key);
			else
				paid = 0;
			
			
			
			resultMap.put(key,(paidFor-paid));
		}
		
		return resultMap;
	}
}