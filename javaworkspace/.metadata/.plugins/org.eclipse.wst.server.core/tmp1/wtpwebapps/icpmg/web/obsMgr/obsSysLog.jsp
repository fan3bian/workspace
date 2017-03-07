<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
$(function(){
	sysComboData();
	loadSysLogGrid();
});
function loadSysLogGrid(){
	$('#obs_sys_log_grid').datagrid({
		singleSelect:true,
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		sortName:'ctime',
		sortOrder:'desc',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar:[],    
	    url:'${pageContext.request.contextPath}/obsMgr/querySysLogList.do',
	    onLoadSuccess: function (data) {
	    	
    		var pageopt = $('#obs_sys_log_grid').datagrid('getPager').data("pagination").options;
			var  _pageSize = pageopt.pageSize;//分页条数
			var  _rows = $('#obs_sys_log_grid').datagrid("getRows").length;//每页实际条数
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for( var i=10;i>_rows;i--){
					$(this).datagrid('appendRow', {description:'' });
				}
				$('#obs_sys_log_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    	total: total,
			     });
			}else{
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			
	    },
		 onClickRow: function (rowIndex, rowData) {
			if   (rowData.operation ==''){
				 $(this).datagrid('unselectRow', rowIndex);
			}else{
				//点击有数据的行  标志位变为0
				flagck=0;
			}
			//判断时候已经有全部选择
			if(flagck ==1){
				$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
			}
		}, 
		//点击全选
		onCheckAll: function(rows) {
			//全选时，标志位变为1
			flagck = 1;
				$.each(rows, function (idx, val) {
					if(val.operation ==''){
						//如果是空行，不能被选中
						$("#obs_sys_log_grid").datagrid('uncheckRow', idx);
						//增加全选复选框被选中
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
						
					}
			});
		} 
	});
}
function searchDataGrid(){
	$('#obs_sys_log_grid').datagrid('load',icp.serializeObject($('#sys_log_param')));
};
function reset(){
	$('#sys_log_param').form('reset');
	$('#obs_sys_log_grid').datagrid('load',{});
}
function sysComboData(){
	$('#syslogparam').combobox({ 
		data: [
		       {id: '', name: '请选择'},
		       {id: 'userid', name: '用户'},
		       {id: 'module', name: '模块'},
		       {id: 'clientip', name: 'IP地址'},
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
	$("#syslogparam").combobox('select', '');//根据id绑定初始化选项
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
		<div>
			<form id="sys_log_param">
				<table >
					<tr>
						<td class="FieldInput2"><input name="syslogparam" id="syslogparam" style="height:30px;width:140px"/></td>
						<td>&nbsp;&nbsp;<input class="easyui-textbox" name="syslogvalue" id="syslogvalue" style="width:140px;height:30px;border:false"/></td>
						<td>&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" editable="fasle"name="sysstarttime" id="sysstarttime" style="width:140px;height:30px;border:false">
					    <td>&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox"  editable="fasle" validType="compareDate['sysstarttime']" name="sysendtime" id="sysendtime" style="width:140px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset()">重置</a>
						</td>
						
					</tr>
				</table>
			</form>
		</div>
		<div style="height:390px;">
			<table style="width:98%;" id="obs_sys_log_grid">
				<thead>
					<tr>
						<th data-options="field:'userid',width:20,align:'center'">账号</th>
						<th data-options="field:'module',width:20,align:'center'">模块</th>
						<th data-options="field:'ctime',width:20,align:'center'">时间</th>
						<th data-options="field:'clientip',width:20,align:'center'">IP地址</th>
						<th data-options="field:'description',width:20,align:'center'">异常原因</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>  
