/****************************************************************************************************/
/**
 * 变更详情
 * @param row
 */
function resUpdateLoadDetail(row)
{
	//$('#res-update-detail-dialog').window('close');
	$('#res-update-detail-dialog').window('open');
	
	//设备ID
	$('#res-update-detail-neid-input').textbox({
		type:'text',
		width:120,
		editable:false,
		readonly:true
	});
	$('#res-update-detail-neid-input').textbox('setText',row.neid);
	
	//设备名称
	$('#res-update-detail-nename-input').textbox({
		type:'text',
		width:120,
		editable:false,
		readonly:true
	});
	$('#res-update-detail-nename-input').textbox('setText',row.nename);
	
	//设备类型
	$('#res-update-detail-netypename-input').textbox({
		type:'text',
		width:125,
		editable:false,
		readonly:true
	});
	$('#res-update-detail-netypename-input').textbox('setText',row.netypename);
	
	//变更字段 （组件名称）
	$('#res-update-detail-updatenode-input').textbox({
		type:'text',
		width:125,
		editable:false,
		readonly:true
	});
	$('#res-update-detail-updatenode-input').textbox('setText',row.updatenode);
	
	//是否授权 （组件名称）
	$('#res-update-detail-isleagleText-input').textbox({
		type:'text',
		width:120,
		editable:false,
		readonly:true
	});
	$('#res-update-detail-isleagleText-input').textbox('readonly');
	$('#res-update-detail-isleagleText-input').textbox('setText',row.islegalText);
	
	//变更时间
	$('#res-update-detail-mtime-input').textbox({
		type:'text',
		width:125,
		editable:false,
		readonly:true
	});
	$('#res-update-detail-mtime-input').textbox('setText',row.mtime);
	
	//设备内容
	$('#res-update-detail-content-input').textbox({
		type:'text',
		readonly:true,
		multiline:true,
		width:500,
		height:150
		
	});
	$('#res-update-detail-content-input').textbox('setText',row.updatecontent);
	$('#res-update-detail-content-block').empty();
	$('#res-update-detail-content-block').append(row.updatecontent);
	
	$('#res-update-detail-button-close').linkbutton({    
	    //iconCls:'icon-cancel',
		width:100,
		height:30,
		onClick:function()
		{
			$('#res-update-detail-dialog').window('close');
		}
	});  

	$('#res-update-detail-table').show();
}

/****************************************************************************************************/
/**
 * 台账
 * @param row
 */
