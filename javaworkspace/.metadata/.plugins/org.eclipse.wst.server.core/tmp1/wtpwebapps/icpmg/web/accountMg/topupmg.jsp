<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<style type="text/css">
.customer-product-close {
  position: absolute;
  top: 50%;
  margin-top: -8px;
  height: 16px;
  overflow: hidden;
  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
}
.FieldInput2 {
	width: 75%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}

.FieldLabel2 {
	width: 25%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>
	<script type="text/javascript">
		var toolbar = [
				{
					text : '充值',
					iconCls : 'icon-add',
					handler : function() { 
						$("#windowaccountid").val('');
						$("#windowaccountname").val('');
						$("#windowauserid").val('');
						$("#windowadate").datetimebox('setValue', '');    
						$("#windowamoney").val('');
						$("#windowauser").val('');
						$("#windowausername").val('');
						$("#windowauserphone").val('');
						
						$("#windowapath").combobox('select','1');
						$('#window').window('open');
					}
				}];
		$(document).ready(function() {
			debugger;
			loadDataGrid();
			loadComboData();
			loaddatetimespinner();

		});
		function loaddatetimespinner()
		{
				$('#windowadate').datetimebox({    
    				required: true,    
    				showSeconds: true,
    				formatter:function(date)
    				{
    					var y = date.getFullYear();
						var m = date.getMonth()+1;
						if(m<10)
						{
							m='0'+m;
						}
						var d = date.getDate();
						if(d<10)
						{
							d='0'+d;
						}
						var h = date.getHours();
						if(h<10)
						{
							h='0'+h;
						}
						var mi = date.getMinutes();
						if(mi<10)
						{
							mi='0'+mi;
						}
						var s = date.getSeconds();
						if(s<10)
						{
							s='0'+s;
						}
						return y+'-'+m+'-'+d+' '+h+':'+mi+':'+s;
						//return y+'-'+m+'-'+d+' '+h+':'+mi+':'+s;
    					
    				}
    			  
				});
		}

		function loadComboData()
		{
			$('#windowapath').combobox({ 
				data: [{
					id: '1',
					name: '现金'
				},{
					id: '2',
					name: '网银转账'
				},{
					id: '3',
					name: '支票'
				},{
					id: '4',
					name: '银行转账'
				},{
					id: '5',
					name: '汇票'
				},{
					id: '6',
					name: '其他'
				}],   
			    valueField:'id',    
			    textField:'name',
			}); 
			debugger;
			$("#windowapath").combobox('select','1');
		}
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'adate',
								sortOrder : 'desc',
								singleSelect : true,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/portal/topupList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#topup_searchform')));
			};
			function pathformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">现金</span>";
							case "2":
								return "<span style=\"color:green\">网银转账</span>";
							case "3":
								return "<span style=\"color:green\">支票</span>";
							case "4":
								return "<span style=\"color:green\">银行转账</span>";
							case "5":
								return "<span style=\"color:green\">汇票</span>";
							case "6":
								return "<span style=\"color:green\">其他</span>";
							}
							
			} 
			function isDouble(s) {
				var regu = "^([0-9]*)$";
				//var regu = "^([0-9]*[.0-9])$"; // 小数测试
				var re = new RegExp(regu);
				if (s.search(re) != -1)
				return true;
				else
				return false;
			}
			function submitSave()
			{
		 		$('#reportform').form('submit',{
			    url:'${pageContext.request.contextPath}/portal/saveTopup.do', 
			    onSubmit: function(){
			    	debugger;
			    	if($("#windowaccountid").attr("value")==null || $.trim($("#windowaccountid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"充值账户不能为空!");  
			    		return false;
			    	}
			    	if($("#windowadate").datetimebox('getValue')==null || $.trim($("#windowadate").datetimebox('getValue'))=="" )
			    	{
			    		$.messager.alert('消息',"充值时间不能为空!");  
			    		return false;
			    	}
			    	if($("#windowamoney").attr("value")==null || $.trim($("#windowamoney").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"充值金额不能为空!");  
			    		return false;
			    	}
			    	if(!isDouble($("#windowamoney").attr("value")))
			    	{
			    		$.messager.alert('消息',"充值金额必须为整数!");  
			    		return false;
			    	}
			    	if($("#windowauser").attr("value")==null || $.trim($("#windowauser").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"充值用户不能为空!");  
			    		return false;
			    	}
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#topup_searchform')));
						$('#window').window('close');
						$('#w').window('close');
			    	}
			    }
			});
			}
			function showSelectWin(type)
			{
				 $('#condiSearch').textbox({onClickButton:function()
				 {
				 	$('#condiSearchTable').datagrid('clearChecked');
				 	$('#condiSearchTable').datagrid('reload',{
							condiSearch: this.value,
							condi:type
							});
				 }});
				 $("#windowvalue").val(type);
				 condiSearchTableLoad(type);
				 $('#w').window('open');
			}
			function condiSearchTableLoad(type)
		{
			$('#condiSearchTable').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					nowarp:false,
					singleSelect:true,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					pagination:true,
					pageSize:5,
					pageList:[5,10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/portal/getCondiByCondi.do',
				     queryParams: {
						condi:type,
						condiSearch: $('#condiSearch').textbox('getValue'),
						puserid:$("#windowaccountid").val(),
					}
					}); 
		}
		function writeToInput()
		{
			var rows  = $('#condiSearchTable').datagrid('getSelections');
			if(rows.length!=1)
			{
			$.messager.alert('消息','请选择一项！'); 
					return;
			}
			debugger;
   			if('accountid'== $("#windowvalue").val())
   			{
   				$("#windowaccountid").val(rows[0].email);
   				$("#windowaccountname").val(rows[0].uname);
   				$("#windowauserid").val(rows[0].paras);
   			}else
   			{
   				$("#windowauser").val(rows[0].email);
   				$("#windowausername").val(rows[0].uname);
   				$("#windowauserphone").val(rows[0].paras);
   			}
            $('#condiSearchTable').datagrid('clearChecked');
   			$('#condiSearch').textbox('setValue','');
            $('#condiSearch').textbox('setText','');
			$('#w').window('close');
		}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="topup_searchform">
				<table>
					<tr>
						<td>充值账户：<input class="easyui-textbox" name="accountid"
							id="searchaccountid" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#topup_searchform input').val('');$('#searchaccountid').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'accountid',width:60,align:'center'">充值账户</th>
						<th data-options="field:'accountname',width:40,align:'center'">账户名称</th>
						<th data-options="field:'auserid',width:60,align:'center'">所属用户</th>
						<th data-options="field:'adate',width:80,align:'center'">充值时间</th>
						<th data-options="field:'amoney',width:60,align:'center'">充值金额</th>
						<th data-options="field:'apath',width:60,align:'center',formatter:pathformater">充值方式</th>
						<th data-options="field:'auser',width:60,align:'center'">充值用户编码</th>
						<th data-options="field:'ausername',width:60,align:'center'">充值用户名称</th>
						<th data-options="field:'auserphone',width:60,align:'center'">充值用户电话</th>
						<th data-options="field:'muser',width:60,align:'center'">操作人</th>
						<th data-options="field:'mtime',width:80,align:'center'">记录时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="账户充值" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:410px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="reportform" method="post" enctype="multipart/form-data">
						<table align="center" style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									充值账户：</td>
								<td class="FieldInput2"><input id="windowaccountid" name="accountid" style="height:30px;width:200px" readonly /><font color="red">*</font>
								<a href="#" id="searchuser" onClick="javascript:showSelectWin('accountid');" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									账户名称：</td>
								<td class="FieldInput2"><input id="windowaccountname" name="accountname" style="height:30px;width:200px" readonly /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									所属用户：</td>
								<td class="FieldInput2"><input id="windowauserid" name="auserid" style="height:30px;width:200px" readonly /><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									充值时间：</td>
								<td class="FieldInput2"><input id="windowadate" name="adate" style="height:30px;width:200px"/><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									充值金额：</td>
								<td class="FieldInput2"><input id="windowamoney" name="amoney" style="height:30px;width:200px" type="text" />元<font color="red">*</font>
								
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									充值方式：</td>
								<td class="FieldInput2"><input id="windowapath" name="apath" style="height:30px;width:200px" /></td>

							</tr>
								<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									充值用户编码：</td>
								<td class="FieldInput2"><input id="windowauser" name="auser" style="height:30px;width:200px" readonly /><font color="red">*</font>
								<a href="#" id="searchuser" onClick="javascript:showSelectWin('auser');" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a></td>
							</tr>
							</tr>
								<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									充值用户名称：</td>
								<td class="FieldInput2"><input id="windowausername" name="ausername" style="height:30px;width:200px" readonly /><font color="red">*</font>
								</td>
							</tr>
							</tr>
								<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									充值用户电话：</td>
								<td class="FieldInput2"><input id="windowauserphone" name="auserphone" style="height:30px;width:200px"/><font color="red">*</font>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false"
					style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitSave();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="$('#window').window('close');$('#w').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
		<div id="w" class="easyui-window" title="条件查询" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:250px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<input id ="windowvalue"  type="hidden" value="" >
				<div data-options="region:'center'" style="padding:10px;">
					<table class="">
							<tr>
								<td><input id ="condiSearch" class="easyui-textbox" data-options="buttonIcon:'icon-search'" style="width:150px"> 
								</td>
							</tr>
					</table>
					<table id="condiSearchTable" title="" style="width:95%;" data-options="">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'email',width:30,align:'center'">编码</th>
							<th data-options="field:'uname',width:30,align:'center'">名称</th>
							<th data-options="field:'paras',width:30,align:'center',hidden:true">名称</th>
						</tr>
					</thead>
				</table>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="writeToInput();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#condiSearch').textbox('setValue','');$('#condiSearch').textbox('setText','');$('#w').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
</body>

