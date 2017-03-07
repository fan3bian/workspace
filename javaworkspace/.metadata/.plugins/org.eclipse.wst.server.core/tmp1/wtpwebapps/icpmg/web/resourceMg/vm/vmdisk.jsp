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
var toolbard = [
		{
			text:'创建磁盘',
			iconCls:'icon-add',
			handler:function(){ 
				/* var dialog = parent.icp.modalDialog({
								title : '创建磁盘',
								url : '${pageContext.request.contextPath}/web/resourceMg/vm/addvmdisk.jsp',
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
							}); */
				
			}
		},{
			text:'创建快照',
			iconCls:'icon-add',
			handler:function(){ 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1 || rows.length>1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
			}
		},{
			text:'初始化',
			iconCls:'icon-redo',
			handler:function(){ 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1 || rows.length>1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
			}
		},{
			text:'管理',
			iconCls:'icon-man',
			handler:function(){ 
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1 || rows.length>1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
						
						
						
						/* var dialog = parent.icp.modalDialog({
										title : '新增填报信息',
										url : '${pageContext.request.contextPath}/web/oil/addOilResearch.jsp',
										buttons : [{
											text : '添加',
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
									}); */
						
					}
				}
               ];
               
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
	 
	    url:'${pageContext.request.contextPath}/vm/queryVmDisks.do',
	    onLoadSuccess: function (data) {
		      var pageopt = $('#grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#grid').datagrid("getRows").length
		      if (_pageSize >= 10) {
		         for(i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {operation:''  })
		         }
		         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
		      }else{
		         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
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
//状态格式
function statusformater(value, row, index) {
	switch (value) {
		case "Ready":
			return "可使用";
		case "Allocated":
			return "已挂载";
        case "Destroy":
			return "已删除";
	}
} 
//磁盘类型格式
function disktypeformater(value, row, index) {
	switch (value) {
		case "ROOT":
			return "系统盘";
		case "DATADISK":
			return "数据盘";
	}
}

function platformater(value, row, index) {
   switch (value) {
		case "0001":
			return "openstack平台";
		case "0002":
			return "vmware平台";
	     case "0003":
			return "cloudstack平台";
	}
}
//下拉框数据
function loadComboData(){
	$('#logparam').combobox({ 
		data: [
		       {id: '', name: '请选择'},
		       {id: 'displayname', name: '磁盘名称'},
		       {id: 'platformid', name: '平台名称'},
		       {id: 'disknum', name: '磁盘容量'},
		       {id: 'mountpoin', name: '挂载点'},
		       {id: 'userid', name: '所属用户'}
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
			<table >
				<tr>
					<!-- <td class="FieldInput2"><input name="logparam" id="logparam" style="height:30px;width:160px"/></td>
					<td>&nbsp;&nbsp;<input class="easyui-textbox" name="logvalue" id="logvalue" style="width:160px;height:30px;border:false"/></td> -->
					<td>磁盘名称：<input class="easyui-textbox" name="displayname"
							style="width:120px;height:30px;border:false">
							<%-- 厂商：<input id="searchvendorid"  class="easyui-combobox" name="vendorid" style="width:90px;height:30px;align-text:center"
								data-options="panelHeight:200,
								url:'${pageContext.request.contextPath}/alarm/getVendorids.do',
								valueField:'id',
								textField:'name',
								"/> --%>
							&nbsp;&nbsp;单位：<input class="easyui-combobox" name="searchCompany" style="width:160px;height:30px;align-text:center"
								data-options="panelHeight:100,
								url:'${pageContext.request.contextPath}/alarm/getCompany.do',
								valueField:'id',
								textField:'name',
								"/>
					
					</td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset();$('#logparam').textbox('clear');$('#logvalue').textbox('clear');">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="grid">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'displayname',width:60,align:'center'">磁盘名称</th>
					<th data-options="field:'servername',width:60,align:'center'">所属云服务器</th>
					<th data-options="field:'platformid',width:40,align:'center',formatter:platformater,hidden:true">平台名称</th>
					<th data-options="field:'disknum',width:30,align:'center'">磁盘容量(G)</th>
					<th data-options="field:'disktype',width:40,align:'center',formatter:disktypeformater">磁盘类型</th>
					<!-- <th data-options="field:'mountpoint',width:30,align:'center'">挂载点</th> -->
					<th data-options="field:'curstat',width:30,align:'center',formatter:statusformater">状态</th>
				</tr>
			</thead>
		</table>
	</div>  
</div>
</body>

