package pocket.dao;

import pocket.utility.*;
import pocket.beans.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class GroupDao{

			public Connection connection=null;
			public PreparedStatement statement=null;
			public ResultSet resultSet=null;
			
			public ArrayList<GroupDetail> getAllGroups(){
			String sql = "select * from groupdetail ";
			GroupDetail groupDetail=null;
			Connection connection=null;
			ArrayList<GroupDetail> groups= new ArrayList<GroupDetail>();
			
			PreparedStatement statement=null;
			try {
					connection = DbUtil.getConnection();
					statement = connection.prepareStatement(sql);
					
					ResultSet rs = statement.executeQuery();
					while(rs.next()){
						groupDetail = new GroupDetail();
						groupDetail.setGroupName(rs.getString("name"));
						//groupDetail.setEmailId(rs.getString("email_id"));
						groupDetail.setGroupId(rs.getInt("group_id"));
						groups.add(groupDetail);
					}
					DbUtil.closeResultSet(rs);
				} 
			catch (SQLException e){
					e.printStackTrace();
					return groups;
			}
			finally {
					DbUtil.closeStatement(statement);
					DbUtil.closeConnection(connection);
			 }
			return groups;
		}

		public GroupDetail getGroupMembersByName(GroupDetail groupdetail){
			String sql = "select * from groupdetail where name=?";
			GroupDetail groupDetail=null;
			Connection connection=null;
			ArrayList<GroupDetail> groups= new ArrayList<GroupDetail>();
			ArrayList<String> emails = new ArrayList<String>();
			PreparedStatement statement=null;
			try {
					connection = DbUtil.getConnection();
					statement = connection.prepareStatement(sql);
					statement.setString(1,groupdetail.getGroupName());
					ResultSet rs = statement.executeQuery();
					groupDetail = new GroupDetail();
					while(rs.next()){
						groupDetail.setGroupName(rs.getString("name"));
						emails.add(rs.getString("email_id"));
						groupDetail.setGroupId(rs.getInt("group_id"));
					}
					groupDetail.setEmailid(emails);
					//groups.add(groupDetail);
					DbUtil.closeResultSet(rs);
				} 
			catch (SQLException e){
					e.printStackTrace();
					return groupDetail;
			}
			finally {
					DbUtil.closeStatement(statement);
					DbUtil.closeConnection(connection);
			 }
			return groupDetail;
		}

		
		public GroupDetail getGroupMembersById(GroupDetail groupdetail){
			String sql = "select * from groupdetail where group_id=?";
			GroupDetail groupDetail=null;
			Connection connection=null;
			ArrayList<GroupDetail> groups= new ArrayList<GroupDetail>();
			ArrayList<String> emails = new ArrayList<String>();
			PreparedStatement statement=null;
			try {
					connection = DbUtil.getConnection();
					statement = connection.prepareStatement(sql);
					statement.setInt(1,groupdetail.getGroupId());
					ResultSet rs = statement.executeQuery();
					groupDetail = new GroupDetail();
					while(rs.next()){
						groupDetail.setGroupName(rs.getString("name"));
						emails.add(rs.getString("email_id"));
						groupDetail.setGroupId(rs.getInt("group_id"));
					}
					groupDetail.setEmailid(emails);
					DbUtil.closeResultSet(rs);
				} 
			catch (SQLException e){
					e.printStackTrace();
					return groupDetail;
			}
			finally {
					DbUtil.closeStatement(statement);
					DbUtil.closeConnection(connection);
			 }
			return groupDetail;
		}
		
		public GroupDetail getGroupNameByGroupId(GroupDetail groupdetail){
			String sql = "select * from groupdetail where group_id=?";
			GroupDetail groupDetail=null;
			Connection connection=null;
			ArrayList<GroupDetail> groups= new ArrayList<GroupDetail>();
			ArrayList<String> emails = new ArrayList<String>();
			PreparedStatement statement=null;
			try {
					connection = DbUtil.getConnection();
					statement = connection.prepareStatement(sql);
					statement.setInt(1,groupdetail.getGroupId());
					ResultSet rs = statement.executeQuery();
					groupDetail = new GroupDetail();
					if(rs.next()){
						
						groupDetail.setGroupName(rs.getString("name"));
						emails.add(rs.getString("email_id"));
						groupDetail.setGroupId(rs.getInt("group_id"));
						
					}
					groupDetail.setEmailid(emails);
					DbUtil.closeResultSet(rs);
				} 
			catch (SQLException e){
					e.printStackTrace();
					return groupDetail;
			}
			finally {
					DbUtil.closeStatement(statement);
					DbUtil.closeConnection(connection);
			 }
			return groupDetail;
		}
		
	/*	
		//Created By Divya
		public ArrayList<GroupDetail> getGroupDetailByEmail(GroupDetail groupdetail){
            String sql = "select * from groupdetail where email_id=?";
            //GroupDetail groupDetail=null;
            Connection connection=null;
            ArrayList<GroupDetail> groups= new ArrayList<GroupDetail>();
            PreparedStatement statement=null;
            try {
                    connection = DbUtil.getConnection();
                    statement = connection.prepareStatement(sql);
					for(String s:groupdetail.getEmailid()){
							if(s !=  null && !s.equals("")){
								statement.setString(1,s);	
							}
					}
					
					ResultSet rs = statement.executeQuery();
                    //statement.setString(1,groupdetail.getEmailid());
                     //groupDetail = new GroupDetail();
                    while(rs.next()){
                    	GroupDetail groupDetail = new GroupDetail();
                        groupDetail.setGroupName(rs.getString("name"));
                        groupDetail.setGroupId(rs.getInt("group_id"));
                        groups.add(groupDetail);
                    }
                    DbUtil.closeResultSet(rs);
                } 
            catch (SQLException e){
                    e.printStackTrace();
                    return groups;
            }
            finally {
                    DbUtil.closeStatement(statement);
                    DbUtil.closeConnection(connection);
             }
            return groups;
        }
*/
        public GroupDetail getGroupDetailById(GroupDetail groupdetail){
            String sql = "select * from groupdetail where group_id=?";
            //GroupDetail groupDetail=null;
            Connection connection=null;
            GroupDetail groupDetail = new GroupDetail();
            PreparedStatement statement=null;
            try {
                    connection = DbUtil.getConnection();
                    statement = connection.prepareStatement(sql);
                    
                                statement.setInt(1,groupdetail.getGroupId());    
                            
                    
                    
                    ResultSet rs = statement.executeQuery();
                    //statement.setString(1,groupdetail.getEmailid());
                     //groupDetail = new GroupDetail();
                    
                    ArrayList<String> emails = new ArrayList<String>();
                    while(rs.next()){
                        
                       groupDetail.setGroupId(rs.getInt("group_id"));
                        groupDetail.setGroupName(rs.getString("name"));
                        emails.add(rs.getString("email_id"));
                        
                   }
                    groupDetail.setEmailid(emails);
					System.out.println("--------Group Emails:"+emails.toString());
                    DbUtil.closeResultSet(rs);
                }
                
            catch (SQLException e){
                    e.printStackTrace();
                    return null;
            }
            finally {
                    DbUtil.closeStatement(statement);
                    DbUtil.closeConnection(connection);
             }
            return groupDetail;
        }
		

	
	
///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           addGroup()
// Parameters:      Object of GroupDetail class
// Purpose:         This method is use to create a new Group. GroupController will call this method and pass 
//					groupdetail object which contains all details like Groupname and email ids in that group.
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/11/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////
	public boolean addGroup(GroupDetail groupDetail)
	{
		try{
			Connection conn = DbUtil.getConnection();
			String query = "insert into groupdetail (group_id,name,email_id) values(?,?,?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1,groupDetail.getGroupId());
			ps.setString(2,groupDetail.getGroupName());
			for(String s:groupDetail.getEmailid()){
				if(s !=  null && !s.equals("")){
					ps.setString(3,s);
					ps.executeUpdate();
				}
			}
			//statement.setString(3, Arrays.toString(groupDetail.getEmailid().toArray()).replaceAll("\\[|\\]", "").replaceAll(", ",","));
			
			//ps.execute();
			
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
	
	
	///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           getid()
// Parameters:      N/A
// Purpose:         Before creating this method GroupController call this method to get the maximum group_id in the db
//					and then it will return the MAX groupid to GroupController.
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/11/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////

	public int getid()
	{
		int groupid=0;
		try{
			//GroupDetail groupDetail = new GroupDetail();
			Connection conn = DbUtil.getConnection();
			System.out.println("first it goes over here");
			String sql = "SELECT MAX(group_id) AS groupid FROM groupdetail";
			statement = conn.prepareStatement(sql);
			resultSet = statement.executeQuery();
			resultSet.next();
			System.out.println("it goes over here");
			groupid = resultSet.getInt(1);
			System.out.println("Query fetched the data");
			System.out.println(resultSet.getInt("groupid"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			//return false;
		}
		return groupid;
	
	}
	
	

	///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           getGroupDetailByEmail()
// Parameters:      Object of GroupDetail class
// Purpose:         This method is use to get Group names and group id's the details of group based on email_id
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/11/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////
	public ArrayList<GroupDetail> getGroupDetailByEmail(GroupDetail groupdetail){
				String sql = "select * from groupdetail where email_id=?";
				//GroupDetail groupDetail=null;
				Connection connection=null;
				ArrayList<GroupDetail> groups= new ArrayList<GroupDetail>();
				PreparedStatement statement=null;
				try {
						connection = DbUtil.getConnection();
						statement = connection.prepareStatement(sql);
						for(String s:groupdetail.getEmailid()){
								if(s !=  null && !s.equals("")){
									statement.setString(1,s);	
								}
						}
						
						ResultSet rs = statement.executeQuery();
						//statement.setString(1,groupdetail.getEmailid());
						 //groupDetail = new GroupDetail();
						while(rs.next()){
							GroupDetail groupDetail = new GroupDetail();
							groupDetail.setGroupName(rs.getString("name"));
							groupDetail.setGroupId(rs.getInt("group_id"));
							groups.add(groupDetail);
						}
						DbUtil.closeResultSet(rs);
					} 
				catch (SQLException e){
						e.printStackTrace();
						return groups;
				}
				finally {
						DbUtil.closeStatement(statement);
						DbUtil.closeConnection(connection);
				 }
				return groups;
			}
	



	///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           getGroupDetailByEmail()
// Parameters:      Object of GroupDetail class
// Purpose:         This method is use to get Group names and group id's the details of group based on email_id
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/11/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////	
		public GroupDetail getGroupDetails(int group_id)
		{
			GroupDetail groupdetail = new GroupDetail();
			try{
				Connection conn = DbUtil.getConnection();
				group_id = group_id;
				String sql = "select * from groupdetail where group_id=?";
				PreparedStatement statement = conn.prepareStatement(sql);
				statement.setInt(1,group_id);
				ResultSet rs = statement.executeQuery();
				ArrayList<String> userIdList = new ArrayList<String>();
				while(rs.next()){
					groupdetail.setGroupName(rs.getString("name"));
					groupdetail.setGroupId(rs.getInt("group_id"));
					userIdList.add(rs.getString("email_id"));
				}
							groupdetail.setEmailid(userIdList);
				
				DbUtil.closeStatement(statement);
				DbUtil.closeConnection(conn);
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
				
			}
			return groupdetail;
		}
		
		
		

	///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           getGroupDetailByEmail()
// Parameters:      Object of GroupDetail class
// Purpose:         This method is use to delete the members of exisiting group.
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/11/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////
		public boolean deleteMembers(GroupDetail groupDetail)
		{
			//Check if person you are trying to remove has any outstanding left in the group or not.
			
			GroupDetail groupdetail = new GroupDetail();
				try{
						Connection conn = DbUtil.getConnection();
						String query = "delete from groupdetail where group_id=? and email_id=?";
						PreparedStatement ps = conn.prepareStatement(query);
						ps.setInt(1,groupDetail.getGroupId());
						for(String s:groupDetail.getEmailid()){
							if(s !=  null && !s.equals("")){
								ps.setString(2,s);
								ps.executeUpdate();
							}
					}
				
				
				DbUtil.closeStatement(statement);
				DbUtil.closeConnection(conn);
			}	
			catch(Exception e)
			{
				e.printStackTrace();
				return false;
				
			}
			return true;
		}
	
		
///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           updateGroup()
// Parameters:      Object of GroupDetail class
// Purpose:         This method is use to update the details of the group such as add a new member in the group. 
//					It is also used to change the name of the group.
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/11/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////
	public boolean updateGroup(GroupDetail groupDetail)
	{
		try{
			Connection conn = DbUtil.getConnection();
			String query1 = "update groupdetail set name=? where group_id=?";
			PreparedStatement ps1 = conn.prepareStatement(query1);
			ps1.setString(1,groupDetail.getGroupName());
			ps1.setInt(2,groupDetail.getGroupId());
			ps1.executeUpdate();
			
			String query2 = "insert into groupdetail (group_id,name,email_id) values(?,?,?)";
			PreparedStatement ps2 = conn.prepareStatement(query2);
			ps2.setInt(1,groupDetail.getGroupId());
			ps2.setString(2,groupDetail.getGroupName());
			for(String s:groupDetail.getEmailid()){
				if(s !=  null && !s.equals("")){
					ps2.setString(3,s);
					ps2.executeUpdate();
				}
			}
			
			
			DbUtil.closeStatement(ps1);
			DbUtil.closeStatement(ps2);
			DbUtil.closeConnection(conn);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}

	
	

	///////////////////////////////////////////////////////////////////////////////
//                   ALL members COMPLETE THESE SECTIONS
// Title:           deleteGroup()
// Parameters:      Object of GroupDetail class
// Purpose:         This method is use to get Group names and group id's the details of group based on email_id
// Author:           Rishabh Shah
// Last Change By:   N/A
// Change Date:      11/11/2017
// Comments:  		 
//
//////////////////// PAIR PROGRAMMERS COMPLETE THIS SECTION ////////////////////
	public boolean deleteGroup(GroupDetail groupDetail){
		
			GroupDetail groupdetail = new GroupDetail();
				try{
						Connection conn = DbUtil.getConnection();
						String query = "delete from groupdetail where group_id=?";
						PreparedStatement ps = conn.prepareStatement(query);
						ps.setInt(1,groupDetail.getGroupId());
						ps.executeUpdate();
						DbUtil.closeStatement(statement);
						DbUtil.closeConnection(conn);
			}	
			catch(Exception e)
			{
				e.printStackTrace();
				return false;
				
			}
			return true;
		}
}
