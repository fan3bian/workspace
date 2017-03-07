<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>已办工单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  
  </head>
  
  <body>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
  <script type="text/javascript" charset="utf-8">	

	$(document).ready(function(){
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
	});

	var showDraft = function(id,adr) {//草稿状态跳转
		
	$('#centerTab').panel({
		href:"${pageContext.request.contextPath}/"+adr+"?transferid=" + id
		});
	};
	
	var showDetail = function(id) {//待办 已办 办结状态跳转
		$('#centerTab').panel({
		href:"${pageContext.request.contextPath}/approvalCenter.do?transferid=" + id
		});
	};
	
	//状态
	function flowformater(value,row,index){  
		if(row.tstatusid == '1'){
	 		return "<img src=\"${pageContext.request.contextPath}/images/limit1.png\" />";
	  	}else if(row.tstatusid == undefined || row.tstatusid == ""){
	  		return "";
	  	}
	 	return "<img src=\"${pageContext.request.contextPath}/images/normal1.png\" />";
	 }
	
	 //操作
	 function rowformater(value,row,index){var str = '';
		 if(row.fstatus == '草稿'){
		 	str += icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnchakan.png\" title="发起" onclick="showDraft(\'{0}\',\'{1}\');"/>', row.flowid,row.jspurl);
		 	return str;
		 }else if(row.fstatus == undefined || row.fstatus == ""){
			 return "";
		 }
		 return icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnchakan.png\" title="查看" onclick="showDetail(\'{0}\');"/>', row.flowid);
	 }
	 
	function searchAndLoad()
	 {
		if ($('#order_searchform').form('validate')) {
			$('#dg').datagrid('load',icp.serializeObject($('#order_searchform')));
		} 
	}
	
	//已办列表
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
		url:'${pageContext.request.contextPath}/workorder/queryOrder.do',
		method: 'post',
		loadMsg: '数据装载中......',
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
	
 </script>
  <style type="text/css">
	.lcy-body .panel-body{ background: #eee; }
</style>
<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" />
  	<div style="width: 100%; height: 100%">
	  	<div class="easyui-layout lcy-body" data-options="fit:true,border:false" >
	  		 <div data-options="region:'north',border:false" style="height: 43px;padding-top: 4px;">
	  		 	 <form id="order_searchform">
	  		 	 	<div style="margin: -1px 20px;">
	  		 	 		<table class="lcy-search">
	  		 	 			<tr>
	  		 	 				<td>工单号：<input class="easyui-textbox" name="flowid" id="flowid" style="width:100px;border:false"></td>
	  		 	 				<td >使用单位：<input class="easyui-textbox"  name="useUnit" id="useUnit" style="width:100px;"></td>
	  		 	 				<td>工单状态：<select class="easyui-combobox" name="fstatusid" id="fstatusid" data-options="panelHeight:'auto',editable:false" style="width:100px;">
										<option value="0">请选择</option>
										<option value="1">草稿</option>
										<option value="2">提交</option>
										<option value="3">受理</option>
										<!-- <option value="4">归档</option> -->
										<option value="5">办结</option>
										<option value="6">驳回</option>
										<option value="7">撤销</option>
										</select>
								</td>
								<td>开始时间：<input class="easyui-datetimebox" editable="fasle"name="starttime" id="starttime" style="width:120px;border:false"></td>
								<td>结束时间：<input class="easyui-datetimebox"  editable="fasle" validType="compareDate['starttime']" name="endtime" id="endtime" style="width:120px;border:false"></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchAndLoad()">查询</a>&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#order_searchform input').val('');$('#flowid').textbox('clear');$('#fstatusid').combobox('select','0');
							$('#useUnit').combobox('select','');$('#starttime').textbox('clear');$('#endtime').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
								<th data-options="field:'tstatusid',width:60,align:'center',sortable:true,formatter:flowformater">状态</th>
								<th data-options="field:'flowid',width:120,align:'center',sortable:true">工单号</th>
								<th data-options="field:'flowname',width:150,align:'center',sortable:true">标题</th>
								<th data-options="field:'unitname',width:100,align:'center',sortable:true">申请单位</th>
								<th data-options="field:'useunitname',width:100,align:'center',sortable:true">使用单位</th>
								<th data-options="field:'ctime',width:100,align:'center',sortable:true">发起时间</th>
								<th data-options="field:'fstatus',width:60,align:'center',sortable:true">工单状态</th>
								<th data-options="field:'Ftypename',width:60,align:'center',sortable:true">工单类型</th>
								<th data-options="field:'jspurl',width:30,align:'center',hidden:true">URL</th>
								<th data-options="field:'id',width:50,align:'center',formatter:rowformater">工单信息</th>
							</tr>
						</thead>
	  		 		</table>
	  		 	</div>
	  		 </div>
	  	</div>
  	</div>
  </body>
  </html>