<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<%@page import="pocket.controllers.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="pocket.beans.*"%>
<%  //System.out.println("inside content.....");
    //HttpSession session = response.getSession();
	//Divya Section
    UserDetail user = (UserDetail)session.getAttribute("User");
    ExpenseDao expenseDao = new ExpenseDao();
	
	//Created By preyang
	ExpenseDao ex = new ExpenseDao();
    HashMap<Integer,Double> hm1 =  ex.getTotalExpenseByMonth(user.getEmailId());
	System.out.println(hm1.toString());
	Map<Integer, Double> hm = new TreeMap<Integer, Double>(hm1);
	System.out.println(hm.toString());
	System.out.println(user.toString());
	
	//Rishabh
		//UserDetail user = (UserDetail)session.getAttribute("User");
		String email = user.getEmailId();
		String emailExpenseDao = email;
		ExpenseDao expenseDao1 = new ExpenseDao();
		HashMap<String, Double> paidforId = expenseDao1.getExpensePaidForId(emailExpenseDao);
		HashMap<String, Double> paidbyId = expenseDao1.getExpensePaidById(emailExpenseDao);
		System.out.println("----------PaidforId:"+paidforId.toString());
		System.out.println("----------PaidById:"+paidbyId);
		HashMap<String,Double>result = expenseDao1.getFinalResult(paidforId,paidbyId);
		System.out.println(result);
		
		LoginDao loginDao = new LoginDao();
		


	
%>

<!--Divya-->

    <% Map<String,Double> categoryChart = expenseDao.getUserExpenseByCategory(user);%>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        
        var data = google.visualization.arrayToDataTable([
            ['Category', 'Expense'],
         <%Set keys = categoryChart.keySet(); 
         for (Iterator i1 = keys.iterator(); i1.hasNext(); ) {
           String key = (String) i1.next();
           double value = (double) categoryChart.get(key);%>
           ['<%=key%>', <%=value%>],
        <%}%>
          
          
        ]);

        var options = {
          title: 'My Expenses'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    </script>
	
	<!--Preyang-->
	<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart1);

      function drawChart1() {
        var data1 = google.visualization.arrayToDataTable([

          ['Task', 'Expense($)'],
          
		<%for(Integer month:hm.keySet()){
				double expense = hm.get(month);
		%>
			['<%=ExpenseDetail.monthEnum.get(month)%>',<%=expense%>],
          <%}%>
        ]);


        var options1 = {
			title: 'Month Wise Expense',
			 chartArea: {width: '50%'}
        };

        var chart1 = new google.visualization.BarChart(document.getElementById('Barchart'));

        chart1.draw(data1, options1);
      }
    </script>

<%
					
						DecimalFormat dfowe = new DecimalFormat("0.00");
						//String dfo = dfowe.format(tAmountowe);
								  
					%>
