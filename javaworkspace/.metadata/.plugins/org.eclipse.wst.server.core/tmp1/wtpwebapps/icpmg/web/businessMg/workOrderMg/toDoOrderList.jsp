<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>待办工单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  
  </head>
  
  <body>
  <style type="text/css">
	.lcy-body .panel-body{ background: #eee; }
</style>
<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" />
  	<div style="width: 100%; height: 100%">
	  	<div class="easyui-layout lcy-body" data-options="fit:true,border:false" >
	  		 <div data-options="region:'north',border:false" style="height: 43px;padding-top: 4px;">
	  		 	 <form id="order_searchform">
	  		 	 	<style>.lcy-search td{padding:0px 20px 0px 0;}</style>
	  		 	 	<div style="margin: -1px 20px;">
	  		 	 		<table class="lcy-search">
	  		 	 			<tr>
	  		 	 				<td>工单号：<input class="easyui-textbox" name="flowid" id="flowid" style="width:120px"/></td>
	  		 	 				<td>使用单位：<input class="easyui-textbox" name="useUnit" id="useUnit" style="width:120px;"></td>
	  		 	 				<td>开始时间：<input class="easyui-datetimebox" editable="fasle"name="starttime" id="starttime" style="width:150px;border:false"></td>
	  		 	 				<td>结束时间：<input class="easyui-datetimebox"  editable="fasle" validType="compareDate['starttime']" name="endtime" id="endtime" style="width:140px;border:false"></td>
	  		 	 				<td><a href="javascript:void(0);" class="easyui-linkbutton"
									   data-options="iconCls:'icon-search',plain:true"
									   onclick="$('#dg').datagrid('load',icp.serializeObject($('#order_searchform')));">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true"
						   onclick="">重置</a>
					</td>
	  		 	 			</tr>
	  		 	 		</table>
	  		 	 	</div>
	  		 	 </form>
	  		 </div>
	  		 <div data-options="region:'center',border:false" id="addid">
	  		 	<div style="margin: 0 20px 40px 20px;">
	  		 		<table id="dg" width="100%" data-options="fitColumns:true">
	  		 			<thead>
							<tr>
							    <th data-options="field:'tstatusid',width:40,align:'center',sortable:true,formatter:flowformater">状态</th>
								<th data-options="field:'flowid',width:120,align:'center',sortable:true">工单号</th>
								<%--
									<th data-options="field:'orderid',width:100,align:'center',sortable:true">订单号</th>
									<th data-options="field:'cusername',width:100,sortable:true">发起人</th>
									<th data-options="field:'stepstatusid',width:60,sortable:true,formatter:stepformater">环节状态</th>
								--%>
								<th data-options="field:'flowname',width:150,align:'center',sortable:true">标题</th>
								<th data-options="field:'unitname',width:100,align:'center',sortable:true">申请单位</th>
								<th data-options="field:'useunitname',width:100,align:'center',sortable:true">使用单位</th>
								<th data-options="field:'ctime',width:100,align:'center',sortable:true">发起时间</th>
								<th data-options="field:'stepname',width:80,align:'center'" >当前环节</th>
								<th data-options="field:'fstatus',width:50,align:'center'">工单状态</th>
								<th data-options="field:'dostatusid',width:60,align:'center',hidden:true">办理状态</th>
								<th data-options="field:'Ftypename',width:60,align:'center'">工单类型</th>
								<th data-options="field:'id',width:50,align:'center',formatter:rowformater">操作</th>
							</tr>
						</thead>
	  		 		</table>
	  		 	</div>
	  		 </div>
	  	</div>
  	</div>
  	<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		//操作
		function rowformater(value, row, index) {
			var str = '';
			if(row.flowid != undefined && row.flowid != ""){
				str += icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnshenpi.png\" title="处理" onclick="showhandler(\'{0}\');"/>', row.flowid);
			}
			return str;
		}
		window.rowformater = rowformater;

		//状态
		function flowformater(value, row, index) {
			if (row.tstatusid == '1') {
				//str += sy.formatString('<img class="iconImg ext-icon-note" title="查看" onclick=""/>', row.id);
				// return "<span style=\"background-image: url('${pageContext.request.contextPath}/images/normal.png') \"></span>";
				return "<img src=\"${pageContext.request.contextPath}/images/limit1.png\" />";
			}else if(row.tstatusid == undefined){
				return "";
			}
			return "<img src=\"${pageContext.request.contextPath}/images/normal1.png\" />";

		}
		window.flowformater = flowformater;

		var showhandler = function(id) {
			$('#centerTab').panel({
				href:"${pageContext.request.contextPath}/approvalCenter.do?transferid=" + id
			});
		};
		window.showhandler = showhandler;

		function stepformater(value, row, index) {
			switch (value) {
				case '1':
					return "<span style=\"color:red\">工单超时</span>";
				case '0':
					return "正常";
			}
		}
		window.stepformater = stepformater;

		$("#parentOrder").combobox({
			valueField: 'flowtype',
			textField: 'flowtypename',
			editable:false,
			url: '${pageContext.request.contextPath}/workorder/getParentType.do',
			onSelect: function(rec){
				var urlson = '${pageContext.request.contextPath}/workorder/getSonType.do?id='+rec.flowtype;
				$('#Ftype').combobox('reload', urlson);
				$('#Ftype').combobox('setValue','');
			},onLoadSuccess:function(){

				var parentId= $('#parentOrder').combobox('getValue');
				var url2='${pageContext.request.contextPath}/workorder/getSonType.do?id='+parentId;
				$('#Ftype').combobox('reload', url2);
			}
		});

		$("#btnReset").on('click', function () {
			$('#order_searchform input').val('');
			$('#flowid').textbox('clear');
			/*
			$('#Ftype').textbox('clear');
			$('#parentOrder').textbox('clear');
			*/
			$('#useUnit').combobox('select','');
			$('#dg').datagrid('load', {});
		});

		//待办列表
		$("#dg").datagrid({
			rownumbers: false,
			border: false,
			striped: true,
			scrollbarSize: 0,
			sortName: 'ctime',
			sortOrder: 'desc',
			nowarp: false,
			singleSelect: true,
			pagination: true,
			url: '${pageContext.request.contextPath}/workorder/queryToDo.do',
			method: 'post',
			loadMsg: '数据装载中......',
			fitColumns: true,
			idField: 'flowid',
			pagination: true,
			pageSize: 10,
			pageList: [10, 20, 30, 40, 50],
			onLoadSuccess: function(data) {
                var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;//分页条数
				var  _rows = $('#dg').datagrid("getRows").length;//每页实际条数
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 10) {
					for(i=10;i>_rows;i--){
						//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						$(this).datagrid('appendRow', {orderid:''  })
					}
					$('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
                
				//设置不显示复选框
				/*
		        var rows = data.rows;
		        if (rows.length) {
					 $.each(rows, function (idx, val) {
						if(val.neid=='' || val.neid == undefined){ 
							//addid为datagrid上一层的div id 
							//$('#addid  input:checkbox').eq(idx+1).css("display","none");//设置不显示复选框
						}
					}); 
		        }*/
            }
		});

		//使用单位（已过滤数据权限）
		$('#useUnit').combobox({
			url:'${pageContext.request.contextPath}/project/getUnitsData.do',
			valueField: 'unitId',
			textField: 'unitName',
			width:120,
			panelHeight: '100',
			loadFilter:function(data){
				data.unshift({unitId:"",unitName:"请选择"});
				return data;
			}
		});

	})
</script>
  </body>
  </html>