<%@page import="pocket.controllers.*"%>
<%@page import="java.util.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="pocket.beans.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
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


<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<%
UserDetail user = (UserDetail)session.getAttribute("User");
try{
%>
<div class="row wrapper border-bottom white-bg page-heading">
      <div class="col-sm-4">
        <%
        String groupName="";
        int groupId=0;
		//System.out.println("------------asd--adsd");
        GroupDetail group = (GroupDetail)session.getAttribute("group_obj");
        Map<Integer, HashMap<Integer,ExpenseDetail>> expenseMap = (Map<Integer, HashMap<Integer,ExpenseDetail>>)session.getAttribute("expense_map");
        System.out.println("------------Herwass"+expenseMap.toString());
		groupId = group.getGroupId();
		groupName = group.getGroupName();
        ArrayList<String> members1 = group.getEmailid();
		System.out.println("--------------"+members1.toString());
		System.out.println("Here-------------------------");
      %>
        <h2><%=group.getGroupName()%></h2>
        <!--<ol class="breadcrumb">
          <li>
            <a href="index-2.html">Home</a>
          </li>
          <li class="active">
            <strong>Frequently asked questions</strong>
          </li>
        </ol>-->
      </div>
      <div class="col-sm-8">
        <div class="title-action">
          <a href="updategroup.jsp?group_id=<%=groupId%>" action="viewgroup"class="btn btn-primary btn-sm">Edit Group</a>
        </div>
      </div>
    </div>
        <div class="wrapper wrapper-content">
      <div class="col-lg-12">
                    <div class="tabs-container">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#tab-3"> <i class="fa fa-exchange "></i></a></li>
                            <li class=""><a data-toggle="tab" href="#tab-4"><i class="fa fa-bar-chart"></i></a></li>
                            <li class=""><a data-toggle="tab" href="#tab-5"><i class="fa fa-bars"></i></a></li>
                        </ul>
                        <div class="tab-content">
							<%if(!expenseMap.isEmpty()){%>
                            <div id="tab-3" class="tab-pane active">
                                <div class="panel-body">
                                    <div class="wrapper wrapper-content animated fadeInRight">
                                     <%System.out.println("month"+expenseMap.keySet().toString());

                                     ArrayList<Integer> tmp = new ArrayList<Integer>();
                                     for(int i:expenseMap.keySet())
                                      tmp.add(i);
                                     Collections.sort(tmp);
                                     Collections.reverse(tmp);

                                      for(int month : tmp){
                                          System.out.println("month"+month);
                                          HashMap<Integer,ExpenseDetail> monthExpList = expenseMap.get(month);
                                     %> 
                                      <div class="month-divider ">

                                        <span><%=ExpenseDetail.monthEnum.get(month)%> 2017</span><!-- remaining-->
                                        <a href="#" target="_blank">View printable summary</a>
                                      </div>
                                        <%
                                        for(int expenseId:monthExpList.keySet()){
                                        ExpenseDetail tmpExp = monthExpList.get(expenseId);
                                        %>
                    <div class="bottom-divider faq-item">
                      <div class="row">
                        <div class="col-md-6">
                          <div class="date"><%=tmpExp.getAddedDate()%></div>
                          <img src="https://s3.amazonaws.com/splitwise/uploads/category/icon/slim/uncategorized/general.png" class="receipt">
                          <a data-toggle="collapse" href="#<%=tmpExp.getExpenseId()%>" class="faq-question"><%=tmpExp.getName()%></a>
                          <%String addedById;
                            if((tmpExp.getAddedById()).equals(user.getEmailId())){ addedById = "You";}
                            else{
                              addedById = LoginDao.getUserDetailByEmail(tmpExp.getAddedById());
                          }
                              %>
                          <small>Added by <strong><%=addedById%>
                            </strong> <i class="fa fa-clock-o"></i> <%=tmpExp.getSysCreationDate()%></small>
                        </div>
                        <div class="col-md-4">
                          <div class="row">
                            <div class="col-md-6">
                              <%String paidById;
                            if((tmpExp.getPaidById()).equals(user.getEmailId())){ paidById = "You Paid";}
                            else{
                              paidById = LoginDao.getUserDetailByEmail(tmpExp.getPaidById()) + " Paid";
                          }
						  	
                              %>
                              <span class="small font-bold"><%=paidById%></span>
                              <div class="tag-list">
							  
                                <span class="normal">$ <%=tmpExp.getTotalAmount()%></span>
                              </div>
                            </div>
                            <%
							String role;
                                String color;
                                double amount;
                                HashMap<String, Double> map = tmpExp.getAmount();
								if(map.isEmpty())
								{
									
								}
								else{
									
								}
                                if(tmpExp.getPaidById().equals(user.getEmailId())){
                                    role = "You lent";
                                    color= "positive";
									//System.out.println("Empty Not Map");
                                    amount = tmpExp.getTotalAmount() - map.get(user.getEmailId());
                                }else{
                                   
									if(map.get(user.getEmailId()) != null)
									{
										role = "You Owe";
										color = "negative";
										amount = map.get(user.getEmailId());
									}
									else{
										role = "Not Involved";
										color = "normal";
										amount = 0;
									}
                                    
                                  }
								
                                %>
                            <div class="col-md-6">
                              
                              <span class="small font-bold"><%=role%></span>
                              <div class="tag-list">
                                <span class="<%=color%>">$<%=amount%></span>
                              </div>
                            </div>
                            
                          </div>
                          
                        </div>
                        <div class="col-md-2 text-right">
                          <button class="btn btn-info " type="button"><i class="fa fa-paste"></i> Edit</button>
                          <button class="btn btn-danger " type="button"><i class="fa fa-times"></i> Delete</button>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-lg-12">
                          <div id="<%=tmpExp.getExpenseId()%>" class="panel-collapse collapse ">
                            <div class="faq-answer">
                              <div class="row expense_detail">
                                <table>
                                  <tbody>
                                    <tr>
                                      <td colspan="2">
                                        <div class="receipt">
                                          <h4><i class="fa fa-camera"></i> RECEIPT</h4>
                                          <%if(!tmpExp.getImage().equals("No File Selected") || !tmpExp.getImage().equals("")){%>
										  <a href="../images/<%=tmpExp.getImage()%>" target="_blank">
                                          <img width="60px" height="60px" src="../images/<%=tmpExp.getImage()%>">
                                          </a>
										  <%}else{%>
										  No Receipt
										  <%}%>
                                        </div>
                                       
                                        <img src="https://s3.amazonaws.com/splitwise/uploads/category/icon/slim/uncategorized/general.png" class="category" title="General" alt="General">
                                        <h3><%=tmpExp.getName()%></h3>
                                        <div class="cost">
                                         $<%=tmpExp.getTotalAmount()%>
                                        </div>  
                                        <%String addedId;
                            if((tmpExp.getAddedById()).equals(user.getEmailId())){ addedId = "You";}
                            else{
                              addedId = LoginDao.getUserDetailByEmail(tmpExp.getAddedById()) ;
                          }
                              %>
                                        <div class="creation_info">    
                                          Added by <strong><%=addedId%>
                                          </strong> <i class="fa fa-clock-o"></i> <%=tmpExp.getSysCreationDate()%>
                                        </div>
                                        <hr style="margin: 0; border-bottom: none; border-top: 1px solid #ddd">
                                      </td>
                                    </tr>
                                    <tr>
                                      <td class="left">
                                        <table class="shares">
                                          <tbody>
                                            <tr class="user">
                                              <td class="avatar">
                                                <img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/50-31b0bb2f5aec77f11d60a1dc3fa14c23a958fed79261b32e94a73e9c27473ebb.png" class="avatar" alt="User avatar">
                                              </td>
                                              <%
											
												String paidId;
                                                if((tmpExp.getPaidById()).equals(user.getEmailId())){ paidId = "You";}
                                                else{
                                                  paidId = LoginDao.getUserDetailByEmail(tmpExp.getPaidById());
                                              }
                                                  %>
                                              <td><strong><%=paidId%></strong> paid   <strong>$<%=tmpExp.getTotalAmount()%></strong></td>
                                            </tr>
                                            <%for(String s:tmpExp.getPaidForId()){%>
                                            <tr class="user">
                                              <td class="avatar">
                                                <img src="https://splitwise.s3.amazonaws.com/uploads/user/avatar/4907757/medium_a807a6e9-2651-460b-8d0b-f5f587dc14d9.jpeg" class="avatar" alt="User avatar">
                                              </td>
                                              <%String paidForId;
                                                if(s.equals(user.getEmailId())){ paidForId = "You";}
                                                else{
                                                  paidForId = LoginDao.getUserDetailByEmail(s);
                                              }
                                                  %>
                                              <td>
                                                <strong>
                                                   <%=paidForId%>
                                                </strong> owes     <strong>$<%=tmpExp.getAmount().get(s)%></strong>
                                              </td>
                                            </tr><%}%>
                                          </tbody>
                                        </table>
                                        </td>
                                      
									  <td class="right">
                                        <div class="comments">
                                          <h4><i class="fa fa-comment"></i> Notes and comments</h4>
										  
                                           <%
											MongodbDao mg = new MongodbDao();
											String username_com = null;
											String comment_individual = null;
											String com_id = null;
											String date_com = null;
											ArrayList<CommentPojo> comment =null;
											Map<String, ArrayList<CommentPojo>> commentMap = mg.selectComment();
											System.out.println("comment" + commentMap.toString());
											
											if(commentMap.containsKey(%><%Integer.toString(tmpExp.getExpenseId())%><%))
											{
											 comment = commentMap.get(%><%Integer.toString(tmpExp.getExpenseId())%><%);
											for (CommentPojo cm : comment)
												{
													 comment_individual = cm.getExpenseId();
													 username_com = cm.getComment();
													 com_id = cm.getCommentId();
													 date_com = cm.getDate();
													
												}
											}%>
											<div class="comment notes" >
											<%if(tmpExp.getNote().equals("") || tmpExp.getNote() == null)
											{
											//System.out.println("Note :"+tmpExp.getNote());		
											%>
											No Notes
												

											<%}else{%>
											
												<%=tmpExp.getNote()%>	
											
											
											<%}%></div><%if(comment_individual != null){%>
											
											<%for (CommentPojo cm : comment){
												%>
											<div class="comment User" data-id="<%=com_id%>">
                                                <div class="header">
                                                  <%=LoginDao.getUserDetailByEmail(cm.getComment())%>
                                                  <span class="timestamp">
                                                    <%=cm.getDate()%>
                                                  </span>
                                                  <%if((user.getEmailId()).equals(cm.getComment())){%>
                                                   <form name="comment" action="../CommentExpenseController" method="post"> 
                                                   <input type= "hidden" name= "commentid" value="<%=cm.getCommentId()%>">
                                                    <button style="margin-top:-25px;background-color:Transparent;border:none;"  class="delete_comment" name ="action" value= "delete_comment"  data-id="<%=cm.getCommentId()%>">x</button>
                                                    </form>                                                
                                                <%}%>
                                                </div>
                                                <%=cm.getExpenseId()%>
                                            </div>
											
											<%}}%>
											<div class="add_comment">
                                            <form name="comment" action="../CommentExpenseController" method="post"> 
                                              <input type="hidden" name="username" value="<%=user.getEmailId()%>">
                                              <input type="hidden" name="expense_id" value="<%=tmpExp.getExpenseId()%>">
                                            <textarea name="comment" placeholder="Add a comment" cols="40" rows="2"></textarea>
                                            <br>
                                            <button name="action" value="commentAdd" class="btn btn-small btn-orange">Post Comment</button>
                                          </form>
                                          </div>
                                        </div>
                                      </td>
									  
                                    </tr>
                                  </tbody>
                                </table>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                    </div>
                  <%}}%>
                    
                  </div>
                                </div>
                            </div>
							<%}else{%>
							<div id="tab-3" class="tab-pane active">
							<div class="panel-body">
								<h1 align="center">No Expense Added for <%=groupName%></h1>
							</div>
							</div>
							<%}%>
                            <div id="tab-4" class="tab-pane">
							<%ExpenseDao ex4 = new ExpenseDao();

								System.out.println("groupid"+groupId);
								System.out.println("paid_by_id"+user.getEmailId());
								 ExpenseDao ex5 = new ExpenseDao();
								 
								Double tAmountpaid =  ex4.getTotalPaidExpenseForGroup(groupId,user.getEmailId());
								
								DecimalFormat dfpaid = new DecimalFormat("0.00");
								  String dfp = dfpaid.format(tAmountpaid);
								  
								
								Double tAmountowe =  ex5.getTotalOweExpenseForGroup(groupId,user.getEmailId());
								
								 DecimalFormat dfowe = new DecimalFormat("0.00");
								  String dfo = dfowe.format(tAmountowe);
								  
								  
								Double tAmountTotal = tAmountpaid - tAmountowe;
								DecimalFormat dftotal = new DecimalFormat("0.00");
								  String dft = dftotal.format(tAmountTotal);
								  
								
								
								
							%>
							
                                <div class="row">
                    <div class="col-lg-4">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right " style="background-color:#5bc5a7!Important">You are Owed</span>
                                <h5>You Paid in <b><%=groupName%></b></h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins"><div style="color:#5bc5a7;font-weight: bold;">$<%=dfp%></div></h1>
                               
                               
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right" style="background-color:#ff652f!Important">You Owe</span>
                                <h5>You Owe in <b><%=groupName%></b></h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins"><div style="color:#ff652f;font-weight: bold;">$<%=dfo%></div></h1>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <%if(tAmountTotal < 0 ){%>
									<span class="label label-primary pull-right">You Owe</span>
								<%}%>
								<%if(tAmountTotal > 0 ){%>
									<span class="label label-primary pull-right">You Are Owed</span>
								<%}%>
                                <h5>Total NET Balance in <b><%=groupName%></b></h5>
                            </div>
                            <div class="ibox-content">
							<%if(tAmountTotal < 0 ){%>
								
                                <h1 class="no-margins"><div style="color:#ff652f;font-weight: bold;">$<%=dft%></div></h1>
								
							<%}%>
							<%if(tAmountTotal > 0 ){%>
                                <h1 class="no-margins"><div style="color:#5bc5a7;font-weight: bold;">$<%=dft%></div></h1>
								
							<%}%>
							<%if(tAmountTotal == 0 ){%>
                                <h1 class="no-margins"><div style="color:#5bc5a7;font-weight: bold;">$0.00</div></h1>
								
							<%}%>
                            </div>
                        </div>
                    </div>
                    
        </div>

