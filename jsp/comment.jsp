<%@page import="pocket.controllers.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="pocket.beans.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>

<jsp:include page='header.jsp'/>
<jsp:include page='leftnavigation.jsp'/>
<jsp:include page='upperheader.jsp'/>
<%
UserDetail user = (UserDetail)session.getAttribute("User");
%>

 <div class="wrapper wrapper-content">
 
            <div class="row animated fadeInRight">
              
                <div class="col-md-12">
				
                        <div class="ibox-content">
						 
                            <form method="post" class="form-horizontal" action= "../CommentExpenseController">
                               
								<div class="form-group"><label class="col-sm-2 control-label">Expense_id</label>
								 
                                <div class="col-sm-10"><input type="text" class="form-control" name = "expense_id"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
								
								<div class="form-group"><label class="col-sm-2 control-label">UserName</label>
									<input type="hidden" class="form-control" name = "username" value="<%=user.getEmailId()%>">
                                    <div class="col-sm-10"><input type="text" class="form-control" name = "userName" disabled="" value="<%=user.getEmailId()%>"></div>
                                </div>
								
                                <div class="hr-line-dashed"></div>
								
								<div class="form-group"><label class="col-sm-2 control-label">Comments</label>
                                    <div class="col-sm-10"><textarea name = "comment" rows="4" cols="50" placeholder="Enter Comment here">
									</textarea></div>
                                </div>
                                
								<input type="hidden" name = "useremail" value= "<%=user.getEmailId()%>" />
								<div class="hr-line-dashed"></div>
								<center>
									<button class="btn btn-primary btn-med" type="submit" name= "action" value="profileupdate"><i class="fa fa-paste"></i>Submit Comment</button>
								</center>
							  
                            </form>
                        </div>
               
				
				
				
				
                </div>
            </div>
</div>



<jsp:include page='importscripts.jsp'/>