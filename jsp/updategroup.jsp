<%@page import="pocket.controllers.*"%>
<%@page import="java.util.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.beans.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>

<%
session=request.getSession(false);
if(session.getAttribute("User") == null)
{
	%>
	<jsp:forward page="index.jsp" />
	<%
}
%>

<%
	GroupDao groupDao = new GroupDao();
	GroupDetail groupDetail = groupDao.getGroupDetails(Integer.parseInt(request.getParameter("group_id")));
	ArrayList<String> userIdList = groupDetail.getEmailid();
%>

<jsp:include page='header.jsp'/>
<script type="text/javascript">
	var i = 0;

	function duplicate() {
		var original = document.getElementById('duplicater' + i);
		var clone = original.cloneNode(true); // "deep" clone
	   clone.id = "duplicater" + ++i; // there can only be one element with an ID
		clone.onclick = duplicate; // event handlers are not cloned
		original.parentNode.appendChild(clone);
	}
</script>
<jsp:include page='leftnavigation.jsp'/>
<jsp:include page='upperheader.jsp'/>
 <%-- <jsp:include page='content.jsp'/> --%> 

  <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-9">
                    <h2>Create Group with your friends</h2>
                </div>
   </div>
 <div class="wrapper wrapper-content">
 
	<div class="ibox-content">
                           
							<%
							 
							UserDetail user = (UserDetail)session.getAttribute("User");
							%>
                            <form id="form" action="../GroupController" method="Get" class="wizard-big">
                                <%--<h1>Account</h1> --%>
                                <fieldset>
                                    
									<div class="form-group">
                                                <label>Group Name *</label>
                                                <input id="groupname" value="<%=groupDetail.getGroupName()%>"  placeholder="Enter Valid Group Name here" name="Name" type="text" class="form-control required">
												<input type="hidden" name="group_id" value="<%=groupDetail.getGroupId()%>">
                                    </div>
                                    <div class="row">
										 <div class="col-lg-4">
                                            <div class="text-center">
                                                <div style="margin-top: 20px">
                                                    <i class="fa fa-group fa-fw" style="font-size: 180px;color: #e5e5e5 "></i>
													<br/><br/>
													<p><button name="action" type="submit" value="deletegroup" class="btn btn-primary btn-lg" role="button">Delete Group</button></p>
										
                                                </div>
                                            </div>
                                        </div>
										
                                        <div class="col-lg-8">
                                            
											<% 
											for(String email:userIdList){ %>
											 <div class="form-group">
																<label>Group Member</label>
																<input value="<%=email%>" disabled="disabled" id="confirm" placeholder="Enter Valid Email Address" name="email" type="text" class="form-control required">
																<li><a href="../GroupController?action=deletemember&&email_id=<%=email%>&&group_id=<%=groupDetail.getGroupId()%>" name="action"  value="groupView">X</a></li>
											  </div>
												
											<%}%>
											
                                           
                                            <div class="form-group" id="duplicater0">
                                                <label>Add Group Member</label>
                                                <input id="confirm" placeholder="Enter Valid Email Address" name="email_id" type="text" class="form-control required">
                                            </div>
											
                                        </div>
										
                                    </div>
									
									 <div class="row">
										 <div class="col-lg-4">
											
											
										   
                                        </div>
                                        <div class="col-lg-8">
                                            <a style="display: block; margin: 15px 0 10px; font-size: 13px; line-height: 13px"  href="javascript:duplicate()">+ Add a person</a>
											
										<p><button name="action" type="submit" value="updategroup" class="btn btn-primary btn-lg" role="button">Update Group</button></p>
										
											
                                        </div>
										 
                                    </div>

                                
                            </form>
                       
</div>
<jsp:include page='importscripts.jsp'/>