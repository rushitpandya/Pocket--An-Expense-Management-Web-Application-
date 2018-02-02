package pocket.beans;

import java.util.Date;

public class CommentPojo implements java.io.Serializable{
 String expense_id;
String commentid;
 String comment;
 String username;
String date;
 
	
	public CommentPojo(String expense_id,String comment, String username,String commentid,String date){
		this.expense_id=expense_id;
		this.commentid=commentid;
		this.date = date;
		
		this.comment = comment;
		this.username = username;
		
	}
	
	
	public CommentPojo() {
		
	}

	public String getExpenseId() {
		return expense_id;
	}

	public void setExpenseId(String expense_id) {
		this.expense_id = expense_id;
	}
	public String getCommentId() {
		return commentid;
	}

	public void setCommentId(String commentid) {
		this.commentid = commentid;
	}
public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
}