function resUpdateLoadHistory(row)
{
//	var loadData_action_path = context_path + "/omsResourceUpdate/loadResUpdateData.do";
	var getDeviceDetail_path = context_path + "/omsResourceUpdate/getDeviceDetail.do";
	var loadHistoryLog_path = context_path + "/omsResourceUpdate/loadHistoryLog.do";
	
	$('#res-update-history-dialog').window('open');
	$('#res-update-history-main').show();
	
	$('#res-update-history-title').empty();
	$('#res-update-history-title').append("【"+ row.neid + "】  " + row.nename);
	
	$('#res-update-history-querybar .ip .ipvalue').empty();
	$('#res-update-history-querybar .mtime .mtime-value').empty();
	$('#res-update-history-querybar .curstat .curstat-value').empty();
	$.ajax
	({
		 	type : 'post',
			async:false, 
			data:{neid:row.neid},
			url:getDeviceDetail_path,
			dataType:'json',
			success:
				function(ret)
				{
					if( (ret == "") || (ret == undefined) || (ret == null))
					{
						return;
					}
					$('#res-update-history-querybar .ip .ipvalue').append(ret.ipaddr);

					$('#res-update-history-querybar .mtime .mtime-value').append(ret.usetime);

					$('#res-update-history-querybar .curstat .curstat-value').append(ret.curstat);
				}
		});
	
	$('#res-update-history-datagrid').datagrid
	({ 
		onLoadSuccess: function (data) {
			var pageopt = $('#res-update-history-datagrid').datagrid('getPager').data("pagination").options;
			var  _pageSize = pageopt.pageSize;
			var  _rows = $('#res-update-history-datagrid').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
			   for(var i=10;i>_rows;i--){
			      //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
			      $(this).datagrid('appendRow', {content:''  });
			   }
			   $('#res-update-history-datagrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
						if   (val.content==''){  
							$('#res-update-history-table  input:checkbox').eq(idx+1).css("display","none");
							 
						}
					}); 
			}
			} ,
			//没数据的行不能被点击
			onClickRow: function (rowIndex, rowData) {
					if   (rowData.content==''){
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
					if   (val.content==''){
						$("#res-update-history-datagrid").datagrid('uncheckRow', idx);
						//增加全选复选框被选中
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				});
			
			} , 
			onUncheckAll: function(rows) {
				flagck = 0;
			},
	    url:loadHistoryLog_path,
	    queryParams:{neid:row.neid},
		pagination:true,
		pageList:[10,20,30,40],
		pageNumber:1,
		pageSize:10,
		showFooter:true,
		striped:true,
	    columns:[[    
	              {field:'logid',title:'日志编码',width:30,align:'center'},
	              {field:'netypename',title:'设备类型名称',width:50,align:'center'},
	              {field:'updatetype',title:'变更类型',width:40,align:'center'},
	              {field:'updatesummary',title:'变更摘要',width:50,align:'center'},
	              {field:'mtime',title:'变更时间',width:50,align:'center'},
	              {field:'islegalText',title:'是否授权',width:30,align:'center'},
	              {
	            	  field:'operate',
	            	  title:'操作',
	            	  width:30,
	            	  align:'center',
	      				formatter: function(value,row,index)
	      				{
	      					if(row.logid == undefined || row.logid == null || row.logid == "")
	      					{
	      						return "";
	      					}else
	      					{
	      						return "<span class=\"resupdate-detail-link\"" +
	      								"  onclick='resUpdateLoadDetail(" + JSON.stringify(row) + ")'>详情</span>";
	      					}
	      					
	      				}

	              }

	          ]],
		fitColumns:true,
		singleSelect:true
	}); 
	
	$('#res-update-history-button-close').linkbutton({    
	    //iconCls:'icon-cancel',
		width:100,
		height:30,
		onClick:function()
		{
			$('#res-update-history-dialog').window('close');
		}
	});
}


/****************************************************************************************************/

