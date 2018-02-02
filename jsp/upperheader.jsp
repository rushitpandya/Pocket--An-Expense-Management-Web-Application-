<%@page import="pocket.beans.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%
	UserDetail user = (UserDetail)session.getAttribute("User");
	String emailid = user.getEmailId();
%>	
<div class="row border-bottom">
        <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
            <form role="search" class="navbar-form-custom" action="http://webapplayers.com/inspinia_admin-v2.3/search_results.html">
                <div class="form-group">
                    <input type="text" placeholder="Search Expense by Title..." class="form-control" name="top-search" id="top-search">
                </div>
            </form>
        </div>
            <ul class="nav navbar-top-links navbar-right">
				
                <li>
                    <a  data-toggle="modal" data-target="#myModal" style="color:white;">
                        <i class="fa fa-money"></i><!--<span class="label label-warning">--> Add Bill <!--</span>-->
                    </a>
                </li>
				
				<div class="modal inmodal" id="myModal" role="dialog" aria-hidden="true">
				
					<div class="modal-dialog">
						<div class="modal-content animated bounceInRight">
							<div class="modal-header">
								
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								<i class="fa fa-money modal-icon"></i>
								<h4 class="modal-title">Add Bill</h4>
							</div>
							<div class="modal-body" id="modalwithdate">
								<div class="with_field">
									<span class="with">With <b>you</b> and:</span>
									<ul id="with_person_list" class="token-input-list-mac">
										
										<li class="token-input-input-token-mac" id="main_li">
											<input type="text" class="token-input-add_bill_with"  name="token-input-add_bill_with" id="token-input-add_bill_with" style="outline: none; width:auto;"  >
										</li>
									</ul>	
								</div>
								<div>
								<div id="error_msg_bill_members" style="color:red;"></div>
								<!--	<form role="form">-->
										<div class="form-group"><label>Description</label> <input type="text" name="expense_title" id="expense_title" placeholder="Enter Description" class="form-control"></div>
										<div id="error_msg_description" style="color:red;"></div>
										<div class="form-group"><label>Amount</label> <input type="text" placeholder="Amount" class="form-control" name="bill_amount" id="bill_amount" value="0.0"></div>
										<div id="error_msg_amount" style="color:red;"></div>
									<div class="form-group">
									<label>Category</label><br>
									
									<select class="select2_demo_3 form-control" name="category">
									<option></option>
									<option value="Other" selected>Other</option>
									<option value="Grocery">Grocery</option>
									<option value="Dinning">Dinning</option>
									<option value="Car">Car</option>
									<option value="Taxi">Taxi</option>
									<option value="Liquor">Liquor</option>
									<option value="Services">Services</option>
									<option value="General">General</option>
									</select>
									</div>
										<div class="row" style="text-align:center;padding-bottom:10px;margin-left:auto;margin-right:auto;">
											<div class="col-sm-12">
												<div class="with_field" style="padding-bottom:10px;">
													<span class="with">Paid By </span>
													<ul style="margin-left:-35px;" id="with_person_list" class="token-input-list-mac">
														<li class="token-input-token-mac" id="payer_li_id">
															<img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/50-31b0bb2f5aec77f11d60a1dc3fa14c23a958fed79261b32e94a73e9c27473ebb.png">
															<a data-toggle="modal" onclick="showPayerModal();" style="color:#1ab394" href="#">
															<span id="payer_span_id" style="color:#1ab394"><%=emailid%></span>
									
															
															</a>
															<!--<span class="token-input-delete-token-mac">×</span>-->
														</li>
														<li class="token-input-input-token-mac">
															<span class="with_continue">&nbsp;&nbsp;&nbsp;and split&nbsp;&nbsp;&nbsp;</span>
														</li>
														<li class="token-input-token-mac">
															<a data-toggle="modal" style="color:#1ab394" onclick="showPayeeModal();">Equally</a>
															
														</li>
													</ul>
													
												</div>
											</div>
										</div>
										<div class="row">
											<!--<div class='col-sm-6'>
												<div class="form-group">
													<div class='input-group date' id='date1'>
														<input type='text' name="datepicker" class="form-control" value="12/12/2017"/>
														<span class="input-group-addon">
															<span class="glyphicon glyphicon-calendar"></span>
														</span>
													</div>
													 <script type="text/javascript">
														$(function () {
															$('#date1').datepicker();
															$("#date1").on("change",function(){
																var selected = $(this).val();
																alert(selected);
															})
														});
													</script>
												</div>
											</div>-->
											<input type='hidden' name="datepicker" class="form-control" value="12/12/2017"/>
											<div class="col-sm-6 form-group">
												<label>Add Image/Note</label><br>
												<a class="btn btn-primary" href="login.html" data-toggle="modal" data-target="#addNoteImage">
													<i class="fa fa-money"></i><!--<span class="label label-warning">--> Add Bill Image/Note <!--</span>-->
												</a>	
											</div>
										</div>
									<!--</form>-->
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
								<button type="button" onclick="submitForm()" class="btn btn-primary" >Add Expense</button>
							</div>
						</div>
					</div>	
					
				</div>
				
				
				<div class="modal modal_side_left inmodal" id="addNoteImage" tabindex="-1" role="dialog" aria-hidden="true">
				
					<div class="modal-dialog modal-sm">
						<div class="modal-content animated bounceInRight">
							<div class="modal-header modal_header_sub">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								<!--<i class="fa fa-laptop modal-icon"></i>-->
								<h4 class="modal-title">Add Image/Note</h4>
							</div>
							<form id="upload-form"  method="post" enctype="multipart/form-data">
							<div class="modal_body" style="padding:20px;">
								<div class="form-group">
									<label>Add Image</label><br>
									<label title="Upload image file" for="inputImage" class="btn btn-primary">
										<input type="file" accept="image/*" name="file" id="inputImage" class="hide" >
										Add Image
										
									</label>
									
									<br></br>
									<input type="text" class="form-control" id="upload-file-info" name="expense_file1" readonly value="No File Selected">
									</br>
									<!--<button class="btn-primary" type="submit" id="upload_receipt" >Upload Receipt</button>-->
									<input type="hidden" name="expense_file1" id="expense_file" value="" >
									</form>
								</div>
								<div class="form-group">
									<label>Note</label> 
									<textarea placeholder="Enter Note" class="form-control" name="expense_note"></textarea>
								</div>	
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary" data-dismiss="modal" >Save changes</button>
							</div>
						</div>
					</div>
				</div>
				
				<div class="modal modal_side_left inmodal" id="selectpayer" tabindex="-1" role="dialog" aria-hidden="true">
					<div class="modal-dialog modal-sm">
						<div class="modal-content animated bounceInRight">
							<div class="modal-header modal_header_sub">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								<!--<i class="fa fa-laptop modal-icon"></i>-->
								<h4 class="modal-title">Select Payer</h4>
								<input id="payer" name="payer" type="hidden" value="<%=emailid%>">
							</div>
							<div class="modal_body_sub">
								<ul id="payers_ul">
								  
								</ul>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary" data-dismiss="modal" >Save changes</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal modal_side_left inmodal" id="selectpayee" tabindex="-1" role="dialog" aria-hidden="true">
					<div class="modal-dialog modal-sm">
						<div class="modal-content animated bounceInRight">
							<div class="modal-header modal_header_sub">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								<!--<i class="fa fa-laptop modal-icon"></i>-->
								<h4 class="modal-title">Select Payees</h4>
							</div>
							<div class="modal_body_sub">
								<div class="tabs-container">
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="#tab-31"> <i class="fa fa-laptop"></i></a></li>
										<li class=""><a data-toggle="tab" href="#tab-41"><i class="fa fa-desktop"></i></a></li>
										
									</ul>
									<div class="tab-content">
										<div id="tab-31" class="tab-pane active">
											<div class="panel-body" id="equally_panel">
												
													
											</div>
										</div>
										<div id="tab-41" class="tab-pane">
											<div class="panel-body" id="exactly_panel">
												
												
											</div>
										</div>
										
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
								</form>
							</div>
						</div>
					</div>
				
				</div>
			
				
				
                <li>
					<a href="login.html" data-toggle="modal" data-target="#settleupmain">
                        <i class="fa fa-money"></i><!--<span class="label label-warning">--> Settle Up <!--</span>-->
                    </a>
                </li>
				
				<div class="modal inmodal"  id="settleupmain" role="dialog" aria-hidden="true">
					<div class="modal-dialog modal-sm">
						<div class="modal-content animated bounceInRight">
						<form action="../AddExpenseController" method="post">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								<h4 class="modal-title">Settle Up</h4>
							</div>
							<div class="modal-body" id="modalwithdate">
								
								<div class="form-group">
									<label>Paid By:</label><br>
									
									<!--<select class="select2_demo_3 form-control">
									<option></option>
									<!--<option value="Bahamas">Bahamas</option>
									<option value="Bahrain">Bahrain</option>
									<option value="Bangladesh">Bangladesh</option>
									<option value="Barbados">Barbados</option>
									<option value="Belarus">Belarus</option>
									<option value="Belgium">Belgium</option>
									<option value="Belize">Belize</option>
									<option value="Benin">Benin</option>
									<option value=""></option>
									</select>-->
									<input type="text" name="paid_by1" id="paid_by1" class="form-control" disabled value="<%=user.getEmailId()%>">
									<input type="hidden" name="paid_by" value="<%=user.getEmailId()%>">
									<input type="hidden" name="added_by" value="<%=user.getEmailId()%>">
									<input type="hidden" name="expense_title" value="Ewa_Demo_Settle_Up_aaaaaaa">
									<input type="hidden" name="expense_category" value="Other">
									<input type="hidden" name="added_date" value="2017/12/12">
									<input type="hidden" name="group_id" value="0">
									
									
								</div>
								
								<div class="form-group">
									<label>Paid To:</label><br>
									
									<select class="select2_demo_3 form-control"  name="paid_for" required>
									<option></option>
									<!--<option value="Bahamas">Bahamas</option>
									<option value="Bahrain">Bahrain</option>
									<option value="Bangladesh">Bangladesh</option>
									<option value="Barbados">Barbados</option>
									<option value="Belarus">Belarus</option>
									<option value="Belgium">Belgium</option>
									<option value="Belize">Belize</option>
									<option value="Benin">Benin</option>-->
									<%
									ExpenseDao expenseDao1 = new ExpenseDao();
									//System.out.println("user.getEmailId()"+user.getEmailId());
									HashMap<String, UserDetail> friendList = (HashMap<String, UserDetail>)expenseDao1.getFriendListByEmail(user.getEmailId());
									//System.out.println("friendList in Friends  " + friendList);
									if(!(friendList.isEmpty()))
									{	
									Set keys = friendList.keySet();

								   for (Iterator i = keys.iterator(); i.hasNext(); ) {
									   String key = (String) i.next();
						       UserDetail friend = (UserDetail) friendList.get(key);%>
						       <option  value="<%=friend.getEmailId()%>"><%=friend.getEmailId()%></option>
							<%}}%>	
									</select>
								</div>
								<div class="form-group">
									<label>Add Amount</label><br>
										<input type="text" name="total" id="settle_amount" class="form-control" required>
										<div id="error_msg_amount_settle" style="color:red;"></div>
											
								</div>
								<div class="form-group">
									<label>Add Image</label><br>
									<label title="Upload image file" for="inputImage" class="btn btn-primary">
										<input type="file" accept="image/*" name="settle_file1"  id="settle_file1" class="hide">
										Add Image
									</label>								
								</div>
								<input type="text" class="form-control" id="upload-file-info1"  readonly value="No File Selected">
								<input type="hidden" name="expense_file2" id="expense_file2" value="" >
								<div class="form-group">
									<label>Note</label> 
									<textarea placeholder="Enter Note" class="form-control" name="expense_note"></textarea>
								</div>
									
								
							  
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
								<button type="submit" class="btn btn-primary">Settle Up</button>
							</div>
							</form>
						</div>
					</div>
				</div>
				
				
                
                <li class="dropdown">
                    <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                        <i class="fa fa-user"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="profile.jsp">
                                <div>
                                    <i class="fa fa-envelope fa-fw"></i> Your Account
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="creategroup.jsp">
                                <div>
                                    <i class="fa fa-group fa-fw"></i> Create Group
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="../SignoutController">
                                <div>
                                    <i class="fa fa-sign-out fa-fw"></i> Logout
                                </div>
                            </a>
                        </li>
                    </ul>
                </li>

          
            </ul>

        </nav>
</div>