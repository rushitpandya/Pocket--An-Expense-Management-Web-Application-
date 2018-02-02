	package pocket.utility;
	
	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	
	public class DbUtil {
		
		private static final String MYSQLURL = "jdbc:mysql://127.0.0.1:3306/pocketdb";
	    private static final String MYSQL_DRIVER_NAME = "com.mysql.jdbc.Driver";
	    private static String user_name="root";
		private static String pwd="root";
	    
	    public static Connection getConnection() throws SQLException {
			Connection con= null;
			
			try{
				 
				Class.forName(MYSQL_DRIVER_NAME);
				con=DriverManager.getConnection(MYSQLURL,user_name,pwd);
			}
			catch(ClassNotFoundException e){
				e.printStackTrace();
				
			}
			return con;
		}
	
	    
		public static  void closeResultSet(ResultSet rs) {
			if( rs!=null){
				try{
					 rs.close();
					
				}catch(SQLException e){
					e.printStackTrace();
				}
			
			}
		}
	
		public static void closeStatement(PreparedStatement createCustomerPS) {
			if(createCustomerPS!=null){
				try{
					createCustomerPS.close();
					
				}catch(SQLException e){
					e.printStackTrace();
				}
			}	
		}
	
		public static void closeConnection(Connection conn) {
			if(conn!=null){
				try{
					conn.close();
					
				}catch(SQLException e){
					e.printStackTrace();
				}
			}		
		}
		
	
	}
