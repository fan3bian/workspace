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
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/validate.js"></script>
	<script type="text/javascript">
		function initCombobox()
		{
			$('#product').combobox({    
			    url:'${pageContext.request.contextPath}/tariff/getProductList.do',    
			    valueField:'pid',    
			    textField:'pname' ,
           		 onLoadSuccess: function () {
           		 	debugger; //加载完成后,设置选中第一项
	                var val = $(this).combobox("getData");
	                for (var item in val[0]) {
	                    if (item == "pid") {
	                        $(this).combobox("select", val[0][item]);
	                    }
	                }
            }  
			}); 
		}
		var toolbar = [
				{
					text : '增加',
					iconCls : 'icon-add',
					handler : function() { 
					    $("#id").val('');
						$("#pid").val('');
						$("#pname").val('');
						$("#pcolid").val('');
						$("#pcolname").val('');
						$("#model").val('');
						$('#ptype').combobox('setValue', '1');
						$("#tprice").val('');
						$('#isvalid').combobox('setValue', '1');
						$("#pvalue").val('');
						$("#snote").val('');
						initCombobox();
						$('#window').window('open');
					}
				},
				{
					text : '修改',
					iconCls : 'icon-modify',
					handler : function() {
						debugger;
							var rows = $('#dg').datagrid('getChecked');
							if(rows.length!=1)
							{
								$.messager.alert('消息','请选择一条记录！'); 
								return; 
							}
							
							$("#id").val(rows[0].id);
							$("#pid").val(rows[0].pid);
							$("#pname").val(rows[0].pname);
							$("#pcolid").val(rows[0].pcolid);
							$("#pcolname").val(rows[0].pcolname);
							$("#model").val(rows[0].model);
							$('#ptype').combobox('setValue', rows[0].ptype);
							$("#tprice").val(rows[0].tprice);
							$('#isvalid').combobox('setValue', rows[0].isvalid);
							$("#pvalue").val(rows[0].pvalue);
							$("#snote").val(rows[0].snote);
							initCombobox();
							$('#product').combobox('setValue', rows[0].pid);
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
							var fids = "";
							 $.each(rows,function(index,object){
							 	fids+=object.id+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/tariff/delProPrice.do',
			   				  		data:{fid:fids},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#prcieconfig_searchform')));
								    		
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
			   				  		url:'${pageContext.request.contextPath}/tariff/generatePriceFile.do',
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#prcieconfig_searchform')));
								    		
								    	} 
			   				  		}
			   				  	});
			   				  }
			   				 });
						}
				}];
		$(document).ready(function() {

			loadDataGrid();

		});
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'pcolid',
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
								url : '${pageContext.request.contextPath}/tariff/propriceList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#prcieconfig_searchform')));
			};
			function typeformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span>按时计费</span>";
							case "2":
								return "<span>按项计费</span>";
							}
			} 
			function validformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">在用</span>";
							case "0":
								return "<span style=\"color:red\">停用</span>";
							}
			} 
			
			function submitSave()
			{
				$('#priceform').form('submit',{
			    url:'${pageContext.request.contextPath}/tariff/addorupdatePrice.do', 
			    onSubmit: function(){
			   			$("#pid").val($('#product').combobox('getValue'));
						$("#pname").val($('#product').combobox('getText'));
			    	if($("#pcolid").attr("value")==null || $.trim($("#pcolid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"计费编码不能为空!");  
			    		return false;
			    	}
			    	if($("#pcolname").attr("value")==null || $.trim($("#pcolname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"计费名称不能为空!");  
			    		return false;
			    	}
			    	if($("#model").attr("value")==null || $.trim($("#model").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"规格不能为空!");  
			    		return false;
			    	}
			    	if($("#tprice").attr("value")==null || $.trim($("#tprice").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"单位单价不能为空!");  
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
							icp.serializeObject($('#prcieconfig_searchform')));
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
			<form id="prcieconfig_searchform">
				<table>
					<tr>
						<td>计费名称：<input class="easyui-textbox" name="pcolname"
							id="searchpname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#prcieconfig_searchform input').val('');$('#searchpname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'id',width:0,hidden:true"></th>
						<th data-options="field:'pid',width:0,hidden:true"></th>
						<th data-options="field:'pname',width:60,align:'center'">产品名称</th>
						<th data-options="field:'pcolid',width:60,align:'center'">计费编码</th>
						<th data-options="field:'pcolname',width:60,align:'center'">计费名称</th>
						<th data-options="field:'model',width:60,align:'center'">规格</th>
						<th data-options="field:'ptype',width:60,align:'center',formatter:typeformater">计费类型</th>
						<th data-options="field:'tprice',width:60,align:'center'">单位单价</th>
						<th data-options="field:'pvalue',width:60,align:'center'">规格描述</th>
						<th data-options="field:'auser',width:60,align:'center'">审核人</th>
						<th data-options="field:'atime',width:60,align:'center'">审核时间</th>
						<th data-options="field:'isvalid',width:60,align:'center',formatter:validformater">状态</th>
						<th data-options="field:'snote',width:60,align:'center'">备注</th>
					</tr>
				</thead>
			</table>
		</div>
		
	</div>	
		<div id="window" class="easyui-window" title="单价配置" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:500px;height:520px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="priceform" method="post">
						<input id="pname" name="pname" type="hidden" />
						<input id="pid" name="pid" type="hidden" />
						<input id="id" name="id" type="hidden" />
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									产品名称：</td>
								<td class="FieldInput2"><input id="product" style="height:30px;width:200px" /></td>

							</tr>
							<tr>
								<td class="FieldLabel2">计费编码：</td>
								<td class="FieldInput2"><input id="pcolid" name="pcolid" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">计费名称：</td>
								<td class="FieldInput2"><input id="pcolname" name="pcolname" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">规格：</td>
								<td class="FieldInput2"><input id="model" name="model" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">计费类型：</td>
								<td class="FieldInput2"><select id="ptype" class="easyui-combobox" name="ptype">   
									    <option value="1">按时计费</option>   
									    <option value="2" >按项计费</option>   
									</select>  
							  <font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">单位单价：</td>
								<td class="FieldInput2"><input id="tprice" name="tprice" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">状态：</td>
								<td class="FieldInput2"><select id="isvalid" class="easyui-combobox" name="isvalid">   
									    <option value="1">启用</option>   
									    <option value="0" >停用</option>   
									</select>  
							  <font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									规格描述：</td>
								<td class="FieldInput2"><input id="pvalue"
									style="height:125px;width: 260px" name="pvalue"
									class="easyui-textbox"
									data-options="multiline:true" />
									</td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									备注：</td>
								<td class="FieldInput2"><input id="snote"
									style="height:75px;width: 260px" name="snote"
									class="easyui-textbox"
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
		
</body>

