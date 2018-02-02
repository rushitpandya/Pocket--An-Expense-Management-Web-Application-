 <!-- Mainly scripts -->
<%@page import="pocket.beans.*"%>
<%
	UserDetail user = (UserDetail)session.getAttribute("User");
	String emailid = user.getEmailId();
%>	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../assets-dashboard/js/jquery-2.1.1.js"></script>
    <script src="../assets-dashboard/js/bootstrap.min.js"></script>
    <script src="../assets-dashboard/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="../assets-dashboard/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Flot -->
    <script src="../assets-dashboard/js/plugins/flot/jquery.flot.js"></script>
    <script src="../assets-dashboard/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
    <script src="../assets-dashboard/js/plugins/flot/jquery.flot.spline.js"></script>
    <script src="../assets-dashboard/js/plugins/flot/jquery.flot.resize.js"></script>
    <script src="../assets-dashboard/js/plugins/flot/jquery.flot.pie.js"></script>
    <script src="../assets-dashboard/js/plugins/flot/jquery.flot.symbol.js"></script>
    <script src="../assets-dashboard/js/plugins/flot/jquery.flot.time.js"></script>

    <!-- Peity -->
    <script src="../assets-dashboard/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="../assets-dashboard/js/demo/peity-demo.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="../assets-dashboard/js/inspinia.js"></script>
    <script src="../assets-dashboard/js/plugins/pace/pace.min.js"></script>

    <!-- jQuery UI -->
    <script src="../assets-dashboard/js/plugins/jquery-ui/jquery-ui.min.js"></script>

    <!-- Jvectormap -->
    <script src="../assets-dashboard/js/plugins/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
    <script src="../assets-dashboard/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>

    <!-- EayPIE -->
    <script src="../assets-dashboard/js/plugins/easypiechart/jquery.easypiechart.js"></script>

    <!-- Sparkline -->
    <script src="../assets-dashboard/js/plugins/sparkline/jquery.sparkline.min.js"></script>

    <!-- Sparkline demo data  -->
    <script src="../assets-dashboard/js/demo/sparkline-demo.js"></script>
	
	<!-- Data picker -->
   <script src="../assets-dashboard/js/plugins/datapicker/bootstrap-datepicker.js"></script>
	<!-- Select2 -->
    <script src="../assets-dashboard/js/plugins/select2/select2.full.min.js"></script>
	<script src="../js/jquery.form.js"></script>
    <script>

	$('#inputImage').on('change', uploadFile);
	
	function uploadFile(event)
	{
		$('#upload-file-info').val($(this).val());
		$('#upload-file-info1').val($(this).val());
	    event.stopPropagation(); 
	    event.preventDefault(); 
	    var files = event.target.files; 
	    var data = new FormData();
	    $.each(files, function(key, value)
	    {
	        data.append(key, value);
	    });
	    postFilesData(data); 
	 }
	
function postFilesData(data)
	{
	 $.ajax({
        url: '../UploadReceipt',
        type: 'POST',
        data: data,
        cache: false,
        dataType: 'json',
        processData: false, 
        contentType: false,
		
        success: function(data)
        {
        	//success
			//alert(data);
			
			//	alert("Data"+element);
			$('input[name=expense_file1]').val(data);
			$('input[name=expense_file2]').val(data);
				//$('#expense-file').val(data);
			
        }
        
	    });
	}
	
	
	$('#settle_file1').on('change', uploadFile1);
	
	function uploadFile1(event)
	{
		$('#upload-file-info1').val($(this).val());
		
	    event.stopPropagation(); 
	    event.preventDefault(); 
	    var files = event.target.files; 
	    var data = new FormData();
	    $.each(files, function(key, value)
	    {
	        data.append(key, value);
	    });
	    postFilesData1(data); 
	 }
	
