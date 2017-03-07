<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
.FieldInput2 {

	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	loadComboData();
	loadDataGrid();
});
//查询结果
function loadDataGrid(){
	$('#grid').datagrid({
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar:[],    
	    url:'${pageContext.request.contextPath}/db/querydbServers.do?flowid=' + '<%=request.getParameter("transferid")%>'
	    }); 
}
function searchDataGrid(){
	$('#grid').datagrid('load',icp.serializeObject($('#conditionForm')));
};
function reset(){
	$('#conditionForm input').val('');
	$('#grid').datagrid('load',{});
}
function curstatformater(value, row, index) {
	switch (value) {
		case "Running":
			return "运行中";
		case "Stopped":
			return "停止";
		case "Stopping":
			return "正在停止";
		case "Starting":
			return "启动中";
		case "Destroyed":
			return "已删除";
		case "Expunging":
			return "正在销毁";
	}
} 
//下拉框数据
function loadComboData(){
	$('#lbparam').combobox({ 
		data: [
		       {id: '', name: '请选择'},
		       {id: 'lbname', name: '配置名称'},
		       {id: 'listport', name: '监听端口'},
		       {id: 'serverip', name: '服务器IP'},
		       {id: 'servername', name: '服务器名称'},
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
	$("#lbparam").combobox('select', '');
}


//提交按钮
function ok4(){
	jQuery.ajax( {
		url : "${pageContext.request.contextPath}/db/confirmflow.do",
		data : {
			'flowid' : $('#flowid').val(), 
			'stepno' : $('#stepno').val(),
			/* 'ftp_address' : $('#ftp_address').val(),
			'ftp_username' : $('#ftp_username').val(),
			'ftp_pass' : $('#ftp_pass').val(),
			'vpn_address' : $('#vpn_address').val(),
			'vpn_username' : $('#vpn_username').val(),
			'vpn_pass' : $('#vpn_pass').val()*/
			} ,
		type : "post",
		cache : false,
		dataType : "json",
		success : function(retr) {
			if (retr.success) {
				$.messager.alert('提示', retr.msg, 'info');
			} else {
				$.messager.alert('提示', retr.msg, 'error');
			}
			$('#dd').dialog('close');
		}
	});
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px;margin:10px 20px 10px ;">
	<input type="hidden" id="flowid" name="flowid" value="<%=request.getParameter("transferid")%>"/>
	<input type="hidden" id="stepno" name="stepno" value="<%=request.getParameter("stepno")%>"/>
	<!-- <div data-options="region:'north',border:false" style="height:80px;overflow:hidden;">
		<form id="conditionForm">
			<table >
				<tr>
				<td class="FieldInput2"><input name="lbparam" id="lbparam" style="height:30px;width:160px"/></td>
					<td class=""><input name="lbparam" id="lbparam" style="width:60px"/></td>
					<td>&nbsp;&nbsp;<input class="easyui-textbox" name="lbvalue" id="lbvalue" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="reset()">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div> -->
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="grid">
			<thead>
				<tr>
					<th data-options="field:'dbname',width:50,align:'center'">数据库名称</th>
					<th data-options="field:'disknum',width:20,align:'center'">硬盘大小</th>
					<th data-options="field:'muser',width:50,align:'center'">允许访问用户名</th>
					<th data-options="field:'ips',width:50,align:'center'">允许访问ips</th>
					<th data-options="field:'curstat',width:20,align:'center',formatter:curstatformater">状态</th>
				</tr>
			</thead>
		</table>
	</div>  
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="ok4();" style="width:80px">提交</a>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#dd').dialog('close');" style="width:80px">取消</a>
	</div>
</div>
</body>

