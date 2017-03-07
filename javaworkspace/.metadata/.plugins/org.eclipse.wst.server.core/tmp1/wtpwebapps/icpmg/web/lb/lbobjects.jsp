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
var lbtoolbar = [
				{
					text:'管理',
					iconCls:'icon-man',
					handler:function(){ 
						var rows = $('#object_grid').datagrid('getChecked');
						if(rows.length<1 || rows.length>1){
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}
						
						$('#centerTab').panel({
							href:"${pageContext.request.contextPath}/lb/lbManageInit.do?lbid_=" + rows[0].lbid
						});
						
					}
				}
               ];
$(document).ready(function() {
	loadComboData();
	loadObjectDataGrid();
});
//查询结果
function loadObjectDataGrid(){
	$('#object_grid').datagrid({
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
		toolbar:lbtoolbar,    
		/* sortName:'lbid',
		sortOrder:'desc',
		remoteSort:false, */
	    url:'${pageContext.request.contextPath}/lb/queryLbObjects.do',
	    onLoadSuccess: function (data) {
		      var pageopt = $('#object_grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#object_grid').datagrid("getRows").length;
		      var total = pageopt.total;
		        
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {curstat :''  });
		         }
		         $('#object_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
		       
		      }else{
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		      var rows = data.rows;
		      if (rows.length) {
					 $.each(rows, function (idx, val) {
						if   (val.curstat ==''){ 
							$('#object_div  input:checkbox').eq(idx+1).css("display","none");
						}
					}); 
		      }
		 } ,
		 onClickRow: function (rowIndex, rowData) {
					if   (rowData.curstat ==''){
						 $(this).datagrid('unselectRow', rowIndex);
					}else{
						flagck=0;
					}
					if(flagck ==1){
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
		}, 
		onCheckAll: function(rows) {
			flagck = 1;
				$.each(rows, function (idx, val) {
					if   (val.curstat ==''){
						$("#object_grid").datagrid('uncheckRow', idx);
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				});
		}, 
		onUncheckAll: function(rows) {
			flagck = 0;
		}
	});
}
	function searchDataGrid() {
		$('#object_grid').datagrid('load',
				icp.serializeObject($('#conditionForm')));
	};
	function reset() {
		$('#conditionForm').form('reset');
		$('#object_grid').datagrid('load', {});
	}
	function funip(value, row, index){
		
		if("null"==value)
			return "";
		else
			return value;
	}
	function statusformater(value, row, index) {
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
		case "Creating":
			return "正在创建";
		case "error":
			return	"<a style=\"color:red;cursor:pointer;\" onclick=\"deletelb('" + row.lbid + "');\">创建失败</a>"
		}
	}
	function deletelb(lbid){
		
		$.messager.confirm('系统提示信息', '当前记录无效，请删除！', function(r){
			if(r){
				$.ajax({
					 url:'${pageContext.request.contextPath}/lb/deletelb.do?',
					 type:'post',
					 async:false,
					 data:{lbid:lbid},
				     dataType:'json',  
				     success:function(data){      	
						if (data.success) {
							$.messager.alert('提示', data.msg, 'info');
						} else {
							$.messager.alert('提示', data.msg, 'error');
						}
						$('#object_grid').datagrid("reload");
					}
				});
			}
		});
		
	}
	//下拉框数据
	function loadComboData() {
		$('#lbparam_').combobox({
		data: [
		       {id: '', name: '请选择'},
		       {id: 'displayname', name: '名称'},
		       {id: 'regionname', name: '区域'},
		       {id: 'lbip', name: '管理地址'},
		       {id: 'funip', name: '业务地址'},
		       {id: 'description', name: '描述'},
		       {id: 'curstat', name: '状态'}
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
	$("#lbparam_").combobox('select', '');
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background:#eee;">
		<form id="conditionForm">
			<table >
				<tr>
					<td>查询维度：<input name="lbparam" id="lbparam_" style="height:30px;width:160px"/></td>
					<td>&nbsp;&nbsp;<input class="easyui-textbox" name="lbvalue" id="lbvalue_" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset()">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" id="object_div">
		<table title="" style="width:100%;" id="object_grid">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'lbid',width:60,align:'center'">编码</th>
					<th data-options="field:'displayname',width:50,align:'center'">名称</th>
					<th data-options="field:'funip',width:50,align:'center',formatter:funip">业务地址</th>
					<th data-options="field:'lbip',width:50,align:'center',formatter:funip">管理地址</th>
					<th data-options="field:'regionname',width:30,align:'center'">区域</th>
					<th data-options="field:'description',width:60,align:'center'">描述</th>
					<th data-options="field:'ctime',width:60,align:'center'">开通时间</th>
					<th data-options="field:'curstat',width:40,align:'center',formatter:statusformater">状态</th>
				</tr>
			</thead>
		</table>
	</div>  
</div>
</body>

