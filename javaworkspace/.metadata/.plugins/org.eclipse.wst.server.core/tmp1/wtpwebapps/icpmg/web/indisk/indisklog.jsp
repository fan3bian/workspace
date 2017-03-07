<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
.FieldInput2 {
	height: 25px;
	background-color: #eee;
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
	$('#log_grid').datagrid({
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[10,20,30,40,50],
	    url:'${pageContext.request.contextPath}/indisk/queryIndiskLogList.do',
	    onLoadSuccess: function (data) {
		      var pageopt = $('#log_grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#log_grid').datagrid("getRows").length
		      var total = pageopt.total;
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {status :''  });
		         }
		         $('#log_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
		       
		      }else{
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		 }
	    }); 
}
function searchDataGrid(){
	$('#log_grid').datagrid('load',icp.serializeObject($('#conditionForm')));
};
function reset(){
	$('#conditionForm input').val('');
	$('#log_grid').datagrid('load',{});
}
function opchannelformater(value, row, index) {
	switch (value) {
		case "1":
			return "用户操作";
		case "0":
			return "管理员操作";
	}
} 
//下拉框数据
function loadComboData(){
	$('#logparam').combobox({ 
		data: [
		       {id: '', name: '请选择'},
		       {id: 'operation', name: '操作项'},
		       {id: 'username', name: '操作者'},
		       {id: 'result', name: '执行结果'},
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
	$("#logparam").combobox('select', '');
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background-color: #eee;margin-bottom:10px">
		<form id="conditionForm">
			<input name="resourcetype" value="2" type="hidden" />
			<table >
				<tr>
					<td class="FieldInput2"><input name="logparam" id="logparam" style="height:30px;width:160px"/></td>
					<td>&nbsp;&nbsp;<input class="easyui-textbox" name="logvalue" id="logvalue" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();$('#logparam').textbox('clear');$('#logvalue').textbox('clear');">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="log_grid">
			<thead>
				<tr>
					<th data-options="field:'operation',width:40,align:'center'">操作项</th>
					<th data-options="field:'resourceid',width:50,align:'center'">资源名称</th>
					<th data-options="field:'username',width:30,align:'center'">操作者</th>
					<th data-options="field:'operatetime',width:50,align:'center'">操作时间</th>
					<th data-options="field:'ip',width:50,align:'center'">IP</th>
					<th data-options="field:'result',width:20,align:'center'">执行结果</th>
				</tr>
			</thead>
		</table>
	</div>  
</div>
</body>

