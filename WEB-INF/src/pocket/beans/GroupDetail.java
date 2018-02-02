package pocket.beans;
import java.util.ArrayList;


public class GroupDetail{
	
	private int groupid;
	private String name;
	private ArrayList<String> email_id = new ArrayList<>();

	public GroupDetail(){}
	
	public GroupDetail(int groupid, String name,  ArrayList<String> email_id){
		this.groupid = groupid;
		this.name = name;
		this.email_id = email_id;
	}
	
	public GroupDetail(int groupid){
		this.groupid = groupid;
	}

	public int getGroupId() {
		return groupid;
	}

	public void setGroupId(int groupid) {
		this.groupid = groupid;
	}
	
	public String getGroupName(){
		return name;
	}
	
	public void setGroupName(String name){
		this.name = name;
	}
	
	
	public ArrayList<String> getEmailid() {
		return email_id;
	}

	public void setEmailid(ArrayList<String> email_id) {
			this.email_id = email_id;
		}
	
}