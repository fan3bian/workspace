<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>

<body >
	<style type="text/css">
		.FieldInput2 {
			width:77%;
			height:25px;
		    background-color: #FFFFFF;
			font: normal 12px tahoma, arial, helvetica, sans-serif;
		    text-align: left;
		    word-wrap: break-word;
		    padding-top:0px !important;
		    padding-bottom:0px !important;
		    border:#BCD2EE 1px solid !important;  
		}
		.FieldLabel2 {
			width:23%;
			height:25px;
		    background-color: #F0F8FF;
			font: normal 12px tahoma, arial, helvetica, sans-serif;
		    text-align: left;
		    word-wrap: break-word;
		    padding-top:0px !important;
		    padding-bottom:0px !important;
		    padding-right:10px !important;
		    border:#BCD2EE 1px solid !important;  
		}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
	<script type="text/javascript">
	var showDetail = function(id) {
		
		$('#centerTab').panel({
		href:"${pageContext.request.contextPath}/web/businessMg/workOrderMg/ModelDetail.jsp?transid=" + id
		//href:"${pageContext.request.contextPath}/web/businessMg/workOrderMg/ModelDetail.jsp"
		});
	};
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{
				$("#modelid").val('');
				$("#modelname").val('');
				$("#tlong").val('');
				$("#stepnum").val('');
				$("#ver").val('v1.0');
				$("#doroleid").val('');
				$("#ctime").val('');
				$("#cuserid").val('');
				$("#isvalid").val('');
				$("#ftable").val('');
				$("#jspurl").val('');
				$("#snote").val('');
				$("#modelno").val('');
				$('#uiwindow').window('open');
			}
		},{
			text:'删除',
			iconCls:'icon-remove',
			handler:function()
			{
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var modelids = "";
				 $.each(rows,function(index,object){
				 	modelids+=object.modelid+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:urlrootpath+'/workorder/delFlowIndex.do',
   				  		data:{modelid:modelids},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg').datagrid('unselectAll');
					    		$('#dg').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
					    		
					    	} 
   				  		}
   				  	});
   				  }
   				 });
			}
		},{
			text:'修改',
			iconCls:'icon-modify',
			handler:function()
			{
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length!=1)
				{
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
				
				$("#modelid").val(rows[0].modelid);
				$("#modelname").val(rows[0].modelname);
				$("#tlong").val(rows[0].tlong);
				$("#stepnum").val(rows[0].stepnum);
				$("#ver").val(rows[0].ver);
				$("#doroleid").val(rows[0].doroleid);
				$('#isvalid').combobox('select',rows[0].isvalid);
				
				$("#ftable").val(rows[0].ftable);
				$("#jspurl").val(rows[0].jspurl);
				$("#snote").val(rows[0].snote);
				$("#modelno").val(rows[0].modelno);
				
				$('#uiwindow').window('open');
				
			}
		}];
		
		$(document).ready(function() {
			
			loadDataGrid();
			
		});
		function loadDataGrid()
			{
				$('#dg').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					scrollbarSize:0,
					sortName:'modelid',
					sortOrder:'asc',
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'modelid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/workorder/queryIndex.do',   
					}); 
				
			}
			
		function searchDataGrid(){
			$('#dg').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
		};
		function statusformater(value,row,index)
		 {
		 
			switch (value) {
							case 2:
								return "<span style=\"color:green\">草稿</span>";
							case 1:
								return "<span style=\"color:green\">在用</span>";
							case 0:
								return "<span style=\"color:red\">停用</span>";
							}
		 }
	    function rowformater(value,row,index)
		 {
		   return icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnchakan.png\" title="查看" onclick="showDetail(\'{0}\');"/>', row.modelid);
		 }

	function submitSave() {
		if ($('#tableform').form('validate')) {
			$('#saveBtn').linkbutton('disable');
			$('#tableform').form('submit', {
				url: '${pageContext.request.contextPath}/workorder/addFlowIndex.do',
				onSubmit: function () {

				},
				success: function (retr) {
					//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
					var _data = JSON.parse(retr);
					//alert("success: "+_data.success);
					$.messager.alert('消息', _data.msg);
					if (_data.success) {
						$('#dg').datagrid('reload', icp.serializeObject($('#ordercofig_searchform')));
					}
					$('#saveBtn').linkbutton('enable');
				}
			});
			$('#uiwindow').window('close');
		}
	}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
			<form id="ordercofig_searchform">
				<table >
					<tr>
						<td>模板名称：<input class="easyui-textbox" name="modelnames"  id="modelnames" style="width:160px;height:30px;border:false"></td>
						
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#ordercofig_searchform input').val('');$('#modelnames').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;"  id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'stepnum',hidden:true"></th>
						<th data-options="field:'doroleid',hidden:true"></th>
						<th data-options="field:'ftable',hidden:true"></th>
						<th data-options="field:'snote',hidden:true"></th>
						<th data-options="field:'cuserid',hidden:true"></th>
						<th data-options="field:'jspurl',hidden:true"></th>
						<th data-options="field:'modelno',hidden:true"></th>
						<th data-options="field:'modelid',width:100,align:'center',sortable:true">模板编码</th>
				        <th data-options="field:'modelname',width:100,align:'center',sortable:true">模板名称</th>
						<th data-options="field:'ver',width:60,align:'center',sortable:true">版本</th>
						<th data-options="field:'tlong',width:80,align:'center'">时限</th>
						<th data-options="field:'ctime',width:100,align:'center',sortable:true">创建时间</th>
						<th data-options="field:'isvalid',width:80,align:'center',formatter:statusformater">标志</th>
						<th data-options="field:'id',width:50,align:'center',formatter:rowformater">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="uiwindow" class="easyui-window" title="工单维护" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:390px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<form id="tableform" method="post">
							<input id="modelid" name="modelid" type="hidden"  />
							<input id="ctime" name="ctime"  type="hidden" />
							<input id="cuserid" name="cuserid"  type="hidden" />
						<table align="center"  style="width:80%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									模板名称：</td>
								<td class="FieldInput2"><input id="modelname"
									style="height:25px" name="modelname" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									处理时长：</td>
								<td class="FieldInput2"><input id="tlong"
									style="height:25px" name="tlong" class="easyui-validatebox"
									data-options="required:true,validType:'integ'" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									总环节数：</td>
								<td class="FieldInput2"><input id="stepnum"
									style="height:25px" name="stepnum" class="easyui-validatebox"
									data-options="required:true,validType:'integ'" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									版本号：</td>
								<td class="FieldInput2"><input id="ver"
									style="height:25px" value="v1.0" name="ver" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									督办角色：</td>
								<td class="FieldInput2"><input id="doroleid"
									style="height:25px" name="doroleid" class="easyui-validatebox"
									 /></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									表单表：</td>
								<td class="FieldInput2"><input id="ftable"
									style="height:25px" name="ftable" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									流程简写：</td>
								<td class="FieldInput2"><input id="modelno"
									style="height:25px" name="modelno" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2">页面地址：</td>
								<td class="FieldInput2"><input id="jspurl"
									style="height:25px" name="jspurl" class="easyui-validatebox"
									data-options="required:true"  /><font color="red">*（相对路径）</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">启用标志：</td>
								<td class="FieldInput2"><select class="easyui-combobox" id="isvalid" name="isvalid" data-options="panelHeight:'auto',editable:false" style="height:25px;width:130px;">
							<option value="2">草稿</option>
							<option value="1">在用</option>
							<option value="0">停用</option>
					</select></td>
							</tr>
							<tr>
								<td class="FieldLabel2">备注：</td>
								<td class="FieldInput2"><textarea name="snote" id="snote" style="height:25px;width:130px;"></textarea></td>
							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="saveBtn" href="javascript:void(0)" onclick="submitSave();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#uiwindow').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
	</div>
</body>