<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!-- <style type="text/css">
	.search{width:120px;height:30px;border:false;}
	.time{width:130px;height:30px;border:false;}
</style> -->
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script> --%>

<script type="text/javascript">
$(function(){
	logIOStatForm = $('#logIOStat_form').form();
	datagrid = $('#logIOStat_datagrid').datagrid({
		url:'${pageContext.request.contextPath}/logStat/getLogIOStat.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		/* fit:true, */
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'operationLogID',
		sortName:'createTime',
		sortOrder:'desc',
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'LogID',
			field:'operationLogID',
			hidden:true,
			width:100
		},{
			title:'邮箱',
			field:'operationUserID',
			width:100,
			sortable:true
		},{
			title:'客户名称',
			field:'operationUser',
			width:100,
			sortable:true
		},{
			title:'IP地址',
			field:'ipAddr',
			width:100
		},{
			title:'IP地理位置',
			field:'ipLocation',
			width:80
		},{
			title:'时间',
			field:'createTime',
			width:100,
			sortable:true
		},{
			title:'应用系统名称',
			field:'projectName',
			width:100,
			formatter: function(value,rowData,rowIndex){
				var str='';
				if(value == 'icpmg'){
					str='运维支撑系统';
				}
				if(value == 'icpserver'){
					str='客户自服务系统';
				}
				return str;
			}
		},{
			title:'结果',
			field:'result',
			width:150
		}]]
	});
	logIOStatReset=function(){
		$('#logIOStat_form input').val('');
		datagrid.datagrid('load',{});
	};
	logIOStatSearch=function(){
		if ($('#logIOStat_form').form('validate')) {
			datagrid.datagrid('load',icp.serializeObject(logIOStatForm));
		}
	};
});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="logIOStat_form" method="post">
			<table>
				<tr>
					<td>邮箱帐号：<input class="easyui-textbox" name="email" id="email" data-options="prompt:'电子邮箱',validType:['email','length[10,30]'],missingMessage:'请输入电子邮箱'" style="width:110px;height:24px;border:false"></td>
					<td>&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" id="stime" name="stime" data-options="editable:false" /></td>
					<td>&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox" id="etime" name="etime" data-options="editable:false,validType:'compareDate[\'stime\']' " /></td>
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="logIOStatSearch()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="logIOStatReset();$('#stime').datetimebox('clear');$('#etime').datetimebox('clear');$('#email').textbox('clear');">重置</a>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div data-options="region:'center',border:false" style="background:#eee;">
		<table id="logIOStat_datagrid" style="background:#eee;width:100%;"></table>
	</div>
</div>