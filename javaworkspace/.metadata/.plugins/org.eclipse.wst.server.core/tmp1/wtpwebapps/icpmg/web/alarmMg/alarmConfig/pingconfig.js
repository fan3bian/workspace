$(function(){
	var normal_url_action_path = context_path+'/pingconfig/queryPingConfig.do';
	var query_url_action_path = context_path+'/pingconfig/queryPingConfigByIP.do';
	var delete_url_action_path = context_path+'/pingconfig/deletePingConfig.do';

	var addPingConfig_path = context_path + '/web/alarmMg/alarmConfig/addPingConfig.jsp';
	var flagck = 0;
	/***************************************************************************************************/
	/**
	 * 加载配置
	 */
	$('#pingconfig-datagrid').datagrid
	({    
	    url:normal_url_action_path,
	    onLoadSuccess: function (data) {
		      var pageopt = $('#pingconfig-datagrid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#pingconfig-datagrid').datagrid("getRows").length;
		      var total = pageopt.total; //显示的查询的总数
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {content:''  });
		         }
		         $('#pingconfig-datagrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
							$('#pingconfigdiv  input:checkbox').eq(idx+1).css("display","none");
							 
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
						$("#pingconfig-datagrid").datagrid('uncheckRow', idx);
						//增加全选复选框被选中
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				});
		
		 } , 
			onUncheckAll: function(rows) {
				flagck = 0;
			},
		pagination:true,
		pageList:[10,20,30,40],
		pageNumber:1,
		pageSize:10,
		showFooter:true,
		striped:true,
	    columns:[[    
	              {field:'checkflag',title:'Price',width:100,align:'center',checkbox:true},
	              {field:'neid',title:'设备id',width:50,align:'center'},
	              {field:'nename',title:'设备名称',width:30,align:'center'},
	              {field:'netypename',title:'设备类型名称',width:20,align:'center'},
	              {field:'neipaddr',title:'IP地址',width:40,align:'center'},
	              {field:'nesuserid',title:'影响用户',width:40,align:'center'}

	          ]],
	  	toolbar: [
		  	        {
				  		text:'添加',
						iconCls: 'icon-add',
						handler: function()
								{
									$('#add-ping-config-dialog').window('open');
								}
					},
					{
						text:'删除',
						iconCls: 'icon-delete',
						handler: function()
								{
									pingConfigDelete();
								}
					}
				],
		fitColumns:true   
	});  

	/***************************************************************************************************/
	/**
	 * 查询
	 */
	$("#ping-query-button").click(
			function(){
				var $pingIP = $("#ping-config-ip").val();
				$('#pingconfig-datagrid').datagrid('options').url = query_url_action_path;
				$('#pingconfig-datagrid').datagrid('reload',{pingip: $pingIP});
			}
	);

	$("#ping-query-button").mouseleave(
			function(){
				$('#pingconfig-datagrid').datagrid('options').url = normal_url_action_path;
			}
	);
	/***************************************************************************************************/
	/**
	 * 重置
	 */
	$("#ping-reset-button").click(
			function(){
				$("#ping-config-ip").textbox('clear');
				$('#pingconfig-datagrid').datagrid('options').url = normal_url_action_path;
				$('#pingconfig-datagrid').datagrid('reload');
			}
	);
	/***************************************************************************************************/
	/**
	 * 
	 * 删除
	 */
	function pingConfigDelete()
	{
		var checkedRows = $('#pingconfig-datagrid').datagrid('getSelections');
		if(checkedRows=="")
		{
			$.messager.alert('错误','未选中任何配置!无法删除!','error');    
			return;
		}
		
		$.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
		    if (r)
		    	{   
		    		/***********************************************/
					var deleteAllFlag = true;
					for(var vo in checkedRows)
					{
						var neid = checkedRows[vo].neid;
						var nename = checkedRows[vo].nename;
		  				$.ajax
		  				({
		  				 	type : 'post',
		  					async:false, 
		  					data:{paramtype:0, neid:neid},
		  					url:delete_url_action_path,
		  					dataType:'text',
		  					success:
		  						function(ret)
		  						{
		  							if(ret=="false")
		  							{
		  								deleteAllFlag = false;
		  							}
		  						}
		  				});
					}
						
					if(deleteAllFlag==true)
					{
						$.messager.alert("  完成  ","  被选中配置已全部删除成功!  ","info");
					}
					else
					{
						$.messager.alert("  警告  ","  部分配置删除失败,请检查与数据库的网路链接!  ","warning");
					}
					$('#pingconfig-datagrid').datagrid('reload');
					
					/************************************************/
		    	}
		    else
		    	{
		    		return;
		    	}
		    
		}); 

	}
	/***************************************************************************************************/
	/**
	 * 呼出添加窗口
	 */
	$('#add-ping-config-dialog').dialog({    
	    title: '添加连通性告警配置',    
	    width: 500,    
	    height: 300,    
	    closed: true,    
	    cache: false,    
	    href: addPingConfig_path,    
	    modal: true,
	    onBeforeOpen:function(){
			var clk = "clk";
			neid = clk;
	    	nename = clk;
	    	netypeid = clk;
	    	netypename = clk;
			neipaddr = clk;
			nesuserid = clk;
	    }
	}); 

});


