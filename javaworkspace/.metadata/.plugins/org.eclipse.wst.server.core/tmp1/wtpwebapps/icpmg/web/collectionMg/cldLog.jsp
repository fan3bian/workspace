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
		/* var toolbar = [
				{
					text : '增加',
					iconCls : 'icon-add',
					handler : function() { 
						$("#windowflag").val('1');
						$("#windowlogid").val('');
						$("#windowtitle").val('');
						$("#windowcontext").val('');
						$("#windowctime").val('');
						$("#windowcuser").val('');
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
						$("#windowlogid").val(rows[0].logid);
						$("#windowtitle").val(rows[0].title);
						$("#windowcontext").val(rows[0].context);
						$("#windowctime").val(rows[0].ctime);
						$("#windowcuser").val(rows[0].cuser);
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
							var logids="";
							 $.each(rows,function(index,object){
							 	logids+=object.logid+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/log/delLogDetail.do',
			   				  		data:{logids:logids},
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
				}]; */
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
								sortName : 'logid',
								sortOrder : 'asc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/log/logList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#cldLog_searchform')));
			};
			
			/* function submitSave()
			{
		 		$('#cldLogform').form('submit',{
			    url:'${pageContext.request.contextPath}/log/saveOrUpdate.do', 
			    onSubmit: function(){ */
			    	/* if($("#windowlogid").attr("value")==null || $.trim($("#windowlogid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"日志编码不能为空!");  
			    		return false;
			    	} */
			    	/* if($("#windowtitle").attr("value")==null || $.trim($("#windowtitle").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"标题不能为空!");  
			    		return false;
			    	}
			    	if($("#windowcontext").attr("value")==null || $.trim($("#windowcontext").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"内容不能为空!");  
			    		return false;
			    	} */
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
			    	
			   /*  },
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
			} */
	</script>
<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="cldLog_searchform">
				<table>
					<tr>
						<td>标题：<input class="easyui-textbox" name="title"
							id="searchtitle" style="width:100px;height:30px;border:false">
							创建时间：<input class="easyui-datetimebox" name="starttime"
							id="starttime" style="width:140px;height:30px;border:false">
							到<input class="easyui-datetimebox" name="endtime"
							id="endtime" style="width:140px;height:30px;border:false">
						</td>
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
						<th data-options="field:'logid',width:30,align:'center'">编码</th>
						<th data-options="field:'title',width:40,align:'center'">标题</th>
						<th data-options="field:'context',width:50,align:'center'">内容</th>
						<th data-options="field:'ctime',width:40,align:'center'">创建时间</th>
						<th data-options="field:'cuser',width:30,align:'center'">创建人</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<!-- <div id="window" class="easyui-window" title="日志详情" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:420px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="cldLogform" method="post" enctype="multipart/form-data" >
						<input id="windowlogid" name="logid" type="hidden" />
						<table align="center" style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									编码：</td>
								<td class="FieldInput2"><input id="windowlogid" name="logid" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									标题：</td>
								<td class="FieldInput2"><input id="windowtitle" name="title" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							
							<tr>
								<td class="FieldLabel2">
									内容：</td>
								<td class="FieldInput2"><input id="windowcontext" name="context" style="width:200px;height:100px;" class="easyui-validatebox" required="true"  /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									创建时间：</td>
								<td class="FieldInput2"><input id="windowctime" name="ctime" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">
									创建人：</td>
								<td class="FieldInput2"><input id="windowcuser" name="cuser" class="easyui-validatebox" required="true" style="height:30px;" /><font color="red">*</font></td>
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
		</div> -->
</body>

