<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import ="java.util.*,pocket.beans.UserDetail"%>
<%
	UserDetail userDetail = null;
	if(request.getAttribute("setNewPassword")==null ){
	userDetail=(UserDetail)session.getAttribute("userDetail");	
	}

%>

<!DOCTYPE html>
<html>

<!-- Mirrored from webapplayers.com/inspinia_admin-v2.3/forgot_password.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 30 Oct 2015 15:58:30 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Forgot password</title>

    <link href="../assets-dashboard/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets-dashboard/css/font-awesome.css" rel="stylesheet">

    <link href="../assets-dashboard/css/animate.css" rel="stylesheet">
    <link href="../assets-dashboard/css/style.css" rel="stylesheet">
    
     <!--  custom below javascript and css alert -->
	    <script src="../js/sweetalert.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="/BookMart/sweetalert-master/dist/sweetalert.css">
    <!-- end sweet alert -->

</head>

<body class="gray-bg">
 <%
		if(session.getAttribute("errorMsg") != null )
		{
			out.println("<h3 style='background-color:red;color:white;'>"+(String)(session.getAttribute("errorMsg"))+"</h3>");
			session.removeAttribute("errorMsg");
		}		
%>
    <div class="passwordBox animated fadeInDown">
        <div class="row">

            <div class="col-md-12">
                <div class="ibox-content">

                    <h2 class="font-bold">Change password</h2>

                    <p>
                        Enter your New password.
                    </p>

                    <div class="row">

                        <div class="col-lg-12">
                            <form class="m-t" role="form" method="post" action="/Pocket/LoginController">
                           	<% if(request.getAttribute("setNewPassword")==null ){%>
                            <input type="hidden" name="email" value="<%=userDetail.getEmailId() %>" />
                            <%} %>
                                <div class="form-group">
                                    <input type="password" name="newPassword" class="form-control" placeholder="New Password" required>
                                </div>
                                <div class="form-group">
                                    <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                                </div>
                                <button type="submit" name="action" value="setNewPassword" class="btn btn-primary block full-width m-b">Change password</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr/>
        
    </div>
    
    
     <script type="text/javascript" src="/Pocket/js/jquery-1.11.3.min.js"></script>
  	 <script type="text/javascript" src="/Pocket/js/bootstrap.min.js"></script>
  	 
    <%if(request.getAttribute("setNewPassword")!=null && request.getAttribute("setNewPassword").toString().equals("setNewPassword")){%>
    <script>
    $(document).ready(function () {
    	//System.out.println("hiii inside setNewPassword");
    	//response.sendRedirect("jsp/index.jsp");
    	swal({   
    		title: "Password Changed Successfully.",
    		text: "Please sign in again for outstanding experience.",
    		type: "success",
    		/* showCancelButton: true, */
    		confirmButtonColor: "#DD6B55",
    		confirmButtonText: "Ok",
    		closeOnConfirm: false 
    		}, 
    		function(){
    			window.location.href = 'http://localhost/Pocket/';
    		});
    		/* swal("Registration Done Successfully.", "Check your mail to verify your email.", "success");
    		 */
    		
    });
    </script>
    
    <%}else{System.out.println("in else");
    //response.sendRedirect("index.jsp");
    } %>

</body>


<!-- Mirrored from webapplayers.com/inspinia_admin-v2.3/forgot_password.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 30 Oct 2015 15:58:30 GMT -->
</html>
