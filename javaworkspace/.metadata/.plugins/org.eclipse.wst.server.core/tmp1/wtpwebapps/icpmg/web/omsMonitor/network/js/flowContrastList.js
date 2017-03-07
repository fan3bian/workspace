var flagck = 0;
var toolbarflowcontrast = [
		{
			    id:'flowcontrastadd',
			    disabled:false,
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					$('#addfolwcontrast').panel({title:"新增监控项"});
					$('#addfolwcontrast').window('open');
					$("#addfolwcontrastwindowform").form('clear');
				} 
		},{
		    id:'flowcontrastadd',
		    disabled:false,
			text : '修改',
			iconCls : 'icon-modify',
			handler : function() {
					$("#addfolwcontrastwindowform").form('clear');
					var rows = $("#flow_contrast_dg").datagrid('getChecked');
					if(rows.length!=1)
					{
						$.messager.alert('消息','请选择一条记录！'); 
						return; 
					}
					var id = "";
					$.each(rows,function(index,object){
					 		id= object.groupid;
	   				 });
					$.ajax({
				  			type : 'post',
				  			url:context_path+"/networkfolw/detailFlowContrastList.do",
				  			data:{
				  				groupid:id,
				  			},
				  			success:function(retr){
				  				var obj = JSON.parse(retr);
								$('#addfolwcontrast').window({
									onOpen: function () {
										$('#addfolwcontrastwindowform').form('load',obj);
									}
								});
								$('#addfolwcontrast').panel({title:"监控项变更"});
								$('#addfolwcontrast').window('open');
				  			}
				  	});
			} 
	},{
	    id:'flowcontrastadd',
	    disabled:false,
		text : '删除',
		iconCls : 'icon-remove',
		handler : function() {
			var rows = $("#flow_contrast_dg").datagrid('getChecked');
			if(rows.length<1)
			{
				$.messager.alert('消息','请至少选择一条记录！'); 
				return; 
			}
			var ids = "";
			$.each(rows,function(index,object){
					ids+="'"+object.groupid+"',";
			});
			$.messager.confirm('确认','您确认要删除信息么？',function(r){   
					 if (r){
						 $.ajax({
					  			type : 'post',
					  			url:context_path+"/networkfolw/deleteFlowContrastList.do",
					  			data:{
					  				groupids:ids
					  			},
					  			success:function(retr){
					  				var _data =  JSON.parse(retr); 
									if(_data.success){
										$('#flow_contrast_dg').datagrid('reload',icp.serializeObject($('#flow_contrast_searchform')));
										$.messager.show({
											msg:_data.msg,
											title:'消息'
										});
							    	}else{
							    		$.messager.alert('消息',_data.msg);
							    	}
					  			}
							});
					 }
			});
		} 
}
];

$(function () {
	loadDataGrid();
});

	function loadDataGrid() {
		$('#flow_contrast_dg')
				.datagrid(
						{
							rownumbers : false,
							border : false,
							striped : true,
							scrollbarSize : 0,
							sortName : 'createtime',
							sortOrder : 'desc',
							singleSelect : false,
							method : 'post',
							loadMsg : '数据装载中......',
							fitColumns : true,
							//idField : 'pid',
							queryParams: {
								//resourcetypeid: 'his'
							},
							pagination : true,
							pageSize : 10,
							pageList : [ 5, 10, 20, 30, 40, 50 ],
							toolbar : toolbarflowcontrast,
							 url:context_path+"/networkfolw/queryFlowContrastList.do",
							onLoadSuccess: function (data) {
							      var pageopt = $('#flow_contrast_dg').datagrid('getPager').data("pagination").options;
							      var  _pageSize = pageopt.pageSize;
							      var  _rows = $('#flow_contrast_dg').datagrid("getRows").length;
							      var total = pageopt.total; //显示的查询的总数
							      if (_pageSize >= 10) {
							         for(var i=10;i>_rows;i--){
							            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							            $(this).datagrid('appendRow', {groupid:''  });
							         }
							         $('#flow_contrast_dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
											if   (val.groupid==''){  
												$('#addflowconctrast  input:checkbox').eq(idx+1).css("display","none");
												 
											}
										}); 
							      }
							 } ,
							 //没数据的行不能被点击
							 onClickRow: function (rowIndex, rowData) {
										if   (rowData.groupid==''){
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
										if   (val.groupid==''){
											$("#flow_contrast_dg").datagrid('uncheckRow', idx);
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
	
	
	//查询按钮
	function searchDataGrid() {
		$('#flow_contrast_dg').datagrid('load',
			icp.serializeObject($('#flow_contrast_searchform')));
	};
	//重置按钮
	function reloadDataGrid(){
		$("#flow_contrast_searchform").form('clear');
		searchDataGrid();
	}
	//保存按钮
	function saveFlowContrastList(){
		$('#flowcontrastsavebtn').linkbutton('disable');
		var  url = context_path+"/networkfolw/saveFlowContrastList.do";
		$('#addfolwcontrastwindowform').form('submit',{
		    url:url,
		    onSubmit: function(){
		    },
		    success:function(retr){
		    	var _data =  JSON.parse(retr); 
				if(_data.success){
					$('#flow_contrast_dg').datagrid('reload',icp.serializeObject($('#flow_contrast_searchform')));
					$.messager.show({
						msg:_data.msg,
						title:'消息'
					});
		    	}else{
		    		$.messager.alert('消息',_data.msg);
		    	}
		    	$('#flowcontrastsavebtn').linkbutton('enable');
		    }
		});
		 	$('#addfolwcontrast').window('close');
		 	$('#flowcontrastsavebtn').linkbutton('enable');
	}
	//取消按钮
	function retFlowcontrastWindow(){
		$("#addfolwcontrastwindowform").form('clear');
		$('#addfolwcontrast').window('close');
	}

	function folwcontrasteditformater(value, row, index){
		if(value.length==0){
			return "";
		}else{
			return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewPage('"+ row.groupid+"','1');\">编辑</a>";
		}
	}
	
	function addGroupname(value, row, index){
		if (typeof(value) != "undefined") { 
			if(value.length==0){
				return "";
			}else{
				return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewPage('"+ row.groupid+"','2');\">"+value+"</a>";
			}
		}
	}
	
	function viewPage(id,type){
		//var groupid = $(id).next().val();
		var url = '/icpmg/web/omsMonitor/host/jsp/hostKpiOverview.jsp';
		if(type=='1'){
			url = '/icpmg/web/omsMonitor/host/jsp/hostKpiOverview.jsp';
		}
		$('#centerTab').panel({
			href:url,
			queryParams:{
				groupid:id
			}
		});	
	}