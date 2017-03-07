<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>
<body>
<style type="text/css">
.FieldInput2 {
	height: 25px;
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
	loadDataGrid();
});
//查询结果
function loadDataGrid(){
	$('#diskmgr_grid').datagrid({
		rownumbers : false,
		singleSelect:true,
		nowrap:false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		multiSort:true,
		sortName:'unitname',
		sortOrder:'desc',
	    url:'${pageContext.request.contextPath}/instance/getAllDisksForInstance.do',
	    onLoadSuccess: function(data){
            $(this).datagrid("autoMergeCells",['unitname','servername']);
        }
    }); 
}

function searchDataGrid(){
	$('#diskmgr_grid').datagrid('load',icp.serializeObject($('#conditionForm')));
};
function reset(){
	$('#conditionForm input').val('');
	$('#diskmgr_grid').datagrid('load',{});
}

function subdiskname(value, row, index){
	return value;
}
//磁盘类型格式
function disktypeformater(value, row, index) {
	switch (value) {
		case "ROOT":
			return "系统盘";
		case "DATADISK":
			return "数据盘";
		default:
			return "数据盘";
	}
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
		<form id="conditionForm">
			<table >
				<tr>
					<td>云服务器名称：<input class="easyui-textbox" name="servername" id="servername" style="width:200px">&nbsp;&nbsp;</td>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="reset()">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;height:96%"  id="diskmgr_grid">
			<thead>
				<tr>
					<th data-options="field:'serverid',checkbox:true,hidden:true"></th>
					<th data-options="field:'unitname',width:120,align:'center',sortable:true,order:'desc'">部门单位</th>
					<th data-options="field:'servername',width:120,align:'center',sortable:false,order:'desc'">云服务器名称</th>
					<th data-options="field:'diskname',width:100,align:'center',hidden:true,formatter:subdiskname">磁盘名称</th>
					<th data-options="field:'disknum',width:50,align:'center'">磁盘大小(GB)</th>
					<th data-options="field:'disktype',width:60,align:'center',formatter:disktypeformater">磁盘类型</th>
					<!-- <th data-options="field:'mountpoint',width:50,align:'center'">挂载点</th> -->
					<th data-options="field:'userid',width:60,align:'center'">所属用户</th>
					<th data-options="field:'cuserid',width:60,align:'center'">磁盘创建人</th>
					<th data-options="field:'ctime',width:80,align:'center'">创建时间</th>
				</tr>
			</thead>
		</table>
	</div>  
</div>
</body>