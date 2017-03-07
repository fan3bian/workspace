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
		var url;
		var toolbar = [
				{
					text : '增加',
					iconCls : 'icon-add',
					handler : function() { 
						$("#mid").val('');
						$("#mname").val('');
						
						$("#cli").val('');
						$("#para").val('');
						$("#typeid").val('');
						$("#typename").val('');
						$("#period").val('');
						$("#funcid").val('');
						$('#isvalid').combobox('setValue', '1');
						$("#mtime").show();
						$("#muser").show();
						$("#ctime").show();
						$("#cuser").show();
						url='${pageContext.request.contextPath}/log/addClcModel.do';
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
						debugger;
						$("#mid").val(rows[0].mid);
						$("#mname").val(rows[0].mname);
						
						$("#cli").val(rows[0].cli);
						$("#para").val(rows[0].para);
						$("#typeid").val(rows[0].typeid);
						$("#typename").val(rows[0].typename);
						$("#period").val(rows[0].period);
						$("#funcid").val(rows[0].funcid);
						$('#isvalid').combobox('setValue', rows[0].isvalid);
						$("#mtime").val(rows[0].mtime);
						$("#muser").val(rows[0].muser);
						$("#ctime").val(rows[0].ctime);
						$("#cuser").val(rows[0].cuser);
						url='${pageContext.request.contextPath}/log/updateClcModel.do';
						$('#window').window('open');
					}
				},
				{
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						debugger;
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length!=1)
						{
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}
							debugger;
							var mids = "";
							 $.each(rows,function(index,object){
								 mids+=object.mid+",";
								 //alert(mids);
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/log/delClcModelDetail.do',
			   				  		data:{mids:mids},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#ClcModel_searchform')));
								    		
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
								sortName : 'mid',
								sortOrder : 'desc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/log/clcModelList.do'
							});

		}
			
			function searchDataGrid() {
				
			$('#dg').datagrid('load',
					icp.serializeObject($('#ClcModel_searchform')));
			};
			
			
			
			function submitSave()
			{
		 		$('#ClcModelform').form('submit',{
		 			
			    url:url, 
			    onSubmit: function(){
			    	if($("#mid").attr("value")==null || $.trim($("#mid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"编码不能为空!");  
			    		return false;
			    	}
			    	if($("#mname").attr("value")==null || $.trim($("#mname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"模板不能为空!");  
			    		return false;
			    	}			    	
			    	if($("#cli").attr("value")==null || $.trim($("#cli").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"命令不能为空!");  
			    		return false;
			    	}
			    	if($("#para").attr("value")==null || $.trim($("#para").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"设备名称不能为空!");  
			    		return false;
			    	}
			    	if($("#typeid").attr("value")==null || $.trim($("#typeid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"类型不能为空!");  
			    		return false;
			    	}
			    	if($("#typename").attr("value")==null || $.trim($("#typename").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"类型不能为空!");  
			    		return false;
			    	}
			    	if($("#period").attr("value")==null || $.trim($("#period").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"设备名称不能为空!");  
			    		return false;
			    	}
			    	if($("#funcid").attr("value")==null || $.trim($("#funcid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"用户密码不能为空!");  
			    		return false;
			    	}
			    	/* if($("#ctime").attr("value")==null || $.trim($("#ctime").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"时间不能为空!");  
			    		return false;
			    	}if($("#cuser").attr("value")==null || $.trim($("#cuser").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"操作人不能为空!");  
			    		return false;
			    	} */
			    },
			    success:function(retr){
			    	var _data =  JSON.parse(retr); 
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#ClcModel_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			}
			
			function validformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">在用</span>";
							case "0":
								return "<span style=\"color:red\">停用</span>";
							}
			} 
			
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="ClcModel_searchform">
				<table>
					<tr>
					    <td>类型：<input class="easyui-textbox" name="typeid"
							id="searchtypeid" style="width:160px;height:30px;border:false"></td>
						<td>模板：<input class="easyui-textbox" name="mname"
							id="searchmname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#ClcModel_searchform input').val('');$('#searchtypeid').textbox('clear');$('#searchmname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'mid',width:0,hidden:true"></th>
						<th data-options="field:'typename',width:0,hidden:true"></th>
						<th data-options="field:'funcid',width:0,hidden:true"></th>
						<th data-options="field:'isvalid',width:60,align:'center',formatter:validformater,hidden:true"></th>
						<th data-options="field:'mtime',width:0,hidden:true"></th>
					    <th data-options="field:'muser',width:0,hidden:true"></th>
					    <th data-options="field:'mname',width:60,align:'center'">模板</th>
						<th data-options="field:'typeid',width:60,align:'center'">类型</th>
						<th data-options="field:'cli',width:60,align:'center'">命令</th>
						<th data-options="field:'para',width:60,align:'center'">参数</th>
						<th data-options="field:'ctime',width:60,align:'center'">时间</th>
						<th data-options="field:'cuser',width:60,align:'center'">操作人</th>
						
					</tr>
				</thead>
			</table>
		</div>
	</div>	
		<div id="window" class="easyui-window" title="模板详情" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:420px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="ClcModelform" method="post" enctype="multipart/form-data" >
					
						<table align="center" style="width:100%">

                            
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									编码：</td>
								<td class="FieldInput2"><input id="mid" name="mid" style="height:30px;width:200px"   required="true" /><font color="red">*</font>
								
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									模板：</td>
								<td class="FieldInput2"><input id="mname" name="mname" style="height:30px;width:200px"   required="true" /><font color="red">*</font>
								
							</tr>
							

							<tr>
								<td class="FieldLabel2">命令：</td>
								<td class="FieldInput2"><input id="cli" name="cli" style="height:30px ;width:200px"  required="true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2">参数：</td>
								<td class="FieldInput2"><input id="para" name="para" style="height:30px ;width:200px" required="true"  /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2">类型：</td>
								<td class="FieldInput2"><input id="typeid" name="typeid" style="height:30px ;width:200px"  required="true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">名称：</td>
								<td class="FieldInput2"><input id="typename" name="typename" style="height:30px ;width:200px"  required="true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">采集间隔：</td>
								<td class="FieldInput2"><input id="period" name="period" style="height:30px ;width:200px"  required="true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">用户名和密码：</td>
								<td class="FieldInput2"><input id="funcid" name="funcid" style="height:30px ;width:200px"  required="true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">状态：</td>
								<td class="FieldInput2"><select id="isvalid" class="easyui-combobox" name="isvalid">   
									    <option value="1">启用</option>   
									    <option value="0" >停用</option>   
									</select>  
							  <font color="red">*</font></td>
							</tr>
							<!-- <tr>
								<td class="FieldLabel2">创建时间：</td>
								<td class="FieldInput2"><input id="mtime" name="mtime" style="height:30px"; width:200px"  required="true" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">创建人：</td>
								<td class="FieldInput2"><input id="muser" name="muser" style="height:30px" ;width:200px"  required="true" /><font color="red">*</font></td>

							</tr> -->
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
		
</body>

