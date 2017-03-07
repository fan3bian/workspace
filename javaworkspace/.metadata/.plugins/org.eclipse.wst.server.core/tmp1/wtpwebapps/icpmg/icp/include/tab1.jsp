<%@ page contentType="text/html; charset=UTF-8" %>
<html>
	<head>
		<title>待办工单</title>
		<meta charset="UTF-8">
	</head>
	<body>
		<style type="text/css">
			.datagrid-btable tr{ height:42px;}
		</style>
		<script type="text/javascript" charset="utf-8">
			$(function(){
				//var status_data = [{"value":"1","text":"草稿"},{"value":"2","text":"提交"},{"value":"3","text":"受理"},{"value":"4","text":"归档"},{"value":"5","text":"办结"}];
				resoursequery_datagrid = $('#dg1').datagrid({
					url:'${pageContext.request.contextPath}/homepage/queryToDo.do',
					queryParams: {
						type: '1',
						sort: 'ctime',
						order: 'desc'
					},
					 pagination:true,//分页控件
					 showFooter:false,
					 width:'100%',
					 height:295,
					pageSize:5,
					pageList:[5],
					align:'center',
					halign:'center',
					fitColumns:true,
					border:false,
					scrollbarSize:0,
					idField:'rmdid',
					sortOrder:'asc',
					singleSelect:true,
					onClickRow:function(rowIndex,rowData){
						window.parent.window.parent.querymenu('%/workOrderMg/toDoOrderList.jsp%');
					},
					columns:[[{
						title:'序号',
						field:'rmdid',
						width:'20%',
						align:'center',
						 styler: function(value,row,index){
                                    return 'vertical-align:middle;';
                            },
						formatter:function(value,row,index){
							switch (index) {
								case 0:
									return "<span>1</span>";
								case 1:
									return "<span>2</span>";
								case 2:
									return "<span>3</span>";
								case 3:
									return "<span>4</span>";
								case 4:
									return "<span>5</span>";
								}
						},
					},{
						title:'标题',
						field:'flowname',
						width:'30%',
						fit:true,
						align:'center',
						styler: function(value,row,index){
                                    return 'vertical-align:middle;';
                            },
					},{
						title:'工单状态',
						field:'fstatus',
						width:'20%',
						align:'center',
						styler: function(value,row,index){
                                    return 'vertical-align:middle;';
                            },
						
					},{
						title:'发起时间',
						field:'ctime',
						width:'30%',
						align:'center',
						styler: function(value,row,index){
                                    return 'vertical-align:middle;';
                            },
						formatter:function(value,row,index){
						   return translateDate(value);
						 },
					}]]
				});
			});
			
			
	
	//转换日期格式 "yyyy-MM-dd HH:mm:ss"
	function translateDate(value){
		var timeStr = value;
		var time = value;
		if(timeStr.length>14){
			var date = timeStr.slice(0, 10) + ' ';
			var time = timeStr.slice(11, 19);
			time = date + time;
		}else{
			var year = timeStr.slice(0, 4) + '-';
			var month = timeStr.slice(4,6) + '-';
			var day = timeStr.slice(6,8) + ' ';
			var hour = timeStr.slice(8,10) + ':';
			var min = timeStr.slice(10,12) + ':';
			var sec = timeStr.slice(12,14); 
			time = year + month + day + hour + min + sec;
		}
		return time;
	}
		</script>
				<div class="easyui-layout" data-options="fit:true,border:false" >
			<div data-options="region:'center',border:false" style="background:#eee;">
				<table id="dg1" style="background:#eee;width:100%;text-align:center;"></table>
			</div>
		</div>
	</body>
</html>
