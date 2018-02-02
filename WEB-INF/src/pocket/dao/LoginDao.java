package pocket.dao;

import pocket.utility.*;
import pocket.beans.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class LoginDao{
	
	public boolean existsEmail(UserDetail userDetail)
	{
		try{
			Connection conn = DbUtil.getConnection();
			String query = "select * from userDetail where email_id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,userDetail.getEmailId());
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				DbUtil.closeResultSet(rs);
				DbUtil.closeStatement(ps);
				DbUtil.closeConnection(conn);
				return true;
			}
			DbUtil.closeResultSet(rs);
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean existsEmailAndFlag(UserDetail userDetail)
	{
		try{
			Connection conn = DbUtil.getConnection();
			String query = "select * from userDetail where email_id=? and signup_flag=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,userDetail.getEmailId());
			ps.setString(2,userDetail.getSignupFlag());
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				DbUtil.closeResultSet(rs);
				DbUtil.closeStatement(ps);
				DbUtil.closeConnection(conn);
				return true;
			}
			DbUtil.closeResultSet(rs);
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean insertUserDetail(UserDetail userDetail)
	{
		try{
			Connection conn = DbUtil.getConnection();
			String query = "insert into userDetail (email_id,password,firstname,lastname,activation_flag,verification_token,signup_flag,fb_id,gmail_id,profile_pic,expense_limit) values(?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,userDetail.getEmailId());
			ps.setString(2,userDetail.getPassword());
			ps.setString(3,userDetail.getFirstName());
			ps.setString(4,userDetail.getLastName());
			ps.setString(5,userDetail.getActivationFlag());
			ps.setString(6,userDetail.getVerificationToken());
			ps.setString(7,userDetail.getSignupFlag());
			ps.setString(8,userDetail.getFbId());
			ps.setString(9,userDetail.getGmailId());
			ps.setString(10,userDetail.getProfilePic());
			ps.setDouble(11,userDetail.getExpenseLimit());
			ps.execute();
			
			DbUtil.closeStatement(ps);
			DbUtil.closeConnection(conn);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
	public boolean updateActivationFlag(UserDetail userDetail){
		String sql = "update userDetail set activation_flag = ? where email_id=?";
		boolean s = false;
		Connection connection=null;
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setString(1, userDetail.getActivationFlag());
				statement.setString(2, userDetail.getEmailId());
				
				statement.executeUpdate();
				s=true;
			} 
		catch (SQLException e){
				e.printStackTrace();
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }
		return s;
		
	}

	public boolean checkToken(UserDetail userDetail){
		boolean insert = false;
		String sql = "select verification_token from userDetail where email_id=?;";
		Connection connection=null;
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setString(1, userDetail.getEmailId());
				
				ResultSet rs = statement.executeQuery();
				while(rs.next()){
					if (rs.getString("verification_token").equals(userDetail.getVerificationToken()))
					{
						insert = true;
					}
					else
					{
						insert = false;
					}
				}
				DbUtil.closeResultSet(rs);
			} 
		catch (SQLException e){
				e.printStackTrace();
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }
		
		return insert;
	}

	public UserDetail getUserDetail(UserDetail user){
		String sql = "select * from userDetail where email_id=?;";
		UserDetail userDetail=null;
		Connection connection=null;
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setString(1, user.getEmailId());
				
				ResultSet rs = statement.executeQuery();
				if(rs.next()){
					userDetail = new UserDetail();
					userDetail.setEmailId(rs.getString("email_id"));
					userDetail.setPassword(rs.getString("password"));
					userDetail.setFirstName(rs.getString("firstname"));
					userDetail.setLastName(rs.getString("lastname"));
					userDetail.setActivationFlag(rs.getString("activation_flag"));
					userDetail.setVerificationToken(rs.getString("verification_token"));
					userDetail.setSignupFlag(rs.getString("signup_flag"));
					userDetail.setFbId(rs.getString("fb_id"));
					userDetail.setGmailId(rs.getString("gmail_id"));
					userDetail.setProfilePic(rs.getString("profile_pic"));
					userDetail.setExpenseLimit(rs.getDouble("expense_limit"));
				}
				DbUtil.closeResultSet(rs);
			} 
		catch (SQLException e){
				e.printStackTrace();
				return userDetail;
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }
		return userDetail;
	}
	
	public boolean updateVerificationToken(UserDetail userDetail) {
	int count = 0;
	
		Connection connection=null;
		PreparedStatement statement=null;
		ResultSet rs = null;
		boolean flag = false;
		String sql = "SELECT COUNT(email_id) AS EMAIL_ID_count FROM userDetail WHERE email_id=?";
		String sql_update = "UPDATE userDetail SET VERIFICATION_TOKEN=? WHERE EMAIL_ID=? ";
		try {

				
				connection = DbUtil.getConnection();
				
				statement = connection.prepareStatement(sql);
				statement.setString(1, userDetail.getEmailId());
				
				rs = statement.executeQuery();
				if(rs.next())
				{
					count = rs.getInt(1);
				}
		}
		catch (SQLException e){
				e.printStackTrace();
				DbUtil.closeResultSet(rs);
				DbUtil.closeStatement(statement);
		}
		if (count == 0) 
		{
			flag = false;
			return flag;
		} 
		else 
		{
			try {
				
				statement = connection.prepareStatement(sql_update);
				statement.setString(1, userDetail.getVerificationToken());
				statement.setString(2, userDetail.getEmailId());
				 int update_count= statement.executeUpdate();

				
				if(update_count==1 && count>0)
				{
					flag = true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
				DbUtil.closeResultSet(rs);
				DbUtil.closeStatement(statement);
			}
			finally {
				DbUtil.closeResultSet(rs);
				DbUtil.closeStatement(statement);
				DbUtil.closeConnection(connection);
			}
			
		}
	return flag;
	}

	public boolean setNewPassword(UserDetail userDetail, String newPassword){
		UserDetail user = new UserDetail();
		
		Connection connection=null;
		PreparedStatement statement=null;
		boolean update =false;
		int rowsUpdated;
		String sql ="UPDATE userDetail SET PASSWORD=? WHERE EMAIL_ID=?";
		try {
				
				connection = DbUtil.getConnection();
				
				statement = connection.prepareStatement(sql);
				statement.setString(1, newPassword);
				statement.setString(2, userDetail.getEmailId());
				rowsUpdated = statement.executeUpdate();
				if (rowsUpdated > 0) 
				{
					update=true;		
				}
				else
				{
					update=false;
				}
		}
		catch (SQLException e) {
				e.printStackTrace();
		}
		finally {
    	    DbUtil.closeStatement(statement);
    	    DbUtil.closeConnection(connection);
		}
	
		return update;
		
	}
	
	public void updateProfile(UserDetail userDetail){
		String sql = "update userDetail set firstname=?,lastname=? where email_id=? ";
		Connection connection=null;
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setString(1, userDetail.getFirstName());
				statement.setString(2, userDetail.getLastName());
				statement.setString(3,userDetail.getEmailId());
				
				statement.execute();
			} 
		catch (SQLException e){
				e.printStackTrace();
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }
		
		
	}
		public void updateLimit(UserDetail userDetail){
		String sql = "update userDetail set expense_limit=? where email_id=? ";
		Connection connection=null;
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setDouble(1, userDetail.getExpenseLimit());
				statement.setString(2,userDetail.getEmailId());
				
				statement.execute();
			} 
		catch (SQLException e){
				e.printStackTrace();
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }
		
		
	}
	public void updatePassword(UserDetail userDetail){
		String sql = "update userDetail set password=? where email_id=? ";
		Connection connection=null;
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setString(1, userDetail.getPassword());
				statement.setString(2,userDetail.getEmailId());
				
				statement.execute();
			} 
		catch (SQLException e){
				e.printStackTrace();
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }	
	}
	
	public void changeProfilePicture(UserDetail userDetail){
		String sql = "update userDetail set profile_pic=? where email_id=? ";
		Connection connection=null;
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setString(1, userDetail.getProfilePic());
				statement.setString(2,userDetail.getEmailId());
				
				statement.execute();
			} 
		catch (SQLException e){
				e.printStackTrace();
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }	
	}
	
	public ArrayList<UserDetail> getAllUsers(){
		String sql = "select * from userDetail ";
		UserDetail userDetail=null;
		Connection connection=null;
		ArrayList<UserDetail> users= new ArrayList<UserDetail>();
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				
				ResultSet rs = statement.executeQuery();
				while(rs.next()){
					userDetail = new UserDetail();
					userDetail.setEmailId(rs.getString("email_id"));
					userDetail.setPassword(rs.getString("password"));
					userDetail.setFirstName(rs.getString("firstname"));
					userDetail.setLastName(rs.getString("lastname"));
					userDetail.setActivationFlag(rs.getString("activation_flag"));
					userDetail.setVerificationToken(rs.getString("verification_token"));
					userDetail.setSignupFlag(rs.getString("signup_flag"));
					userDetail.setFbId(rs.getString("fb_id"));
					userDetail.setGmailId(rs.getString("gmail_id"));
					userDetail.setProfilePic(rs.getString("profile_pic"));
					userDetail.setExpenseLimit(rs.getDouble("expense_limit"));
					users.add(userDetail);
				}
				DbUtil.closeResultSet(rs);
			} 
		catch (SQLException e){
				e.printStackTrace();
				return users;
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }
		return users;
	}
	
	public static String getUserDetailByEmail(String email){
		String sql = "select * from userDetail where email_id=?;";
		UserDetail userDetail=null;
		Connection connection=null;
		String returnResult = "";
		PreparedStatement statement=null;
		try {
				connection = DbUtil.getConnection();
				statement = connection.prepareStatement(sql);
				statement.setString(1, email);
				
				ResultSet rs = statement.executeQuery();
				if(rs.next()){
					
					returnResult += rs.getString("firstname");
					returnResult += " "+rs.getString("lastname");
					
				}
				DbUtil.closeResultSet(rs);
			} 
		catch (SQLException e){
				e.printStackTrace();
				return returnResult;
		}
		finally {
	    	    DbUtil.closeStatement(statement);
	    	    DbUtil.closeConnection(connection);
	     }
		return returnResult;
	}
	
	//Created By Divya
	public static UserDetail getUser(String email){
        String sql = "select * from userDetail where email_id=?;";
        UserDetail userDetail=null;
        Connection connection=null;
        PreparedStatement statement=null;
        try {
                connection = DbUtil.getConnection();
                statement = connection.prepareStatement(sql);
                statement.setString(1, email);
                
                ResultSet rs = statement.executeQuery();
                if(rs.next()){
                    userDetail = new UserDetail();
                    userDetail.setEmailId(rs.getString("email_id"));
                    userDetail.setPassword(rs.getString("password"));
                    userDetail.setFirstName(rs.getString("firstname"));
                    userDetail.setLastName(rs.getString("lastname"));
                    userDetail.setActivationFlag(rs.getString("activation_flag"));
                    userDetail.setVerificationToken(rs.getString("verification_token"));
                    userDetail.setSignupFlag(rs.getString("signup_flag"));
                    userDetail.setFbId(rs.getString("fb_id"));
                    userDetail.setGmailId(rs.getString("gmail_id"));
                    userDetail.setProfilePic(rs.getString("profile_pic"));
                    userDetail.setExpenseLimit(rs.getDouble("expense_limit"));
                }
                DbUtil.closeResultSet(rs);
            } 
        catch (SQLException e){
                e.printStackTrace();
                return userDetail;
        }
        finally {
                DbUtil.closeStatement(statement);
                DbUtil.closeConnection(connection);
         }
        return userDetail;
    }
}