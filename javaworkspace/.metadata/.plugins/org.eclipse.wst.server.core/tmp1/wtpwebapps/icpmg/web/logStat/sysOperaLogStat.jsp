<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	sysOperaLogStatForm = $('#sysOperaLogStat_form').form();
	sysOperaLogdatagrid = $('#sysOperaLogStat_datagrid').datagrid({
		url:'${pageContext.request.contextPath}/logStat/getOperaLogStat.do',
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
			title:'菜单名称',
			field:'menuName',
			hidden:true,
			width:100,
		},{
			title:'菜单等级',
			field:'menuLevel',
			hidden:true,
			width:80,
			formatter:function(value,rowData,rowIndex){
				var str = '';
				if(value == 1){
					str = '一级菜单';
				}
				if(value == 2){
					str = '二级菜单';
				}
				return str;
			}
		},{
			title:'菜单ID',
			field:'menuID',
			hidden:true,
			width:80
		},{
			title:'结果',
			field:'result',
			width:150
		}]]
	});
	sysOperaLogStatReset=function(){
		$('#sysOperaLogStat_form input').val('');
		sysOperaLogdatagrid.datagrid('load',{});
	};
	sysOperaLogStatSearch=function(){
		if($('#sysOperaLogStat_form').form('validate')){
			sysOperaLogdatagrid.datagrid('load',icp.serializeObject(sysOperaLogStatForm));
		}
	};
});

</script>
<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="sysOperaLogStat_form" method="post">
			<table>
				<tr>
					<td>菜单名称：<input class="easyui-textbox" name="mname" id="mname" data-options="prompt:'菜单名称',validType:'length[4,8]',missingMessage:'菜单名称'" style="width:110px;height:24px;border:false"></td>
					<td>&nbsp;&nbsp;日志分类：
						<select class="easyui-combobox id="logtype" name="menuName" data-options="prompt:'日志类型',editable:false" style="width:120px">
							<option value=""></option>
							<option value="用户变更日志">用户变更日志</option>
							<option value="密码变更日志">密码变更日志</option>
							<option value="角色权限日志">角色权限日志</option>
							<option value="产品操作日志">产品操作日志</option>
							<option value="菜单点击日志">菜单点击操作</option>
						</select>
					</td>
					<td>&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" id="stime" name="stime" data-options="editable:false" /></td>
					<td>&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox" id="etime" name="etime" data-options="editable:false,validType:'compareDate[\'stime\']' " /></td>
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="sysOperaLogStatSearch()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="sysOperaLogStatReset();$('#mname').textbox('clear');$('#stime').datetimebox('clear');$('#etime').datetimebox('clear');">重置</a>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="background:#eee;">
		<table id="sysOperaLogStat_datagrid" style="background:#eee;width:100%;"></table>
	</div>
</div>