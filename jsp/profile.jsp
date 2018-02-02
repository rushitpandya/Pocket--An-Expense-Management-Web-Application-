<%@page import="pocket.controllers.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.dao.*"%>
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

<jsp:include page='header.jsp'/>
<jsp:include page='leftnavigation.jsp'/>
<jsp:include page='upperheader.jsp'/>
<%
UserDetail user = (UserDetail)session.getAttribute("User");
%>

 <div class="wrapper wrapper-content">
 
            <div class="row animated fadeInRight">
                <div class="col-md-4">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>Profile Details</h5>
                        </div>
                        <div>
                            <div class="ibox-content no-padding border-left-right">
							<%
							String imgPath=null;
							boolean flag=false;
							if(user.getSignupFlag().equals("P"))
							{
								imgPath="../assets-login/img/"+user.getProfilePic();
								flag=true;
							}	
							else if(user.getSignupFlag().equals("G"))
							{
								imgPath=user.getProfilePic();
							}	
							else if(user.getSignupFlag().equals("F"))
							{
								imgPath="http://graph.facebook.com/"+user.getFbId()+"/picture?type=large";
							}
							%>
							 <form action = "../UploadServlet" method = "post" enctype = "multipart/form-data">	
                                <img alt="image" id="blah" class="img-responsive" src="<%=imgPath%>" width="600" height="600">
                            </div>
                            <div class="ibox-content profile-content">
							<input type="hidden" name="fileName" value="<%=user.getEmailId()%>">
                                <h4><strong><%=user.getFirstName()%> <%=user.getLastName()%></strong></h4>
                                <p><i class="fa fa-envelope"></i> <%=user.getEmailId()%></p>
                                 <%if(flag){%>
								 <div class="user-button">
                                    <div class="row">
                                        <div class="col-md-6">
                                           <label for="file-upload" class="btn btn-primary btn-sm btn-block">
												<i class="fa fa-cloud-upload"></i> Custom Upload
											</label>
											<input id="file-upload" style="display:none;" type="file" name="file_upload" onchange="readURL(this);" accept="image/gif, image/jpeg, image/png" required/> 	
                                        </div>
										
                                        <div class="col-md-6">
                                            <button type="submit" class="btn btn-primary  btn-sm btn-block"><i class="fa fa-download"></i> Upload Picture</button>
                                        </div>
										</form>
                                    </div>
                                </div>
								 <%}else{%>
								 </form>
								 <%}%>
								
                               <!-- <div class="row m-t-lg">
                                    <div class="col-md-4">
                                        <span class="bar">5,3,9,6,5,9,7,3,5,2</span>
                                        <h5><strong>169</strong> Posts</h5>
                                    </div>
                                    <div class="col-md-4">
                                        <span class="line">5,3,9,6,5,9,7,3,5,2</span>
                                        <h5><strong>28</strong> Following</h5>
                                    </div>
                                    <div class="col-md-4">
                                        <span class="bar">5,3,2,-1,-3,-2,2,3,5,2</span>
                                        <h5><strong>240</strong> Followers</h5>
                                    </div>
                                </div>-->
                               
                            </div>
                    </div>
                </div>
                </div>
				
				
				
				
				
                <div class="col-md-8">
				<div class="row">
				 <%
							if(session.getAttribute("errorMsg") != null )
							{
								if(session.getAttribute("errorMsg").equals("New Password and Confirm Password should match!"))
								{	
									out.println("<h3 style='background-color:red;color:white;'>"+(String)(session.getAttribute("errorMsg"))+"</h3>");
									session.removeAttribute("errorMsg");
								}
								else{
									out.println("<h3 style='background-color:green;color:white;'>"+(String)(session.getAttribute("errorMsg"))+"</h3>");
									session.removeAttribute("errorMsg");
								}
							}
						%>
                  <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>Update Profile</h5>
                          <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>

                            </div>
                        </div>
                        <div class="ibox-content">
						 
                            <form method="post" class="form-horizontal" action= "../UpdateProfileController">
                               
								<div class="form-group"><label class="col-sm-2 control-label">First Name</label>
								 
                                    <div class="col-sm-10"><input type="text" class="form-control" name = "UpdatefName" value="<%=user.getFirstName()%>"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
								
								<div class="form-group"><label class="col-sm-2 control-label">Last Name</label>
                                    <div class="col-sm-10"><input type="text" class="form-control" name = "UpdatelName" value="<%=user.getLastName()%>"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
								
								<div class="form-group"><label class="col-lg-2 control-label">Email Address</label>
                                    <div class="col-lg-10"><input type="text"  disabled="" value="<%=user.getEmailId()%>" placeholder="Disabled input here..." class="form-control"></div>
                                </div>
								<input type="hidden" name = "useremail" value= "<%=user.getEmailId()%>" />
								<div class="hr-line-dashed"></div>
								<center><button class="btn btn-primary btn-med" type="submit" name= "action" value="profileupdate"><i class="fa fa-paste"></i> Update Profile</button></center>
							  
                            </form>
                        </div>
                    </div>  
				</div>
				
				<div class="row">
				
                  <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>Update Limit</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                
                            </div>
                        </div>
                        <div class="ibox-content">
                            <form role="form" class="form-inline" action= "../UpdateProfileController" method="post">
                                <div class="form-group">
                                  <div class="input-group">
									<span class="input-group-addon"><i class="fa fa-usd"></i></span>
                                    <input type="text" placeholder="Enter Limit" name="limit" id="exampleInputEmail2" value="<%=user.getExpenseLimit()%>" class="form-control">
                                <input type="hidden" name = "useremail" value= "<%=user.getEmailId()%>" />
								</div>
                                 </div>
                                <button class="btn btn-primary" name= "action" value="setlimit" type="submit">Set Limit</button>
                            </form>
                        </div>
                    </div>
				</div>
				
				<!-- set flag for pocket log in because we do not have password for gmail and fb log in so we disabled image and password change option for that.-->
				 <%if(flag){%>
				 
				<div class="row">
				
                  <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>Change Password</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                
                            </div>
                        </div>
                        <div class="ibox-content">
                            <form role="form" class="form-inline" action= "../UpdateProfileController" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail2" class="sr-only">Password</label>
                                    <input type="password" placeholder="Enter New Password" id="exampleInputEmail2"
                                     name="newpassword"  class="form-control">
                                </div>
                                
								<div class="form-group">
                                    <label for="exampleInputEmail2" class="sr-only">Password</label>
                                    <input type="password" placeholder="Confirm New Password" id="exampleInputEmail2"
                                      name="comfirmpassword"  class="form-control">
									  <input type="hidden" name = "useremail" value= "<%=user.getEmailId()%>" />
                                </div>
								
                                <button class="btn btn-primary" name="action" value="changepassword" type="submit">Change Password</button>
                            </form>
                        </div>
                    </div>
				</div>
				<%}%>
                </div>
            </div>
</div>



<jsp:include page='importscripts.jsp'/>