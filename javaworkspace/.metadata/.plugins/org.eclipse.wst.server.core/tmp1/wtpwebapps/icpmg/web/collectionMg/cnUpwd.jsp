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
		var url;
		var toolbar = [
		        
				{
					text : '增加',
					//图标
					iconCls : 'icon-add',
					handler : function() { 
					    $("#fid").val('');
					    $("#funcid").val('');
					    $("#neid").val('');
						$("#nename").val('');
						$("#uservar").val('');
						$("#usercol").val('');
						$("#username").val('');
						$("#pwdvar").val('');
						$("#pwdcol").val('');
						$("#tablename").val('');
						$("#sourceid").val('');
					    url = '${pageContext.request.contextPath}/log/addModel.do', 
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
							
							$("#fid").val(rows[0].fid);
							$("#funcid").val(rows[0].funcid);
							$("#neid").val(rows[0].neid);
							$("#nename").val(rows[0].nename);
							$("#uservar").val(rows[0].uservar);
							$("#usercol").val(rows[0].usercol);
							$("#username").val(rows[0].username);
							$("#pwdvar").val(rows[0].pwdvar);
							$("#pwdcol").val(rows[0].pwdcol);
							$("#tablename").val(rows[0].tablename);
							$("#sourceid").val(rows[0].sourceid);
						    url = '${pageContext.request.contextPath}/log/updateModel.do', 
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
							 	fids+=object.fid+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/log/delModelDetail.do',
			   				  		data:{fids:fids},
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
				},];
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
								sortName : 'fid',
								sortOrder : 'desc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/log/modelList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#prcieconfig_searchform')));
			};
			
			
			function submitSave()
			{
				$('#priceform').form('submit',{
			    url:url, 
			    onSubmit: function(){
			   			
			    	/* if($("#fid").attr("value")==null || $.trim($("#fid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"编码不能为空!");  
			    		return false;
			    	} */
			    	if($("#funcid").attr("value")==null || $.trim($("#funcid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"句柄串不能为空!");  
			    		return false;
			    	}
			    	
			    	
			    	
			    },
			    success:function(retr){
			    	var _data =  JSON.parse(retr); 
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#prcieconfig_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			 	
		 
			}
			//下拉框数据
			function loadComboData1(){
				$('searchpname1_').combobox({ 
					data: [
					       {id: '', name: '请选择'},
					       
					],   
				    valueField:'id',    
				    textField:'name',
				}); 
				$("#searchpname1_").combobox('select', '');
			}
			function loadComboData2(){
				$('searchpname2_').combobox({ 
					data: [
					       {id: '', name: '请选择'},
					       
					],   
				    valueField:'id',    
				    textField:'name',
				}); 
				$("#searchpname2_").combobox('select', '');
			}
			
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
				<table>
					<tr>
			            <td>类型：<input class="easyui-textbox" name="leixing"
							id="searchpname1_" style="width:160px;height:30px;border:false"></td>
						<td>设备：<input class="easyui-textbox" name="shebei"
							id="searchpname2_" style="width:160px;height:30px;border:false"></td>
						    <td>&nbsp;&nbsp;<a href="javascript:void(0);" 
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#prcieconfig_searchform input').val('');$('#searchpname1_').textbox('clear');$('#searchpname2_').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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

						<th data-options="field:'fid',width:60,align:'center'">函数</th>
						<th data-options="field:'funcid',width:0,hidden:true"></th>
						<th data-options="field:'neid',width:0,hidden:true"></th>
						<th data-options="field:'nename',width:60,align:'center'">设备</th>
						<th data-options="field:'uservar',width:60,align:'center'">用户变量</th>
						<th data-options="field:'usercol',width:60,align:'center'">用户字段</th>
						<th data-options="field:'username',width:60,align:'center'">用户名</th>
						<th data-options="field:'pwdvar',width:60,align:'center'">密码变量</th>
						<th data-options="field:'pwdcol',width:60,align:'center'">密码字段</th>
						<th data-options="field:'tablename',width:60,align:'center'">字典表</th>
						<th data-options="field:'sourceid',width:60,align:'center'">设备字段名</th>
						
					</tr>
				</thead>
			</table>
		</div>
		
	</div>	
		<div id="window" class="easyui-window" title="采集模板" data-options="closed:true,iconCls:'icon-save',inline:true"
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
								<td class="FieldLabel2">函数：</td>
								<td class="FieldInput2"><input id="fid" name="fid" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">句柄串：</td>
								<td class="FieldInput2"><input id="funcid" name="funcid" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">设备编码：</td>
								<td class="FieldInput2"><input id="neid" name="neid" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">设备名称：</td>
								<td class="FieldInput2"><input id="nename" name="nename" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">用户变量：</td>
								<td class="FieldInput2"><input id="uservar" name="uservar" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							
							<tr>
								<td class="FieldLabel2">用户字段：</td>
								<td class="FieldInput2"><input id="usercol" name="usercol" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">用户名：</td>
								<td class="FieldInput2"><input id="username" name="username" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">密码变量：</td>
								<td class="FieldInput2"><input id="pwdvar" name="pwdvar" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">密码字段：</td>
								<td class="FieldInput2"><input id="pwdcol" name="pwdcol" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">字典表：</td>
								<td class="FieldInput2"><input id="tablename" name="tablename" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">设备字段名：</td>
								<td class="FieldInput2"><input id="sourceid" name="sourceid" style="height:30px" class="easyui-validatebox" data-options="required:true" /><font color="red">*</font></td>
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