$(function(){
	
	var resUpdate_loadData_action_path = context_path + "/omsResourceUpdate/loadResUpdateData.do";
	var listTypeName_url_action_path = context_path+'/pingconfig/listNeTypeName.do';
	var queryby_nename_action_path = context_path + "/omsResourceUpdate/queryByNename.do";
	var queryby_typeid_action_path = context_path + "/omsResourceUpdate/queryByTypeid.do";
	var queryby_nename_typeid_action_path = context_path +"/omsResourceUpdate/queryByNenameAndtypeid.do";
	var doUpdate_action_path = context_path + "/omsResourceUpdate/doResUpdate.do";
	var doRmdObjectUpdate_action_path = context_path + "/omsResourceUpdate/doRmdObjectUpdate.do";
	
	
/****************************************************************************************************/
/**
 * 初始加载数据
 */	
	
	$('#res-update-datagrid').datagrid
	({    
		onLoadSuccess: function (data) {
		var pageopt = $('#res-update-datagrid').datagrid('getPager').data("pagination").options;
		var  _pageSize = pageopt.pageSize;
		var  _rows = $('#res-update-datagrid').datagrid("getRows").length;
		var total = pageopt.total; //显示的查询的总数
		if (_pageSize >= 10) {
		   for(var i=10;i>_rows;i--){
		      //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
		      $(this).datagrid('appendRow', {content:''  });
		   }
		   $('#res-update-datagrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
					if   (val.content==''){  
						$('#res-update-table  input:checkbox').eq(idx+1).css("display","none");
						 
					}
				}); 
		}
		} ,
		//没数据的行不能被点击
		onClickRow: function (rowIndex, rowData) {
				if   (rowData.content==''){
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
				if   (val.content==''){
					$("#res-update-datagrid").datagrid('uncheckRow', idx);
					//增加全选复选框被选中
					$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
				}
			});
		
		} , 
		onUncheckAll: function(rows) {
			flagck = 0;
		},
	    url:resUpdate_loadData_action_path,
		pagination:true,
		pageList:[10,20,30,40],
		pageNumber:1,
		pageSize:10,
		showFooter:true,
		striped:true,
	    columns:[[    
	              {field:'checkflag',title:'Price',width:10,align:'center',checkbox:true},
	              {field:'logid',title:'日志编码',width:50,align:'center'},
	              {field:'netypename',title:'设备类型名称',width:50,align:'center'},
	              {field:'nename',title:'设备名称',width:70,align:'center'},
	              {
	            	  field:'updatetype',title:'变更类型',width:50,align:'center',
	            	  formatter: function(value,row,index)
	            	  {
	            		  if(value == '0')
	            		  {
	            			  value = '采集变更';
	            		  }else
	            		  {
	            			  if(value == '2')
            				  {
            				  	value = '手工维护';
            				  }
	            			  
	            		  }
	            		  return value;
	            	  }
	              },
	              {field:'updatesummary',title:'变更摘要',width:50,align:'center'},
	              {field:'mtime',title:'变更时间',width:50,align:'center'},
	              {field:'islegalText',title:'是否授权',width:50,align:'center'},
	              {
	            	  field:'operate',
	            	  title:'操作',
	            	  width:50,
	            	  align:'center',
	      				formatter: function(value,row,index)
	      				{
	      					if(row.logid == undefined || row.logid == null || row.logid == "")
	      					{
	      						return "";
	      					}else
	      					{
	      						return "<span class=\"resupdate-detail-link\"" +
	      								"  onclick='resUpdateLoadDetail(" + JSON.stringify(row) + ")'>详情</span>" +
	      								"<span class=\"resupdate-detail-spliter\">|</span>" +
	      								"<span class=\"resupdate-history-link\"" +
	      								"  onclick='resUpdateLoadHistory(" + JSON.stringify(row) + ")'>流水</span>";
	      					}
	      					
	      				}

	              }

	          ]],
	  	toolbar: [
					/**
					 * 授权操作
					 */	
		  	        {
				  		text:'授权变更',
						iconCls: 'icon-objmanage',
						handler: function()
								{
									var rows = $('#res-update-datagrid').datagrid('getChecked');
									if( (rows.length == 0) || (rows.length == null) || (rows == "") || (rows == null) )
									{
										$.messager.alert("  警告","  授权变更失败！请选择想要授权的变更记录后再进行添变更 ","warning");
										return;
									}
									var arr = [];
									for(var i=0 ; i<rows.length; i++)
									{
										arr.push(rows[i].neid);
									}
									
									$.ajax
									({
										 	type : 'post',
											async:false, 
											data:{neidArray:arr.toString(),optype:'allow'},
											url:doUpdate_action_path,
											dataType:'json',
											success:
												function(ret)
												{
													if(ret == true)
													{
														$.messager.alert(' 通知  ','  变更成功','info');
													}else
													{
														$.messager.alert(' 警告  ','  变更失败','error');
													}
												
												}
										});
									
									$.ajax
									({
										 	type : 'post',
											async:false, 
											data:{neidArray:arr.toString(),optype:'allow'},
											url:doRmdObjectUpdate_action_path,
											dataType:'json',
											success:
												function(ret)
												{
													if(ret == true)
													{
													}else
													{
														$.messager.alert(' 警告  ','  资源表授权变更失败','error');
													}
												
												}
										});
									$('#res-update-datagrid').datagrid('reload');
									
								}
					},
					{
						text:'非授权变更',
						iconCls: 'icon-objmanage',
						handler: function()
								{
									var rows = $('#res-update-datagrid').datagrid('getChecked');
									if( (rows.length == 0) || (rows.length == null) || (rows == "") || (rows == null) )
									{
										$.messager.alert("  警告","  授权变更失败！请选择想要授权的变更记录后再进行添变更 ","warning");
										return;
									}
									var arr = [];
									for(var i=0 ; i<rows.length; i++)
									{
										arr.push(rows[i].neid);
									}
									
									$.ajax
									({
										 	type : 'post',
											async:false, 
											data:{neidArray:arr.toString(),optype:'forbid'},
											url:doUpdate_action_path,
											dataType:'json',
											success:
												function(ret)
												{
													if(ret == true)
													{
		//												alert('变更成功');
														$.messager.alert(' 通知  ','  变更成功','info');
													}else
													{
														$.messager.alert(' 警告  ','  变更失败','error');
													}
												
												}
										});
									
									$.ajax
									({
										 	type : 'post',
											async:false, 
											data:{neidArray:arr.toString(),optype:'forbid'},
											url:doRmdObjectUpdate_action_path,
											dataType:'json',
											success:
												function(ret)
												{
													if(ret == true)
													{
													}else
													{
														$.messager.alert(' 警告  ','  资源表授权变更失败','error');
													}
												
												}
										});
									$('#res-update-datagrid').datagrid('reload');
								}
					}
				],
		fitColumns:true

	}); 	
	
	
