package pocket.dao;

import pocket.utility.*;
import pocket.beans.*;
import java.sql.*;
import com.mongodb.*;
import java.util.*;
import java.io.*;
import java.text.SimpleDateFormat;


public class MongodbDao{
	DBCollection mycomments;
	DB db;
	static int count = 1;
	public  void getConnection()
	{
		
		MongoClient mongo;
		mongo = new MongoClient("localhost",27017);
		
		 db = mongo.getDB("Comments");
		mycomments =db.getCollection("myComment");
		
	}
	public  void insertComment(String expense_id,String username,String comment)
	{
		String TimeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
		
		getConnection();
		
		BasicDBObject doc = new BasicDBObject("title","Comments").
		append("expenseId",expense_id).
		append("username",username).
		append("Date",TimeStamp).
		append("comment_id",count).
		append("Comment",comment);
		mycomments.insert(doc);
		count = count + 1;
		
	}
	
	public  HashMap<String, ArrayList<CommentPojo>> selectComment()

	{

		getConnection();

		HashMap<String, ArrayList<CommentPojo>> reviewHashmap=new HashMap<String, ArrayList<CommentPojo>>();
		DBCursor cursor = mycomments.find();

		while (cursor.hasNext())				
					
		{							
			BasicDBObject obj = (BasicDBObject) cursor.next();		
			if(! reviewHashmap.containsKey(obj.getString("expenseId")))
			{							
										
				ArrayList<CommentPojo> arr = new ArrayList<CommentPojo>();				
				reviewHashmap.put(obj.getString("expenseId"), arr);		
			}							
			ArrayList<CommentPojo> listReview = reviewHashmap.get(obj.getString("expenseId"));
			CommentPojo review =new	CommentPojo(obj.getString("Comment"),obj.getString("username"),obj.getString("expenseId"),obj.getString("comment_id"),obj.getString("Date"));		
		
			listReview.add(review);							
		}					
		return  reviewHashmap;					
				
	}							
	public  void deleteComment(Integer comment_id)
    {
        
        getConnection();
        
        BasicDBObject document = new BasicDBObject();
        document.put("comment_id",comment_id);
        
        mycomments.remove(document);
        System.out.println("deleted from database");
    
        
    }
}