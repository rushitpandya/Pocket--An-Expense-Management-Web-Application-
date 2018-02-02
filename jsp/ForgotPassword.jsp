<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Pocket | Forgot password</title>

    <link href="../assets-dashboard/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets-dashboard/font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="../assets-dashboard/css/animate.css" rel="stylesheet">
    <link href="../assets-dashboard/css/style.css" rel="stylesheet">

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

                    <h2 class="font-bold">Forgot password</h2>

                    <p>
                        Enter your email address and your password will be reset and emailed to you.
                    </p>

                   <div class="row">

                        <div class="col-lg-12">
                           <form action="/Pocket/LoginController" method="post">
                                <div class="form-group">
                                    <input type="email" id="email" name="email" class="form-control" placeholder="Email address" required="required">
                                </div>

                                <button name="action" value="sendNewPassword" class="btn btn-primary block full-width m-b">Send new password</button>
							</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr/>
        <div class="row">
            <div class="col-md-6">
                Copyright Example Company
            </div>
            <div class="col-md-6 text-right">
               <small>© 2014-2015</small>
            </div>
        </div>
    </div>
<script type="text/javascript" src="/Pocket/js/jquery-1.11.3.min.js"></script>
     <script type="text/javascript" src="/Pocket/js/bootstrap.min.js"></script>
   
    <%if(request.getAttribute("sendNewPassword")!=null && request.getAttribute("sendNewPassword").toString().equals("sendNewPassword")){%>
    <script>
    $(document).ready(function () {
    	//System.out.println("hiii inside toString()");
        
    	
    	swal({   
    		title: "Mail Sent.",
    		text: "Check your mail to change your password.",
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

</html>