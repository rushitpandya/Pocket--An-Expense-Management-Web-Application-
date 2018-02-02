<%@page import="pocket.controllers.*"%>
<%@page import="java.util.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="pocket.beans.*"%>

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
<div class="row wrapper border-bottom white-bg page-heading">
      <div class="col-sm-4">
        <%
		try{
        String friendName="";
        UserDetail friend = (UserDetail)session.getAttribute("friend_obj");
        System.out.println("friend-----" +friend.toString());
        System.out.println("friend-----" +friend.getEmailId());
        Map<Integer, HashMap<Integer,ExpenseDetail>> expenseMap = (Map<Integer, HashMap<Integer,ExpenseDetail>>)session.getAttribute("expense_map");
        System.out.println(expenseMap.toString());
        %>
        
        <h2><%=LoginDao.getUserDetailByEmail(friend.getEmailId())%></h2>
        <!--<ol class="breadcrumb">
          <li>
            <a href="index-2.html">Home</a>
          </li>
          <li class="active">
            <strong>Frequently asked questions</strong>
          </li>
        </ol>-->
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
                          <a data-toggle="collapse" href="#<%=tmpExp.getExpenseId()%>" class="faq-question"> <%=tmpExp.getName()%> </a>
                          <% String addedById;
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
                              paidById = LoginDao.getUserDetailByEmail(tmpExp.getPaidById()) + " Paid ";
                          }
                              %>
                              <span class="small font-bold"><%=paidById%></span>
                              <div class="tag-list">
                                <span class="normal">$<%=tmpExp.getTotalAmount()%></span>
                              </div>
                            </div>
                            <%String role;
                                String color;
                                double amount;
                                HashMap<String, Double> map = tmpExp.getAmount();
								System.out.println(map.toString());
                                if(tmpExp.getPaidById().equals(user.getEmailId())){
									if(map.get(user.getEmailId()) != null)
									{
										role = "You Lent";
										color= "positive";
                                    amount = tmpExp.getTotalAmount() - map.get(user.getEmailId());
									}
									else{
										role = "You Lent";
										color = "positive";
										amount = tmpExp.getTotalAmount();
									}
                                    
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
                                              <%String paidId;
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
											}										  
											%>
											<div class="comment notes" >
											<%if(tmpExp.getNote().equals("") || tmpExp.getNote() == null)
											{
											//System.out.println("Note :"+tmpExp.getNote());		
											%>
											No Notes
												

											<%}else{%>
											
												<%=tmpExp.getNote()%>	
											
											
											<%}%></div>
											<%if(comment_individual != null){%>
											
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
								<h1 align="center">No Expense Added for <%=LoginDao.getUserDetailByEmail(friend.getEmailId())%></h1>
							</div>
							</div>
							<%}%>
                            <div id="tab-4" class="tab-pane">
                                <div class="panel-body">
                                    <strong>Donec quam felis</strong>

                                    <p>Thousand unknown plants are noticed by me: when I hear the buzz of the little world among the stalks, and grow familiar with the countless indescribable forms of the insects
                                        and flies, then I feel the presence of the Almighty, who formed us in his own image, and the breath </p>

                                    <p>I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine. I am so happy, my dear friend, so absorbed in the exquisite
                                        sense of mere tranquil existence, that I neglect my talents. I should be incapable of drawing a single stroke at the present moment; and yet.</p>
                                </div>
                            </div>
                            <div id="tab-5" class="tab-pane">
                                <div class="panel-body">
                                    <div class="ibox-content" id="ibox-content">
                    <div id="vertical-timeline" class="vertical-container dark-timeline center-orientation">
                      <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon positive-bg">
                          <i class="fa fa-briefcase"></i>
                        </div>

                        <div class="vertical-timeline-content">
                          <h2><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/100-4c516cdaad9fa42b890727b03e49634a199eaba880df708835105dfa42fac74b.png" class="avatar"> Harshil Shah</h2>
                          <p class="positive">gets back <span class="amount">$45</span><a style="float:right;" href="#" class="btn btn-sm btn-primary"> More info</a></p>
                          
                        </div>
                      </div>

                      <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon negative-bg">
                          <i class="fa fa-file-text"></i>
                        </div>

                        <div class="vertical-timeline-content">
                          <h2>Send documents to Mike</h2>
                          <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since.</p>
                          <a href="#" class="btn btn-sm btn-success"> Download document </a>
                          <span class="vertical-date">
                            Today <br/>
                            <small>Dec 24</small>
                          </span>
                        </div>
                      </div>

                      <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon lazur-bg">
                          <i class="fa fa-coffee"></i>
                        </div>

                        <div class="vertical-timeline-content">
                          <h2>Coffee Break</h2>
                          <p>Go to shop and find some products. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's. </p>
                          <a href="#" class="btn btn-sm btn-info">Read more</a>
                          <span class="vertical-date"> Yesterday <br/><small>Dec 23</small></span>
                        </div>
                      </div>

                      <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon yellow-bg">
                          <i class="fa fa-phone"></i>
                        </div>

                        <div class="vertical-timeline-content">
                          <h2>Phone with Jeronimo</h2>
                          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iusto, optio, dolorum provident rerum aut hic quasi placeat iure tempora laudantium ipsa ad debitis unde? Iste voluptatibus minus veritatis qui ut.</p>
                          <span class="vertical-date">Yesterday <br/><small>Dec 23</small></span>
                        </div>
                      </div>

                      <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon lazur-bg">
                          <i class="fa fa-user-md"></i>
                        </div>

                        <div class="vertical-timeline-content">
                          <h2>Go to the doctor dr Smith</h2>
                          <p>Find some issue and go to doctor. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. </p>
                          <span class="vertical-date">Yesterday <br/><small>Dec 23</small></span>
                        </div>
                      </div>

                      <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon navy-bg">
                          <i class="fa fa-comments"></i>
                        </div>

                        <div class="vertical-timeline-content">
                          <h2>Chat with Monica and Sandra</h2>
                          <p>Web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). </p>
                          <span class="vertical-date">Yesterday <br/><small>Dec 23</small></span>
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