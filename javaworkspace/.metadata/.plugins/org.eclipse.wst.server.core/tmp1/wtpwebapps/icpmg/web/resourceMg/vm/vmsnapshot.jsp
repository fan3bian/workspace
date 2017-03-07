<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<script type="text/javascript">
var grid;
var snapshottoolbar = [
						{
							text:'创建快照',
							iconCls:'icon-add',
							handler:function(){ 
								var dialog = parent.icp.modalDialog({
									title : '创建快照',
									url : '${pageContext.request.contextPath}/web/resourceMg/vm/addvmsnapshot.jsp?serverid=' + $("#serverid").val(),
									buttons : [{
										text : '创建',
										iconCls:'icon-ok',
										handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
											dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
										}
									},{
										text : '取消',
										iconCls:'icon-cancel',
										handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
											dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
										}
									}]
								}); 
							}
						}
                       ];
$(document).ready(function() {
	loadDataGrid();
});
//查询结果
function loadDataGrid(){
	grid = $('#snapshot_grid').datagrid({
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
		toolbar:snapshottoolbar,    
	    url:'${pageContext.request.contextPath}/vm/queryVmSnapshots.do?serverid=' + '<%=request.getParameter("vmid")%>'
	 }); 
}
function searchDataGrid(){
	$('#snapshot_grid').datagrid('load',icp.serializeObject($('#conditionForm')));
};
function reset(){
	$('#conditionForm input').val('');
	$('#snapshot_grid').datagrid('load',{});
}
function ssstatusformater(value, row, index) {
	if(value == '1'){
		return "正在创建";
	}else if(value == '2'){
		return "创建成功";
	}else if(value == '3'){
		return "创建失败";
	}
}
function optionformater(value, row, index) {
	if(row.curstat == '2'){
		return "<a href=\"javascript:void(0);\" onclick=\"operatesnap(\'" + value + "\',\'restore\',\'" + row.curstat + "\');\">恢复快照</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"operatesnap(\'" + value + "\',\'delete\',\'" + row.curstat + "\');\">删除快照</a>";
	}else if(row.curstat == '3'){
		return "<a href=\"javascript:void(0);\" onclick=\"operatesnap(\'" + value + "\',\'delete\',\'" + row.curstat + "\');\">删除快照</a>";
	}
} 
//恢复快照,删除快照
function operatesnap(name, type,status){
	$('#conditionForm').form('submit',{
	    url:'${pageContext.request.contextPath}/vm/snapoperate.do', 
	    onSubmit : function(param) {
	    	param.serverid=$('#serverid').val();
			param.snapname=name;
			param.type=type;
			param.status=status;
			 $.blockUI({
		               message: "<h2>请求已发送,请稍后......</h2>",
		              css: {color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
		              overlayCSS: {opacity:'0.0'}
		             });
		},
	    success:function(retr){
	        $.unblockUI();
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				$.messager.alert('提示', _data.msg, 'info');
			} else {
				$.messager.alert('提示', _data.msg, 'error');
			}
	    }
	});
}
</script>
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
		<form id="conditionForm">
			<input type="hidden" id="serverid" name="serverid" value="<%=request.getParameter("vmid")%>"/>
			<table >
				<tr>
					<td>&nbsp;&nbsp;快照名称：<input class="easyui-textbox" name="displayname" id="displayname" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="reset();$('#displayname').textbox('clear');">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="snapshot_grid">
			<thead>
				<tr>
					<th data-options="field:'displayname',width:60,align:'center'">快照名称</th>
					<th data-options="field:'createtime',width:60,align:'center'">快照时间</th>
					<th data-options="field:'curstat',width:30,align:'center',formatter:ssstatusformater">状态</th>
					<th data-options="field:'snapname',width:60,align:'center',formatter:optionformater">操作</th>
				</tr>
			</thead>
		</table>
	</div>  
</body>

