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
	    url:'${pageContext.request.contextPath}/lb/queryLbLogs.do',
	    onLoadSuccess: function (data) {
		      var pageopt = $('#grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#grid').datagrid("getRows").length;
		      var total = pageopt.total;
		        
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {result :''  });
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
						if   (val.result ==''){ 
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
	$('#conditionForm').form('reset');
	$('#grid').datagrid('load',{});
}
function opchannelformater(value, row, index) {
	switch (value) {
		case "1":
			return "用户操作";
		case "0":
			return "管理员操作";
	}
} 
function resourcetypeformater(value, row, index){
	switch (value) {
		case "1":
			return "负载均衡资源实例";
		case "2":
			return "应用服务监听";
		case "3":
			return "后端服务器";
		case "4":
			return "转发策略";
		case "5":
			return "服务器证书";
			
	}
}
//下拉框数据
function loadComboData(){
	$('#operateresult').combobox({ 
		data: [
		       {id: '', name: '请选择'},
		       {id: '成功', name: '成功'},
		       {id: '失败', name: '失败'}
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
	$("#operateresult").combobox('select', '');//根据id绑定初始化选项
	$("#operateresult").combobox({panelHeight:'auto'});
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background:#eee;">
		<form id="conditionForm">
			<table >
				<tr>
					<td>时间范围：<input class="easyui-datetimebox" name="starttime" id="starttime" style="width:140px;height:30px;border:false">
						-<input class="easyui-datetimebox" name="endtime" id="endtime" style="width:140px;height:30px;border:false">
					</td>
					<td>&nbsp;&nbsp;资源名称：<input class="easyui-textbox" name="resourcename" id="resourcename" style="width:160px;height:30px;border:false"/>
						操作结果：<input name="operateresult" id="operateresult" style="height:30px;width:160px"/></td>
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
					<th data-options="field:'resourcename',width:30,align:'center'">资源名称</th>
					<th data-options="field:'resourcetype',width:30,align:'center',formatter:resourcetypeformater">操作类型</th>
					<th data-options="field:'opchannel',width:40,align:'center',formatter:opchannelformater">操作渠道</th>
					<th data-options="field:'username',width:40,align:'center'">操作人名称</th>
					<th data-options="field:'operatetime',width:50,align:'center'">操作时间</th>
					<th data-options="field:'result',width:20,align:'center'">操作结果</th>
				</tr>
			</thead>
		</table>
	</div>  
</div>
</body>

