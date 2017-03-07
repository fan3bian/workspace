<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<style type="text/css">
.product-product-close {
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
					text : '增加',
					iconCls : 'icon-add',
					handler : function() { 
						$("#windowflag").val('1');
						$("#windowisvalid").val('1');
						$("#windowmid").val('');
						$("#windowmname").val('');
						$("#windowshopid").val('');
						$("#windowshopname").val('');
						$("#windowsnote").val('');
						$("#oldmid").val('');
						$("#oldshopid").val('');
						$("#oldshoptype").val('');
						$("#isvalidcheck").attr("checked",true);
						$("#windowshoptype").combobox('select','bmc_server');
						$("#searchmeal").show();
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
						debugger;
						//$("#windowstatus").val(rows[0].status);
						$("#windowflag").val('2');
						if(rows[0].isvalid==1)
						{
							$("#isvalidcheck").attr("checked",true);
							$("#windowisvalid").val('1');
						}else
						{
							$("#isvalidcheck").attr("checked",false);	
							$("#windowisvalid").val('0');
						}
						$("#windowmid").val(rows[0].mid);
						$("#windowmname").val(rows[0].mname);
						$("#windowshopid").val(rows[0].shopid);
						$("#windowshopname").val(rows[0].shopname);
						$("#windowsnote").val(rows[0].snote);
						$("#oldmid").val(rows[0].mid);
						$("#oldshopid").val(rows[0].shopid);
						$("#oldshoptype").val(rows[0].shoptype);
						$("#windowshoptype").combobox('select',rows[0].shoptype);
						$("#searchmeal").hide();
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
							debugger;
							var mids = "";
							 $.each(rows,function(index,object){
							 	mids+=object.mid+":"+object.shoptype+":"+object.shopid+",";
			   				 });
							 mids+="-1:-1:-1";
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/product/delMealDetail.do',
			   				  		data:{mids:mids},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#mealplan_searchform')));
								    		
								    	} 
			   				  		}
			   				  	});
			   				  }
			   				 });
						}
				}];
		$(document).ready(function() {
			debugger;
			loadDataGrid();
			loadComboData();
		});
		function loadComboData()
		{
			$('#windowshoptype').combobox({ 
				data: [{
					id: 'bmc_server',
					name: '服务器'
				},{
					id: 'bmc_data',
					name: '云数据库'
				}],   
			    valueField:'id',    
			    textField:'name',
			    onSelect: function(rec){ 
			    	$("#windowshopid").val('');
					$("#windowshopname").val('');
		        }
			}); 
			debugger;
			$("#windowshoptype").combobox('select','bmc_server');
		}
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'mid',
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
								url : '${pageContext.request.contextPath}/product/mealDetailList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#mealplan_searchform')));
			};
			function isvalidformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">在用</span>";
							case "0":
								return "<span style=\"color:red\">停用</span>";
							}
			} 
			function shoptypeformater(value, row, index) {
				switch (value) {
							case "bmc_server":
								return "<span style=\"color:blue\">服务器</span>";
							case "bmc_data":
								return "<span style=\"color:blue\">云数据库</span>";
							}
			} 
			
			function submitSave()
			{
		 		$('#mealdetailform').form('submit',{
			    url:'${pageContext.request.contextPath}/product/saveMealDetail.do', 
			    onSubmit: function(){
			    	if($("#windowmid").attr("value")==null || $.trim($("#windowmid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"套餐编码不能为空!");  
			    		return false;
			    	}
			    	if($("#windowmname").attr("value")==null || $.trim($("#windowmname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"套餐名称不能为空!");  
			    		return false;
			    	}
			    	if($("#windowshopid").attr("value")==null || $.trim($("#windowshopid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"产品编码不能为空!");  
			    		return false;
			    	}
			    	if($("#windowshopname").attr("value")==null || $.trim($("#windowshopname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"产品名称不能为空!");  
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
							icp.serializeObject($('#mealplan_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			}
			function showSelectWin(value)
			{
			 $('#condiSearch').textbox({onClickButton:function()
			 {
			 	$('#condiSearchTable').datagrid('clearChecked');
			 	$('#condiSearchTable').datagrid('reload',{
						condi: $('#property').combobox('getValue'),
						condiSearch: this.value
						});
			 }});
			 condiSearchTableLoad(value);
			 $('#w').window('open');
		}
		function condiSearchTableLoad(value)
		{
			if('shop'==value)
			{
				debugger;
				value = $("#windowshoptype").combobox('getValue');
			}
			 $("#windowvalue").val(value);
			
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
					pageSize:10,
					pageList:[10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/product/getCondiByCondi.do',
				    queryParams: {
						condi:value,
						condiSearch: $('#condiSearch').textbox('getValue')
					}
				    
					}); 
		}
		function confrm()
		{
			debugger;
			var rows  = $('#condiSearchTable').datagrid('getSelections');
			if(rows.length!=1)
			{
			$.messager.alert('消息','请选择一项！'); 
					return;
			}
			var values = "";
			var text = "";
			$.each(rows,function(index,object){
				 	values+=object.id+",";
				 	text+=object.name+",";
   				 });
   			values=values.substring(0,values.length-1);
   			text=text.substring(0,text.length-1);
   			if(''!= $("#windowvalue").val())
   			{
   				$("#windowshopid").val(values);
   				$("#windowshopname").val(text);
   			}else
   			{
   				$("#windowmid").val(values);
   				$("#windowmname").val(text);
   			}
            $('#condiSearchTable').datagrid('clearChecked');
   			$('#condiSearch').textbox('setValue','');
            $('#condiSearch').textbox('setText','');
			$('#w').window('close');
		}
		function cancel()
		{
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
			<form id="mealplan_searchform">
				<table>
					<tr>
						<td>套餐名称：<input class="easyui-textbox" name="mname"
							id="searchmname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#mealplan_searchform input').val('');$('#searchmname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'mid',width:60,align:'center'">套餐编码</th>
						<th data-options="field:'mname',width:60,align:'center'">套餐名称</th>
						<th data-options="field:'shoptype',width:60,align:'center',formatter:shoptypeformater">产品类型</th>
						<th data-options="field:'shopid',width:60,align:'center'">产品编码</th>
						<th data-options="field:'shopname',width:60,align:'center'">产品名称</th>
						<th data-options="field:'isvalid',width:60,align:'center',formatter:isvalidformater">状态</th>
						<th data-options="field:'snote',width:60,align:'center'">备注</th>
					
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="window" class="easyui-window" title="套餐明细" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:360px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="mealdetailform" method="post" enctype="multipart/form-data">
						<input id="windowflag" name="flag" type="hidden" value="0" />
						<input id="windowisvalid" name="isvalid"  type="hidden" />
						<input id="windowvalue" name="value"  type="hidden" />
						<input id="oldmid" name="oldmid"  type="hidden" />
						<input id="oldshopid" name="oldshopid"  type="hidden" />
						<input id="oldshoptype" name="oldshoptype"  type="hidden" />
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									套餐编码：</td>
								<td class="FieldInput2"><input id="windowmid" name="mid" style="height:30px;" readonly /><font color="red">*</font>
								<a href="#" id="searchmeal" onClick="javascript:showSelectWin('');" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a></td>

							</tr>
							<tr>
								<td class="FieldLabel2">套餐名称：</td>
								<td class="FieldInput2"><input id="windowmname" name="mname" style="height:30px" readonly /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									产品类型：</td>
								<td class="FieldInput2"><select id="windowshoptype" name="shoptype" style="height:25px;width:50%;"></select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel2">产品编码：</td>
								<td class="FieldInput2"><input id="windowshopid" name="shopid" style="height:30px" readonly /><font color="red">*</font>
								<a href="#" id="searchshop" onClick="javascript:showSelectWin('shop');" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a></td>
							</tr>
							</tr>
								<tr>
								<td class="FieldLabel2">产品名称：</td>
								<td class="FieldInput2"><input id="windowshopname" name="shopname" style="height:30px" readonly /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">是否有效：</td>
								<td class="FieldInput2"><input id="isvalidcheck"
									type="checkbox" checked="checked" /></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
								备注：</td>
								<td class="FieldInput2"><input id="windowsnote"
									style="height:75px;width: 260px" name="snote"
									data-options="multiline:true" /></td>

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
		<div id="w" class="easyui-window" title="数据查询" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:500px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<table class="">
							<tr>
								<td><input id = "condiSearch" class="easyui-textbox" data-options="buttonIcon:'icon-search'" style="width:150px"> 
								</td>
							</tr>
					</table>
					<table id="condiSearchTable" title="" style="width:95%;" data-options="">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'id',width:30,align:'center'">编码</th>
							<th data-options="field:'name',width:30,align:'center'">名称</th>
						</tr>
					</thead>
				</table>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="confrm();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="cancel();" style="width:80px">取消</a>
				</div>
			</div>
		</div>	
</body>