$(function(){
	var urlconfig_normal_path = context_path+'/urlconfig/queryURLConfig.do';
	var urlconfig_query_url_path = context_path+'/urlconfig/queryURLConfigByURL.do';
	var urlconfig_delete_url_path = context_path+'/urlconfig/deleteURLConfig.do';

	var addURLConfig_path = context_path + '/web/alarmMg/alarmConfig/addURLConfig.jsp';
	var flagck = 0;
	$('#urlconfig-datagrid').datagrid
	({    
	    url:urlconfig_normal_path,
	    onLoadSuccess: function (data) {
		      var pageopt = $('#urlconfig-datagrid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#urlconfig-datagrid').datagrid("getRows").length;
		      var total = pageopt.total; 
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {content:''  });
		         }
		         $('#urlconfig-datagrid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏信息
			    		total: total,
			    	});
		         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
		      }else{
		         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      } //设置不显示复选框
		      var rows = data.rows;
		      if (rows.length) {
					 $.each(rows, function (idx, val) {
						if   (val.content==''){  
							$('#urlconfigdiv  input:checkbox').eq(idx+1).css("display","none");
							 
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
						$("#urlconfig-datagrid").datagrid('uncheckRow', idx);
						//增加全选复选框被选中
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				});
		}, 
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
	              {field:'url',title:'应用URL',width:40,align:'center'},
	              {field:'nesuserid',title:'影响用户',width:40,align:'center'}

	          ]],
		toolbar: [
			        {
				  		text:'添加',
						iconCls: 'icon-add',
						handler: function()
								{
									$('#add-url-config-dialog').window('open');
								}
					},
					{
						text:'删除',
						iconCls: 'icon-delete',
						handler: function()
								{
									URLConfigDelete();
								}
					}
				],          
		fitColumns:true   
	});  

	/***************************************************************************************************/
	/**
	 * 查询
	 */
	$("#url-query-button").click(
			function(){
				var $urlAlarm_config_url = $("#url-config-url").val();
				$('#urlconfig-datagrid').datagrid('options').url = urlconfig_query_url_path;
				$('#urlconfig-datagrid').datagrid('reload',{urlAlarm_config_url: $urlAlarm_config_url});
			}
	);

	$("#url-query-button").mouseleave(
			function(){
				$('#urlconfig-datagrid').datagrid('options').url = urlconfig_normal_path;
			}
	);
	/***************************************************************************************************/
	/**
	 * 重置
	 */
	$("#url-reset-button").click(
			function(){
				$("#url-config-url").textbox('clear');
				$('#urlconfig-datagrid').datagrid('options').url = urlconfig_normal_path;
				$('#urlconfig-datagrid').datagrid('reload');
			}
	);
	/***************************************************************************************************/
	/**
	 * 
	 * 删除
	 */
	function URLConfigDelete()
	{
		var checkedRows = $('#urlconfig-datagrid').datagrid('getSelections');
		if(checkedRows=="")
		{
			$.messager.alert('错误','未选中任何配置!无法删除!','error');    
			return;
		}
		
		$.messager.confirm('确认','您确认想要删除配置吗？',function(r){    
		    if (r)
		    	{   
		    		/***********************************************/
					var deleteAllFlag = true;
					for(var vo in checkedRows)
					{
						var neid = checkedRows[vo].neid;
						var total_url = checkedRows[vo].url;
		  				$.ajax
		  				({
		  				 	type : 'post',
		  					async:false, 
		  					data:{paramtype:1, neid:neid,totalurl:total_url},
		  					url:urlconfig_delete_url_path,
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
					$('#urlconfig-datagrid').datagrid('reload');
					
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
	$('#add-url-config-dialog').dialog({    
	    title: '添加应用告警配置',    
	    width: 500,    
	    height: 400,    
	    closed: true,    
	    cache: false,    
	    href: addURLConfig_path,    
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

	/***************************************************************************************************/




});
