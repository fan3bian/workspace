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
						$("#windowstatus").val('0');
						$("#windowistag").val('0');
						$("#windowuserid").val('');
						$("#windowtitle").val('');
						$("#searchuser").show();
						$("#windowcontent").val('');
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
						$("#windowstatus").val('0');
						$("#windowistag").val(rows[0].istag);
						$("#windowuserid").val(rows[0].userid);
						$("#windowsendtime").val(rows[0].sendtime);
						$("#searchuser").hide();
						$("#windowtitle").val(rows[0].title);
						$("#windowcontent").val(rows[0].content);
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
							var userids = "";
							var sendtimes = "";
							 $.each(rows,function(index,object){
							 	userids+=object.userid+",";
							 	sendtimes+=object.sendtime+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/customer/delMessage.do',
			   				  		data:{userid:userids,sendtime:sendtimes},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#message_searchform')));
								    		
								    	} 
			   				  		}
			   				  	});
			   				  }
			   				 });
						}
				}];
		$(document).ready(function() {
			debugger;
			//loadDataGrid();
			$("#searchtitle").focus(function(){
				alert();
				$("#searchtitle").textbox('setValue','');
			});
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
								sortName : 'sendtime',
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
								url : '${pageContext.request.contextPath}/customer/messageList.do'
							});

		}
			
			function searchDataGrid() {
				
			$('#dg').datagrid('load',
					icp.serializeObject($('#message_searchform')));
			};
			function statformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:red\">已读</span>";
							case "0":
								return "<span style=\"color:green\">未读</span>";
							}
			} 
			function tagformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:red\">已标记</span>";
							case "0":
								return "<span style=\"color:green\">未标记</span>";
							}
			} 
			
			function submitSave()
			{
		 		$('#messageform').form('submit',{
			    url:'${pageContext.request.contextPath}/customer/saveMessage.do', 
			    onSubmit: function(){
			    	if($("#windowuserid").attr("value")==null || $.trim($("#windowuserid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"用户编码不能为空!");  
			    		return false;
			    	}
			    	debugger;
			    	if($("#windowtitle").attr("value")==null || $.trim($("#windowtitle").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"标题不能为空!");  
			    		return false;
			    	}
			    	if($("#windowcontent").attr("value")==null || $.trim($("#windowcontent").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"内容不能为空!");  
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
							icp.serializeObject($('#message_searchform')));
						$('#window').window('close');
						$('#w').window('close');
			    	}
			    }
			});
			}
			function showSelectWin()
			{
				 $('#condiSearch').textbox({onClickButton:function()
				 {
				 	$('#condiSearchTable').datagrid('clearChecked');
				 	$('#condiSearchTable').datagrid('reload',{
							username: this.value
							});
				 }});
				 condiSearchTableLoad();
				 $('#w').window('open');
			}
			function condiSearchTableLoad()
		{
			$('#condiSearchTable').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					pagination:true,
					pageSize:5,
					pageList:[5,10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/authMgr/getUsers.do'
					}); 
		}
		function writeToInput()
		{
			var rows  = $('#condiSearchTable').datagrid('getSelections');
			if(rows.length==0)
			{
			$.messager.alert('消息','请至少选择一项！'); 
					return;
			}
			var values = "";
			$.each(rows,function(index,object){
				 	values+=object.email+",";
   				 });
   			values=values.substring(0,values.length-1);
            $('#windowuserid').val(values);
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
			<form id="message_searchform">
				<table>
					<tr>
						<td>标题：<input class="easyui-textbox" name="title"
							id="searchtitle" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#message_searchform input').val('');$('#searchtitle').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'userid',width:60,align:'center'">用户编码</th>
						<th data-options="field:'sendtime',width:60,align:'center'">发送时间</th>
						<th data-options="field:'title',width:60,align:'center'">标题</th>
						<th data-options="field:'content',width:60,align:'center'">内容</th>
						<th data-options="field:'sendperson',width:60,align:'center'">发送人</th>
						<th data-options="field:'status',width:60,align:'center',formatter:statformater">状态</th>
						<th data-options="field:'istag',width:60,align:'center',formatter:tagformater">标记</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="信息发布" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:260px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="messageform" method="post">
						<input id="windowstatus" name="status" type="hidden" value="0" />
						<input id="windowistag" name="istag" type="hidden"  value="0"/>
						<input id="windowsendtime" name="sendtime" type="hidden"/>
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									用户编码：</td>
								<td class="FieldInput2"><input id="windowuserid" name="userid" style="height:30px;width:200px" readonly /><font color="red">*</font>
								<a href="#" id="searchuser" onClick="javascript:showSelectWin();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a></td>

							</tr>
							<tr>
								<td class="FieldLabel2">标题：</td>
								<td class="FieldInput2"><input id="windowtitle" name="title" style="height:30px" /><font color="red">*</font></td>
							</tr>

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									内容：</td>
								<td class="FieldInput2"><input id="windowcontent"
									style="height:75px;width: 260px" name="content"
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
						onclick="$('#window').window('close');$('#w').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
		<div id="w" class="easyui-window" title="条件查询" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:250px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
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
							<th data-options="field:'email',width:30,align:'center'">用户编码</th>
							<th data-options="field:'uname',width:30,align:'center'">用户名称</th>
						</tr>
					</thead>
				</table>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="writeToInput();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
</body>

