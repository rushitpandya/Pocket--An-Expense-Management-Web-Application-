<%@page import="pocket.controllers.*"%>
<%@page import="pocket.utility.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>

<%
	FacebookConnectionUtility fbConnection = new FacebookConnectionUtility();
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
    <title>Pocket Landing Page</title>
    <meta name="description" content="Free Bootstrap Theme by BootstrapMade.com">
    <meta name="keywords" content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">
    
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans|Candal|Alegreya+Sans">
	<!--<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">-->
    <link rel="stylesheet" type="text/css" href="../assets-login/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../assets-login/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../assets-login/css/imagehover.min.css">
    <link rel="stylesheet" type="text/css" href="../assets-login/css/style.css">
    
	
  </head>
		
  <body>
    <!--Navigation bar-->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
	  <%
		if(session.getAttribute("errorMsg") != null )
		{
			out.println("<h3 style='background-color:red;color:white;'>"+(String)(session.getAttribute("errorMsg"))+"</h3>");
			session.removeAttribute("errorMsg");
		}
		%>
        <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index.jsp">Poc<span>Ket</span></a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav navbar-right">
          <!--<li><a href="#feature">Features</a></li>
          <li><a href="#organisations">Organisations</a></li>
          <li><a href="#courses">Courses</a></li>
          <li><a href="#pricing">Pricing</a></li>-->
          <li><a href="#" data-target="#login" data-toggle="modal"><i class="fa fa-sign-in" aria-hidden="true">&nbsp;&nbsp;</i>Sign in</a></li>
          <li class="btn-trial"><a href="#" data-target="#SignUp" data-toggle="modal">Sign Up</a></li>
        </ul>
        </div>
      </div>
    </nav>
    <!--/ Navigation bar-->
    <!--Modal box-->
    <div class="modal fade" id="login" role="dialog">
      <div class="modal-dialog modal-sm">
      
        <!-- Modal content no 1-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title text-center form-title">Login</h4>
          </div>
          <div class="modal-body padtrbl">

            <div class="login-box-body">
              <p class="login-box-msg">Sign in to start your session</p>
              <div class="form-group">
                <form name="" id="loginForm" name="signup" action="../LoginController" method="post">
                 <div class="form-group has-feedback"> <!----- username -------------->
                      <input class="form-control" placeholder="Username"  id="loginid" type="text" autocomplete="on"  name="email" required/> 
            <span style="display:none;font-weight:bold; position:absolute;color: red;position: absolute;padding:4px;font-size: 11px;background-color:rgba(128, 128, 128, 0.26);z-index: 17;  right: 27px; top: 5px;" id="span_loginid"></span><!---Alredy exists  ! -->
                      <span class="glyphicon glyphicon-user form-control-feedback"></span>
                  </div>
                  <div class="form-group has-feedback"><!----- password -------------->
                      <input class="form-control" placeholder="Password" name="password" id="loginpsw" type="password" autocomplete="off" required />
            <span style="display:none;font-weight:bold; position:absolute;color: grey;position: absolute;padding:4px;font-size: 11px;background-color:rgba(128, 128, 128, 0.26);z-index: 17;  right: 27px; top: 5px;" id="span_loginpsw"></span><!---Alredy exists  ! -->
                      <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                          <div class="checkbox icheck">
                              <label>
                                <input type="checkbox" id="loginrem" > Remember Me &nbsp;  
                            <a href="../jsp/ForgotPassword.jsp">Forgot Password ?</a>
                              </label>
                          </div>
                      </div>
                      <div class="col-xs-12">
                          <button type="submit" class="btn btn-green btn-block btn-flat" name="action" value="pocketLogin">Sign In</button>
                          <div id="signinshow" class="control-group" style="display: none;">
                        
                          <button disabled  id="signinbtn" name="submit" value="bookSignIn" class="btn btn-theme btn-block">Sign In</button>
                        </div>
                      </div>
						  <button class="loginBtn loginBtn--facebook" ><a style="color:white;" href="<%=fbConnection.getFBAuthUrl()%>"> Login with Facebook</a></button>
						  <button class="loginBtn loginBtn--google"><a style="color:white;" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/Pocket/GmailLoginController&response_type=code&client_id=88196211357-vl6vl38tdtd2geaap9ih7easi7tkhovj.apps.googleusercontent.com&approval_prompt=force" > Login with Google</a></button>
                      </div>
					  
					  
                  </div>
				  
                </form>
              </div>
            </div>
			<div class="divider"></div>
			<center> <p> New User? Please <a href="#" data-target="#SignUp" data-toggle="modal">Sign Up</a> </p></center>
          </div>
		  
        </div>

      </div>
    </div>
    <!--/ Modal box-->
	 <!--Modal box-->
    <div class="modal fade" id="SignUp" role="dialog">
      <div class="modal-dialog modal-sm">
      
        <!-- Modal content no 2-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title text-center form-title">SignUp form</h4>
          </div>
          <div class="modal-body padtrbl">

            <div class="login-box-body">
              <p class="login-box-msg">Sign up to start using Pocket</p>
              <div class="form-group">
                <form name="" id="loginForm" name="signup" action="../LoginController" method="post">
				<div class="form-group has-feedback"> <!----- Firstname -------------->
                      <input class="form-control" placeholder="First Name"  id="fname" name="fName" type="text" autocomplete="off" required /> 
            <span style="display:none;font-weight:bold; position:absolute;color: red;position: absolute;padding:4px;font-size: 11px;background-color:rgba(128, 128, 128, 0.26);z-index: 17;  right: 27px; top: 5px;" id="span_loginid"></span><!---Alredy exists  ! -->
                      <span class="glyphicon glyphicon-user form-control-feedback"></span>
                  </div><div class="form-group has-feedback"> <!----- lastname -------------->
                      <input class="form-control" placeholder="Last Name"  id="lname" name="lName" type="text" autocomplete="off" required /> 
            <span style="display:none;font-weight:bold; position:absolute;color: red;position: absolute;padding:4px;font-size: 11px;background-color:rgba(128, 128, 128, 0.26);z-index: 17;  right: 27px; top: 5px;" id="span_loginid"></span><!---Alredy exists  ! -->
                      <span class="glyphicon glyphicon-user form-control-feedback"></span>
                  </div><div class="form-group has-feedback"> <!----- username -------------->
                      <input class="form-control" placeholder="Email id"  id="emailid" name="email" type="text" autocomplete="off" required /> 
            <span style="display:none;font-weight:bold; position:absolute;color: red;position: absolute;padding:4px;font-size: 11px;background-color:rgba(128, 128, 128, 0.26);z-index: 17;  right: 27px; top: 5px;" id="span_loginid"></span><!---Alredy exists  ! -->
                      <span class="glyphicon glyphicon-user form-control-feedback"></span>
                  </div>
                  <div class="form-group has-feedback"><!----- password -------------->
                      <input class="form-control" placeholder="Password" id="loginpsw" name="password" type="password" autocomplete="off" required />
            <span style="display:none;font-weight:bold; position:absolute;color: grey;position: absolute;padding:4px;font-size: 11px;background-color:rgba(128, 128, 128, 0.26);z-index: 17;  right: 27px; top: 5px;" id="span_loginpsw"></span><!---Alredy exists  ! -->
                      <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                  </div>
				  <div class="form-group has-feedback"><!----- password -------------->
                      <input class="form-control" placeholder="Confirm Password" id="loginpsw" name="confirmPassword"  type="password" autocomplete="off" required />
            <span style="display:none;font-weight:bold; position:absolute;color: grey;position: absolute;padding:4px;font-size: 11px;background-color:rgba(128, 128, 128, 0.26);z-index: 17;  right: 27px; top: 5px;" id="span_loginpsw"></span><!---Alredy exists  ! -->
                      <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                          <div class="checkbox icheck">
                              <label>
                                <input type="checkbox" id="loginrem" > Remember Me
                              </label>
                          </div>
                      </div>
                      <div class="col-xs-12">
                          <button type="submit" name="action" value="pocketSignUp" class="btn btn-green btn-block btn-flat">SignUp</button>
						  <button class="loginBtn loginBtn--facebook" ><a style="color:white;" href="<%=fbConnection.getFBAuthUrl()%>"> SignUp with Facebook</a></button>
						  <button class="loginBtn loginBtn--google"><a style="color:white;" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/Pocket/GmailLoginController&response_type=code&client_id=88196211357-vl6vl38tdtd2geaap9ih7easi7tkhovj.apps.googleusercontent.com&approval_prompt=force" > SignUp with Google</a></button>
                      </div>
                  </div>
				  
                </form>
              </div>
            </div>
			<div class="divider"></div>
			
          </div>
		  
        </div>

      </div>
    </div>
    <!--/ Modal box-->
    <!--Banner-->
    <div class="banner">
      <div class="bg-color">
        <div class="container">
          <div class="row">
            <div class="banner-text text-center">
              <div class="text-border">
                <h2 class="text-dec">Easy | Fast | Convenient</h2>
              </div>
              <div class="intro-para text-center quote">
                <p class="big-text">Divide Everyday Bill . . . Divide Trip Expense. . .</p>
                <p class="small-text">Pocket is very easy, fast and convenient way to divide your expense between your friends, room mate and trip members. 
				<br><b>Make It Easier...</b></p>
                <a href="#footer" class="btn get-quote">Get Started Now</a>
              </div>
              <a href="#feature" class="mouse-hover"><div class="mouse"></div></a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--/ Banner-->
    <!--Feature
    <section id ="feature" class="section-padding">
      <div class="container">
        <div class="row">
          <div class="header-section text-center">
            <h2>Features</h2>
            <p>We do the math for you,  We organize all your shared expenses in one place, so that everyone can see who they owe. Whether you are sharing a ski vacation, splitting rent with roommates, or owe someone for lunch, Pocket makes life easier. .</p>
            <hr class="bottom-line">
          </div>
          <div class="feature-info">
            <div class="fea">
              <div class="col-md-4">
                <div class="heading pull-right">
                  <h4>Latest Technologies</h4>
                  <p>Donec et lectus bibendum dolor dictum auctor in ac erat. Vestibulum egestas sollicitudin metus non urna in eros tincidunt convallis id id nisi in interdum.</p>
                </div>
                <div class="fea-img pull-left">
                  <i class="fa fa-css3"></i>
                </div>
              </div>
            </div>
            <div class="fea">
              <div class="col-md-4">
                <div class="heading pull-right">
                  <h4>Toons Background</h4>
                  <p>Donec et lectus bibendum dolor dictum auctor in ac erat. Vestibulum egestas sollicitudin metus non urna in eros tincidunt convallis id id nisi in interdum.</p>
                </div>
                <div class="fea-img pull-left">
                  <i class="fa fa-drupal"></i>
                </div>
              </div>
            </div>
            <div class="fea">
              <div class="col-md-4">
                <div class="heading pull-right">
                  <h4>Award Winning Design</h4>
                  <p>Donec et lectus bibendum dolor dictum auctor in ac erat. Vestibulum egestas sollicitudin metus non urna in eros tincidunt convallis id id nisi in interdum.</p>
                </div>
                <div class="fea-img pull-left">
                  <i class="fa fa-trophy"></i>
                </div>
              </div>
            </div>
        </div>
        </div>
      </div>
    </section>-->
    <!--/ feature-->
    <!--Organisations
    <section id ="organisations" class="section-padding">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">         
              <div class="orga-stru">
                <h3>65%</h3>
                <p>Say NO!!</p>
                <i class="fa fa-male"></i>
              </div>  
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">         
              <div class="orga-stru">
                <h3>20%</h3>
                <p>Says Yes!!</p>
                <i class="fa fa-male"></i>
              </div>  
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">         
              <div class="orga-stru">
                <h3>15%</h3>
                <p>Can't Say!!</p>
                <i class="fa fa-male"></i>
              </div>  
            </div>
          </div>
          <div class="col-md-6">
            <div class="detail-info">
              <hgroup>
                <h3 class="det-txt"> Is inclusive quality education affordable?</h3>
                <h4 class="sm-txt">(Revised and Updated for 2016)</h4>
              </hgroup>
              <p class="det-p">Donec et lectus bibendum dolor dictum auctor in ac erat. Vestibulum egestas sollicitudin metus non urna in eros tincidunt convallis id id nisi in interdum.</p>
            </div>
          </div>
        </div>
      </div>
    </section>-->
    <!--/ Organisations-->
    <!--Cta-
    <section id="cta-2">
      <div class="container">
        <div class="row">
            <div class="col-lg-12">
              <h2 class="text-center">Subscribe Now</h2>
              <p class="cta-2-txt">Sign up for our free weekly software design courses, we’ll send them right to your inbox.</p>
             <div class="cta-2-form text-center">
              <form action="#" method="post" id="workshop-newsletter-form">
                    <input name="" placeholder="Enter Your Email Address" type="email">
                    <input class="cta-2-form-submit-btn" value="Subscribe" type="submit">
                </form>
             </div>   
            </div>
        </div>
      </div>
    </section>-->
    <!--/ Cta-->
    <!--work-shop
    <section id="work-shop" class="section-padding">
      <div class="container">
        <div class="row">
          <div class="header-section text-center">
            <h2>Upcoming Workshop</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Exercitationem nesciunt vitae,<br> maiores, magni dolorum aliquam.</p>
            <hr class="bottom-line">
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="service-box text-center">
              <div class="icon-box">
                <i class="fa fa-html5 color-green"></i>
              </div>
              <div class="icon-text">
                <h4 class="ser-text">Mentor HTML5 Workshop</h4>
              </div>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="service-box text-center">
              <div class="icon-box">
                <i class="fa fa-css3 color-green"></i>
              </div>
              <div class="icon-text">
                <h4 class="ser-text">Mentor CSS3 Workshop</h4>
              </div>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="service-box text-center">
              <div class="icon-box">
                <i class="fa fa-joomla color-green"></i>
              </div>
              <div class="icon-text">
                <h4 class="ser-text">Mentor Joomla Workshop</h4>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>-->
    <!--/ work-shop-->
    <!--Faculity member-->
    <section id="faculity-member" class="section-padding">
      <div class="container">
        <div class="row">
          <div class="header-section text-center">
            <h2>Meet Our Team Members</h2>
            <p>Pocket a virtual wallet is build by a team of 5 persons.<br> Here is some basic information about our team.</p>
            <hr class="bottom-line">
          </div>
          <div class="col-lg-4 col-md-4 col-sm-4">
            <div class="pm-staff-profile-container" >
              <div class="pm-staff-profile-image-wrapper text-center">
                <div class="pm-staff-profile-image">
                  <img src="../assets-login/img/riten.jpg" alt="" class="img-thumbnail img-circle" />
                </div>   
              </div>                                
              <div class="pm-staff-profile-details text-center">  
                <p class="pm-staff-profile-name">Riten Chhatrala</p>
              </div>     
            </div>
          </div>
          <div class="col-lg-4 col-md-4 col-sm-4">
            <div class="pm-staff-profile-container" >
              <div class="pm-staff-profile-image-wrapper text-center">
                <div class="pm-staff-profile-image">
                  <img src="../assets-login/img/rushit.jpg" alt="" class="img-thumbnail img-circle" />
                </div>   
              </div>                                
              <div class="pm-staff-profile-details text-center">  
                <p class="pm-staff-profile-name">Rushit Pandya</p>
              </div>     
            </div>
          </div>
          <div class="col-lg-4 col-md-4 col-sm-4">
            <div class="pm-staff-profile-container" >
              <div class="pm-staff-profile-image-wrapper text-center">
                <div class="pm-staff-profile-image">
                    <img src="../assets-login/img/rishabh.jpg" alt="" class="img-thumbnail img-circle" />
                </div>   
              </div>                                
              <div class="pm-staff-profile-details text-center">  
                <p class="pm-staff-profile-name">Rishabh Shah</p>
              </div>     
            </div>
          </div>
        </div>
		<div class="row" style="padding-left:240px;">
		<center>
          <div class="col-lg-4 col-md-4 col-sm-4">
            <div class="pm-staff-profile-container" >
              <div class="pm-staff-profile-image-wrapper text-center">
                <div class="pm-staff-profile-image">
                  <img src="../assets-login/img/preyang.jpg" alt="" class="img-thumbnail img-circle" />
                </div>   
              </div>                                
              <div class="pm-staff-profile-details text-center">  
                <p class="pm-staff-profile-name">Preyang Shah</p>
              </div>     
            </div>
          </div>
          <div class="col-lg-4 col-md-4 col-sm-4">
            <div class="pm-staff-profile-container" >
              <div class="pm-staff-profile-image-wrapper text-center">
                <div class="pm-staff-profile-image">
                  <img src="../assets-login/img/divya.jpg" alt="" class="img-thumbnail img-circle" />
                </div>   
              </div>                                
              <div class="pm-staff-profile-details text-center">  
                <p class="pm-staff-profile-name">Divya Patel</p>
              </div>     
            </div>
          </div>
		 </center>
          <!--<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="pm-staff-profile-container" >
              <div class="pm-staff-profile-image-wrapper text-center">
                <div class="pm-staff-profile-image">
                    <img src="img/mentor.jpg" alt="" class="img-thumbnail img-circle" />
                </div>   
              </div>                                
              <div class="pm-staff-profile-details text-center">  
                <p class="pm-staff-profile-name">Bryan Johnson</p>
              </div>     
            </div>
          </div>-->
        </div>
      </div>
    </section>
    <!--/ Faculity member-->
    <!--Testimonial-->
   <!-- <section id="testimonial" class="section-padding">
      <div class="container">
        <div class="row">
          <div class="header-section text-center">
            <h2 class="white">See What Our Customer Are Saying?</h2>
            <p class="white">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Exercitationem nesciunt vitae,<br> maiores, magni dolorum aliquam.</p>
            <hr class="bottom-line bg-white">
          </div>
          <div class="col-md-6 col-sm-6">
            <div class="text-comment">
              <p class="text-par">"Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, nec sagittis sem"</p>
              <p class="text-name">Abraham Doe - Creative Dırector</p>
            </div>
          </div>
          <div class="col-md-6 col-sm-6">
            <div class="text-comment">
              <p class="text-par">"Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, nec sagittis sem"</p>
              <p class="text-name">Abraham Doe - Creative Dırector</p>
            </div>
          </div>
        </div>
      </div>
    </section>-->
    <!--/ Testimonial-->
    
   
    <!--Contact-->
    <section id ="contact" class="section-padding">
      <div class="container">
        <div class="row">
          <div class="header-section text-center">
            <h2>Contact Us</h2>
            <p>If you have any questions or suggestions regarding pocket<br> Please feel free to contact us.</p>
            <hr class="bottom-line">
          </div>
          <div id="sendmessage">Your message has been sent. Thank you!</div>
          <div id="errormessage"></div>
          <form action="" method="post" role="form" class="contactForm">
              <div class="col-md-6 col-sm-6 col-xs-12 left">
                <div class="form-group">
                    <input type="text" name="name" class="form-control form" id="name" placeholder="Your Name" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
                    <div class="validation"></div>
                </div>
                <div class="form-group">
                    <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" data-rule="email" data-msg="Please enter a valid email" />
                    <div class="validation"></div>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="subject" id="subject" placeholder="Subject" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />
                    <div class="validation"></div>
                </div>
              </div>
              
              <div class="col-md-6 col-sm-6 col-xs-12 right">
                <div class="form-group">
                    <textarea class="form-control" name="message" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="Message"></textarea>
                    <div class="validation"></div>
                </div>
              </div>
              
              <div class="col-xs-12">
                <!-- Button -->
                <button type="submit" id="submit" name="submit" class="form contact-form-button light-form-button oswald light">SEND EMAIL</button>
              </div>
          </form>
          
        </div>
      </div>
    </section>
    <!--/ Contact-->
    <!--Footer-->
    <footer id="footer" class="footer">
      <div class="container text-center">
    
         
      <form class="mc-trial row">
        <div class="form-group col-md-3 col-md-offset-2 col-sm-4">
          <div class=" controls">
            <input name="name" placeholder="Enter Your Name" class="form-control" type="text">
          </div>
        </div><!-- End email input -->
        <div class="form-group col-md-3 col-sm-4">
          <div class=" controls">
            <input name="EMAIL" placeholder="Enter Your email" class="form-control" type="email">
          </div>
        </div><!-- End email input -->
        <div class="col-md-2 col-sm-4">
          <p>
            <button name="submit" type="submit" class="btn btn-block btn-submit">
            Submit <i class="fa fa-arrow-right"></i></button>
          </p>
        </div>
      </form><!-- End newsletter-form -->
      <ul class="social-links">
        <li><a href="#link"><i class="fa fa-twitter fa-fw"></i></a></li>
        <li><a href="#link"><i class="fa fa-facebook fa-fw"></i></a></li>
        <li><a href="#link"><i class="fa fa-google-plus fa-fw"></i></a></li>
        <li><a href="#link"><i class="fa fa-dribbble fa-fw"></i></a></li>
        <li><a href="#link"><i class="fa fa-linkedin fa-fw"></i></a></li>
      </ul>
        ©2016 Pocket. All rights reserved
        <div class="credits">
            <!-- 
                All the links in the footer should remain intact. 
                You can delete the links only if you purchased the pro version.
                Licensing information: https://bootstrapmade.com/license/
                Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=Mentor
            -->
            Designed by <a href="https://bootstrapmade.com/">Team 17 EWA</a>
        </div>
      </div>
    </footer>
    <!--/ Footer-->
    
    <script src="../assets-login/js/jquery.min.js"></script>
    <script src="../assets-login/js/jquery.easing.min.js"></script>
    <script src="../assets-login/js/bootstrap.min.js"></script>
    <script src="../assets-login/js/custom.js"></script>
    <!--<script src="../assets-login/contactform/contactform.js"></script>-->
    
  </body>
</html>