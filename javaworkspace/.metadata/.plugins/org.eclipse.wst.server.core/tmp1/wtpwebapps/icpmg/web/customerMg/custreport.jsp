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
						$("#windowuserid").val('');
						$("#windowreportname").val('');
						$("#searchuser").show();
						$("#windowintroduce").val('');
						$("#windowpublishtime").val('');
						
						$("#windowreporturl").val('');
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
						$("#windowuserid").val(rows[0].userid);
						$("#searchuser").hide();
						$("#windowpublishtime").val(rows[0].publishtime);
						$("#windowreportname").val(rows[0].reportname);
						$("#windowintroduce").val(rows[0].introduce);
						$("#windowreporturl").val(rows[0].reporturl);
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
							var publishtimes = "";
							 $.each(rows,function(index,object){
							 	userids+=object.userid+",";
							 	publishtimes+=object.publishtime+",";
			   				 });
			   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/customer/delReport.do',
			   				  		data:{userid:userids,publishtime:publishtimes},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#report_searchform')));
								    		
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
								sortName : 'publishtime',
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
								url : '${pageContext.request.contextPath}/customer/reportList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#report_searchform')));
			};
			function statformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:red\">已读</span>";
							case "0":
								return "<span style=\"color:green\">未读</span>";
							}
			} 
			function reporturlformater(value, row, index) {
				return "<a href=\""+'${pageContext.request.contextPath}'+value+"\" target=\"_blank\">下载</a>";
			} 
			
			function submitSave()
			{
		 		$('#reportform').form('submit',{
			    url:'${pageContext.request.contextPath}/customer/saveReport.do', 
			    onSubmit: function(){
			    	debugger;
			    	if($("#windowuserid").attr("value")==null || $.trim($("#windowuserid").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"用户编码不能为空!");  
			    		return false;
			    	}
			    	debugger;
			    	if($("#windowreportname").attr("value")==null || $.trim($("#windowreportname").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"标题不能为空!");  
			    		return false;
			    	}
			    	if($("#windowintroduce").attr("value")==null || $.trim($("#windowintroduce").attr("value"))=="" )
			    	{
			    		$.messager.alert('消息',"内容不能为空!");  
			    		return false;
			    	}
			    	if(!$("#reportform input[name='reportUrls']")[0].value&&!$("#reportform input[name='reportfile']")[0].value)
					{
						$.messager.alert('消息', "附件不能为空！");
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
							icp.serializeObject($('#report_searchform')));
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
			<form id="report_searchform">
				<table>
					<tr>
						<td>标题：<input class="easyui-textbox" name="reportname"
							id="searchreportname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#report_searchform input').val('');$('#searchreportname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'publishtime',width:60,align:'center'">报告时间</th>
						<th data-options="field:'reportname',width:60,align:'center'">标题</th>
						<th data-options="field:'introduce',width:60,align:'center'">内容</th>
						<th data-options="field:'status',width:60,align:'center',formatter:statformater">状态</th>
						<th data-options="field:'reporturl',width:60,align:'center',formatter:reporturlformater">报告</th>
					
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="window" class="easyui-window" title="报告发布" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:300px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="reportform" method="post" enctype="multipart/form-data">
						<input id="windowpublishtime" name="publishtime" type="hidden" value="" />
						<input id="windowstatus" name="status" type="hidden" value="0" />
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									用户编码：</td>
								<td class="FieldInput2"><input id="windowuserid" name="userid" style="height:30px;width:200px" readonly /><font color="red">*</font>
								<a href="#" id="searchuser" onClick="javascript:showSelectWin();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a></td>

							</tr>
							<tr>
								<td class="FieldLabel2">标题：</td>
								<td class="FieldInput2"><input id="windowreportname" name="reportname" style="height:30px" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									内容：</td>
								<td class="FieldInput2"><input id="windowintroduce"
									style="height:75px;width: 260px" name="introduce"
									data-options="multiline:true" /></td>

							</tr>
							<tr>
								<td class="FieldLabel2">附件：</td>
								<td class="FieldInput2"><input id="reportfile" type="file"
									style="height:25px" 
									name="reportfile" /><font
									color="red">选择一个附件*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">附件路径：</td>
								<td class="FieldInput2"><input id="windowreporturl" style="height:25px" name="reportUrls" readonly/></td>
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

