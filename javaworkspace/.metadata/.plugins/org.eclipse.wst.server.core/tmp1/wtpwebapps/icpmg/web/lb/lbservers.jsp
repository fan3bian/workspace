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
	loadComboData();
	loadDataGrid();
});
//查询结果
function loadDataGrid(){
	$('#grid').datagrid({
		singleSelect:true,
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
	    url:'${pageContext.request.contextPath}/lb/queryLbServers.do',
	    onLoadSuccess: function (data) {
		      var pageopt = $('#grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#grid').datagrid("getRows").length;
		      var total = pageopt.total;
		        
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {weight :''  });
		         }
		         $('#grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
		       
		      }else{
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		      var rows = data.rows;
		      if (rows.length) {
					 $.each(rows, function (idx, val) {
						if   (val.weight ==''){ 
							$('#grid_div  input:checkbox').eq(idx+1).css("display","none");
						}
					}); 
		      }
		 }
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
		case "UP":
			return "运行中";
		case "DOWN":
			return "停止";
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
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
		<form id="conditionForm">
			<table >
				<tr>
					<td class="FieldInput2"><input name="lbparam" id="lbparam" style="height:30px;width:160px"/></td>
					<td>&nbsp;&nbsp;<input class="easyui-textbox" name="lbvalue" id="lbvalue" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="reset()">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" id="grid_div">
		<table title="" style="width:100%;"  id="grid">
			<thead>
				<tr>
					<th data-options="field:'lbdisplayname',width:50,align:'center'">负载均衡名称</th>
					<th data-options="field:'listport',width:20,align:'center'">监听端口</th>
					<th data-options="field:'lbname',width:50,align:'center'">配置名称</th>
					<th data-options="field:'servername',width:50,align:'center'">服务器名称</th>
					<th data-options="field:'lsstatus',width:20,align:'center',formatter:curstatformater">状态</th>
					<th data-options="field:'serverip',width:30,align:'center'">服务器IP</th>
					<th data-options="field:'backport',width:20,align:'center'">协议端口</th>
					<th data-options="field:'weight',width:20,align:'center'">权重</th>
				</tr>
			</thead>
		</table>
	</div>  
</div>
</body>

