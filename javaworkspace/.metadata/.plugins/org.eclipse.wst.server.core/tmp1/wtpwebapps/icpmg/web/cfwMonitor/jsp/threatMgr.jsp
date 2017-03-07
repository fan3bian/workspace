<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
<style type="text/css">
.FieldInput2 {
	width:35%;
	height:25px;
    background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
    text-align: left;
    word-wrap: break-word;
    padding-top:0px !important;
    padding-bottom:0px !important;
    border:#BCD2EE 1px solid !important;  
}
.FieldLabel2 {
	width:20%;
	height:25px;
    background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
    text-align: left;
    word-wrap: break-word;
    padding-top:0px !important;
    padding-bottom:0px !important;
    padding-right:10px !important;
    border:#BCD2EE 1px solid !important;  
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	function loadDataGrid(){
		$('#dg').datagrid({
			rownumbers:false,
			border:false,
			striped:true,
			nowarp:false,
			singleSelect:false,
			method:'post',
			loadMsg:'数据装载中......',
			fitColumns:true,
			pagination:true,
			pageSize:10,
			pageList:[5,10,20,30,40,50],
//			url:'../cfwMonitor/jsp/datagrid_data1.json'
			url:'${pageContext.request.contextPath}/cfwMonitor/getListPmdSecurityThreat.do'
		});
	}


	$('#securityid').combobox({
		url:'${pageContext.request.contextPath}/cfwMonitor/getListRmdSecurity.do',
		valueField:'securityid',
		textField:'oname',
		loadFilter: function(data){
//			console.log(data);
//			$(data).each(function (index,ele){
//				if(ele.oname.trim() == ""){
//
//					delete data[index].items[1]
//				}else{
//
//				}
//			});

			console.log(data);
			return data;
		}

	});

	loadDataGrid();
});

function resetContent(formId) {
	var clearForm = document.getElementById(formId);
	if (null != clearForm && typeof(clearForm) != "undefined") {
		clearForm.reset();
	}
}
function searchDataGrid(){
	$('#dg').datagrid('load',icp.serializeObject($('#funcmgr_searchform')));
}

</script>

	
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
		<form id="funcmgr_searchform">
			<input type="hidden" name="cmd" id="cmd" value="search">
			<table class="tableForm datagrid-toolbar">
				<tr>
					<td>租户：<input class="easyui-textbox" name="custname" id="custumName" style="width:200px"></td>
					<td>实例：<input id="securityid" name="objectid" style="width:200px" >
					</td>
					<td>威胁开始时间：<input class="easyui-datetimebox" name="starttime" id="starttime" style="width:200px">
					</td>
					<td>威胁结束时间
						<input class="easyui-datetimebox" name="closeTime" id="closetime" style="width:200px">
					</td>
					<td>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#funcmgr_searchform input').not($('#cmd')).val('');">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div data-options="region:'center',border:false">
		<div>
			<img src="../cfwMonitor/images/sa-2.png">
		</div>
		<table title="" style="width:100%;" id="dg">
			<thead>
			<%--{"serverid":"2016-09-10 12:00:00","customname":"Koi","serveridip":"192.168.1.2","threatname":"P","threattype":1,"source":"Large","target":"EST-1"},--%>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th> 
					<th data-options="field:'starttime',width:120,align:'center',sortable:true">时间</th>
					<th data-options="field:'custname',width:120,align:'center',sortable:true">租户名称</th>
					<th data-options="field:'objectid',width:80,align:'center'">防火墙实例ip</th>
					<th data-options="field:'threatname',width:80,align:'center'">威胁名称</th>
					<th data-options="field:'threattype',width:80,align:'center'">威胁类型</th>
					<th data-options="field:'victimehost',width:80,align:'center'">攻击主机</th>
					<th data-options="field:'attackhost',width:80,align:'center'">受害主机</th>
				</tr>
			</thead>
		</table>
	</div>
		

</div>
</body>