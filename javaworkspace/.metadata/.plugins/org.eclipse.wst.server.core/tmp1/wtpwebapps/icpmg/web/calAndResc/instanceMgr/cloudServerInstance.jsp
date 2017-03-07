<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>
<body>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
		<form id="conditionForm">
			<table >
				<tr>
					<td>名称：<input class="easyui-textbox" name="csName" data-options="prompt:'云服务器名称'" style="width:180px;height:28px;border:false"></td>
					<td>&nbsp;状态：<select class="easyui-combobox" name="csStatus" data-options="panelHeight:'auto',required:true,editable:false" style="width:150px;height:28px;border:false">
						<option value="All">全部</option>
						<option value="Running">运行中</option>
						<option value="Stopped">停止</option>
						<option value="Stopping">正在停止</option>
						<option value="Starting">启动中</option>
						<option value="Destroyed">已删除</option>
						<option value="Expunging">正在销毁</option>
						</select>
					</td>
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reset()">重置</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-muban',plain:true" onclick="downloadExcel()">模板下载</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-daoru',plain:true" onclick="infoImport()">信息导入</a>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table title="" style="width:100%;height:96%" id="object_grid">
			<thead>
				<tr>
					<th data-options="field:'serverid',align:'center',hidden:true">编码</th>
					<th data-options="field:'unitname',width:100,align:'center',sortable:true,order:'desc'">部门单位</th>
					<th data-options="field:'servername',width:150,align:'center',sortable:false,order:'desc'">云服务器名称</th>
					<th data-options="field:'cpunum',width:30,align:'center'">CPU(C)</th>
					<th data-options="field:'memnum',width:50,align:'center'">内存大小(G)</th>
					<th data-options="field:'disknum',width:50,align:'center'">磁盘大小(G)</th>
					<th data-options="field:'ipaddr',width:80,align:'center'">IP</th>
					<th data-options="field:'poolname',width:40,align:'center'">资源池</th>
					<th data-options="field:'curstat',width:40,align:'center',formatter:statFormater">运行状态</th>
					<th data-options="field:'ops',width:100,align:'center',formatter:opsFormater">操作</th>
				</tr>
			</thead>
		</table>
	</div>  
</div>
<jsp:include page="instanceDetail.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		loadObjectDataGrid();
	});
	function loadObjectDataGrid(){
		var sortFlag = false;
		$('#object_grid').datagrid({
			rownumbers : false,
			singleSelect: true,
			nowrap:false,
			border : false,
			striped : true,
			scrollbarSize : 0,
			method : 'post',
			loadMsg : '数据装载中......',
			fitColumns : true,
			pagination : true,
			pageSize:10,
			pageList:[5,10,20,30,40,50],
			multiSort:false,
			sortName:'unitname',
			sortOrder:'desc',
			url:'${pageContext.request.contextPath}/instance/getAllInstances.do',
			onLoadSuccess: function(data){
				if(!sortFlag) $(this).datagrid("autoMergeCells",['unitname']);
			}
		});
	}
	//运行监控
	function operMonitor(vmid){
		$('#centerTab').panel({
			href:"${pageContext.request.contextPath}/instance/operMonitor.do?neid_=" + vmid
		});
	}

	//实例详细信息
	function instanceDetail(vmid){
		$.ajax({
			url:'${pageContext.request.contextPath}/instance/getInstanceDetail.do',
			data:{
				neid_: vmid
			},
			type : "post",
			cache : false,
			dataType : "html",
			success:function(result){
				//var o = r.obj;
				$('#object_grid').datagrid('unselectAll');
				$('#instance_detail_dialog').html(result);
				$('#instance_detail_dialog').dialog('open');
			}
		});
	}

	//告警统计
	function alarmStatistics(vmid){
		alert(vmid);
	}
	//云服务器运行状态格式化
	function statFormater(value,rowData,index){
		var statStr = '';
		switch(value){
			case 'Running':
				statStr = '运行中';
				break;
			case 'Stopped':
				statStr = '停止';
				break;
			case 'Stopping':
				statStr = 正在停止;
				break;
			case 'Starting':
				statStr = 启动中;
				break;
			case 'Destroyed':
				statStr = '已删除';
				break;
			case 'Expunging':
				statStr = '正在销毁';
				break;
			default:
				statStr = '';
		}
		return statStr;
	}
	//操作
	function opsFormater(value,rowData,index){
		var str='';
		str += '<a onclick="operMonitor(\''+rowData.serverid+'\');">运行监控</a>';
		str += '<a onclick="instanceDetail(\''+rowData.serverid+'\');">|详细信息</a>';
		//str += '<a onclick="alarmStatistics(\''+rowData.serverid+'\');">|告警统计</a>';
		return str;
	}
	//查询功能
	function searchDataGrid(){
		$('#object_grid').datagrid('load',icp.serializeObject($('#conditionForm')));
	}
	function reset(){
		$('#conditionForm input').val('');
		$('#object_grid').datagrid('load',{});
	}

	//下载模板
	function downloadExcel(){
		var url = '${pageContext.request.contextPath}/instance/downloadExcel.do';
		$.ajax({
			type : 'post',
			url : url,
			dataType:'text',
			async: false,
			success:function(result){
				console.log(result);
				url = '${pageContext.request.contextPath}/'+result;
				window.location.href = url;
			}
		});
	}

	//信息导入 按钮
	function infoImport(){
		url='${pageContext.request.contextPath}/instance/infoImportVM.do';
		$('#importwindow').window('open');
	}
</script>

</body>