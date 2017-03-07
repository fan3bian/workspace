<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
$(function(){
	loadComboData();
	loadUserLogGrid();
});
function loadUserLogGrid(){
	$('#obs_user_log_grid').datagrid({
		singleSelect:true,
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		sortName:'operatetime',
		sortOrder:'desc',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar:[],    
	    url:'${pageContext.request.contextPath}/obsMgr/queryLogList.do',
	    onLoadSuccess: function (data) {
	    	
    		var pageopt = $('#obs_user_log_grid').datagrid('getPager').data("pagination").options;
			var  _pageSize = pageopt.pageSize;//分页条数
			var  _rows = $('#obs_user_log_grid').datagrid("getRows").length;//每页实际条数
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for( var i=10;i>_rows;i--){
					//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					$(this).datagrid('appendRow', {result:''  });
				}
				$('#obs_user_log_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    	total: total,
			     });
			}else{
				//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
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
						$("#obs_user_log_grid").datagrid('uncheckRow', idx);
						//增加全选复选框被选中
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
						
					}
			});
		} 
	});
}
function searchDataGrid(){
	$('#obs_user_log_grid').datagrid('load',icp.serializeObject($('#conditionForm')));
};
function reset(){
	$('#conditionForm').form('reset');
	$('#obs_user_log_grid').datagrid('load',{});
}
function loadComboData(){
	$('#logparam').combobox({ 
		data: [
		       {id: '', name: '请选择'},
		       {id: 'userid', name: '操作'},
		       {id: 'operatetype', name: '操作类型'},
		       {id: 'channeltype', name: '渠道'},
		       {id: 'result', name: '执行结果'},
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
	$("#logparam").combobox('select', '');//根据id绑定初始化选项
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
		<div>
			<form id="conditionForm">
				<table>
					<tr>
						<td class="FieldInput2"><input name="logparam" id="logparam" style="height:30px;width:140px"/></td>
						<td>&nbsp;&nbsp;<input class="easyui-textbox" name="logvalue" id="logvalue" style="width:140px;height:30px;border:false"/></td>
						<td>&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" editable="fasle"name="starttime" id="starttime" style="width:140px;height:30px;border:false">
					    <td>&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox"  editable="fasle" validType="compareDate['starttime']" name="endtime" id="endtime" style="width:140px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset()">重置</a>
						</td>
						
					</tr>
				</table>
			</form>
		</div>
		<div >
			<table style="width:98%;" id="obs_user_log_grid">
				<thead>
					<tr>
						<th data-options="field:'userid',width:20,align:'center'">操作者</th>
						<th data-options="field:'operation',width:20,align:'center'">操作</th>
						<th data-options="field:'operatetype',width:20,align:'center'">操作类型</th>
						<th data-options="field:'channeltype',width:20,align:'center'">渠道</th>
						<th data-options="field:'operatetime',width:20,align:'center'">操作时间</th>
						<th data-options="field:'description',width:30,align:'center'">详细描述</th>
						<th data-options="field:'result',width:20,align:'center'">执行结果</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>  
