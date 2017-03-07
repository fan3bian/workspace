<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
	<style type="text/css">
select {
	width: 8%;
	height: 30px;
}

.FieldInput3 {
	width: 12%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}

.FieldLabel3 {
	width: 8%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>
	<script type="text/javascript">
		var grid;
		var snmpTollbar = [ {
			text : '新增SNMP主机',
			iconCls : 'icon-add',
			handler : function() {
			
				$('#snmpCreateForm').form('clear');
			
				//初始化
				$('#mode').combobox('setValue', '3');
				$('#version').combobox('setValue', '1');
				$('#access').combobox('setValue', '1');
				
				//显示ip地址填框
				$("#ipAddr" ).css("display", "block");
				$("#ipRange" ).css("display", "none");
				$("#ipMask" ).css("display", "none"); 
				
				//显示团体字 权限
				$("#community").textbox("enable");
				$("#access").combobox("enable");
				
				$('#snmpAddDialog').attr('style', 'visibility:visible');
				$('#snmpAddDialog').window('open');
				
			}
		} ];
		$(document).ready(function() {
			snmpLoadDataGrid();
			$('.j-link-add').linkbutton({
				plain : true,
				iconCls : 'icon-add'
			});

			$('.j-toggle li').bind('click', function(event) {
				$(this).addClass('active').siblings().removeClass('active');
			});
			$(".j-multiple li").unbind("click");
			$(".j-multiple li").click(function() {
				$(this).toggleClass('active');
			});

		});
		//查询结果
		function snmpLoadDataGrid() {
			grid = $('#snmp_grid')
					.datagrid(
							{
								singleSelect : true,
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : snmpTollbar,
								queryParams : {
									securityid : $("#tabs_security_id").val()
								},
								url : '${pageContext.request.contextPath}/security/querySnmpList.do',
								onLoadSuccess : function(data) {
									var pageopt = $('#snmp_grid').datagrid(	'getPager').data("pagination").options;
									var _pageSize = pageopt.pageSize;
									var _rows = $('#snmp_grid').datagrid("getRows").length;
									var total = pageopt.total; //显示的查询的总数
									if (_pageSize >= 10) {
										for (i = 10; i > _rows; i--) {
											$(this).datagrid('appendRow', {
												operation : ''
											});
										}
										$('#snmp_grid')
												.datagrid('getPager')
												.pagination('refresh', { // 改变选项，并刷新分页栏-条数信息
													total : total,
												});
									} else {
										$(this).closest('div.datagrid-wrap')
												.find('div.datagrid-pager')
												.show();
									}
									
									

									$('#snmpAddDialog').dialog(
											{
														title : "新增SNMP主机",
														height : 500,
														closed : true,
														modal : true,
														collapsible : false,
														minimizable : false,
														maximizable : false,
														resizable : false,
														buttons : [
																{
																	text : '提交',
																	iconCls : 'icon-ok',
																	handler : function() {
																		addSnmpHost();
																	}
																},
																{
																	text : '取消',
																	iconCls : 'icon-cancel',
																	handler : function() {
																		$('#snmpAddDialog').dialog('close');
																	}
																} ]
													});
									$('#snmpUpdateDialog').dialog(
													{
														title : "修改SNMP主机",
														width : 450,
														height : 500,
														closed : true,
														modal : true,
														collapsible : false,
														minimizable : false,
														maximizable : false,
														resizable : false,
														buttons : [
																{
																	text : '提交',
																	iconCls : 'icon-ok',
																	handler : function() {
																		updateSnmpHost();
																	}
																},
																{
																	text : '取消',
																	iconCls : 'icon-cancel',
																	handler : function() {
																		$('#snmpUpdateDialog').dialog('close');
																	}
																} ]
													});
									$('.j-open').linkbutton({
										iconCls : 'icon-open',
										plain : true
									});
									$('.j-close').linkbutton({
										iconCls : 'icon-close',
										plain : true
									});
									$('.j-delete').linkbutton({
										iconCls : 'icon-delete',
										plain : true
									});
									$('.j-modify').linkbutton({
										iconCls : 'icon-modify',
										plain : true
									});
								}
							});
		}
		
		//IP 版本格式化
		function versionFormatter(value,row,index)
		{
			if(!value){return "";}
			if(value=='0')
				return "V1";
			if(value=='1')
				return "V2C";
			if(value=='3')
				return "V3";
		}
		//IP类型格式化
		function modeFormatter(value,row,index)
		{
			if(!value){return "";}
			if(value=='1')
				return "IP/掩码";
			if(value=='2')
				return "IP范围";
			if(value=='3')
				return "IP地址";
		}
		
		//权限格式化
		function accessFormatter(value,row,index)
		{
			if(!value){return "";}
			if(row.snmpversion=='3'){return "";}
			if(value=='1')
				return "只读";
			if(value=='2')
				return "可写";
		}
		
		//操作列格式化
		function snmpOperatorFormatter(value, row, index) {
			if (!value) {
				return "";
			}
			var str = "";
			str += "<a href=\"javascript:void(0);\"  class=\"j-modify\" onclick=\"getSnmpHost(\'"
					+ row.snmphostid + "\',\'"+ row.hosttype + "\',\'"
					+ row.host + "\',\'" + row.snmpversion + "\',\'"
					+ row.groupwords + "\',\'" + row.permissions + "\');\" title=\"修改\"></a>&nbsp;|&nbsp;"
					
					+ "<a href=\"javascript:void(0);\"  class=\"j-delete\" onclick=\"deleteSnmpHost(\'"
					+ row.snmphostid + "\',\'" + row.hosttype + "\',\'"
					+ row.host + "\',\'" + row.snmpversion + "\',\'"
					+ row.groupwords + "\',\'" + row.permissions + "\');\" title=\"删除\"></a>";
			return str;
		}
		//获取单记录信息展示
		function getSnmpHost(snmphostid,hosttype,host,snmpversion,groupwords,permissions) {
			
			$('#snmpUpdateForm').form('clear');
			$("#snmphostid").textbox('setValue',snmphostid);
			$('#hostnameUpdate').html(host);
			if(hosttype=='1'){
				$('#modeUpdate').html('IP/掩码');
			}else if(hosttype=='2'){
				$('#modeUpdate').html('IP范围');
			}else if(hosttype=='3'){
				$('#modeUpdate').html('IP地址');
			}
			
			$('#versionUpdate').combobox('setValue',snmpversion); 
			if(snmpversion=='3')
			{
				$("#communityUpdate").textbox("disable");
				$("#accessUpdate").combobox("disable");
			}else{
				$("#communityUpdate").textbox("enable");
				$("#accessUpdate").combobox("enable");
				$("#communityUpdate").textbox('setValue',groupwords);
				$('#accessUpdate').combobox('setValue',permissions); 
			}
			
			$('#snmpUpdateDialog').attr('style', 'visibility:visible');
			$('#snmpUpdateDialog').window('open');
			
		}
		//修改配置信息保存
		function updateSnmpHost() {
			
			var access = $('#accessUpdate').combobox('getValue');
			var version = $('#versionUpdate').combobox('getValue');
			var mode = $("#modeUpdate").text();
			var hostname = $("#hostnameUpdate").text();
			var community = $("#communityUpdate").val();
			var snmphostid = $("#snmphostid").val();
			
			if(mode=="IP地址"){
				mode="3";
			}else if(mode=="IP范围"){
				mode="2";
			}else if(mode=="IP/掩码"){
				mode="1";
			}

			
			$('#snmpUpdateForm')
					.form('submit',{
								url : "${pageContext.request.contextPath}/security/updateSnmpHost.do",
								onSubmit : function(param) {
									param.securityid = $("#tabs_security_id").val();
									param.objectid = $("#tabs_object_id").val();
									param.displayname = $("#tabs_displayname").val();
									param.manip = $("#tabs_manip").val();
									param.snmphostid = snmphostid;
									
									param.mode = mode;
									param.access = access;
									param.version = version;
									param.hostname = hostname;
									param.community = community;
									
									
								},
								success : function(retr) {
									var data = $.parseJSON(retr);
									if (data.success) {
										snmpLoadDataGrid();
									} else {
										$.messager.alert('提示信息', '更新信息发生错误，请重试！','error');
									}
									$('#snmpUpdateDialog').window('close');
								}

							});
		}
		
		//单记录删除
		function deleteSnmpHost(snmphostid,hosttype,host,snmpversion,groupwords,permissions) {
			$.messager
					.confirm(
							'提示',
							'SNMP主机配置一经删除将不可恢复，删除后该主机将不再采集到当前云防火墙各种指标数据，您确定要执行此操作吗？',
							function(r) {
								if (r) {
									$('#snmpMainForm').form('submit',
													{
														url : '${pageContext.request.contextPath}/security/delSnmpHost.do',
														onSubmit : function(param) {
															param.securityid = $("#tabs_security_id").val();
															param.objectid = $("#tabs_object_id").val();
															param.displayname = $("#tabs_displayname").val();
															param.manip = $("#tabs_manip").val();
															
															param.snmphostid = snmphostid;
															param.mode = hosttype;
															param.access = permissions;
															param.version = snmpversion;
															param.hostname = host;
															param.community = groupwords;
															
														},
														success : function(retr) {
															var _data = $.parseJSON(retr);
															if (_data.success) {
																snmpLoadDataGrid();
															} else {
																$.messager.alert('提示',"删除操作失败，请重试！",'error');
															}
														}
													});
								}
							});

		}

		//新增配置信息保存
		function addSnmpHost() {
			
			var mode = $('#mode').combobox('getValue');
			var access = $('#access').combobox('getValue');
			var version = $('#version').combobox('getValue');
			
			var ipAdd = $("#ipAdd").val();
			var ipStart = $("#ipStart").val();
			var ipEnd = $("#ipEnd").val();
			var maskOfIp = $("#maskOfIp").val();
			var mask = $("#mask").val();
			var community = $("#community").val();
			
			var hostname;
			
	
		//拼接hosname
			if (mode == '3') {
				if(ipAdd=="")
				{
					$.messager.alert('提示信息', 'IP地址不能为空，请重新填写！', 'error');
					return;
				}
				if (!isIP(ipAdd)) {
					$.messager.alert('提示信息', 'IP地址格式错误，请重新填写！', 'error');
					return;
				}
				hostname = ipAdd;
			} else if (mode == "2") {
				if(ipStart==""||ipEnd==""){
					$.messager.alert('提示信息', 'IP起始、终止地址不能为空，请重新填写', 'error');
					return;
				}
				if (isIP(ipStart) && isIP(ipEnd)) {
					if(_ip2int(ipStart)>=_ip2int(ipEnd)){
						$.messager.alert('提示信息', '终止IP地址不能小于起始IP地址', 'error');
						return;
					}
					
					hostname = ipStart + "-" + ipEnd;
				} else {
					$.messager.alert('提示信息', 'IP地址格式，请重新填写！', 'error');
					return;
				}
			} else if (mode == "1") {
			
				if(maskOfIp==""||mask==""){
					$.messager.alert('提示信息', 'IP或掩码不能为空，请重新填写', 'error');
					return;
				}
			
				if ( isIP(maskOfIp)&&( isIP(mask)||(mask > 0 && mask < 33))) {
					hostname = maskOfIp + "/" + mask;
				} else {
					$.messager.alert('提示信息', 'IP地址格式或掩码错误，请重新填写！', 'error');
					return;
				}
			}
			
			if(version!="3")
			{
				if(community=="")
				{
					$.messager.alert('提示信息', '团体字不能为空', 'error');
					return;
				}
			}

			$('#snmpCreateForm')
					.form('submit',
							{
								url : "${pageContext.request.contextPath}/security/savaSnmpHost.do",
								onSubmit : function(param) {
									param.securityid = $("#tabs_security_id").val();
									param.manip = $("#tabs_manip").val();
									//记录日志使用
									param.objectid = $("#tabs_object_id").val();
							    	param.displayname = $("#tabs_displayname").val();
									
									param.mode = mode;
									param.access = access;
									param.version = version;
									param.hostname = hostname;
									param.community = community;
								},
								success : function(retr) {
									var data = $.parseJSON(retr);
									if (data.success) {
										snmpLoadDataGrid();
									} else {
										$.messager.alert('提示信息', '保存发生错误，请重试！',
												'error');
									}
									$('#snmpAddDialog').window('close');
								}

							});
		}

		//选中类型 显示隐藏不同的主机地址框
		function setModeType(mode) {
			if (mode == '1') {
				$("#ipAddr").css("display", "none");
				$("#ipRange").css("display", "none");
				$("#ipMask").css("display", "block");
			}
			if (mode == '2') {
				$("#ipAddr").css("display", "none");
				$("#ipRange").css("display", "block");
				$("#ipMask").css("display", "none");
			}
			if (mode == '3') {
				$("#ipAddr").css("display", "block");
				$("#ipRange").css("display", "none");
				$("#ipMask").css("display", "none");
			}
		}

		//若版本是V3 隐藏团体字权限字段
		function setVersionType(version) {
			if (version == '3') {
				$("#community").textbox("disable");
				$("#access").combobox("disable");
				return;
			}

			$("#community").textbox("enable");
			$("#access").combobox("enable");
		}
		
		
		//若版本是V3 隐藏团体字权限字段-更新对话框
		function setVersionTypeUpdate(version) {
			if (version == '3') {
				$("#communityUpdate").textbox("disable");
				$("#accessUpdate").combobox("disable");
				return;
			}

			$("#communityUpdate").textbox("enable");
			$("#accessUpdate").combobox("enable");
		}

		//ip地址校验
		function isIP(ip) {
			var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/
			return re.test(ip);
		}
		//ip数字转换
		function _ip2int(ip) {
   			var num = 0;
   			ip = ip.split(".");
    		num = Number(ip[0]) * 256 * 256 * 256 + Number(ip[1]) * 256 * 256 + Number(ip[2]) * 256 + Number(ip[3]);
   		    num = num >>> 0;
    		return num;
		}
	</script>
	<form id="snmpMainForm"></form>
	<div data-options="region:'center',border:false">
		<table title="" style="width: 100%;" id="snmp_grid">
			<thead>
				<tr>
					<th data-options="field:'hosttype',width:8,align:'center',formatter:modeFormatter">类型</th>
					<th data-options="field:'host',width:20,align:'center'">主机</th>
					<th data-options="field:'snmpversion',width:10,align:'center',formatter:versionFormatter">SNMP版本</th>
					<th data-options="field:'permissions',width:10,align:'center',formatter:accessFormatter">权限</th>
					<th data-options="field:'snmphostid',width:10,align:'center',formatter:snmpOperatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="snmpAddDialog" class="pop" style="visibility: hidden">
		<div class="item-wrap" style="margin-bottom: 25px">
			<form id="snmpCreateForm" method="post"	data-options="novalidate:true">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
					<tr>
						<td align="right" width="30%">类型：</td>
						<td align="left" width="70%">
							<select id="mode" class="easyui-combobox"
								data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){setModeType(rec.value)}"
								style="width: 174px;">
								<option value="3">ip地址</option>
								<option value="2">ip范围</option>
								<option value="1">ip/掩码</option>
							</select>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">主机：</td>
						<td nowrap align="left" width="70%">
							<div id="ipAddr">
								<input type="text" id="ipAdd" class="easyui-textbox"
									style="width: 174px;" data-options="prompt:'请输入IP地址'">
							</div>
							<div id="ipRange">
								<input type="text" id="ipStart" class="easyui-textbox"
									style="width: 174px;" data-options="prompt:'起始IP'">&nbsp;-&nbsp;
								<input type="text" id="ipEnd" class="easyui-textbox"
									style="width: 174px;" data-options="prompt:'终止IP'">
							</div>
							<div id="ipMask">
								<input type="text" id="maskOfIp" class="easyui-textbox"
									style="width: 174px;" data-options="prompt:'IP地址'">&nbsp;/&nbsp;
								<input type="text" id="mask" class="easyui-textbox"
									style="width: 174px;" data-options="prompt:'网络掩码'">
							<div>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">SNMP版本：</td>
						<td align="left" width="70%">
							<select id="version" class="easyui-combobox"
								data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){setVersionType(rec.value)}"
								style="width: 174px;">
								<option value="0">V1</option>
								<option value="1">V2C</option>
								<option value="3">V3</option>
							</select>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">团体字：</td>
						<td align="left" width="70%">
							<input type="text" id="community" class="easyui-textbox" style="width: 174px;"><lable>&nbsp;&nbsp;(1-31字符)</lable>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">权限：</td>
						<td align="left" width="70%">
							<select id="access"	class="easyui-combobox" data-options="panelHeight:'auto',width:140,editable:false"
								style="width: 174px;">
								<option value="1">只读</option>
								<option value="2">可写</option>
							</select>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>


	<div id="snmpUpdateDialog" class="pop" style="visibility: hidden;">

		<div class="item-wrap" style="margin-bottom: 25px">
			<form id="snmpUpdateForm" method="post"	data-options="novalidate:true">
				<input id="snmphostid" type="hidden" class="easyui-textbox">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
					<tr>
						<td align="right" width="30%">类型：</td>
						<td align="left" width="70%">
							<lable id="modeUpdate"/>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">主机：</td>
						<td nowrap align="left" width="70%">
							<lable id="hostnameUpdate"/>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">SNMP版本：</td>
						<td align="left" width="70%">
							<select id="versionUpdate" class="easyui-combobox"
								data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){setVersionTypeUpdate(rec.value)}"
								style="width: 174px;">
								<option value="0">V1</option>
								<option value="1">V2C</option>
								<option value="3">V3</option>
							</select>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">团体字：</td>
						<td align="left" width="70%">
							<input type="text" id="communityUpdate" class="easyui-textbox" style="width: 174px;"><lable>&nbsp;&nbsp;(1-31字符)</lable>
						</td>
					</tr>

					<tr>
						<td align="right" width="30%">权限：</td>
						<td align="left" width="70%">
							<select id="accessUpdate"	class="easyui-combobox" data-options="panelHeight:'auto',width:140,editable:false"
								style="width: 174px;">
								<option value="1">只读</option>
								<option value="2">可写</option>
							</select>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>

