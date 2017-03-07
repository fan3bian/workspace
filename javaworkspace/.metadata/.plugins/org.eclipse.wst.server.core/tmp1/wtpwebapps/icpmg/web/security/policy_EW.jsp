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
		var policyEwtoolbar = [ {
			text : '新增安全策略',
			iconCls : 'icon-add',
			handler : function() {
				$('#policyEwCreateForm').form('clear');

				//初始化
				
				$('#protocal').textbox('setValue', 'All').textbox('setText','All');
				$('#port').textbox('setValue', 'All').textbox('setText','All');
				$('#policyEww').attr('style', 'visibility:visible');
				$("#porder1Ew").val("");
				$('#policyEww').window('open');
				
			}
		} ];
		$(document).ready(function() {
			policyEwloadDataGrid();
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
		function policyEwloadDataGrid() {
			grid = $('#policyEw_grid')
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
								toolbar : policyEwtoolbar,
								queryParams : {
									securityid : $("#tabs_security_id").val()
								},
								url : '${pageContext.request.contextPath}/security/queryPolicyEwList.do',
								onLoadSuccess : function(data) {
									var pageopt = $('#policyEw_grid').datagrid(	'getPager').data("pagination").options;
									var _pageSize = pageopt.pageSize;
									var _rows = $('#policyEw_grid').datagrid("getRows").length;
									var total = pageopt.total; //显示的查询的总数
									if (_pageSize >= 10) {
										for (i = 10; i > _rows; i--) {
											$(this).datagrid('appendRow', {
												operation : ''
											});
										}
										$('#policyEw_grid')
												.datagrid('getPager')
												.pagination('refresh', { // 改变选项，并刷新分页栏-条数信息
													total : total,
												});
									} else {
										$(this).closest('div.datagrid-wrap')
												.find('div.datagrid-pager')
												.show();
									}

									$('#policyEww').dialog(
											{
														title : "新增安全策略",
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
																		addpolicyEw();
																	}
																},
																{
																	text : '取消',
																	iconCls : 'icon-cancel',
																	handler : function() {
																		$('#policyEww').dialog('close');
																	}
																} ]
													});
									$('#policyEww1').dialog(
													{
														title : "修改安全策略",
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
																		editpolicyEw();
																	}
																},
																{
																	text : '取消',
																	iconCls : 'icon-cancel',
																	handler : function() {
																		$('#policyEww1').dialog('close');
																	}
																} ]
													});
									// 弹层选择地址
									$('#addrwEw').dialog({
										title : "选择地址",
										width : 500,
										height : 300,
										closed : true,
										modal : true,
										collapsible : false,
										minimizable : false,
										maximizable : false,
										resizable : false,
										buttons : [ {
											text : '提交',
											iconCls : 'icon-ok',
											handler : function() {
												policyEwAddrFill();//内容回填
												$('#addrwEw').dialog('close');
											}
										}, {
											text : '取消',
											iconCls : 'icon-cancel',
											handler : function() {
												$('#addrwEw').dialog('close');

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
		//行为属性格式化
		function policyEwbeformatter(value, row, index) {
			var str = "";
			if(value == '1'){
				str = "拒绝";
			}else if(value == '2'){
				str = "允许";
			}
			else if(value == '5'){
				str = "安全链接";
			}
			return str;
		}
		//状态属性格式化
		function policyEwpsformatter(value, row, index) {
			var str = "";
			if (value == '1') {
				str = "在用";
			} else if (value == '0') {
				str = "停用";
			}
			return str;
		}
		
		function displayAllStr(value, row, index) {
			if(value){
				return "All";
			}
		}
		//操作列格式化
		function fwEwoptionformatter(value, row, index) {
			if (!value) {
				return "";
			}
			var str = "";
			if (row.pstatus == "0") {
				str = "<a href=\"javascript:void(0);\" class=\"j-open\" onclick=\"policyEweditstatus(\'1\',\'"
						+ row.policyid + "\');\"  title=\"启用\"></a>";
			} else if (row.pstatus == "1") {
				str = "<a href=\"javascript:void(0);\" class=\"j-close\" onclick=\"policyEweditstatus(\'0\',\'"
						+ row.policyid + "\');\" title=\"停用\"></a>";
			}

			str += "&nbsp;|&nbsp;<a href=\"javascript:void(0);\"  class=\"j-modify\" onclick=\"getpolicyEw(\'"
					+ row.policyid
					+ "\',\'"
					+ row.policyname
					+ "\',\'"
					+ row.behavior
					+ "\',\'"
					+ row.sdomainid
					+ "\',\'"
					+ row.ddomainid
					+ "\',\'"
					+ row.saddrstr
					+ "\',\'"
					+ row.saddrstrv
					+ "\',\'"
					+ row.daddrstr
					+ "\',\'"
					+ row.daddrstrv
					+ "\',\'"
					+ row.description
					+ "\',\'"
					+ row.logdeny
					+ "\',\'"
					+ row.logstart
					+ "\',\'"
					+ row.logend
					+ "\',\'"
					+ row.seqno
					+ "\');\" title=\"修改\"></a>&nbsp;|&nbsp;"
					+ "<a href=\"javascript:void(0);\"  class=\"j-delete\" onclick=\"policyEwdelbefore(\'"
					+ row.policyid + "\' );\" title=\"删除\"></a>";
			return str;
		}
		//获取单记录信息展示
		function getpolicyEw(policyid, policyname, behavior, sdomainid,
				ddomainid, saddrstr, saddrstrv, daddrstr, daddrstrv,
				description, logdeny, logstart, logend, seqno) {
			$('#policyEwCreateForm1').form('clear');
			
			$('#policyidEw1').val(policyid);
			$('#policyEwname1').textbox('setValue', policyname).textbox('setText', policyname);
			if(behavior==1){  //2:允许  1：拒绝
				$('#behaviorEw1').removeClass('active');
				$('#behaviorEw1_1').addClass('active');
			}else{
				$('#behaviorEw1_1').removeClass('active');
				$('#behaviorEw1').addClass('active');
			}
			
			$('#protocalEw').textbox('setValue', 'All').textbox('setText','All');
			$('#portEw').textbox('setValue', 'All').textbox('setText','All');
			
			 $("#saddrEw1").val(saddrstrv);
			 $('#saddrnameEw1').textbox('setValue', saddrstr).textbox('setText', saddrstr);
			 
			$('#c').textbox('setValue', 'All').textbox('setText','All');
			$('#portEw').textbox('setValue', 'All').textbox('setText','All');

			$('#policyEww1').attr('style', 'visibility:visible');
			$('#policyEww1').window('open');
		}
		//修改配置信息保存
		function editpolicyEw() {
			
			var behaviorStr = "";
			var policyid = $("#policyidEw1").val();
			
			var behavior_flag = $("#behaviorEw1").hasClass("active");
			if(behavior_flag){
				behaviorStr = 2; //行为:允许
			}else{
				behaviorStr = 1; //行为：拒绝
			}
			
			var saddr = $("#saddrEw1").val();
			
			
			if(saddr == null || saddr == ""){
				$.messager.alert('提示信息','源地址不可为空！', 'info');
				return;
			}

			
			$('#policyEwCreateForm1')
					.form(
							'submit',
							{
								url : "${pageContext.request.contextPath}/security/updatePolicyEw.do",
								onSubmit : function(param) {
									param.securityid = $("#tabs_security_id").val();
									param.objectid = $("#tabs_service_id").val();
									param.displayname = $("#tabs_displayname").val();
									param.manip = $("#tabs_manip").val();
									param.policyid = policyid;
									param.sdomainid = "Any";
									param.ddomainid = "Any";
									param.behavior = behaviorStr;
									param.saddr = saddr;
									
									param.protocal = "All";
									param.port="All";
									param.porder1 = "last";	//默认列表最前
									
									param.logdeny = "1";					//日志默认全部打开
									param.logstart = "1";					
									param.logend = "1"; 
									
									param.daddr = "0,Any";	
									
									param.description = "";
									param.policyname = "";    
									param.porder = "";
								},
								success : function(retr) {
									var data = $.parseJSON(retr);
									if (data.success) {
										policyEwloadDataGrid();
									} else {
										$.messager.alert('提示信息', '保存发生错误，请重试！','error');
									}
									$('#policyEww1').window('close');
								}

							});
		}
		//单记录修改状态
		function policyEweditstatus(pstatus, policyid) {
			$('#policyEwManForm')
					.form(
							'submit',
							{
								url : '${pageContext.request.contextPath}/security/updatePolicyEwStatus.do',
								onSubmit : function(param) {
									param.securityid = $("#tabs_security_id").val();
									param.objectid = $("#tabs_service_id").val();
									param.displayname = $("#tabs_displayname").val();
									param.manip = $("#tabs_manip").val();
									param.policyid = policyid;
									param.pstatus = pstatus;
								},
								success : function(retr) {
									var _data = $.parseJSON(retr);
									if (_data.success) {
										debugger;
										policyEwloadDataGrid();
									} else {
										$.messager.alert('提示', "状态修改操作失败，请重试！",'error');
									}
								}
							});
		}
		//单记录删除
		function policyEwdelbefore(policyid) {
			$.messager
					.confirm(
							'系统提示信息',
							'当前策略删除后不可恢复，请谨慎操作，确定删除吗？',
							function(r) {
								if (r) {
									$('#policyEwManForm').form('submit',
													{
														url : '${pageContext.request.contextPath}/security/delPolicyEw.do',
														onSubmit : function(param) {
															param.securityid = $("#tabs_security_id").val();
															param.objectid = $("#tabs_service_id").val();
															param.displayname = $("#tabs_displayname").val();
															param.manip = $("#tabs_manip").val();
															param.policyid = policyid;
														},
														success : function(retr) {
															var _data = $.parseJSON(retr);
															if (_data.success) {
																policyEwloadDataGrid();
															} else {
																$.messager.alert('提示',"删除操作失败，请重试！",'error');
															}
														}
													});
								}
							});

		}
		//转换seqno
		function changeseqno(porder1, porder2) {
			var policyId = 0;
			var seqno = parseInt(0x00000);
			switch (porder1) {
			case 'front':
				seqno = parseInt(0x10000);
				policyId = 0;
				break;
			case 'last':
				seqno = parseInt(0x00000);
				policyId = 0;
				break;
			case 'befor':
				seqno = parseInt(0x20000);
				policyId = porder2;
				break;
			case 'after':
				seqno = parseInt(0x30000);
				policyId = porder2;
				break;
			}
			return seqno += parseInt(policyId);
		}
		//新增配置信息保存
		function addpolicyEw() {
			
			
			var behaviorStr = "";
			var behavior_flag = $("#behavior").hasClass("active");
			if(behavior_flag){
				behaviorStr = 2; //行为:允许
			}else{
				behaviorStr = 1; //行为：拒绝
			}
			
			var saddr = $("#saddrEw").val();
			
			if(saddr == null || saddr == ""){
				$.messager.alert('提示信息','源地址不可为空！', 'info');
				return;
			}

			$('#policyEwCreateForm')
					.form('submit',
							{
								url : "${pageContext.request.contextPath}/security/savePolicyEw.do",
								onSubmit : function(param) {
									param.securityid = $("#tabs_security_id").val();
									param.objectid = $("#tabs_service_id").val();
									param.displayname = $("#tabs_displayname").val();
									param.manip = $("#tabs_manip").val();
									
									param.sdomainid = "Any";
									param.ddomainid = "Any";
									
									param.behavior = behaviorStr;
									param.saddr = saddr;
									param.protocal = "All";
									param.port="All";
									param.porder1 = "last";	//默认列表最前
									
									param.logdeny = "1";					//日志默认全部打开
									param.logstart = "1";					
									param.logend = "1"; 
									
									param.daddr = "0,Any";	
									
									param.description = "";
									param.policyname = "";    
									param.porder = "";
									
	        
									
								},
								success : function(retr) {
									var data = $.parseJSON(retr);
									if (data.success) {
										policyEwloadDataGrid();
									} else {
										$.messager.alert('提示信息', '保存发生错误，请重试！','error');
									}
									$('#policyEww').window('close');
								}

							});
		}
		//源、目的地址后选择按钮
		function policyEwchooseaddr(oper, type) {
			//先清空
			$('#addrEwCreateForm').form('clear');
			$("#Ewdata_  tr:not(:first)").remove();

			//再赋值
			var temp = "";
			if (oper == 'edit') {
				temp = "1";
			}
			var str = $("#" + type + "addrEw" + temp).val();
			var strname = $("#" + type + "addrnameEw" + temp).val();//页面展示转换后信息
			var strArr = str.split(";");
			var strname_arr = strname.split(",");
			for (var i = 0; i < strArr.length - 1; i++) {
				var sArr = strArr[i].split(",");
				var contypeid = sArr[0];
				var contypename = "";
				 if ("0" == sArr[0]) {
					contypename = "地址簿";
					var val = sArr[1];
				} else  if ("1" == sArr[0]) {
					contypename = "IP/掩码";
					var val = strname_arr[i];
				} else if ("2" == sArr[0]) {
					contypename = "IP范围";
					var val = sArr[1];
				}

				var trHtml = "<tr class='tr'><td  style='display:none;'>"
						+ contypeid
						+ "</td><td  style='text-align:center;width:5%;'>"
						+ contypename
						+ "</td><td  style='text-align:center;width:15%;'>"
						+ val
						+ "</td><td  style='text-align:center;width:5%;'><a class='j-delete'  style='cursor: pointer;' onclick='policyEwdeladdr(this.parentElement.parentElement.rowIndex)'></a></td></tr>";
				var $tr = $("#Ewdata_ tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
				$tr.after(trHtml);
			}

			$('#oper').val(oper);//操作，add/edit
			$('#type').val(type);//地址类型，s/d
			$('.j-delete').linkbutton({
				iconCls : 'icon-delete',
				plain : true
			});

			/*打开页面*/
			$('#addrwEw').window('open');
		}
		//所有地址回填
		function policyEwAddrFill() {
			var addrstr = '';
			var addrstrv = '';
			$("#Ewdata_ .tr").each(
					function() {
						addrstr += $(this).children().eq(2).text() + ",";
						addrstrv += $(this).children().eq(0).text() + ","
								+ $(this).children().eq(2).text() + ";";
					});
			addrstr = addrstr.substring(0, addrstr.length - 1);

			var temp = "";
			if ($('#oper').val() == 'edit') {
				temp = "1";
			}

			if ($('#type').val() == "s") {
				$("#saddrEw" + temp).val(addrstrv);
				$("#saddrnameEw" + temp).textbox('setValue', addrstr).textbox('setText', addrstr);
			} else if ($('#type').val() == "d") {
				$("#daddrEw" + temp).val(addrstrv);
				$("#daddrnameEw" + temp).textbox('setValue', addrstr).textbox('setText', addrstr);
			}
			$('#addrwEw').window('close');
		}
		//地址添加
		function policyEwaddaddr(contypeid, contypename) {
			var val = "";
			/* sif ('0' == contypeid) {
				val = $('#1contype0Ew').val();
			}  */ 
			

		if ('1' == contypeid) {
				val = $('#0contype1').textbox('getValue') + '/'
						+ $('#1contype1').textbox('getValue');
			} else if ('2' == contypeid) {
				val = $('#0contype2').textbox('getValue') + '-'
						+ $('#1contype2').textbox('getValue');
			}

			if (val.length <= 1) {
				return;
			}

			var trHtml = "<tr class='tr'><td  style='display:none;'>"
					+ contypeid
					+ "</td><td  style='text-align:center;width:5%;'>"
					+ contypename
					+ "</td><td style='text-align:center;width:15%;'>"
					+ val
					+ "</td><td  style='text-align:center;width:5%;'><a class='j-delete'  style='cursor: pointer;' onclick='policyEwdeladdr(this.parentElement.parentElement.rowIndex)'></a></td></tr>";
			var $tr = $("#Ewdata_ tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
			$tr.after(trHtml);
			$('.j-delete').linkbutton({
				iconCls : 'icon-delete',
				plain : true
			});
		}
		//地址删除
		function policyEwdeladdr(rowIndex) {
			document.getElementById("Ewdata_").deleteRow(rowIndex);
		}
		
	</script>
	<form id="policyEwManForm"></form>
	<div data-options="region:'center',border:false">
		<table title="" style="width: 100%;" id="policyEw_grid">
			<thead>
				<tr>
					<th data-options="field:'policyid',width:8,align:'center'">ID</th>
					<th data-options="field:'saddrstr',width:20,align:'center'">源地址</th>
					<th data-options="field:'mtime',width:10,align:'center',formatter:displayAllStr">协议</th>
					<th data-options="field:'muserid',width:10,align:'center',formatter:displayAllStr">端口</th>
					<th	data-options="field:'behavior',width:10,align:'center',formatter:policyEwbeformatter">行为</th>
					<th data-options="field:'pstatus',width:10,align:'center',formatter:policyEwpsformatter">状态</th>
					<th data-options="field:'securityid',width:10,align:'center',formatter:fwEwoptionformatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="policyEww" class="pop" style="visibility: hidden">
		<div class="item-wrap" style="margin-bottom: 25px">
            <div class="item2" >
                <div class="item-wrap" >
					<form id="policyEwCreateForm" method="post"
						data-options="novalidate:true">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="table-layout">
							<tr>
								<td align="right" width="30%">源地址：</td>
								<td align="left" width="70%"><input type="hidden"
									id="saddrEw" /> <input id="saddrnameEw" type="text"
									class="easyui-textbox" style="width: 174px;"
									data-options="editable:false"> <span
									style="position: relative; top: 4px; left: 8px; cursor: pointer;"><img
										onclick="policyEwchooseaddr('add', 's');"
										src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span></td>
							</tr>


							<tr>
								<td align="right" width="30%">协议：</td>
								<td align="left" width="70%">
								
								<input type="text" id="protocal"
									class="easyui-textbox" style="width: 174px;"
									data-options="editable:false"  disabled="disabled" value="All" > 
								</td>
							</tr>

							<tr>
								<td align="right" width="30%">端口：</td>
								<td align="left" width="70%"><input type="text" id="port"
									class="easyui-textbox" style="width: 174px;"
									data-options="editable:false"  disabled="disabled" value="All" > 
								</td></td>
							</tr>

							<tr>
								<td align="right" width="30%">行为：</td>
								<td id="beha" align="left" width="70%">
									<ul class="item-ul j-toggle">
										<li id="behavior" class="active" style="padding:0 5px">允许</li>
										<li id="behavior_1"style="padding:0 5px">拒绝</li>
									</ul>
								</td>
							</tr>

						</table>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div id="addrwEw" class="pop">
		<div class="item3">
			<form id="addrEwCreateForm" method="post"
				data-options="novalidate:true">
				<input type="hidden" id="oper" /> <input type="hidden" id="type" />
				<table class="table-layout">
                <tr>
                    <td>配置类型：</td>
                    <td>
                       <select id="addrcontype" class="easyui-combobox"  data-options="panelHeight:'auto',width:80,editable:false,onSelect: 
							function(rec){
							for(var i=0; i<3; i++){
								document.getElementById('contype' + i).style.display='none';
							}
							document.getElementById('contype' + rec.value).style.display=''; 
					    	}">
						<!-- <option value="0">地址簿</option> -->
						<option value="1">IP/掩码</option>
						<option value="2">IP范围</option>
						</select>
                    </td>
                    <td>
                       <div id="contype0" style="display:none;">
							<input type="hidden" id="1contype0"/>
							&nbsp;<select id="_cha" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#1contype0').val(rec.value);}">
								<option value="Any">Any</option>
							</select>
							&nbsp;<a class="j-link-add" href="javascript:void(0)" onclick="policyEwaddaddr('0', '地址簿');" style="width:50px" title="添加"></a>
						</div> 
						<div id="contype1" style="display:none;">
							&nbsp;<input id="0contype1" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;/&nbsp;<input id="1contype1" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;<a class="j-link-add" href="javascript:void(0)" onclick="policyEwaddaddr('1', 'IP/掩码');" style="width:50px" title="添加"></a>
						</div>
						<div id="contype2" style="display:none;">
							&nbsp;<input id="0contype2" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;-&nbsp;<input id="1contype2" class="easyui-textbox" style="width:100px;height:22px;"/>
							&nbsp;<a class="j-link-add" href="javascript:void(0)" onclick="policyEwaddaddr('2', 'IP范围');" style="width:50px" title="添加"></a>
						</div> 
                    </td>
                </tr>
            </table>
			</form>
		</div>
		<div class="panle" data-options="fit:true">
			<table id="Ewdata_" class="table-data">
				<tbody id="tb">
					<tr>
						<th scope="col" style="text-align: center; display: none;">类型编码</th>
						<th scope="col" style="text-align: center; width: 5%;">类型</th>
						<th scope="col" style="text-align: center; width: 15%;">成员</th>
						<th scope="col" style="text-align: center; width: 5%;">操作</th>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div id="policyEww1" class="pop" style="visibility: hidden;">

		<div class="item-wrap" style="margin-bottom: 25px">
            <div class="item2">
                <div class="item-wrap">
		<form id="policyEwCreateForm1" method="post"
			data-options="novalidate:true">
			<input type="hidden" id="policyidEw1" /> <input type="hidden"
				id="seqnoEw" />
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="table-layout">

				<tr>
					<td align="right" width="30%">源地址：</td>
					<td align="left" width="70%"><input type="hidden"
						id="saddrEw1" /> <input id="saddrnameEw1" type="text"
						class="easyui-textbox" style="width: 174px;"
						data-options="editable:false"> <span
						style="position: relative; top: 4px; left: 8px; cursor: pointer;"><img
							onclick="policyEwchooseaddr('edit', 's');"
							src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span></td>
				</tr>

				<tr>
					<td align="right" width="30%">协议：</td>
					<td align="left" width="70%"><input type="text" id="protocalEw"
									class="easyui-textbox" style="width: 174px;"
									data-options="editable:false"  disabled="disabled" value="All" > 
								</td>
					</tr>

					<tr>
						<td align="right" width="30%">端口：</td>
						<td align="left" width="70%"><input type="text" id="portEw"
									class="easyui-textbox" style="width: 174px;"
									data-options="editable:false"  disabled="disabled" value="All" ></td>
				</tr>

				<tr>
                    <td align="right" width="30%">行为：</td>
                        <td id="beha1" align="left" width="70%">
                            <ul class="item-ul j-toggle">
                                <li id="behaviorEw1" class="active" style="padding:0 5px">允许</li>
                                <li id="behaviorEw1_1" style="padding:0 5px">拒绝</li>
                            </ul>
                    </td>
                </tr>
			</table>
		</form>
		</div>
		</div>
		</div>
	</div>
</body>

