<%@page import="pocket.controllers.*"%>
<%@page import="java.util.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="pocket.beans.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>

<jsp:include page='header.jsp'/>


<%
UserDetail user = (UserDetail)session.getAttribute("User");
GroupDetail groupDetailSession = (GroupDetail)session.getAttribute("groupDetail");
String Status = (String)session.getAttribute("Status");
String PrintMsg = (String)session.getAttribute("PrintMsg");
String Action = (String)session.getAttribute("Action");
String email = user.getEmailId();
String emailExpenseDao = email;
System.out.println(email);
GroupDetail groupdetail = new GroupDetail();
ArrayList<String> email_id = new ArrayList<String>();
email_id.add(email);
groupdetail.setEmailid(email_id);
GroupDao groupDao = new GroupDao();
ExpenseDao expenseDao = new ExpenseDao();
ArrayList<GroupDetail> list = groupDao.getGroupDetailByEmail(groupdetail);
//HashMap<String, Double> paidforId = expenseDao.getExpensePaidForId(emailExpenseDao);
//HashMap<String, Double> paidbyId = expenseDao.getExpensePaidById(emailExpenseDao);
//HashMap<String,Double>result = expenseDao.getFinalResult(paidforId,paidbyId);
//System.out.println(paidforId);
//System.out.println(paidbyId);
%>



<%

if(Action !=null && Action.equalsIgnoreCase("CreateGroup")){
	if(Status != null && Status.equalsIgnoreCase("Success")){
		String groupName = groupDetailSession.getGroupName();
		System.out.println(groupName);
		System.out.println(PrintMsg);%>
		<script src="../assets-dashboard/js/plugins/sweetalert/sweetalert.min.js"></script>
		<script src="../assets-dashboard/js/jquery-2.1.1.js"></script>
		<Script>
			$(document).ready(function () {
				//$(document).onload(function(){
					//alert("hiii");	
					swal({
						title: "Group <%=groupName%> Created",
						text: "<%=PrintMsg%>",
						type: "success"
					});
				});
			//});
		</script>
		<%
		session.removeAttribute("Action");
		session.removeAttribute("groupDetail");
		session.removeAttribute("Status");
		session.removeAttribute("PrintMsg");
		
	}
}
 %>
 
 
 
<%

if(Action !=null && Action.equalsIgnoreCase("UpdateGroup")){
	if(Status != null && Status.equalsIgnoreCase("Success")){
		String groupName = groupDetailSession.getGroupName();
		System.out.println(groupName);
		System.out.println(PrintMsg);%>
		<script src="../assets-dashboard/js/plugins/sweetalert/sweetalert.min.js"></script>
		<script src="../assets-dashboard/js/jquery-2.1.1.js"></script>
		<Script>
			$(document).ready(function () {
				//$(document).onload(function(){
					//alert("hiii");	
					swal({
						title: "Group <%=groupName%> Updated",
						text: "<%=PrintMsg%>",
						type: "success"
					});
				});
			//});
		</script>
		<%session.removeAttribute("groupDetail");
		session.removeAttribute("Status");
		session.removeAttribute("PrintMsg");
		session.removeAttribute("Action");
	}
}
 %>

 
 
<%

if(Action !=null && Action.equalsIgnoreCase("DeleteMember")){
	if(Status != null && Status.equalsIgnoreCase("Success")){
		ArrayList<String> userIdList = groupDetailSession.getEmailid();
		//System.out.println(groupName);
		System.out.println(PrintMsg); 
	    for(String email1:userIdList){%>
		<script src="../assets-dashboard/js/plugins/sweetalert/sweetalert.min.js"></script>
		<script src="../assets-dashboard/js/jquery-2.1.1.js"></script>
		<Script>
			$(document).ready(function () {
				//$(document).onload(function(){
					//alert("hiii");	
					swal({
						title: "Member <%=email1%> Deleted",
						text: "<%=PrintMsg%>",
						type: "success"
					});
				});
			//});
		</script>
		<%}
		session.removeAttribute("groupDetail");
		session.removeAttribute("Status");
		session.removeAttribute("PrintMsg");
		session.removeAttribute("Action");
	}
}
 %>

 <%

if(Action !=null && Action.equalsIgnoreCase("DeleteGroup")){
	if(Status != null && Status.equalsIgnoreCase("Success")){
		String groupName = groupDetailSession.getGroupName();
		System.out.println(groupName);
		System.out.println(PrintMsg);%>
		<script src="../assets-dashboard/js/plugins/sweetalert/sweetalert.min.js"></script>
		<script src="../assets-dashboard/js/jquery-2.1.1.js"></script>
		<Script>
			$(document).ready(function () {
				//$(document).onload(function(){
					//alert("hiii");	
					swal({
						title: "Group Deleted",
						text: "<%=PrintMsg%>",
						type: "success"
					});
				});
			//});
		</script>
		<%session.removeAttribute("groupDetail");
		session.removeAttribute("Status");
		session.removeAttribute("PrintMsg");
		session.removeAttribute("Action");
	}
}
 %>

 
 
 
 
 
<nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
				<!--<li style="height:61px;text-align:center;padding-top:20px;"> 
				<img src="../assets-login/img/pocket.PNG">
				</li>-->
                <li class="nav-header">
                    <div class="dropdown profile-element"> <span>
							<%
							String imgPath=null;
							if(user.getSignupFlag().equals("P"))
							{
								imgPath="../assets-login/img/"+user.getProfilePic();
							}	
							else if(user.getSignupFlag().equals("G"))
							{
								imgPath=user.getProfilePic();
								System.out.println(imgPath);
							}	
							else if(user.getSignupFlag().equals("F"))
							{
								imgPath="http://graph.facebook.com/"+user.getFbId()+"/picture";
							}
							%>
                            <img alt="image" class="img-circle" src="<%=imgPath%>" width="70px" href="profile.jsp"/>
							
                             </span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="profile.jsp">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold"><%=user.getFirstName()%> <%=user.getLastName()%></strong>
                             </span> 
                    </div>
                    <div class="logo-element">
                        P+
                    </div>
                </li>
                <li class="active">
                    <a href="dashboard.jsp"><i class="fa fa-th-large"></i> <span class="nav-label">Dashboard</span></a>
                </li>
                <li>
                    <a href="analytics.jsp"><i class="fa fa-pie-chart"></i> <span class="nav-label">Analytics</span></a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-users"></i> <span class="nav-label">Groups</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li class="landing_link" style="margin-left:-30px;">
							<a href="creategroup.jsp"><i class="fa fa-users"></i> <span class="nav-label">Create Group</span> <span class="label label-warning pull-right">+</span></a>
						</li>
						<% 
							for(GroupDetail groupdetail1:list){ %>
								<li><a href="../ExpenseController?id=<%=groupdetail1.getGroupId()%>&&action=viewgroupexpense" name="action"  value="groupView"><%=groupdetail1.getGroupName()%></a></li>
						<%}

						%>
						
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fa fa-user"></i> <span class="nav-label">Friends</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li class="landing_link" style="margin-left:-30px;">
							<a href="#" data-toggle="modal" data-target="#inviteFriendModal"><i class="fa fa-user"></i> <span class="nav-label">Add Friend</span> <span class="label label-warning pull-right">+</span></a>
						</li>
						<%
							ExpenseDao expenseDao1 = new ExpenseDao();
							System.out.println("user.getEmailId()"+user.getEmailId());
							HashMap<String, UserDetail> friendList = null;
							if(expenseDao1.getFriendListByEmail(user.getEmailId()) != null)
							{
								friendList = expenseDao1.getFriendListByEmail(user.getEmailId());
							}
							//System.out.println("friendList in Friends  " + friendList);
							if( friendList != null)
							{	
							Set keys = friendList.keySet();

						   for (Iterator i = keys.iterator(); i.hasNext(); ) {
						       String key = (String) i.next();
						       UserDetail friend = (UserDetail) friendList.get(key);%>
						       <li><a href="../ExpenseController?id=<%=friend.getEmailId()%>&&action=viewfriendexpense" name="action"  value="friendView"><%=friend.getFirstName()%>&nbsp;&nbsp;<%=friend.getLastName()%></a></li>
							<%}}else{%>
							   <li>No Friends</li>
							
							<%}%>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fa fa-history"></i> <span class="nav-label">Recent Activity</span></a>
                </li>
                
				<div class="modal inmodal" id="inviteFriendModal" tabindex="-1" role="dialog" aria-hidden="true">
					<div class="modal-dialog">
						<form name="" id="inviteFriend" name="invite" action="../LoginController" method="post">
						<div class="modal-content animated bounceInRight">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								<i class="fa fa-envelope modal-icon"></i>
								<h4 class="modal-title">Invite Friend</h4>
								<small class="font-bold">Invite your friend to experience Faster | Easier | Convenient group expanse management web application.</small>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<label>Email Address</label> <input type="email" name="email" placeholder="Enter your email" class="form-control">
									<label>Message</label><textarea name="invitemessage" placeholder="Enter your Messsage" class="form-control"></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
								<button type="submit" class="btn btn-primary" name="action" value="inviteFriend">Save changes</button>
							</div>
						</div>
						</form>
					</div>
				</div>
			
                <li>
                    <a class="landing_link" data-toggle="modal" data-target="#inviteFriendModal"><i class="fa fa-user-plus"></i> <span class="nav-label">Invite Friend</span>  </a>
                </li>
                
				
            </ul>

        </div>
    </nav>
	
	 <div id="page-wrapper" class="gray-bg">