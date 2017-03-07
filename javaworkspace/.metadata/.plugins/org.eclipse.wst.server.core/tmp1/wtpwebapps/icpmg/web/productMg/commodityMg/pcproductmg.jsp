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
					text : '增加',
					iconCls : 'icon-add',
					handler : function() { 
						$("#windowflag").val('1');
						$("#windowpid").val('');
						$("#windowpname").val('');
						$("#windowshoptable").val('');
						$("#windowisvaild").val('1');
						$("#isvaildcheck").attr("checked",true);						
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
						$("#windowpid").val(rows[0].pid);
						$("#windowpname").val(rows[0].pname);
						$("#windowshoptable").val(rows[0].shoptable);
						if(rows[0].isvaild=="true")
						{
							$("#isvaildcheck").attr("checked",true);
							$("#windowisvaild").val('1');
						}else
						{
							$("#isvaildcheck").attr("checked",false);	
							$("#windowisvaild").val('0');
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
							debugger;
							var pids = "";
							 $.each(rows,function(index,object){
							 	pids+=object.pid+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/product/delProductType.do',
			   				  		data:{pids:pids},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#product_searchform')));
								    		
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

		});
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'pid',
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
								url : '${pageContext.request.contextPath}/product/productTypeList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#product_searchform')));
			};
			function isvaildformater(value, row, index) {
				switch (value) {
						case "true":
							return "<span style=\"color:green\">在用</span>";
						case "false":
							return "<span style=\"color:red\">停用</span>";
						}
			} 
			function submitSave()
			{
		 		$('#productform').form('submit',{
			    url:'${pageContext.request.contextPath}/product/saveProductType.do', 
			    onSubmit: function(){
			    	debugger;
			    	if($("#windowpid").attr("value")==null || $.trim($("#windowpid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"产品编码不能为空!");  
			    		return false;
			    	}
			    	if($("#windowpname").attr("value")==null || $.trim($("#windowpname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"产品名称不能为空!");  
			    		return false;
			    	}
			    	if($("#windowshoptable").attr("value")==null || $.trim($("#windowshoptable").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"对应商品表不能为空!");  
			    		return false;
			    	}
			    	$("#windowisvaild").val($("#isvaildcheck").attr("checked")?1:0);
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#product_searchform')));
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
			<form id="product_searchform">
				<table>
					<tr>
						<td>产品名称：<input class="easyui-textbox" name="pname"
							id="searchpname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#product_searchform input').val('');$('#searchpname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'pid',width:60,align:'center'">产品编码</th>
						<th data-options="field:'pname',width:60,align:'center'">产品名称</th>
							<th data-options="field:'shoptable',width:60,align:'center'">商品表</th>
						<th data-options="field:'isvaild',width:60,align:'center',formatter:isvaildformater">状态</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="产品" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:300px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="productform" method="post" enctype="multipart/form-data">
						<input id="windowflag" name="flag" type="hidden" value="0" />
						<input id="windowisvaild" name="isvaild"  type="hidden" />
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									产品编码：</td>
								<td class="FieldInput2"><input id="windowpid" name="pid" style="height:30px;width:200px" /><font color="red">*</font>
								</a></td>

							</tr>
							<tr>
								<td class="FieldLabel2">产品名称：</td>
								<td class="FieldInput2"><input id="windowpname" name="pname" style="height:30px" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">商品表：</td>
								<td class="FieldInput2"><input id="windowshoptable" name="shoptable" style="height:30px" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">是否有效：</td>
								<td class="FieldInput2"><input id="isvaildcheck"
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

