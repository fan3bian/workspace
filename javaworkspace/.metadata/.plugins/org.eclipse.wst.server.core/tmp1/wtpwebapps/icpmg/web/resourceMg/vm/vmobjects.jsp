<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<%@ include file="/icp/include/taglib.jsp"%>
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
	var flagck = 0;  //  初始化为0
	var ws = null;
	var url = null;
	var transports = [];
	var rrtoolbar = [
		{
			text: '实例操作',
			id: 'vmmg',
			iconCls: 'icon-objmanage',
			handler: function () {
				var rows = $('#object_grid').datagrid('getChecked');
				if (rows.length < 1 || rows.length > 1) {
					$.messager.alert('消息', '请选择一条记录！');
					return;
				}

				$('#centerTab').panel({
					href: "${pageContext.request.contextPath}/vm/vmManageInit.do",
					queryParams:{
						neid_:rows[0].serverid
					}
				});

			}
		},
		{
			text: '批量开机',
			id: 'vmsopen',
			iconCls: 'icon-objopen',
			handler: function () {
				var rows = $('#object_grid').datagrid('getChecked');
				if (rows.length < 1) {
					$.messager.alert('消息', '请选择至少一条记录！');
					return;
				}
				var neids = '';
				for (var i = 0; i < rows.length; i++) {

					if (rows[i].curstat == 'Stopped') {
						neids = neids + rows[i].serverid + ',';
					}
				}
				if (neids != '') {
					$.messager.confirm('确认','您确认想要批量开机选中记录吗？',function(r){
						if(r){
							neids = neids.substring(0, neids.length - 1);
							$.blockUI({
								message: "<h2>请求已发送,请稍后......</h2>",
								css: {color: '#fff', border: '3px solid #aaa', backgroundColor: '#CCCCCC'},
								overlayCSS: {opacity: '0.0'}
							});
							$.ajax({
								url: '${pageContext.request.contextPath}' + '/vm/batchoperate.do?neids=' + neids + '&type=start',
								type: 'post',
		
								dataType: 'json',
								success: function (retr) {
									$.unblockUI();
									$.messager.alert('消息', '操作完成 !');
									searchDataGrid();
								}
							});
						}
					});
				} else {
					$.messager.alert('消息', '当前的选择中没有需要启动的虚机 !');
				}

			}
		},
		{
			text: '批量关机',
			id: 'vmsclose',
			iconCls: 'icon-objclose',
			handler: function () {
				var rows = $('#object_grid').datagrid('getChecked');
				if (rows.length < 1) {
					$.messager.alert('消息', '请选择至少一条记录！');
					return;
				}
				var neids = '';
				for (var i = 0; i < rows.length; i++) {

					if (rows[i].curstat == 'Running') {
						neids = neids + rows[i].serverid + ',';
					}
				}
				if (neids != '') {
					neids = neids.substring(0, neids.length - 1);
					$.blockUI({
						message: "<h2>请求已发送,请稍后......</h2>",
						css: {color: '#fff', border: '3px solid #aaa', backgroundColor: '#CCCCCC'},
						overlayCSS: {opacity: '0.0'}
					});
					$.ajax({
						url: '${pageContext.request.contextPath}' + '/vm/batchoperate.do?neids=' + neids + '&type=shutdown',
						type: 'post',
						dataType: 'json',
						success: function (retr) {
							$.unblockUI();
							
							$.messager.alert('消息', '操作完成 !');
							searchDataGrid();
						}
					});
				} else {
					$.messager.alert('消息', '当前的选择中没有需要关闭的虚机 !');
				}
			}
		},
		{
			text: '批量重启',
			id: 'vmsreload',
			iconCls: 'icon-reboot',
			handler: function () {
				var rows = $('#object_grid').datagrid('getChecked');
				if (rows.length < 1) {
					$.messager.alert('消息', '请选择至少一条记录！');
					return;
				}
				var neids = '';
				for (var i = 0; i < rows.length; i++) {

					if (rows[i].curstat == 'Running') {
						neids = neids + rows[i].serverid + ',';
					}
				}
				if (neids != '') {
					$.messager.confirm('确认','您确认想要批量重启选中记录吗？',function(r){
						if(r){
							neids = neids.substring(0, neids.length - 1);
							$.blockUI({
								message: "<h2>请求已发送,请稍后......</h2>",
								css: {color: '#fff', border: '3px solid #aaa', backgroundColor: '#CCCCCC'},
								overlayCSS: {opacity: '0.0'}
							});
							$.ajax({
								url: '${pageContext.request.contextPath}' + '/vm/batchoperate.do?neids=' + neids + '&type=restart',
								type: 'post',
		
								dataType: 'json',
								success: function (retr) {
									$.unblockUI();
									$.messager.alert('消息', '操作完成 !');
									searchDataGrid();
								}
							});
						}
					});
				} else {
					alert("当前的选择中没有需要重启的虚机 !");
				}

			}
		},

		{
			text: '修改标签',
			iconCls: 'icon-update',
			id: 'vmnameupdate',
			handler: function () {
				var rows = $('#object_grid').datagrid('getChecked');
				if (rows.length < 1 || rows.length > 1) {
					$.messager.alert('消息', '请选择一条记录！');
					return;
				}
				$('#modify_serverid').val(rows[0].serverid)
				$('#modify_displayname').textbox('setValue', rows[0].displayname);
				$('#modifyvmname').dialog('open');
			}
		},
		{
			text: '运行概况',
			id: 'vmrun',
			iconCls: 'icon-objmanage',
			handler: function () {
				var rows = $('#object_grid').datagrid('getChecked');
				if (rows.length != 1) {
					$.messager.alert('消息', '请选择一条记录！');
					return;
				} 				
				var neid = rows[0].serverid;
				var orghref = '/icpmg/web/omsMonitor/inserver/jsp/runOverview.jsp';
				var oskhref = '/icpmg/web/omsMonitor/inserver/jsp/osRunOverview.jsp';
				var platformTypeUrl = '${pageContext.request.contextPath}/oms_summary/queryVmPlatformType.do';
				
				$.ajax({
			  		type : 'post',
			  		url:encodeURI(platformTypeUrl),
			  		data:{
			  			serverId:neid  			
			  		},
			  		dataType:'json',
			  		success:function(retr){
				   		 var currentServerName = retr.servername;
				  		 var currentPlattype =	retr.plattype;
			  			if(currentPlattype == 'vmware'){
			  				$('#centerTab').panel({
			  					href:encodeURI(orghref),
			  					queryParams:{
			  						neid:neid
			  					}
			  					});	
			  				
			  			}else if(currentPlattype == 'openstack'){
			  				$('#centerTab').panel({
			  					href:encodeURI(oskhref),
			  					queryParams:{
			  						nename:currentServerName
			  					}
			  					});				  				
			  			}else{
			  				$('#centerTab').panel({
			  					href:encodeURI(orghref),
			  					queryParams:{
			  						neid:neid
			  					}
			  					});
			  			}
			  			
			  			
			  		}
				});
			}
		}
	];
	$(document).ready(function () {
		loadComboData();
		loadObjectDataGrid();
	});
	
	function updateUrl(urlPath) {
		if (urlPath.indexOf('sockjs') != -1) {
			url = urlPath;

		} else {
			if (window.location.protocol == 'http:') {
				url = 'ws://' + window.location.host + urlPath;
			} else {
				url = 'wss://' + window.location.host + urlPath;
			}
		}
	}
	function connect() {

		if (window.eventactive) {
			window.eventactive.close();
			window.eventactive = null;
		}
		if (!url) {
			alert('Select whether to use W3C WebSocket or SockJS');
			return;
		}
		ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
			protocols_whitelist: transports
		}) : new WebSocket(url);
		window.eventactive = ws;
		ws.onopen = function () {

		};
		ws.onmessage = function (event) {
			var data = event.data;
			var data = JSON.parse(data);
			var info = data.msg;
			if (data.step == "vmSuccess") {
				var displayname = data.displayname;
				$("#vmname_that_create").text("【" + displayname + "】");
				$("#vmA_detail_text_cpu").text(data.cpu);
				$("#vmA_detail_text_mem").text((data.mem / 1024) + "G");
				$("#vmA_detail_text_image").text(data.images);
				$("#vmA_detail_text_disks").text(data.disks);
				$("#vmA_detail_resourcepool").text(data.resourcepool);
				$("#vmA_detail_vlan").text(data.vlan);
				$("#vmA_detail_text_vmname").text(data.displayname);
				$("#vmA_detail_text_vmnum").text(data.servernum);
				$("#vmA_detail_text_unit").text(data.unit);
				$("#vmA_detail_text_project").text(data.project);
				$("#vmA_detail_text_app").text(data.appname);
// 				$("#createInstances_success_hidden_sid").val(data.serverid);
// 				$("#createInstances_success_hidden_sname").val(data.servername);
// 				$("#createInstances_success_hidden_ptype").val(data.plattype);
// 				$("#createInstances_success_hidden_nettype").val(data.networktypeid);
// 				$("#createInstances_success").window('open');
			} else {

				$.messager.alert('提示', info, "info");
			}
			$('#object_grid').datagrid('load', {});
		};
		ws.onclose = function (event) {

		};
	}

	//查询结果
	function loadObjectDataGrid() {
		$('#object_grid').datagrid({
			rownumbers: false,
			border: false,
			striped: true,
			scrollbarSize: 0,
			method: 'post',
			loadMsg: '数据装载中......',
			fitColumns: true,
			pagination: true,
			pageSize: 10,
			pageList: [5, 10, 20, 30, 40, 50],
			toolbar: rrtoolbar,
			url: '${pageContext.request.contextPath}/vm/queryVmObjects.do',
			
			onLoadSuccess: function (data) {
				var pageopt = $('#object_grid').datagrid('getPager').data("pagination").options;
				var _pageSize = pageopt.pageSize;
				var _rows = $('#object_grid').datagrid("getRows").length;
				
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 10) {
					for(i=10;i>_rows;i--){
						//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						$(this).datagrid('appendRow', {serverid:''  })
					}
					$('#object_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
				//设置不显示复选框
		        var rows = data.rows;
		        if (rows.length) {
					 $.each(rows, function (idx, val) {
						if(val.serverid==''){ 
							//addid为datagrid上一层的div id
							$('#addid  input:checkbox').eq(idx+1).css("display","none");
						////////////aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	 
						}
					}); 
		        }
			},
			//没数据的行不能被点击选中
			onClickRow: function (rowIndex, rowData) {
				if(rowData.serverid==''){///////////////////////
					 $('#object_grid').datagrid('unselectRow', rowIndex);
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
						if(val.serverid==''){/////////////////////////////////////
							//如果是空行，不能被选中
							$("#object_grid").datagrid('uncheckRow', idx);
							//增加全选复选框被选中
							$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
						}
					});
			},
			 //取消全选
			onUncheckAll: function(rows) {
				//取消全选时，标志位变为0
				flagck = 0;
			}
		});

	}
	function searchDataGrid() {
		$('#object_grid').datagrid('load',icp.serializeObject($('#conditionForm')));
	}
	function reset() {
		$('#conditionForm input').val('');
		$('#object_grid').datagrid('load', {});
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
			case "cerror":
				return "创建失败";
		}
	}
    
	
	//修改云服务器名称${ctx}/project/projectedit.do
	function modifyvmname() {
		$('#modifyvmnameform').form('submit', {

			url: '${ctx}/vmmanage/modifyVmName.do',
			onSubmit: function () {
				return $(this).form('validate');
			},
			success: function (data) {
				$('#modifyvmname').window('close');
				var data = JSON.parse(data);
				$("#object_grid").datagrid('load');
				$.messager.alert('提示', data.msg, "info");
			}
		})
	}
	//下拉框数据
	function loadComboData() {
		$('#logparam')
				.combobox(
				{
					data: [{
						id: '',
						name: '请选择'
					}, {
						id: 'serverid',
						name: '云服务器'
					},
					{
							id: 'displayname',
							name: '应用名称'
					}, {
							id: 'curstat',
							name: '状态'
						}],
					valueField: 'id',
					textField: 'name',
					onSelect: function (record) {
						if ("curstat" == record.id) {
							$("#logvalue")
									.removeClass("easyui-textbox")
									.combobox({
										data: [{
											id: 'Running',
											name: '运行中'
										}, {
											id: 'Stopped',
											name: '停止'
										}, {
											id: 'Stopping',
											name: '正在停止'
										}, {
											id: 'Starting',
											name: '启动中'
										}, {
											id: 'Destroyed',
											name: '已删除'
										}, {
											id: 'Expunging',
											name: '正在销毁'
										}],
										valueField: 'id',
										textField: 'name'
									}).combobox('select', 'Running');
						} else {
							$("#logvalue")
									.parents("td")
									.empty()
									.append(
									'&nbsp;&nbsp;<input  name="logvalue" id="logvalue" style="width:160px;height:30px;border:false"/>');
							$("#logvalue").addClass("easyui-textbox");
							$.parser
									.parse($("#logvalue").parents("td"));
						}
					}
				});
		$("#logparam").combobox('select', '');

	}