<%
ExpenseDao ex = new ExpenseDao();

System.out.println("groupid"+groupId);
HashMap<Integer,Double> hm1 =  ex.getTotalExpenseByMonthForGroup(groupId);
Map<Integer, Double> hm = new TreeMap<Integer, Double>(hm1);
System.out.println(hm.toString());

HashMap<String,Double> hmcat =  ex.getTotalExpenseByCategoryForGroup(groupId);
Map<String, Double> hmcategory = new TreeMap<String, Double>(hmcat);
System.out.println(hmcategory.toString());


%>

<script type="text/javascript">
//$(document).ready(function () {

   // $('#carousel-example-generic').on('slide.bs.carousel', function () {
   //     // do something…
    //    loadCharInfo(this);
   // })}); -->
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart1);

      function drawChart1() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Expense'],
          
		<%for(Integer month:hm.keySet()){
				double expense = hm.get(month);
		%>
			['<%=ExpenseDetail.monthEnum.get(month)%>',<%=expense%>],
          <%}%>
        ]);


        var options = {
			title: 'Month Wise Expense Spending for <%=groupName%>',
			 'width':1200,
                     'height':400

        };

        var chart = new google.visualization.BarChart(document.getElementById('Barchart'));

        chart.draw(data, options);
		
		  var data1 = google.visualization.arrayToDataTable([
          ['Task', 'Expense'],
          
		<%for(String category:hmcategory.keySet()){
				double expense = hmcategory.get(category);
		%>
			['<%=category%>',<%=expense%>],
          <%}%>
        ]);

        var options1 = {
          title: 'Category Wise Expense Spending for  <%=groupName%>',
		   'width':1200,
                     'height':400
        };

        var chart = new google.visualization.PieChart(document.getElementById('PieChart'));

        chart.draw(data1, options1);
      }
	  
	  	</script>
		