/****************************************************************************************************/
/**
 * 查询
 */	
	$('#res-update-netype-select').combobox({    
	    url:listTypeName_url_action_path,    
	    valueField:'typeid',    
	    textField:'typename',
	    prompt:'请选择设备类型',
	    onLoadSuccess:function(rec)
	    {
	    	$('#res-update-netype-select').combobox('setValue', '');
	    },
	    onSelect:function(rec){  
	        
	    }
	});  
	
	$('#res-update-nename-input').textbox({
		type:'text',
		prompt:'请输入设备名称'
		
	});
	
	$("#res-update-query-button").click(
			function(){				
				var nename_text = $('#res-update-nename-input').textbox('getText')
				var query_condition_nename = nename_text.trim();
				var query_condition_typeid = $('#res-update-netype-select').combobox('getValue');
				
				if((query_condition_nename == "") || (query_condition_nename == undefined) || (query_condition_nename == null))
				{
					if((query_condition_typeid == "") || (query_condition_typeid == undefined) || (query_condition_typeid == null))
					{
//						alert('全查');
						$('#res-update-datagrid').datagrid('options').url = resUpdate_loadData_action_path;
						$('#res-update-datagrid').datagrid('reload');
					}else
					{
//						alert("用设备类型查");
						$('#res-update-datagrid').datagrid('options').url = queryby_typeid_action_path;
						$('#res-update-datagrid').datagrid('reload',{typeid:query_condition_typeid});
					}
				}else
				{
					if((query_condition_typeid == "") || (query_condition_typeid == undefined) || (query_condition_typeid == null))
					{
//						alert('用设备名称查');
						$('#res-update-datagrid').datagrid('options').url = queryby_nename_action_path;
						$('#res-update-datagrid').datagrid('reload',{nename:query_condition_nename});
					}else
					{
//						alert("设备类型 + 设备名称");
						$('#res-update-datagrid').datagrid('options').url = queryby_nename_typeid_action_path;
						$('#res-update-datagrid').datagrid('reload',{typeid:query_condition_typeid,nename:query_condition_nename});
					}
				}

			}
	);

	$("#res-update-query-button").mouseleave(
			function(){
				$('#res-update-datagrid').datagrid('options').url = resUpdate_loadData_action_path;
			}
	);
	
/****************************************************************************************************/
/**
 * 重置
 */	
	
	$('#res-update-reset-button').click(function(){
		$('#res-update-datagrid').datagrid('options').url = resUpdate_loadData_action_path;
		$('#res-update-netype-select').combobox('reload');
		$('#res-update-nename-input').textbox('setText','');
		$('#res-update-datagrid').datagrid('reload');
	});
	
/****************************************************************************************************/
	
	
	
	
});

