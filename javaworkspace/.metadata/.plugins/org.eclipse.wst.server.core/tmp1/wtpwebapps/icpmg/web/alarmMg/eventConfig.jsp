<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>
<%@ include file="/icp/include/taglib.jsp" %>
<html>

  <body>
  
  		<style type="text/css">
		  		p{
			  		font-family:"微软雅黑"; 
			  		font-size:14px; 
			  		color:#f000;
			  		height: 40px;
					line-height: 40px;
					overflow: hidden;
				}
  				.body{
  					float:flex;
  					width:99%;
  					height:99%;
  				}
  				.top{
  					width:95%;
  					height:40px;
  					background:white;
  				}
  				.top-left{
  					float:left;
  					width:50%;
  				}
  				.top-left p{
  				 padding-left:30px;
  					float:left;
  					height: 40px;
					 line-height: 40px;
					 overflow: hidden;
  				}
  				.infor{
  					padding-left:10px;
  					float:left;
  					height: 40px;
					 line-height: 40px;
					 overflow: hidden;
  				}
  				.top-right{
  					float:left;
  					width:50%;
  					height: 40px;
  				}
  				.top-right p{
  					 padding-left:30px;
  					float:left;
  				}
  				
				.center{
					margin-top:10px;
					width:95%;
  					height:40px;
  					background:white;
				}
				.center p{
  				 padding-left:30px;
  					float:left;
  					height: 40px;
					 line-height: 40px;
					 overflow: hidden;
  				}
  				.center2{
  					margin-left:30px;
					margin-top:10px;
					width:87%;
  					height:40px;
  					background:#eee;
				}
				.center2-left{
					float:left;
  					width:50%;
  					height: 40px;
				}
				.center2-right{
					float:left;
  					width:50%;
  					height: 40px;
				}
				.center2-left p{
						 padding-left:30px;
						 text-align:center; 
					}
					.center2-right p{
					 padding-left:30px;
						 text-align:center; 
					}
					.level-1{
						margin-left:30px;
						margin-top:10px;
						width:87%;
	  					height:40px;
					}
						.level-1 p{
							float:left;
						}
					.infor-left{
						float:left;
						margin-left:40px;
						height: 40px;
						 line-height: 40px;
						 overflow: hidden;
					}
					.infor-right{
						float:left;
						margin-left:70px;
						height: 40px;
					 line-height: 40px;
					 overflow: hidden;
					}
					#addmsg{
						 padding-top:10px;
					 margin-left:50px;
						width:50%;
					}
					.bottom{
					 padding-top:25px;
					 margin-left:50px;
						width:87%;
						 text-align:center; 
					}
					.button{
						float:left;
						width:100%;
						text-align:center; 
					}
					#savebtn{
						 text-align:right; 
						 text-align:center; 
					}
					#btn{
					width:60px;
						 text-align:left; 
						 text-align:center; 
					}
				</style>
    <script type="text/javascript">
    var flagck = 0;
    var configtoolbar = [
          				{
          				    id:'addalmconfig',
          				    disabled:false,
          					text : '新增监控项',
          					iconCls : 'icon-add',
          					handler : function() { 
          						showDiv();
          						$('#addwindow').panel({title:"新增监控项"});
          						$('#addwindow').window('open');
          						clear();
          						$('#addmsg').html('');
          					}
          				},
          				{
          				    id:'almunack',
          				  disabled:false,
          					text : '停用',
          					iconCls : 'icon-almunack',
          					handler : function() {
         							//alert("停用"); 
         							var rows = $("#alarmconfigdatagrid").datagrid('getChecked');
									if(rows.length!=1)
									{
										$.messager.alert('消息','请选择一条记录！'); 
										return; 
									}
									var id = "";
									var status = "0";
									var indexs = 0;
									 $.each(rows,function(index,object){
									 		id= object.cid;
									 		indexs = $("#alarmconfigdatagrid").datagrid('getRowIndex',object);
					   				 });
		   							 $.messager.confirm('确认','您确认想要停用么？',function(r){   
					   					 if (r){
						   						$.ajax({
				          					  			type : 'post',
				          					  			url:'${pageContext.request.contextPath}/alarm/dokpistatus.do',
				          					  			data:{
				          					  				cid:id,
				          					  				status:status
				          					  			},
				          					  			success:function(retr){
					          					  			var r =  JSON.parse(retr); 
					          					  			if(r.success){
						          					  			$("#alarmconfigdatagrid").datagrid('updateRow',{
						          					  				index: indexs,
						          					  				row: {
						          					  					status: '0'
						          					  				}
						          					  			});
					          									$.messager.show({
					          										msg:r.msg,
					          										title:'成功'
					          									});
					          									$("#almunack").linkbutton("disable");
					          									$("#alounack").linkbutton("enable");
					          								}else{
					          									//norRule_datagrid.datagrid('rejectChanges');
					          									$.messager.alert('错误',r.msg,'error');
					          								}
					          					  		
					          					  		 var typeidText = $("#typeid").combo("getText");
					          							   if(!typeidText){
					          								   $("#typeid").combo('reset'); 
					          							   }
					          							  $('#alarmconfigdatagrid').datagrid('load',icp.serializeObject($('#alarmconfig_searchform')));
					          					  			
				          					  			}
				          							});
											}
          							});
          						}
          				} ,
          				{
          				    id:'alounack',
          				  disabled:false,
          					text : '启用',
          					iconCls : 'icon-almack',
          					handler : function() {
         							//alert("启用"); 	
          						var rows = $("#alarmconfigdatagrid").datagrid('getChecked');
								if(rows.length!=1)
								{
									$.messager.alert('消息','请选择一条记录！'); 
									return; 
								}
								var id = "";
								var status = "1";
								var indexs = 0;
								 $.each(rows,function(index,object){
								 		id= object.cid;
								 		indexs = $("#alarmconfigdatagrid").datagrid('getRowIndex',object);
				   				 });
	   							 $.messager.confirm('确认','您确认想要启用么？',function(r){   
				   					 if (r){
					   						$.ajax({
			          					  			type : 'post',
			          					  			url:'${pageContext.request.contextPath}/alarm/dokpistatus.do',
			          					  			data:{
			          					  				cid:id,
			          					  				status:status
			          					  			},
			          					  			success:function(retr){
				          					  			var r =  JSON.parse(retr); 
				          					  		/* $.messager.alert('消息',_data.msg); */
			          					  			if(r.success){
				          					  			$("#alarmconfigdatagrid").datagrid('updateRow',{
				          					  				index: indexs,
				          					  				row: {
				          					  					status: '1'
				          					  				}
				          					  			});
			          									$.messager.show({
			          										msg:r.msg,
			          										title:'成功'
			          									});
			          									$("#almunack").linkbutton("enable");
			          									$("#alounack").linkbutton("disable");
			          								}else{
			          									$.messager.alert('错误',r.msg,'error');
			          								}
			          					  		       
			          					  		   var typeidText = $("#typeid").combo("getText");
			          							   if(!typeidText){
			          								   $("#typeid").combo('reset'); 
			          							   }
			          							  $('#alarmconfigdatagrid').datagrid('load',icp.serializeObject($('#alarmconfig_searchform')));
				          					  		
			          					  			}
			          							});
										}
      							});
      						}
          				}  ,
          				{
          				    id:'updatealounack',
          				  disabled:false,
          					text : '修改',
          					iconCls : 'icon-almack',
          					handler : function() {
         							//alert("启用"); 	
          						var rows = $("#alarmconfigdatagrid").datagrid('getChecked');
								if(rows.length!=1)
								{
									$.messager.alert('消息','请选择一条记录！'); 
									return; 
								}
								var id = "";
								var status = "1";
								var indexs = 0;
								 $.each(rows,function(index,object){
								 		id= object.cid;
								 		indexs = $("#alarmconfigdatagrid").datagrid('getRowIndex',object);
				   				 });
								 showDiv();
	          					clear();
	          					$.ajax({
	        				  		type : 'post',
	        				  		url:'${pageContext.request.contextPath}/alarm/getPmcKpiAlarmVo.do',
	        				  		data:{cid:id},
	        				  		success:function(retr){
										var obj = JSON.parse(retr);
										$('#addwindow').window({
											onOpen: function () {
												$('#alarmcfigform').form('load',obj);
												$("#addtypeid").combobox('unselect',obj.typeid);
												$("#addtypeid").combobox('select',obj.typeid);
												$("#kpi").combobox('unselect',obj.kpiname);
												$("#kpi").combobox('select',obj.kpiname);
											}
										});
										$('#addwindow').panel({title:"监控项变更"});
										$('#addwindow').window('open');
										$('#addmsg').html('');
	        				  		}
	        				});
      						}
          				} 
          				 ,
           				{
           				    id:'delalounack',
           				  disabled:false,
           					text : '删除',
           					iconCls : 'icon-almack',
           					handler : function() {
          							//alert("启用"); 	
           						var rows = $("#alarmconfigdatagrid").datagrid('getChecked');
 								if(rows.length!=1)
 								{
 									$.messager.alert('消息','请选择一条记录！'); 
 									return; 
 								}
 								var id = "";
 								var status = "1";
 								var indexs = 0;
 								 $.each(rows,function(index,object){
 								 		id= object.cid;
 								 		indexs = $("#alarmconfigdatagrid").datagrid('getRowIndex',object);
 				   				 });
 	   							 $.messager.confirm('确认','您确认想要删除信息么？',function(r){   
 				   					 if (r){
 					   						$.ajax({
 			          					  			type : 'post',
 			          					  			url:'${pageContext.request.contextPath}/alarm/deleteAlarmConfig.do',
 			          					  			data:{
 			          					  				cid:id,
 			          					  			},
 			          					  			success:function(retr){
 				          					  			var r =  JSON.parse(retr); 
 				          					  		/* $.messager.alert('消息',_data.msg); */
 			          					  			if(r.success){
 				          					  			$("#alarmconfigdatagrid").datagrid('updateRow',{
 				          					  				index: indexs,
 				          					  				row: {
 				          					  					status: '1'
 				          					  				}
 				          					  			});
 			          									$.messager.show({
 			          										msg:r.msg,
 			          										title:'成功'
 			          									});
 			          								}else{
 			          									$.messager.alert('错误',r.msg,'error');
 			          								}
 			          					  			}
 			          							});
 										}
 				   					$('#alarmconfigdatagrid').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
       							});
       						}
           				} ,
          				 //邮件接收人
          				 {
           					id:'sendemail',
             				disabled:false,
             				text : '邮件',
             				iconCls : 'icon-almack',
             				
             				handler : function(){
             					$('#sendemailwindow').panel({title:"邮件接收人"});
          						$('#sendemailwindow').window('open');
          						$('#addreceivermessage').form('clear');
          						$('#sendemailwindow_searchform').form('clear');
          						var sendemailtoolbar = [
          						                       {
          						                    	id:'addrecipient',
          					             				disabled:false,
          					             				text : '增加',
          					             				iconCls : 'icon-almack',
          					             					handler : function(){
          					             						
          					             						document.getElementById('emailoptiontype').value=1;
          					             						$('#addreceiver').panel({title:"添加收件人"});
          					            						$('#addreceiver').window('open');
          					            						$('#addreceivermessage').form('reset');
          					             					}
          						},
          												{
				          							    id:'changerecipient',
							             				disabled:false,
							             				text : '修改',
							             				iconCls : 'icon-almack',
							             				handler : function(){
							             					
							             					var rows= $('#recipientsdatagrid').datagrid('getSelected');
							             					$('#addreceiver').window({
			 														onOpen: function () {
			 															$('#addreceivermessage').form('load',rows);
			 															
			 														}
			 													});
							             					document.getElementById('emailoptiontype').value=0;
							             					$('#addreceiver').panel({title:"修改收件人信息"});
		 													$('#addreceiver').window('open');
							             					
							             				}
          						},
          												{
					          							id:'delrecipient',
							             				disabled:false,
							             				text : '删除',
							             				iconCls : 'icon-almack',
							             				handler : function(){
							             					var rows= $('#recipientsdatagrid').datagrid('getSelected');
							             					$.messager.confirm('确认','您确认想要删除信息么？',function(r){   
							 				   					 if (r){
							 					   						$.ajax({
							 			          					  			type : 'post',
							 			          					  			url:'${pageContext.request.contextPath}/alarmemail/deleteRecevient.do',
							 			          					  			data:{
							 			          					  				alarmemail:rows.receiveremail,
							 			          					  			},
							 			          					  			success:function(retr){
							 			          					  			 reloadRecipientsdatagrid();
							 			          					  			}
							 			          							});
							 										}
							 				   					
							       							});
							             				}
          						}
          						                        ];
          						$('#recipientsdatagrid').datagrid({
          							rownumbers : false,
    								border : false,
    								striped : true,
    								method : 'post',
    								loadMsg : '数据装载中......',
    								singleSelect : true,
    								fitColumns : true,
    								pagination : true,
    								pageSize : 10,
    								pageList : [ 5, 10, 20, 30, 40, 50 ],
    							 	toolbar : sendemailtoolbar,
    								url : '${pageContext.request.contextPath}/alarmemail/queryRecevient.do',
    								onLoadSuccess: function(data){
    								$('#changerecipient').linkbutton('disable');
									    $('#delrecipient').linkbutton('disable');
									    $('#recipientsdatagrid').datagrid('getPager').pagination({
							                layout: ['list', 'sep', 'first', 'prev', 'sep', 'manual', 'sep', 'next', 'last'],
							                total: data.count
							            })
    								},
    								onSelect: function (){  									
    			
    										$('#changerecipient').linkbutton('enable');
       									    $('#delrecipient').linkbutton('enable');
    								
    								}
    								
    								
    							
          						}
          								);
             				}
           				}
          				 
          			];
	    function formatShow(value,row,index){
	    	if(value==1){
	    	         return "是";
	    	     }else{
	    	         return "否";
	    	}
	    }

    	function reloadRecipientsdatagrid(){
    		$('#recipientsdatagrid').datagrid( {
				  url : '${pageContext.request.contextPath}/alarmemail/queryRecevient.do'});
    	}
    	 function searchRecipientsdatagrid(){
    		   var typeidText = $("#receiver").combo("getText");
			   if(!typeidText){
				   $("#receiver").combo('clear'); 
			   }
			  $('#recipientsdatagrid').datagrid( {
				  url : '${pageContext.request.contextPath}/alarmemail/queryRecevient.do?recevientName='+encodeURIComponent(encodeURIComponent(typeidText)),
				  onLoadSuccess: function (data) {
					  $('#changerecipient').linkbutton('disable');
					    $('#delrecipient').linkbutton('disable');
			            $('#recipientsdatagrid').datagrid('getPager').pagination({
			                layout: ['list', 'sep', 'first', 'prev', 'sep', 'manual', 'sep', 'next', 'last'],		                
			                total: data.count
			            })
			        }});
    	 }
    	 //验证电话号码
    	 $.extend($.fn.validatebox.defaults.rules, {  
		       receiverphonenumber: {
		    	   validator:function(value) {
		    		    var rex=/^1[3-8]+\d{9}$/;
		    		    var  rex1=/^\d{7,8}$/;
		    		    var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
		    		    if(rex.test(value)||rex2.test(value)||rex1.test(value))
		    		    {
		    		      return true;
		    		    }else
		    		    {
		    		       return false;
		    		    }    		      
		    		    },
		           message: '请输入正确的电话号码'  
		         } 			       
		    });
    	 function addreceiver(){   		 
    		 var url='${pageContext.request.contextPath}/alarmemail/addRecevient.do';  
    		 if ($('#emailoptiontype').val() == 0) {
    						var rows= $('#recipientsdatagrid').datagrid('getSelected');
							url = '${pageContext.request.contextPath}/alarmemail/updateRecevientByEmail.do?recevientEmail='+rows.receiveremail;
						}
						$('#addreceivermessage').form({
							url : url,
							onSubmit : function() {
								return $(this).form('validate');
							},
							success : function(data) {
								$('#recipientsdatagrid').datagrid('reload');
								$('#addreceivermessage').form('reset');
								var data = eval('(' + data + ')'); // change the JSON string to javascript object    
								alert(data.msg);

							}
						});
						$('#addreceivermessage').submit();

		  }
		  function addreceiverHide() {
						$('#addreceiver').window('close');
			}
          			
		  $(document).ready(function() {
				loadConfigDataGrid();
				 $('#almunack').linkbutton('disable');
				 $('#alounack').linkbutton('disable');
				 $('#delalounack').linkbutton('disable');
				  $('#updatealounack').linkbutton('disable');
			});
		  
		  //记载表格数据
		  function loadConfigDataGrid(){
			$('#alarmconfigdatagrid')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'edittime',
								sortOrder : 'desc',
								singleSelect : true,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : configtoolbar,
								url : '${pageContext.request.contextPath}/alarm/queryAlarmConfig.do',
								onSelect:docfgCheck,
								onUnselect:unDocfgCheck,
								onLoadSuccess: function (data) {
								      var pageopt = $('#alarmconfigdatagrid').datagrid('getPager').data("pagination").options;
								      var  _pageSize = pageopt.pageSize;
								      var  _rows = $('#alarmconfigdatagrid').datagrid("getRows").length;
								      var total = pageopt.total; //显示的查询的总数
								      if (_pageSize >= 10) {
								         for(var i=10;i>_rows;i--){
								            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
								            $(this).datagrid('appendRow', {cid:''  });
								         }
								         $('#alarmconfigdatagrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
									    		total: total,
									    	});
								         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
								      }else{
								         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
								         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
								      }
								      //设置不显示复选框
								      var rows = data.rows;
								      if (rows.length) {
											 $.each(rows, function (idx, val) {
												if   (val.cid==''){  
													$('#configtevent  input:checkbox').eq(idx+1).css("display","none");
													 
												}
											}); 
								      }
								 } ,
								 //没数据的行不能被点击
								 onClickRow: function (rowIndex, rowData) {
											if   (rowData.cid==''){
												 $(this).datagrid('unselectRow', rowIndex);
											}else{
												flagck=0;
											}
											//判断时候已经有全部选择
											if(flagck ==1){
												$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
											}
								}, 
								 //全选问题
								onCheckAll: function(rows) {
									flagck = 1;
										$.each(rows, function (idx, val) {
											if   (val.cid==''){
												$("#alarmconfigdatagrid").datagrid('uncheckRow', idx);
												//增加全选复选框被选中
												$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
											}
										});
								}, 
								onUncheckAll: function(rows) {
									flagck = 0;
								} 
							});
		}
		  
		  function alrmconfigdetailformater(value, row, index) {
				if(value.length==0){
					return "<a style=\"color:blue;cursor:pointer\" ></a>";
				}else{
					return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewConfigDetails('"+ row.cid+"');\">详情</a>";
				}
		}
		  function docfgCheck(rowIndex,rowData){
			  if(rowData.status=='1'){
				  $('#alounack').linkbutton('disable');
				  $('#almunack').linkbutton('enable');
			  }
			  if(rowData.status=='0'){
				  $('#almunack').linkbutton('disable');
				  $('#alounack').linkbutton('enable');
			  }
			  $('#delalounack').linkbutton('enable');
			  $('#updatealounack').linkbutton('enable');
		  }
		 
		  function unDocfgCheck(rowIndex,rowData){
			  $('#almunack').linkbutton('disable');
			  $('#alounack').linkbutton('disable');
			  $('#delalounack').linkbutton('disable');
			  $('#updatealounack').linkbutton('disable');
			}
		  function alrmconfigstatusformater(value, row, index){
			  if(value=='0'){
				  return "停用";
			  }
			 if(value=='1'){
				 return "在用";		  
			 }
		  }
		  function viewConfigDetails(id){
				$.ajax({
				  		type : 'post',
				  		url:'${pageContext.request.contextPath}/alarm/getPmcKpiAlarmVo.do',
				  		data:{cid:id},
				  		success:function(retr){
				  			clear();
				  			$('#alarmcfigform').form('load',JSON.parse(retr));
				  			hideDiv();
				  			$('#addwindow').panel({title:"监控项详情"});
				  			 $('#addwindow').window('open');
				  		}
				});
			}
		  function hideDiv(){
			  $(".top").hide();
			  $(".bottom").hide();
			  $("#alarmcfigform input").attr("readOnly",true);
			  $("#alarmcfigform input").css('backgroundColor', '#ececec');
		  }
		  function showDiv(){
			  $(".top").show();
			  $(".bottom").show();
			  $("#alarmcfigform input").removeAttr("readonly");
			  $("#alarmcfigform input").css('backgroundColor', '#fff');
		  }
		  function searchConfigDataGrid(){
			  //如果文本框的内容为空，则重置下拉框
			   var typeidText = $("#typeid").combo("getText");
			   if(!typeidText){
				   $("#typeid").combo('reset'); 
			   }
			  $('#alarmconfigdatagrid').datagrid('load',icp.serializeObject($('#alarmconfig_searchform')));
		  }
		  function redo(){
		  	$("#typeid").next().children().text('');
		  }
		  function  addHide(){
			  $('#addwindow').window('close');
		  }
		  function add(){
			 var addtypeid =  $('#addtypeid').combobox('getValue'); 
				if(addtypeid == null || addtypeid == ''){
					$('#addmsg').html('请选择设备类型！');
					return;
				}
				 var kpi =  $('#kpi').combobox('getValue'); 
				if(kpi == null || kpi == ''){
					$('#addmsg').html('请选择监控指标！');
					return;
				}
				if(!/^[0-9]*$/.test($('#seriousceil').val())){
					$('#addmsg').html('请正确填写严重告警阈值的上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#seriouslower').val())){
					$('#addmsg').html('请正确填写严重告警阈值的下限值！');
					return;
				}
				if(($('#seriousceil').val())-($('#seriouslower').val())<0){
					$('#addmsg').html('严重告警阈值的下限值不能大于上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#mainceil').val())){
					$('#addmsg').html('请正确填写主要告警阈值的上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#mainslower').val())){
					$('#addmsg').html('请正确填写主要告警阈值的下限值！');
					return;
				}
				if(($('#mainceil').val())-($('#mainslower').val())<0){
					$('#addmsg').html('主要告警阈值的下限值不能大于上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#secondaryceil').val())){
					$('#addmsg').html('请正确填写次要告警阈值的上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#secondaryslower').val())){
					$('#addmsg').html('请正确填写次要告警阈值的下限值！');
					return;
				}
				if(($('#secondaryceil').val())-($('#secondaryslower').val())<0){
					$('#addmsg').html('次要告警阈值的下限值不能大于上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#generalceil').val())){
					$('#addmsg').html('请正确填写一般告警阈值的上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#generalslower').val())){
					$('#addmsg').html('请正确填写一般告警阈值的下限值！');
					return;
				}
				if(($('#generalceil').val())-($('#generalslower').val())<0){
					$('#addmsg').html('一般告警阈值的下限值不能大于上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#warnceil').val())){
					$('#addmsg').html('请正确填写警告告警阈值的上限值！');
					return;
				}
				if(!/^[0-9]*$/.test($('#warnslower').val())){
					$('#addmsg').html('请正确填写警告告警阈值的下限值！');
					return;
				}
				if(($('#warnceil').val())-($('#warnslower').val())<0){
					$('#addmsg').html('警告告警阈值的下限值不能大于上限值！');
					return;
				}
				else{
					$('#addmsg').html('');
				}
				submitSave();
			}
		  function submitSave(){
			 	$('#savebtn').linkbutton('disable');
			 	var cid = $("#cid").val();
			 	var url = "${pageContext.request.contextPath}/alarm/addAlarmConfig.do";
			 	if(cid){
			 		url = "${pageContext.request.contextPath}/alarm/updateAlarmConfig.do";
			 	}
			 	$('#alarmcfigform').form('submit',{
			    url:url,
			    onSubmit: function(){
			    },
			    success:function(retr){
			    	var _data =  JSON.parse(retr); 
			    	$.messager.alert('消息',_data.msg);
					if(_data.success){
						$('#alarmconfigdatagrid').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
			    	}
			    	$('#savebtn').linkbutton('enable');
			    }
			});
			 	$('#addwindow').window('close');
			 	$('#savebtn').linkbutton('enable');
			 }
		  function clear(){
			  $('#alarmcfigform').form('clear');
			}
  </script>
    <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	    	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
	    			<form id="alarmconfig_searchform"  method ="post">
	    					<table >
	    							<tr>
	    									<td>设备类型：<input name="typeid" id="typeid"  style="width:150px;height:30px" class="easyui-combobox"  data-options=" url: '${pageContext.request.contextPath}/alarm/getType.do',valueField: 'id', textField: 'text', "/></td>
	    									<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="searchConfigDataGrid()">查询</a>
	    									       &nbsp; &nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true"  onclick="$('#alarmconfig_searchform input').val('');$('#alarmconfigdatagrid').datagrid('load',{});">重置</a>
											</td>
	    							</tr>
	    					</table>
	    			</form>
	    	</div>
	    	<div data-options="region:'center',border:false"  style="margin-top:10px" id="configtevent">
					<table  style="width:100%;" id="alarmconfigdatagrid">
			    			<thead >
			    					<tr>
			    							<th data-options="field:'ck',checkbox:true"></th>
											<th data-options="field:'chinaname',align:'center'" style="width:19%;">指标名称</th>
											<th data-options="field:'title',align:'center'" style="width:19.8%;">标题</th>
											<th data-options="field:'edittime',align:'center'" style="width:20%;">时间</th>
											<th data-options="field:'status',align:'center',formatter:alrmconfigstatusformater"  style="width:20%;">状态</th>
											<th data-options="field:'cid',align:'center',formatter:alrmconfigdetailformater" style="width:19%;" >操作</th>
									</tr>
			    			</thead>
		    		</table>
    		</div>
    </div>
    
    <div id="addwindow" class="easyui-window" title="新增监控项" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:800px;height:530px;padding:5px;">
	   		<div class="easyui-layout" data-options="fit:true">
	   				<div class = "body" data-options="region:'center',border:false" style="padding:10px;">
	   						<form id="alarmcfigform" method="post" >
	   								<input type="hidden" id="cid" name="cid"/>
	   								<div class="top">
	   									<div class="top-left">
	   										<p >设备类型：</p>
	   										<div class="infor">
													<input name="typeid" id="addtypeid"  style="width:240px;height:30px" class="easyui-combobox"  
														data-options=" 
																url: '${pageContext.request.contextPath}/alarm/getType.do',
																valueField: 'id', 
																textField: 'text', 
																onSelect: function(rec){ 
																	//alert(111);
																	$('#kpi').combobox('clear');
		            												var url2 = '${pageContext.request.contextPath}/alarm/getSonType.do?typeid='+rec.id;    
														            $('#kpi').combobox('reload', url2); 
														            $('#alarmtitle').textbox('setValue',rec.text + '的指标');
														          
														        }
													"/>
											</div>
	   									</div>
	   									<div class="top-right">
	   										<p >指 标：</p>
	   										<div class="infor">
													<input name="kpiname" id="kpi"  style="width:240px;height:30px" class="easyui-combobox"  data-options=" valueField: 'id', textField: 'text', onSelect:function(rec){  $('#alarmtitle').textbox('setValue', $('#addtypeid').combobox('getText') + '的指标' + rec.text + '超过阈值');} "/>
											</div>
	   									</div>
	   								</div>
	   								<div class="center" >
											<p >标  题：</p>
											<div class="infor">
													<input id="alarmtitle" name="title" class="easyui-textbox" style="width:600px;height:30px;margin-left:8px;"/>
											</div>
									</div>
									<div class="center2" >
										<div class="center2-left">
												<p >上 限</p>
										</div>
										<div class="center2-right">
												<p >下 限</p>
										</div>
									</div>
									<div class="level-1">
											<p>严重</p>
											<div class="infor-left">
													<input name="seriousceil" id="seriousceil" class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
											<div class="infor-right">
													<input name="seriouslower" id="seriouslower"  class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
									</div>
									<div class="level-1">
											<p>主要</p>
											<div class="infor-left">
													<input name="mainceil" id="mainceil"  class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
											<div class="infor-right">
													<input name="mainslower" id="mainslower"   class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
									</div>
									<div class="level-1">
											<p>次要</p>
											<div class="infor-left">
													<input name="secondaryceil" id="secondaryceil" class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
											<div class="infor-right">
													<input name="secondaryslower" id="secondaryslower" class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
									</div>
									<div class="level-1">
											<p>一般</p>
											<div class="infor-left">
													<input name="generalceil" id="generalceil"  class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
											<div class="infor-right">
													<input name="generalslower" id="generalslower"  class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
									</div>
									<div class="level-1">
											<p>警告</p>
											<div class="infor-left">
													<input name="warnceil" id="warnceil"  class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
											<div class="infor-right">
													<input name="warnslower" id="warnslower" class="easyui-textbox" style="width:240px;height:30px;margin-left:8px;"/>
											</div>
											<div >
												<p >备注：包含下限，不包含上限 </p>
											</div>
									</div>
	   						</form>
	   						<div id="addmsg" style="margin-left:225px;color:red;"></div>
							<div class="bottom">
								<div class="button" >
										<a id="savebtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="add()">   保存   </a> 
										<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="addHide()">   取消   </a> 
								</div>
							</div>
	   				</div>
	   		</div>
    </div>
    <div id="sendemailwindow" class="easyui-window" title="邮件接收人" data-options="closed:true,cache : false,modal: true" style="width:800px;height:530px;padding:5px;">
    	    <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		    	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		    			<form id="sendemailwindow_searchform"  method ="post">
		    					<table >
		    							<tr>
		    									<td>收件人姓名：<input name="receivername" id="receiver"  style="width:150px;height:30px" class="easyui-textbox"  /></td>
		    									<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchRecipientsdatagrid()">查询</a>
		    									       &nbsp; &nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#sendemailwindow_searchform input').val('');reloadRecipientsdatagrid();" >重置</a>
												</td>
		    							</tr>
		    					</table>
		    			</form>
		    	</div>
		    	<div data-options="region:'center',border:false"  style="margin-top:10px" id="emailrecipients">
						<table  style="width:100%;" id="recipientsdatagrid">
				    			<thead >
				    					<tr>
				    							<th data-options="field:'ck',checkbox:true"></th>
												<th data-options="field:'receivername',align:'center'" style="width:19%;">接收人名称</th>
												<th data-options="field:'receiverdept',align:'center'" style="width:19.8%;">接收人部门</th>
												<th data-options="field:'receiveremail',align:'center'" style="width:20%;">接收人邮箱</th>
												<th data-options="field:'receiverphone',align:'center'"  style="width:20%;">接收人电话</th>
												<th data-options="field:'isreceive',align:'center'" formatter="formatShow" style="width:19%;" >是否接受邮件</th>
										</tr>
				    			</thead>
			    		</table>
	    		</div>
   		 </div>
    </div>
    <div id="addreceiver" class="easyui-window" title="添加收件人" data-options="closed:true,cache : false,iconCls:'icon-save',modal:true"style="width:400px;height:400px;padding:5px;">
    	<form id="addreceivermessage" method="post" style="margin-left : 60px" >
    		<input type="hidden" id="emailoptiontype" value='0' />
    		<div style="margin-top: 20px;">
    			 <label for="receivername" style="font-size :14px;">姓 名:</label>   
                 <input class="easyui-textbox" type="text" name="receivername"  style="width:200px;height:28px;background:white;" /> 
    		</div>
    		
    		<div style="margin-top: 20px;">
    			 <label for="receiverdept" style="font-size :14px;">部 门:</label>   
                 <input class="easyui-textbox" type="text" name="receiverdept"  style="width:200px;height:28px;background:white;" /> 
    		</div>
    		
    		<div style="margin-top: 20px;">
    			<label for="receiveremail" style="font-size :14px;">邮 箱:</label>   
      		    <input class="easyui-textbox easyui-validatebox" type="text" name="receiveremail"  validType="email" style="width:200px;height:28px;background:white;"/>
    		</div>
    		
    		<div style="margin-top: 20px;">
    			<label for="receiverphone" style="font-size :14px;">电 话:</label>   
      		    <input class="easyui-textbox easyui-validatebox" type="text" name="receiverphone"  data-options="validType:'receiverphonenumber'" style="width:200px;height:28px;background:white;"/>
    		</div> 		
    		<div style="margin-top: 20px;">
		        <td style="text-align:right;"><span style="font-size :14px;">是否接收邮件：</span></td>
		        <td style="text-align:left">
		            <span class="radioSpan">
		                <input type="radio" name="isreceive" value="0" style="margin-left :12px;"><span style="font-size :14px;">否</span></input>
		                <input type="radio" name="isreceive" value="1" style="margin-left :25px;"><span style="font-size :14px;">是</span></input>
		            </span>
		        </td>
    		</div>
    	</form>
    	<div class="bottom">
			<div class="button" >
				<a id="emailsavebtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addreceiver();$('#sendemailwindow_searchform input').val('');reloadRecipientsdatagrid();">   保存   </a> 
				<a id="emailbtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="margin-right: 42px;" onclick="addreceiverHide()">   取消   </a> 
			</div>
		</div>
	</div>
  </body>
</html>
