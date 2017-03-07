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
						$("#windowvid").val('');
						$("#windowmid").val('');
						$("#windowmname").val('');
						$("#windowengname").val('');
						$("#windowchname").val('');
						$("#windowomodel").val('');
						$("#windowtypeid").val('');
						$("#windowtypename").val('');
						$('#isvalid').combobox('setValue', '1');
						$("#windowctime").val('');
						$("#windowcuser").val('');
						
						$("#windowmtime").val('');
						$("#windowmuser").val('');
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
						$("#windowvid").val(rows[0].vid);
						$("#windowmid").val(rows[0].mid);
						$("#windowmname").val(rows[0].mname);
						$("#windowengname").val(rows[0].engname);
						$("#windowchname").val(rows[0].chname);
						$("#windowomodel").val(rows[0].omodel);
						$("#windowtypeid").val(rows[0].typeid);
						$("#windowtypename").val(rows[0].typename);
						$('#isvalid').combobox('setValue', '1');
						$("#windowctime").val(rows[0].muser);
						$("#windowcuser").val(rows[0].muser);						
						$("#windowmtime").val(rows[0].mtime);
						$("#windowmuser").val(rows[0].muser);
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
							var vids="";
							 $.each(rows,function(index,object){
							 	vids+=object.vid+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/log/delCvModelDetail.do',
			   				  		data:{vids:vids},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#cldLod_searchform')));
								    		
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
								sortName : 'vid',
								sortOrder : 'asc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/log/cvModelList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#cldLog_searchform')));
			};
			
			function submitSave()
			{
		 		$('#cvModelform').form('submit',{
			    url:'${pageContext.request.contextPath}/log/saveCvModelUpdate.do', 
			    onSubmit: function(){
			    	
			    	/* if($("#windowvid").attr("value")==null || $.trim($("#windowvid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"编码不能为空!");  
			    		return false;
			    	} */
			    	if($("#windowmid").attr("value")==null || $.trim($("#windowmid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"模板编码不能为空!");  
			    		return false;
			    	}
			    	if($("#windowengname").attr("value")==null || $.trim($("#windowengname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"厂商不能为空!");  
			    		return false;
			    	}
			    	if($("#windowchname").attr("value")==null || $.trim($("#windowchname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"名称不能为空!");  
			    		return false;
			    	}
			    	if($("#windowomodel").attr("value")==null || $.trim($("#windowomodel").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"型号不能为空!");  
			    		return false;
			    	}
			    	if($("#windowtypeid").attr("value")==null || $.trim($("#windowtypeid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"类型不能为空!");  
			    		return false;
			    	}
			    	if($("#windowmname").attr("value")==null || $.trim($("#windowmname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"模板不能为空!");  
			    		return false;
			    	}
			    	if($("#windowtypename").attr("value")==null || $.trim($("#windowtypename").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"类型名称不能为空!");  
			    		return false;
			    	}
			    	/* if($("#windowctime").attr("value")==null || $.trim($("#windowctime").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"创建时间不能为空!");  
			    		return false;
			    	} */
			    	/* if($("#windowcuser").attr("value")==null || $.trim($("#windowcuser").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"创建人不能为空!");  
			    		return false;
			    	} */
			    	
			    },
			    success:function(retr){
			    	var _data =  JSON.parse(retr); 
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#cldLog_searchform')));
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
			<form id="cldLog_searchform">
				<table>
					<tr>
						<td>厂商：<input class="easyui-textbox" name="title"
							id="searchtitle" style="width:100px;height:30px;border:false">
							类型：<input class="easyui-textbox" name="title"
							id="searchtitle" style="width:100px;height:30px;border:false">
							模板：<input class="easyui-textbox" name="title"
							id="searchtitle" style="width:100px;height:30px;border:false">
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#cldLog_searchform input').val('');$('#searchtitle').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'vid',width:0,hidden:true"></th>
						<th data-options="field:'mid',width:0,hidden:true"></th>
						<th data-options="field:'typename',width:0,hidden:true"></th>
						<th data-options="field:'isvalid',width:60,align:'center',formatter:validformater,hidden:true"></th>
						<th data-options="field:'ctime',width:0,hidden:true"></th>
						<th data-options="field:'cuser',width:0,hidden:true"></th>
						<th data-options="field:'engname',width:30,align:'center'">厂商</th>
						<th data-options="field:'chname',width:40,align:'center'">名称</th>
						<th data-options="field:'omodel',width:50,align:'center'">型号</th>
						<th data-options="field:'typeid',width:40,align:'center'">类型</th>
						<th data-options="field:'mname',width:30,align:'center'">模板</th>
						<th data-options="field:'muser',width:40,align:'center'">操作人</th>
						<th data-options="field:'mtime',width:30,align:'center'">时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="模板厂商对应详情" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:420px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="cvModelform" method="post" enctype="multipart/form-data" >
						<input id="windowvid" name="vid" type="hidden" />
						<table align="center" style="width:100%">
							
							
							<!-- <tr>
								<td class="FieldLabel2" style="border-top:!important;">
									编码：</td>
								<td class="FieldInput2"><input id="windowvid" name="vid" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr> -->
							
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									模板编码：</td>
								<td class="FieldInput2"><input id="windowmid" name="mid" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									模板名称：</td>
								<td class="FieldInput2"><input id="windowmname" name="mname" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									厂商：</td>
								<td class="FieldInput2"><input id="windowengname" name="engname" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									名称：</td>
								<td class="FieldInput2"><input id="windowchname" name="chname" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
							   <td class="FieldLabel2" style="border-top:!important;">
									型号：</td>
								<td class="FieldInput2"><input id="windowomodel" name="omodel" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									类型：</td>
								<td class="FieldInput2"><input id="windowtypeid" name="typeid" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
								<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									类型名称：</td>
								<td class="FieldInput2"><input id="windowtypename" name="typename" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">状态：</td>
								<td class="FieldInput2"><select id="windowisvalid" class="easyui-combobox" name="isvalid">   
									    <option value="1">启用</option>   
									    <option value="0" >停用</option>   
									</select>  
							  <font color="red">*</font></td>
							</tr>
							<!-- <tr>
								<td class="FieldLabel2">
									创建时间：</td>
								<td class="FieldInput2"><input id="windowctime" name="ctime" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr> -->
							<!-- <tr>
								<td class="FieldLabel2">
									创建人：</td>
								<td class="FieldInput2"><input id="windowcuser" name="cuser" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
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
		</div>
</body>