function postFilesData1(data)
	{
	 $.ajax({
        url: '../UploadReceipt',
        type: 'POST',
        data: data,
        cache: false,
        dataType: 'json',
        processData: false, 
        contentType: false,
		
        success: function(data)
        {
        	//success
			//alert(data);
			
			//	alert("Data"+element);
			$('input[name=expense_file2]').val(data);
			
				//$('#expense-file').val(data);
			
        }
        
	    });
	}
	
	
	
	function settle_amount_on_blur()
	{
		$('#error_msg_settle_amount').text('');
		var total = $('#settle_amount').val();
		if(total.isNaN)
		{
			$('#error_msg_settle_amount').text('Please Enter Only Numbers!');
			
				$('#settle_amount').val('');
		}
	}
	$(document).on('blur','#settle_amount',function(){
		//bill_amount_on_blur();
		
		settle_amount_on_blur();
	});
	
	function remove(arr1, item) {
	//alert(item);
	
		var email='<%=emailid%>';
		  for(var i = arr1.length; i--;) {
			  if(arr1[i] == item) {
				  arr1.splice(i, 1);
				if(item == ($("#payer").val()))
				{
					$( "li.main_payer" ).removeClass( "selected" );
					$('li.main_payer[data-id="'+email+'"]').addClass("selected");
					$("#payer").val(email);
					$('#payer_span_id').text(email);		
				}
			  }
		  }
	}
	
	
	
	function submitForm()
	{
		
		var members_id=[];
		var members_amount=[];
		var email='<%=emailid%>';
		var added_by=email;
		
		var total,payer,bill_total_amount,added_date,expense_note,expense_file,category;
		
		var url = "../AddExpenseController?added_by="+email;
		$('#error_msg_amount').text('');
		$('#error_msg_description').text('');
		$('#error_msg_bill_members').text('');
		var description = $('#expense_title').val();
		
		if(description != '')
		{
			url=url+"&expense_title="+description;
			bill_total_amount = $('#bill_amount').val();
		
			//alert(bill_total_amount);
			if(bill_total_amount != 0.0 )
			{
				payer=$('#payer').val();
				url=url+"&paid_by="+payer;
				if(friendslist.length > 0)
				{
					total=0;
					$.each(friendslist, function(index, element) {
						var member_amount=$('input[name="'+element+'"]').val();
						members_id[index]=element;
						//alert("User:"+element+" member_amount:"+member_amount)
						members_amount[index]=member_amount;
						total=eval(total)+eval(member_amount);
						url=url+"&"+element+"="+member_amount;
					});
					//alert(total);
					total=Number(Math.round(total+'e2')+'e-2');
					//alert(total);
					if(total == bill_total_amount)
					{	
						category=$('select[name=category]').val();
						expense_note =  $('textarea[name=expense_note]').val();
						added_date = $('input[name=datepicker]').val();
						var image =$('input[name=expense_file1]').val();
						//alert(image);
						url=url+"&expense_note="+expense_note+"&added_date="+added_date+"&expense_category="+category+"&total="+total+"&expense_image="+image;
						//alert(url);
						var groupid=0;
						//alert("length:"+arr.length);
						if(arr.length ==1)
						{
							if(arr[0].indexOf("@") <= -1)
							{	
								$.ajax({
									url : "../AddBillController",
									type : "GET",
									autoFocus: true,
									async :false,
									data : {
										   'getGroupId' : arr[0]
									},
									dataType : "json",
									success : function(data) {
										groupid=data[0];	
									}
									});
							}
						}
						//alert("groupid:"+groupid);
						$.ajax({
							type: "GET",
							url: url+"&group_id="+groupid,                
							dataType: "json",
							success:function(data){
								if(data){
									//<%session.setAttribute("Action","Expense Added Successfully");%>
									window.location.href = 'dashboard.jsp';
								}
							},
							error:function(){
								alert("Something went wrong! Please try again!");
							} 

						});
						
						
						
					}
					else{
						alert("Split Amount Should be Same as Total Amount");
						$('#error_msg_bill_members').text('Please Enter Valid Split Amount for All Members');
					}
				}
				else{
					$('#error_msg_bill_members').text('Please Enter Group or Friends to Split Bill Amount');
				}
			}
			else{
				$('#error_msg_amount').text('Please Enter Valid Amount of Bill');
			}
			
		}
		else{
			$('#error_msg_description').text('Please Enter Description of Bill');
		}
		
	}
	

	
	function add_payees_in_amount_exact_modal(friendslist)
	{
		//alert("here");
		$('#exactly_panel').empty();
		$('#exactly_panel').append('<div class="person" id="exactly_list" data-id="<%=user.getEmailId()%>"><div class="input-prepend"> <span class="add-on currency_symbol">$</span><input type="text" name="<%=user.getEmailId()%>" value="0.0"></div><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/100-4c516cdaad9fa42b890727b03e49634a199eaba880df708835105dfa42fac74b.png"><span class="name"><%=user.getEmailId()%></span></div>');
		var email='<%=emailid%>';
		//alert(friendslist);
		$.each(friendslist, function(index, element) {
			
			if(element!= email)
			{	
				$('#exactly_panel').append('<div class="person" id="exactly_list" data-id="'+element+'"><div class="input-prepend"> <span class="add-on currency_symbol">$</span><input type="text" name='+element+' value="0.0"></div><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/100-4c516cdaad9fa42b890727b03e49634a199eaba880df708835105dfa42fac74b.png"><span class="name">'+element+'</div>');
			}
		});
	}
	
	
	function add_payees_in_amount_modal(friendslist)
	{
		//alert("function call");
		$('#equally_panel').empty();
		$("#equally_panel").append('<div class="person" id="equally_list" data-id="<%=user.getEmailId()%>"><span class="amount equally_amount" data-id="<%=user.getEmailId()%>" >$0.00</span><input class="share" type="checkbox" value="<%=user.getEmailId()%>" checked="checked"><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/100-4c516cdaad9fa42b890727b03e49634a199eaba880df708835105dfa42fac74b.png"><span class="name"><%=user.getEmailId()%></span></div>');
		var email='<%=emailid%>';
		//alert(friendslist);
		$.each(friendslist, function(index, element) {
			
			if(element!= email)
			{	
				$("#equally_panel").append('<div class="person" id="equally_list" data-id="'+element+'"><span class="amount equally_amount" data-id="'+element+'">$0.00</span><input class="share" type="checkbox" value="'+element+'" checked="checked"><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/100-4c516cdaad9fa42b890727b03e49634a199eaba880df708835105dfa42fac74b.png"><span class="name">'+element+'</span></div>');
			}
		});
		
	}
	
	$(document).on('change','.share',function(){
		
		bill_amount_on_blur();
	});
	$(document).on('blur','#bill_amount',function(){
		bill_amount_on_blur();
	});
	
	
	
	function bill_amount_on_blur()
	{
			var total = $('#bill_amount').val();
			
			
			if(!isNaN(total))
			{	
				var count = 0;
				$('input.share:checkbox:checked').each(function(){
					count =count +1;
				});
				$('input.share:checkbox:checked').each(function(){
					var elementname=$(this).val();
					
					$('span[data-id="'+elementname+'"]').text('$'+(total/count).toFixed(3));
					$('input[name="'+elementname+'"]').val((total/count).toFixed(3));
				});
				$('input.share:checkbox:not(:checked)').each(function(){
					var elementname=$(this).val();
					$('span[data-id="'+elementname+'"]').text('$0.0');
					$('input[name="'+elementname+'"]').val(0.0);
				});
			}
			else{
				alert("Please Enter Only Numbers!");
				$('#bill_amount').val('0.0');
			}	
			//alert(total/count);
		
	}
	
	function add_payers_in_select_payer()
	{
		$('#payers_ul > li').remove();
		var payer=$('#payer').val();
		var email='<%=emailid%>';
		if(payer == email)
		{	
			$("#payers_ul").append('<li data-id="<%=user.getEmailId()%>" class="main_payer selected"><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/50-31b0bb2f5aec77f11d60a1dc3fa14c23a958fed79261b32e94a73e9c27473ebb.png"/> <%=user.getEmailId()%></li>');
			
			
		}
		else{
			$("#payers_ul").append('<li data-id="<%=user.getEmailId()%>" class="main_payer "><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/50-31b0bb2f5aec77f11d60a1dc3fa14c23a958fed79261b32e94a73e9c27473ebb.png"/> <%=user.getEmailId()%></li>');
			
		}
		
		$.each(friendslist, function(index, element) {
			if(element!= email)
			{	
				
				if(payer == element)
				{
					$("#payers_ul").append('<li data-id="'+element+'" class="main_payer selected"><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/50-31b0bb2f5aec77f11d60a1dc3fa14c23a958fed79261b32e94a73e9c27473ebb.png"/>'+ element+'</li>');
				}
				else{
					$("#payers_ul").append('<li data-id="'+element+'" class="main_payer"><img src="https://dx0qysuen8cbs.cloudfront.net/assets/fat_rabbit/avatars/50-31b0bb2f5aec77f11d60a1dc3fa14c23a958fed79261b32e94a73e9c27473ebb.png"/>'+ element+'</li>');
				}
			}
		});	
		
		
		
	}
	
	 function readURL(input) {
		
	  if (input.files && input.files[0]) {
		  var reader = new FileReader();

		  reader.onload = function (e) {
			  $('#blah')
				  .attr('src', e.target.result);
		  };

		  reader.readAsDataURL(input.files[0]);
	  }
	};
	
	function showPayeeModal() {
     //alert();
		 if($('#selectpayee').hasClass('in')){
			$('#selectpayee').modal('hide');
			return;
		}
		$('#selectpayer').modal('hide');
		$('#myModal').animate({
			'right' : '30px'
		});
		$('#selectpayee').modal('show');
		//add_payees_in_amount_modal();
		bill_amount_on_blur();
	}
	
	function showPayerModal() {
     //alert();
		 if($('#selectpayer').hasClass('in')){
			$('#selectpayer').modal('hide');
			return;
		}
		 $('#selectpayee').modal('hide');
		 $('#myModal').animate({
			'right' : '30px'
		});
		 $('#selectpayer').modal('show');
		 add_payers_in_select_payer();
	}
		$(document).on("click", "#selectpayeeina", function(event){
			//event.preventDefault();
				alert("hh");
				//$('#selectpayer').modal('hide');
				//$('#selectpayee').modal('show');
		});
		
        $(document).ready(function() {
 
			$(".select2_demo_3").select2({
                placeholder: "Select Email Address",
                allowClear: true,
				width: '100%'
            });
			var email='<%=emailid%>';
			friendslist.push(email);
			//arr.push(email);
			bill_amount_on_blur();
			settle_amount_on_blur();
			/*$('#data_1 .input-group.date').datepicker({
                todayBtn: "linked",
                keyboardNavigation: false,
                forceParse: false,
                calendarWeeks: true,
                autoclose: true
				
				
			});
			*/
		//$('#data_1').datetimepicker();

           
        });

		
		
    </script>
	<script src="../assets-dashboard/js/addbill.js"></script>
</body>

</html>