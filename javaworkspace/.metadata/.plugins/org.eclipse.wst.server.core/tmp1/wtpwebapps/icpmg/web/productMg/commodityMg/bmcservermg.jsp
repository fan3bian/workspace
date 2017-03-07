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
	width: 37%;
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
	width: 13%;
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
					text : '增加',
					iconCls : 'icon-add',
					handler : function() { 
						$("#windowflag").val('1');
						$("#windowshopid").val('');
						$("#windowshopname").val('');
						$("#windowisvalid").val('1');
						$("#isvalidcheck").attr("checked",true);	
						$("#windowimode").combobox('select','1');
						$("#windowcpunum").val('');
						$("#windowmemnum").val('');
						$("#windowdisknum").val('');
						$("#windowstrnum").val('');
						$("#windowosname").val('');
						$("#windowinterbw").val('');
						$("#windowtprice").val('');
						$("#windowiprice").val('');
						$("#windownotes").val('');
						$('#window').window('open');
					}
				},
				{
					text : '修改',
					iconCls : 'icon-modify',
					handler : function() {
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length!=1)
						{
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}
						
						//$("#windowstatus").val(rows[0].status);
						$("#windowflag").val('2');
						$("#windowshopid").val(rows[0].shopid);
						$("#windowshopname").val(rows[0].shopname);
						$("#windowimode").combobox('select',rows[0].imode);
						$("#windowcpunum").val(rows[0].cpunum);
						$("#windowmemnum").val(rows[0].memnum);
						$("#windowdisknum").val(rows[0].disknum);
						$("#windowstrnum").val(rows[0].strnum);
						$("#windowosname").val(rows[0].osname);
						$("#windowinterbw").val(rows[0].interbw);
						$("#windowtprice").val(rows[0].tprice);
						$("#windowiprice").val(rows[0].iprice);
						$("#windownotes").val(rows[0].notes);
						if(rows[0].isvalid=="1")
						{
							$("#isvalidcheck").attr("checked",true);
							$("#windowisvalid").val('1');
						}else
						{
							$("#isvalidcheck").attr("checked",false);	
							$("#windowisvalid").val('0');
						}
						
						$('#window').window('open');
					}
				},
				{
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
							var rows = $('#dg').datagrid('getChecked');
							if(rows.length<1)
							{
								$.messager.alert('消息','请至少选择一条记录！'); 
								return; 
							}
							
							var pids = "";
							 $.each(rows,function(index,object){
							 	pids+=object.shopid+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/product/delBmcserver.do',
			   				  		data:{pids:pids},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#bmcserver_searchform')));
								    		
								    	} 
			   				  		}
			   				  	});
			   				  }
			   				 });
						}
				},
				{
					text : '生成价格文件',
					iconCls : 'icon-print',
					handler : function() {
			   				 $.messager.confirm('确认','您确认想要生成价格文件吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/product/generateBmcserverFile.do',
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#bmcserver_searchform')));
								    		
								    	} 
			   				  		}
			   				  	});
			   				  }
			   				 });
						}
				}];
		$(document).ready(function() {
			
			loadDataGrid();
			loadComboData();
		});
		function loadComboData()
		{
			$('#windowimode').combobox({ 
				data: [{
					id: '1',
					name: '联通'
				},{
					id: '2',
					name: '电信'
				},{
					id: '3',
					name: '移动'
				},{
					id: '4',
					name: '双线'
				},{
					id: '5',
					name: '三线'
				}],   
			    valueField:'id',    
			    textField:'name'
			}); 
			
			$("#windowimode").combobox('select','1');
		}
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'shopid',
								sortOrder : 'desc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/product/bmcserverList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#bmcserver_searchform')));
			};
			function isvalidformater(value, row, index) {
				switch (value) {
						case "1":
							return "<span style=\"color:green\">在用</span>";
						case "0":
							return "<span style=\"color:red\">停用</span>";
						}
			} 
			function imodeformater(value, row, index) {
				switch (value) {
						case "1":
							return "<span style=\"color:blue\">联通</span>";
						case "2":
							return "<span style=\"color:blue\">电信</span>";
						case "3":
							return "<span style=\"color:blue\">移动</span>";
						case "4":
							return "<span style=\"color:blue\">双线</span>";
						case "5":
							return "<span style=\"color:blue\">三线</span>";
							
						}
			} 
			
			function isDecimal(s,len,point) {
				//var regu = "^([0-9]*)$";
				//var regu = "^([0-9]*[.0-9])$"; // 小数测试
				var regu = "^([0-9]{1,"+(len-point)+"}[.0-9]){1,"+point+"}$";
				debugger;
				var re = new RegExp(regu);
				if (re.exec(s) != -1)
					return true;
				else
					return false;
				
			}
			function isNum(s,len) {
				var regu = "^([0-9]{1,"+len+"})$";
				//var regu = "^([0-9]*[.0-9])$"; // 小数测试
				var re = new RegExp(regu);
				if (s.search(re) != -1)
					return true;
				else
					return false;
			}
			function submitSave()
			{
		 		$('#bmcserverform').form('submit',{
			    url:'${pageContext.request.contextPath}/product/saveBmcserver.do', 
			    onSubmit: function(){
			    	
			    	if($("#windowshopname").attr("value")==null || $.trim($("#windowshopname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"产品名称不能为空!");  
			    		return false;
			    	}
			    	if($("#windowcpunum").attr("value")==null || $.trim($("#windowcpunum").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"cpu核数不能为空!");  
			    		return false;
			    	}
			    	
			    	if(!isNum($("#windowcpunum").attr("value"),11))
			    	{
			    		$.messager.alert('消息',"cpu核数必须为数字(长度11)!");  
			    		return false;
			    	}
			    	if($("#windowmemnum").attr("value")==null || $.trim($("#windowmemnum").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"内存大小不能为空!");  
			    		return false;
			    	}
			    	
			    	if(!isNum($("#windowmemnum").attr("value"),12))
			    	{
			    		$.messager.alert('消息',"内存大小必须为数字(长度12)!");  
			    		return false;
			    	}
			    	if($("#windowdisknum").attr("value")==null || $.trim($("#windowdisknum").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"硬盘大小不能为空!");  
			    		return false;
			    	}
			    	
			    	if(!isNum($("#windowdisknum").attr("value"),12))
			    	{
			    		$.messager.alert('消息',"硬盘大小必须为数字(长度12)!");  
			    		return false;
			    	}
			    	if($("#windowstrnum").attr("value")==null || $.trim($("#windowstrnum").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"存储大小不能为空!");  
			    		return false;
			    	}
			    	
			    	if(!isNum($("#windowstrnum").attr("value"),12))
			    	{
			    		$.messager.alert('消息',"存储大小必须为数字(长度12)!");  
			    		return false;
			    	}
			    	if($("#windowosname").attr("value")==null || $.trim($("#windowosname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"操作系统不能为空!");  
			    		return false;
			    	}
			    	
			    	if($("#windowinterbw").attr("value")==null || $.trim($("#windowinterbw").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"公网带宽不能为空!");  
			    		return false;
			    	}
			    	
			    	if(!isNum($("#windowinterbw").attr("value"),12))
			    	{
			    		$.messager.alert('消息',"公网带宽必须为数字(长度12)!");  
			    		return false;
			    	}
			    	
			    	
			    	if($("#windowtprice").attr("value")==null || $.trim($("#windowtprice").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"商品单价（月）不能为空!");  
			    		return false;
			    	}
			    	
			    	if(!isDecimal($("#windowtprice").attr("value"),14,4))
			    	{
			    		$.messager.alert('消息',"商品单价（月）必须为数字(长度14,小数点后4位)!");  
			    		return false;
			    	}
			    	if($("#windowiprice").attr("value")==null || $.trim($("#windowiprice").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"每项单价不能为空!");  
			    		return false;
			    	}
			    	
			    	if(!isDecimal($("#windowiprice").attr("value"),14,4))
			    	{
			    		$.messager.alert('消息',"每项单价必须为数字(长度14,小数点后4位)!");  
			    		return false;
			    	}
			    	$("#windowisvalid").val($("#isvalidcheck").attr("checked")?1:0);
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#bmcserver_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="bmcserver_searchform">
				<table>
					<tr>
						<td>商品名称：<input class="easyui-textbox" name="shopname"
							id="searchshopname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#bmcserver_searchform input').val('');$('#searchshopname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'shopid',width:60,align:'center'">商品编码</th>
						<th data-options="field:'shopname',width:60,align:'center'">商品名称</th>
						<th data-options="field:'cpunum',width:35,align:'center'">cpu核数</th>
						<th data-options="field:'memnum',width:60,align:'center'">内存大小（G）</th>
						<th data-options="field:'disknum',width:60,align:'center'">硬盘大小（G）</th>
						<th data-options="field:'strnum',width:60,align:'center'">存储大小（G）</th>
						<th data-options="field:'osname',width:45,align:'center'">操作系统</th>
						<th data-options="field:'interbw',width:70,align:'center'">公网带宽（Mbps）</th>
						<th data-options="field:'imode',width:40,align:'center',formatter:imodeformater">接入模式</th>
						<th data-options="field:'tprice',width:60,align:'center'">商品单价（月）</th>
						<th data-options="field:'iprice',width:50,align:'center'">每项单价</th>
						<th data-options="field:'notes',width:60,align:'center'">备注</th>
						<th data-options="field:'isvalid',width:30,align:'center',formatter:isvalidformater">状态</th>
						<th data-options="field:'cuserid',width:60,align:'center'">创建人</th>
						<th data-options="field:'ctime',width:60,align:'center'">创建时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="产品" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:360px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="bmcserverform" method="post" enctype="multipart/form-data">
						<input id="windowshopid" name="shopid" type="hidden" value="" />
						<input id="windowflag" name="flag" type="hidden" value="0" />
						<input id="windowisvalid" name="isvalid"  type="hidden" />
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2">产品名称：</td>
								<td class="FieldInput2"><input id="windowshopname" name="shopname" style="height:30px" /><font color="red">*</font></td>
								<td class="FieldLabel2">接入模式：</td>
								<td class="FieldInput2"><input id="windowimode" name="imode" style="height:30px" /><font color="red">*</font></td>
								
							</tr>
							<tr>
								<td class="FieldLabel2">cpu核数：</td>
								<td class="FieldInput2"><input id="windowcpunum" name="cpunum" style="height:30px" /><font color="red">*</font></td>
								<td class="FieldLabel2">内存大小：</td>
								<td class="FieldInput2"><input id="windowmemnum" name="memnum" style="height:30px" />G<font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">硬盘大小：</td>
								<td class="FieldInput2"><input id="windowdisknum" name="disknum" style="height:30px" />G<font color="red">*</font></td>
								<td class="FieldLabel2">存储大小：</td>
								<td class="FieldInput2"><input id="windowstrnum" name="strnum" style="height:30px" />G<font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">操作系统：</td>
								<td class="FieldInput2"><input id="windowosname" name="osname" style="height:30px" /><font color="red">*</font></td>
								<td class="FieldLabel2">公网带宽：</td>
								<td class="FieldInput2"><input id="windowinterbw" name="interbw" style="height:30px" />Mbps<font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">商品单价（月）：</td>
								<td class="FieldInput2"><input id="windowtprice" name="tprice" style="height:30px" />元<font color="red">*</font></td>
								<td class="FieldLabel2">每项单价：</td>
								<td class="FieldInput2"><input id="windowiprice" name="iprice" style="height:30px" />元<font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									备注：</td>
								<td class="FieldInput2"><input id="windowsnote"
									style="height:75px;width: 260px" name="snote"
									class="easyui-textbox"
									data-options="multiline:true" /></td>
								<td class="FieldLabel2">是否有效：</td>
								<td class="FieldInput2"><input id="isvalidcheck"
									type="checkbox" checked="checked" /></td>
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
						onclick="$('#window').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
</body>