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
								sortName : 'status asc ,publishtime',
								sortOrder : 'desc',
								singleSelect : true,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								//toolbar : toolbar,
								url : '${pageContext.request.contextPath}/customer/suggestList.do'
							});

		}
			
			function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#suggest_searchform')));
			};
			 function operformater(value, row, index) {
				return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails('"+ value+"','"+row.status+"');\">明细</a>";
			} 
			function staformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">已办结</span>";
							case "0":
								return "<span style=\"color:red\">处理中</span>";
							}
			} 
			function viewDetails(suggestid,status)
			{
				$('#details')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'publishtime',
								sortOrder : 'desc',
								singleSelect : true,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								pagination : true,
								pageSize : 5,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								queryParams: {
									suggestid: suggestid
								},
								//toolbar : toolbar,
								url : '${pageContext.request.contextPath}/customer/suggeDetailList.do',
								onLoadSuccess : function(data) {
									//debugger;
									$(this).datagrid('selectRow', 0);
									$("#suggestid").val(suggestid);
								}
							});
				if("1"==status)
				{
					 $("#windowsouth").hide();
				}else
				{
					
					 $("#windowsouth").show();
				}
				debugger;
				$("#dealopiniontext").textbox('clear');
				$('#window').window('open');
			}
			function submitSave()
			{
				debugger;
				var row = $('#details').datagrid('getSelected');
				var publishtime = "";
				if(row)
				{
					if(row.dealopinion)
					{
						$.messager.alert('消息',"不能重复填写处理意见！");
						return;
					}
					publishtime = row.publishtime;
				}
				var dealopinion = $("#dealopiniontext").val();
				if(!dealopinion||""==dealopinion)
				{
					$.messager.alert('消息',"处理意见不能为空！");
					return;
				}
				$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/customer/saveSuggestDetail.do',
   				  		data:{suggestid:$("#suggestid").val(),publishtime:publishtime,dealopinion:dealopinion},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#details').datagrid('unselectAll');
					    		$('#details').datagrid('load', {suggestid:$("#suggestid").val()});
					    		$("#dealopiniontext").textbox('clear');
					    		$('#window').window('close');
					    	} 
   				  		}
   				  	});
			}
			function attaformater(value, row, index)
			{
				//debugger;
				if(value)
				{
					return "<a href=\""+'${pageContext.request.contextPath}'+value+"\" target=\"_blank\">下载</a>";
				}else
				{
					return "";
				}
				
			}
			
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="suggest_searchform">
				<table>
					<tr>
						<td>建议人：<input class="easyui-textbox" name="userid"
							id="searchuserid" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#suggest_searchform input').val('');$('#searchuserid').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
						<th data-options="field:'userid',width:60,align:'center'">建议人</th>
						<th data-options="field:'suggesttitle',width:60,align:'center'">标题</th>
						<th data-options="field:'suggestcontent',width:60,align:'center'">内容</th>
						<th data-options="field:'publishtime',width:60,align:'center'">日期</th>
						<th data-options="field:'status',width:60,align:'center',formatter:staformater">状态</th>
						<th data-options="field:'suggestid',width:60,align:'center',formatter:operformater">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		
	</div>	
	<div id="window" class="easyui-window" title="明细" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:400px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<table title="" style="width:100%;" id="details">
				<thead>
					<tr>
						<th data-options="field:'suggestid',width:0,hidden:true"></th>
						<th data-options="field:'publishtime',width:60,align:'center'">日期</th>
						<th data-options="field:'dealperson',width:60,align:'center'">处理人</th>
						<th data-options="field:'dealopinion',width:60,align:'center'">处理意见</th>
						<th data-options="field:'backcontent',width:60,align:'center'">反馈</th>
						<th data-options="field:'attachment',width:60,align:'center',formatter:attaformater">附件</th>
						<!-- <th data-options="field:'status',width:60,align:'center'">状态</th> -->
					</tr>
				</thead>
			</table>
				</div>
				<div id="windowsouth" data-options="region:'south',border:false"
					style="text-align:right;padding:5px 0 0;">
					<form>
					<input id="suggestid" name="suggestid" type="hidden" />
					<table align="center" style="width:100%">
						<tr>
						<td class="FieldLabel2" style="border-top:!important;">
									处理意见：</td>
						<td class="FieldInput2"><input id="dealopiniontext"
							style="height:75px;width: 410px" name="dealopiniontext"
							class="easyui-textbox"
							data-options="multiline:true" /></td>
						</tr>
					</table>
					</form>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
							id="saveBtn" href="javascript:void(0)" onclick="submitSave();"
							style="width:80px">确定</a> <a class="easyui-linkbutton"
							data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
							onclick="$('#window').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>	
</body>