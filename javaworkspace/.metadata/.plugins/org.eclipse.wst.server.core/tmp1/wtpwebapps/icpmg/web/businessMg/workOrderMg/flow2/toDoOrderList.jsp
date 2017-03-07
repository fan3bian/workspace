<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java" %>

<body class="easyui-layout" data-options="fit:true,border:false" >
<style type="text/css">
.iconImg ext-icon-note {background: url('${pageContext.request.contextPath}/images/normal.png') }
</style>
<script type="text/javascript" charset="utf-8">
	var showFun = function (id) {

		$('#centerTab').panel({
			href: "${pageContext.request.contextPath}/approvalCenter.do?transferid=" + id
		});
	};
	function stepformater(value, row, index) {
		switch (value) {
			case '1':
				return "<span style=\"color:red\">工单超时</span>";
			case '0':
				return "正常";
		}
	}
	function flowformater(value, row, index) {
		if (row.tstatusid == '1') {
			//str += sy.formatString('<img class="iconImg ext-icon-note" title="查看" onclick=""/>', row.id);
			// return "<span style=\"background-image: url('${pageContext.request.contextPath}/images/normal.png') \"></span>";
			return "<img src=\"${pageContext.request.contextPath}/images/limit1.png\" />";
		}
		return "<img src=\"${pageContext.request.contextPath}/images/normal1.png\" />";

	}
	function rowformater(value, row, index) {
		var str = '';
		str += icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnshenpi.png\" title="处理" onclick="showFun(\'{0}\');"/>', row.flowid);
		return str;
	}

	$(function (){
		$("#parentOrder").combobox({
			valueField: 'flowtype',
			textField: 'flowtypename',
			editable: false,
			url: '${pageContext.request.contextPath}/workorder/getParentType.do',
			onSelect: function (rec) {
				var urlson = '${pageContext.request.contextPath}/workorder/getSonType.do?id=' + rec.flowtype;
				$('#Ftype').combobox('reload', urlson);
				$('#Ftype').combobox('setValue', '');
			}, onLoadSuccess: function () {

				var parentId = $('#parentOrder').combobox('getValue');
				var url2 = '${pageContext.request.contextPath}/workorder/getSonType.do?id=' + parentId;
				$('#Ftype').combobox('reload', url2);
			}
		});
	});
 </script>
	<div data-options="region:'north',border:false" style="padding:10px 20px 10px 10px;margin:10px 5px 0px 25px;height:30px;overflow:hidden;">
		<form id="order_searchform">
			<table >
				<tr style="background:#eee">
					<td>工单号：<input class="easyui-textbox" name="flowid" id="flowid" style="width:120px;height:30px;border:false"></td>
					<td>&nbsp;&nbsp;工单大类：<input id="parentOrder" style="width:100px;height:30px" name="parentOrder" id="parentOrder"class="easyui-combobox" data-options="" /> </td>
<td>&nbsp;&nbsp;工单小类：<input id="Ftype" name="Ftype" style="width:100px;height:30px" class="easyui-combobox" data-options="valueField:'subflowtype',textField:'subflowtypename',editable:false" />
					</td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$('#dg').datagrid('load',icp.serializeObject($('#order_searchform')));">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#order_searchform input').val('');$('#flowid').textbox('clear');$('#Ftype').textbox('clear');$('#parentOrder').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',fit:true,border:false"  style="padding:10px 20px 10px 10px;margin: 0px 5px 0 25px;">
	<table id="dg" class="easyui-datagrid" style="width:100%;"
		data-options="rownumbers:false,border:false,striped : true,scrollbarSize:0,sortName:'ctime',sortOrder:'asc',nowarp:false,singleSelect: true,url:'${pageContext.request.contextPath}/workorder/queryToDo.do',method:'post',loadMsg:'数据装载中......',fitColumns:true,idField:'flowid',pagination:true,pageSize:10,pageList:[5,10,20,30,40,50]">
		<thead>
			<tr>
			    <th data-options="field:'tstatusid',width:60,align:'center',sortable:true,formatter:flowformater">状态</th>
				<th data-options="field:'flowid',width:100,align:'center',sortable:true">工单号</th>
				<th data-options="field:'orderid',width:100,align:'center',sortable:true">订单号</th>
				<th data-options="field:'flowname',width:100,sortable:true">标题</th>
				<th data-options="field:'cusername',width:100,sortable:true">发起人</th>
				<th data-options="field:'ctime',width:100,align:'center',sortable:true">发起时间</th>
				<th data-options="field:'stepname',width:80,sortable:true" >当前环节</th>
				<th data-options="field:'fstatus',width:60,sortable:true">工单状态</th>
				<th data-options="field:'dostatusid',width:60,hidden:true">办理状态</th>
				<th data-options="field:'stepstatusid',width:60,sortable:true,formatter:stepformater">环节状态</th>
				<th data-options="field:'id',width:50,align:'center',formatter:rowformater">操作</th>
			</tr>
		</thead>
	</table>
	</div>
	
</body>