<div class="wrapper wrapper-content">
        <div class="row">
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">Monthly</span>
                                <h5>Total Balance</h5>
                            </div>
                            <%double difference = (expenseDao.getTotalPaidBy(user))-(expenseDao.getTotalPaidFor(user)) ;%>

                            <div class="ibox-content">
                                <h1 class="no-margins <%if(difference >= 0){%>positive<%}else{%>negative<%}%>">$<%=dfowe.format(difference)%></h1>
                                
                            </div>
                        </div>
                    </div>
					
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">Total Paid</span>
                                <h5>Total Paid</h5>
                            </div>
                            
                                
                            
                            <div class="ibox-content">
                                <h1 class="no-margins positive">$<%=dfowe.format(expenseDao.getTotalPaidBy(user))%></h1>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">Need To Pay</span>
                                <h5>Need To Pay</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins negative"><%if(expenseDao.getTotalPaidFor(user)>0){%>$<%=dfowe.format(expenseDao.getTotalPaidFor(user))%>
								<%}else{%>
								$ 0.00
								<%}%>
								</h1>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
							<%if(user.getExpenseLimit() == 0.0 ){%>
								 <span class="label label-danger pull-right">Set Limit</span>
							<%}else if((user.getExpenseLimit()-difference) < 0){%>
								<span class="label label-danger pull-right">Exceeded Limit</span>
							
							<%}else{%>
								<span class="label label-primary pull-right">Limit</span>
							<%}%>
                               
                                <h5>Limit</h5>
                            </div>
                            
                            <div class="ibox-content">
							<%
							if(difference < 0)
							{
								difference = difference*-1;
							}
							if(user.getExpenseLimit() == 0.0 ){%>
								<h1 class="no-margins <%if((user.getExpenseLimit() - difference)/user.getExpenseLimit() > 0.75){%>positive<%}else{%>negative<%}%>"><a href="profile.jsp" class="btn-primary">Set Limit</a></h1>
							<%}else if((user.getExpenseLimit()-difference) < 0){%>
								<h1 class="no-margins <%if((user.getExpenseLimit() - difference)/user.getExpenseLimit() > 0.75){%>positive<%}else{%>negative<%}%>">$<%=dfowe.format(user.getExpenseLimit() - difference)%></h1>
							
							<%}else{%>
								<h1 class="no-margins <%if((user.getExpenseLimit() - difference)/user.getExpenseLimit() > 0.75){%>positive<%}else{%>negative<%}%>">$<%=dfowe.format(user.getExpenseLimit() - difference)%></h1>
							<%}%>
							
                               
                                
                            </div>
                        </div>
            </div>
        </div>
			<div class="row">
            <div class="wrapper wrapper-content animated fadeInRight">	
			
			<div class="row">
				
              <div class="col-lg-6">
                <div class="ibox float-e-margins" style="height:275px; overflow:auto">
                    <div class="ibox-title">
                        <h5><span>Expense You Owe to Friends</span></small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                           
                            

                        </div>
						 <div class="ibox-content">

                        <table class="table">
                            <thead>
                            <tr>
                                <th class="text-danger">#</th>
                                
                                <th>Friend</th>
                                <th>Amount</th>
                            </tr>
                            </thead>
                            <tbody>
							
							<%
								int i=0;
								for(Map.Entry<String,Double> entry : result.entrySet())
								{
									
									if(entry.getValue() < 0 && !entry.getKey().equals(email))
									{
											i++;
											UserDetail userDetail2 = new UserDetail();
											userDetail2.setEmailId(entry.getKey());
											UserDetail userDetail1 = loginDao.getUserDetail(userDetail2);
											String name = userDetail1.getFirstName() +" "+ userDetail1.getLastName();
							%>
							
                            <tr>
                                <td><%=i%></td>
								
                                
                                <td><%=name%></td>
                                <td class="text-danger">$<%=entry.getValue()*-1%></td>
                            </tr>
								<%}}%>
								<%if(i==0){%>
									<tr><th colspan="3" align="center">No Expense</th></tr>	
									<%}%> 
								
                            </tbody>
                        </table>

                    </div>
                    </div>
					<span class="divider"></span>
                    
                </div>
            </div>
			
							
            <div class="col-lg-6">
                <div class="ibox float-e-margins" style="height:275px; overflow:auto">
                    <div class="ibox-title">
                        <h5>Expense your Friends Owe to You</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                           
                        </div>
                    </div>
                     <div class="ibox-content">

                        <table class="table">
                            <thead>
                            <tr>
                                <th class="text-navy">#</th>
                                <th>Friend</th>
                                <th>Amount</th>
                            </tr>
                            </thead>
                            <tbody>
							<%
							int j=0;
							for(Map.Entry<String,Double> entry : result.entrySet())
								{
									
									if(entry.getValue() > 0 && !entry.getKey().equals(email))
									{
											UserDetail userDetail2 = new UserDetail();
											userDetail2.setEmailId(entry.getKey());
											UserDetail userDetail1 = loginDao.getUserDetail(userDetail2);
											String name = userDetail1.getFirstName() +" "+ userDetail1.getLastName();
											j++;
							%>
					        <tr>
                                <th><%=j%></th>
								
                                <td><%=name%></td>
                                <td class="text-navy">$<%=entry.getValue()%></td>

                            </tr>
								<%}}%>
								<%if(j==0){%>
									<tr><th colspan="3" align="center">No Expense</th></tr>	
									<%}%>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
               
		
</div>
</div>
</div>
			
		<div class="row">
            <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
                <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Expense By Category</small></h5>
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
                            <div class="flot-chart">
                                <div class="flot-chart-content" id="flot-bar-chart"> <div id="piechart" style="width: 100%; height: 100%;"></div></div>
                            </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Every Month Expense</h5>
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
                    <div class="ibox-content">

                         <div class="flot-chart">
                            <div class="flot-chart-content" id="flot-line-chart"><div id="Barchart"></div></div>
                        </div>
                    </div>
                </div>
            </div>
            </div> 


        </div>
		 <div class="footer">
            <div class="pull-right">
                10GB of <strong>250GB</strong> Free.
            </div>
            <div>
                <strong>Copyright</strong> Example Company &copy; 2014-2015
            </div>
        </div>
        </div>
</div>