</script>
	<div style="">
		<form action="#" id="createVmForm" method="post">
			<input type="hidden" id="cpuNum" value='2' name="cpunum"> <input
				type="hidden" id="stroeSize" value='2' name="memnum"> <input
				type="hidden" id="imagesId" name="template"> <input
				type="hidden" id="dataDisk1" name="disk1"> <input
				type="hidden" id="dataDisk2" name="disk2"> <input
				type="hidden" id="resourceId" name="resourcepool"> <input
				type="hidden" id="networkId" name="network"> <input
				type="hidden" id="ipDiy" name="ip"> <input 
				type="hidden" id="serverName" name="servername"> <input 
				type="hidden" id="serverNum" name="serverNum"> <input 
				type="hidden" id="platformid" name="platformid"> <input 
				type="hidden" id="mnetworkypeid" name="networktypeid"> <input
				type="hidden" id="mnetworkypename" name="networktypename"> <input
				type="hidden" id="mproid" name="proid"> <input 
				type="hidden" id="mproname" name="proname"> <input 
				type="hidden" id="munitid" name="unitid"> <input 
				type="hidden" id="munitname" name="unitname"> <input 
				type="hidden" id="mappname" name="mappname">
		</form>
	</div>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding: 10px 20px 10px 20px; margin: 10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height: 30px; overflow: hidden; background-color: #eee">
			<form id="conditionForm" method="post">
				<table>
					<tr>						
						<th>云服务器：</th>
						<td><input class="easyui-textbox" name="serverid"
							style="width: 120px; height: 30px; border: false" />
                        </td>
						<td>	
						    &nbsp;&nbsp;单位：<input 
							class="easyui-combobox"
							name="searchCompany" 
							
							style="width: 160px; height: 30px; align-text: center"
							data-options="panelHeight:100,
								url:'${pageContext.request.contextPath}/alarm/getCompany.do',								
								valueField:'id',
								textField:'name',
								" />
						</td>
						<%--
						<td>		
						    &nbsp;&nbsp;所属平台：<input
							class="easyui-combobox" 
							name="searchPlatform" 
						
							style="width: 160px; height: 30px; align-text: center"
							data-options="panelHeight:100,
								url:'${pageContext.request.contextPath}/alarm/getPlatfrom.do',
							    valueField:'id',
								textField:'name',
								" />
					    
						</td> --%>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton"
							data-options="iconCls:'icon-search',plain:true"
							onclick="searchDataGrid()">查询</a>
							
							
						&nbsp;&nbsp;<a href="javascript:void(0);" 
							class="easyui-linkbutton"
							data-options="iconCls:'icon-redo',plain:true"
							onclick="reset();$('#logparam').textbox('clear');$('#logvalue').textbox('clear');">重置</a>
						</td>

					</tr>
				</table>
			</form>

		</div>
		<div data-options="region:'center',border:false" id='addid'>
			<table title="" style="width: 100%;" id="object_grid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'serverid',width:40,align:'center'">云服务器名称</th>
						<th data-options="field:'displayname',width:20,align:'center'">标签</th>
						<th data-options="field:'appname',width:20,align:'center'">应用</th>
						<th
							data-options="field:'servername',width:60,align:'center',hidden:true">虚机名称</th>
						<th
							data-options="field:'unitid',width:20,align:'center',hidden:true">区域</th>
						<th
							data-options="field:'projectid',width:20,align:'center',hidden:true">区域</th>
						<th data-options="field:'projectname',width:20,align:'center'">项目</th>
						<th data-options="field:'unitname',width:30,align:'center'">使用单位</th>
						<th data-options="field:'groupname',width:20,align:'center',hidden:true">上级部门</th>
						<th data-options="field:'networktypeid',width:30,align:'center',hidden:true">所属平台</th>
						<th data-options="field:'networktypename',width:30,align:'center'">区域</th>
						<%--<th data-options="field:'plattype',width:20,align:'center'">平台类型</th> --%>
						<%--<th data-options="field:'platformname',width:30,align:'center'">所属平台</th>--%>


						<th data-options="field:'cpunum',width:30,align:'center',hidden:true">cpu</th>
						<th data-options="field:'memnum',width:30,align:'center',hidden:true">内存</th>
						<th data-options="field:'osname',width:30,align:'center',hidden:true">操作系统</th>
						<th data-options="field:'platformid',width:30,align:'center',hidden:true">平台id</th> 

						<th data-options="field:'datacenter',width:30,align:'center',hidden:true">资源池</th>
						<th data-options="field:'templateid',width:30,align:'center',hidden:true">模板</th>
						<th data-options="field:'disknum',width:30,align:'center',hidden:true">磁盘</th>
						<th data-options="field:'network',width:30,align:'center',hidden:true">vlan</th>
						<th data-options="field:'curstat',width:20,align:'center',formatter:statusformater">状态</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>


	<div id="modifyvmname" class="easyui-window" title="修改云服务器标签"
		data-options="iconCls:'icon-update',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width: 390px; height: 155px;">
		<form action="" method="post" id="modifyvmnameform">
			<div data-options="region:'center'" style="padding: 10px;">

				<div class="detail-line" style="margin: 10px 37px">
					<input class="easyui-textbox"
						data-options="required:'ture',validType:'isBlank',prompt:'云服务器标签',missingMessage:'云服务器名称必填'"
						id="modify_displayname" style="width: 270px; height: 30px;"
						name="displayname">
				</div>
				<input type="hidden" name="serverid" id="modify_serverid">

				<div data-options="region:'south',border:false"
					style="text-align: center; padding: 10px 0 0;">
					<a class="easyui-linkbutton"
						data-options="iconCls:'icon-ok',plain:true"
						href="javascript:void(0)" onclick="modifyvmname()"
						style="width: 80px">确定</a>&nbsp;&nbsp;&nbsp; <a
						class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel',plain:true"
						href="javascript:void(0)"
						onclick="$('#modifyvmname').dialog('close')" style="width: 80px">取消</a>
				</div>
		</form>
	</div>
</body>
<%-- <jsp:include page="createInstances_basicConfig.jsp"></jsp:include> --%>
<%-- <jsp:include page="createInstances_networkConfig.jsp"></jsp:include> --%>
<%-- <jsp:include page="createInstances_basicInfo.jsp"></jsp:include> --%>
<%-- <jsp:include page="createInstances_success.jsp"></jsp:include> --%>
<%-- <jsp:include page="ip_port_config.jsp"></jsp:include> --%>
<%-- <jsp:include page="ip_port_success.jsp"></jsp:include> --%>