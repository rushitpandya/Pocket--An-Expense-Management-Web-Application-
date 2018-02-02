<!DOCTYPE html>
<head>
    <title>Responsive website template for mobile app</title>
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">    
    <link rel="shortcut icon" href="favicon.ico"> 
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">   
    
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Covered+By+Your+Grace' rel='stylesheet' type='text/css'>  
    <!-- Global CSS -->
    
    <link rel="stylesheet" href="/Pocket/css/bootstrap.min.css">
    <!-- Plugins CSS -->    
    <link rel="stylesheet" href="/Pocket/css/font-awesome.css">
    <link rel="stylesheet" href="/Pocket/css/flexslider.css">
    <link rel="stylesheet" href="/Pocket/css/animate.min.css">
    <!-- Theme CSS -->  
    
    <link id="theme-style" rel="stylesheet" href="/Pocket/css/styles.css">
    
    <!--  custom below javascript and css alert -->
    <script src="/Pocket/js/sweetalert.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/Pocket/css/sweetalert.css">
    <!-- end sweet alert -->
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script> datastr=null;</script>
</head> 
<body data-spy="scroll">
	<%String email = (String)request.getAttribute("email"); %>
	<%String token = (String)request.getAttribute("token"); %>
<form class="form-horizontal" name="signup" action="LoginController" method="post">
									<fieldset>
									
									<!-- First name input-->
										
										<!-- Button -->
										<input type="hidden" name="email" value="<%=email%>" />
										<input type="hidden" name="token" value="<%=token%>" />
										<div class="control-group">
											<label class="control-label" for="confirmsignup"></label>
											<div class="controls">
												<button id="confirmsignup" name="action" value="userActivation" class="btn btn-theme btn-block">Confirm Email</button>
											</div>
										</div>
																			
									</fieldset>
								</form>

							</body>