<div class="row">
            <div class="wrapper wrapper-content animated fadeInRight">
          
                <!-- <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5> Distribution of Expenses by Category for <b><%=groupName%></b>  </small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">Config option 1</a>
                                </li>
                                <li><a href="#">Config option 2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
							<span class="divider"></span>
							<div class="ibox-content">
									
										<div  id="PieChart"></div>
									
							</div>
						</div>
					</div>

					<div class="col-lg-6">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5> Distribution of Expenses by Month for <b><%=groupName%></b> </h5>
								<div class="ibox-tools">
									<a class="collapse-link">
										<i class="fa fa-chevron-up"></i>
									</a>
									<a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
										</a>
										<ul class="dropdown-menu dropdown-user">
											<li><a href="#">Config option 1</a>
											</li>
											<li><a href="#">Config option 2</a>
											</li>
										</ul>
										<a class="close-link">
											<i class="fa fa-times"></i>
										</a>
									</div>
								</div>
								<div class="ibox-content" id="test">

									<div class="flot-chart">
										<div class="flot-chart-content" id="flot-line-chart"><div id="Barchart"></div></div>
									</div>
								</div>
							</div>
						</div> -->
						<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
							  <!-- Indicators -->
							  <ol class="carousel-indicators">
								<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
								<li data-target="#carousel-example-generic" data-slide-to="1"></li>
								
							  </ol>

							  <!-- Wrapper for slides -->
							  <div class="carousel-inner">
								<div class="active item">
								  <div id="PieChart" class="chart" style="height:360px;"></div>
								</div>
								<div class="item">
								  <div id="Barchart" class="chart" style="height:360px;"></div>
								</div>
								
								
							  </div>
 
      
							  <!-- Controls -->
							  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left"></span>
							  </a>
							  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right"></span>
							  </a>
							   <!-- Controls -->
  
						</div>
						
						</div>      

		
					
					</div>
					
					
 

                            </div>
                            <div id="tab-5" class="tab-pane">
                              <% Map<String, Double> groupBalances = new HashMap<String,Double>();
                                  Map<String, UserDetail> groupMembers = new HashMap<String, UserDetail>();

                                    ArrayList<String> members = group.getEmailid();
									System.out.println("-----"+members.toString());
                                    for(String e : members){
                                      UserDetail user_obj = LoginDao.getUser(e);
                                      groupMembers.put(user_obj.getEmailId(), user_obj);
                                  }
                                  Map<String, Double> groupPaidById = ExpenseDao.getGroupPaidById(group.getGroupId());
                                  Map<String, Double> groupPaidForId = ExpenseDao.getGroupPaidForId(group.getGroupId());

                                  for(Map.Entry<String, UserDetail> entry:groupMembers.entrySet()){
                                    
                                    double paid_by,paid_for;
                                    if(groupPaidById.containsKey(entry.getKey())){
                                        paid_by = groupPaidById.get(entry.getKey());

                                    }else{
                                      paid_by = 0;
                                    }
                                    if(groupPaidForId.containsKey(entry.getKey())){
                                        paid_for = groupPaidForId.get(entry.getKey());

                                    }else{
                                      paid_for = 0;
                                    }
                                    groupBalances.put(entry.getKey(),paid_by-paid_for);

                                }

                              %>
                                <div class="panel-body">
                                    <div class="ibox-content" id="ibox-content">
                    <div id="vertical-timeline" class="vertical-container dark-timeline center-orientation">
                      <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon positive-bg">
                          <i class="fa fa-briefcase"></i>
                        </div>
                        <%String action1="", style1="normal";
                          %>
                        <%if(groupBalances==null){%><div class="vertical-timeline-content">
                          <h2>No Entries Found</h2>
                          
                        </div><%}else{for(Map.Entry<String, Double> balance:groupBalances.entrySet()){%>
                        <%double balance1=0.0;
						if(balance.getValue() == 0){
                            action1 = "Settled up";
                            style1 = "normal";
							balance1= balance.getValue();
                        }else if(balance.getValue()<0){
                            action1 = "Owes";
                            style1 = "negative";
							balance1= balance.getValue()*-1;
                        }else if(balance.getValue()>0){
                            action1 = "Lents";
                            style1 = "positive";
							balance1= balance.getValue();
                        }%>
                        <div class="vertical-timeline-content">
                          <h2><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/100-4c516cdaad9fa42b890727b03e49634a199eaba880df708835105dfa42fac74b.png" class="avatar"> <%=LoginDao.getUserDetailByEmail(balance.getKey())%></h2>
                          <p class="<%=style1%>"><%=action1%><span class="amount"> $<%=dfowe.format(balance1)%></span></p>
                          
                        </div>
                        <%}}%>
                      </div>

                      
                        
                      </div>
                    </div>
                  </div>
                                </div>
                            </div>
                            
                            
                        </div>
                    </div>
                </div>
      </div>
        </div>
<%} 
catch(Exception e)
{
	e.printStackTrace();
}%>
<jsp:include page='importscripts.jsp'/>