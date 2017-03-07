<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
	<%
	   String str = request.getParameter("transid")==null?"":request.getParameter("transid");
	  // System.out.println("str="+str);
	 %>
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
var str = "<%=str%>"
var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{document.getElementById('todo').value="create";
				$("#modelid").val(str);
				//$("#modelname").val('');
				$("#stepno").val('');
				$("#stepname").val('');
				$("#tlong").val('');
				$("#doroleid").val('');
				$("#dorolename").val('');
				$("#isvalid").val('');
				$("#yesNextop").val('');
				$("#yesnexbutton").val('');
				$("#Nonextop").val('');
				$("#nonextbutton").val('');
				$("#Opbutton").val('');
				$("#Opbuttonname").val('');
				$("#Ophtml").val('');
				$("#fstatusid").val('');
				$("#fstatus").val('');
				$("#snote").val('');
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
				var stepnos = "";
   				  $.each(rows,function(index,object){
				 	modelids=object.modelid;
				 	stepnos+=object.stepno+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗?',function(r){   
   				  if (r){
   				  	$.ajax({
   				  		type : 'post',
   				  		//url: urlrootpath+'/workorder/delModelDetail.do?modelid='+modelids+'&stepno='+stepnos,
   				  		url: urlrootpath+'/workorder/delModelDetail.do',
   				  		//data: {modelid:modelids},
   				  		 data: {modelid:modelids,stepname:stepnos}, 
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
				document.getElementById('todo').value="update";
				$("#modelid").val(rows[0].modelid);
				$("#stepno").val(rows[0].stepno);
				$("#stepname").val(rows[0].stepname);
				$("#tlong").val(rows[0].tlong);
				$("#doroleid").val(rows[0].doroleid);
				$("#dorolename").val(rows[0].dorolename);
				$("#isvalid").combobox('select',rows[0].isvalid);
				$("#yesNextop").val(rows[0].yesNextop);
				$("#yesnexbutton").val(rows[0].yesnexbutton);
				$("#Nonextop").val(rows[0].Nonextop);
				$("#nonextbutton").val(rows[0].nonextbutton);
				$("#Opbutton").val(rows[0].Opbutton);
				$("#Opbuttonname").val(rows[0].Opbuttonname);
				$("#Ophtml").val(rows[0].Ophtml);
				$("#fstatusid").val(rows[0].fstatusid);
				$("#fstatus").val(rows[0].fstatus);
				$("#snote").val(rows[0].snote);
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
					sortName:'stepno',
					sortOrder:'asc',
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'stepno',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/workorder/queryModelDetail.do?transid='+str
					}); 
				
			}
				function searchDataGrid(){
			$('#dg').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
		};
		function statusformater(value,row,index)
		 {
		 
			switch (value) {
							case 1:
								return "<span style=\"color:green\">在用</span>";
							case 0:
								return "<span style=\"color:green\">停用</span>";
							}
		 }
		 
		 function opformater(value,row,index)
		 {
		 
			switch (value) {
							case 1:
								return "<span style=\"color:green\">有</span>";
							case 0:
								return "<span style=\"color:green\">无</span>";
							}
		 }
		 
		function submitSave()
		 {if ($('#tableform').form('validate')) {
		 	$('#saveBtn').linkbutton('disable');
		 	$('#tableform').form('submit',{
		    url:'${pageContext.request.contextPath}/workorder/addModelDetail.do', 
		    onSubmit: function(){
		    	
		    },
		    success:function(retr){
		    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
		    	var _data =  JSON.parse(retr); 
		    	//alert("success: "+_data.success);
		    	$.messager.alert('消息',_data.msg);  
				if(_data.success){
					$('#dg').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
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
						<td>环节名称：<input class="easyui-textbox" name="stepnames"  id="stepnames" style="width:160px;height:30px;border:false"></td>
						
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#ordercofig_searchform input').val('');$('#stepnames').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
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
						<th data-options="field:'modelid',width:100,align:'center'">模板编码</th>
				        <th data-options="field:'stepno',width:100,align:'center',sortable:true">环节编号</th>
						<th data-options="field:'stepname',width:60,align:'center'">环节名称</th>
						<th data-options="field:'tlong',width:60,align:'center'">时限</th>
						<th data-options="field:'doroleid',width:80,align:'center'">角色编码</th>
						<th data-options="field:'dorolename',width:80,align:'center'">角色名称</th>
						<th data-options="field:'yesnextop',width:80,align:'center'">下一环节编号(同意)</th>
						<th data-options="field:'yesnexbutton',width:80,align:'center'">下一环节名称(同意)</th>
						<th data-options="field:'nonextop',width:80,align:'center'">下一环节编号(不同意)</th>
						<th data-options="field:'nonextbutton',width:80,align:'center'">下一环节名称(不同意)</th>
						<th data-options="field:'opbutton',width:80,align:'center',formatter:opformater">是否有功能按键</th>
						<th data-options="field:'Opbuttonname',width:80,align:'center'">功能名称</th>
						<th data-options="field:'ophtml',width:80,align:'center'">功能URL</th>
					</tr>
				</thead>
			</table>
		</div>
		
	</div>
	<div id="uiwindow" class="easyui-window" title="模板明细维护" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:390px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<form id="tableform" method="post">
							<input id="ctime" name="ctime"  type="hidden" />
							<input id="cuserid" name="cuserid"  type="hidden" />
							<input id="todo" name="todo"  type="hidden" />
						<table align="center"  style="width:80%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									模板名称：</td>
								<td class="FieldInput2"><input id="modelid"
									style="height:25px" name="modelid" 
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									环节编号：</td>
								<td class="FieldInput2"><input id="stepno"
									style="height:25px" name="stepno" class="easyui-validatebox"
									data-options="required:true,validType:'integ'" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									环节名称：</td>
								<td class="FieldInput2"><input id="stepname"
									style="height:25px" name="stepname" 
									data-options="required:true,validType:'integ'" /><font color="red">*</font></td>

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
									角色编码：</td>
								<td class="FieldInput2"><input id="doroleid"
									style="height:25px" name="doroleid" 
									data-options="required:true,validType:'integ'" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									角色名称：</td>
								<td class="FieldInput2"><input id="dorolename"
									style="height:25px" name="dorolename"
									data-options="required:true,validType:'integ'" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2">启用标志：</td>
								<td class="FieldInput2"><select class="easyui-combobox" id="isvalid" name="isvalid" data-options="panelHeight:'auto',editable:false" style="height:25px;width:130px;">
							<option value="1">在用</option>
							<option value="0">停用</option>
					        </select></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									下一环节编号(同意)：</td>
								<td class="FieldInput2"><input id="yesNextop"
									style="height:25px"  name="yesNextop" 
									data-options="required:true" /></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									下一环节名称(同意)：</td>
								<td class="FieldInput2"><input id="yesnexbutton"
									style="height:25px" name="yesnexbutton" 
									 /></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									下一环节编号(不同意)：</td>
								<td class="FieldInput2"><input id="Nonextop"
									style="height:25px"  name="Nonextop" 
									data-options="required:true" /></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									下一环节名称(不同意)：</td>
								<td class="FieldInput2"><input id="nonextbutton"
									style="height:25px" name="nonextbutton" 
									 /></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									是否有功能按键：</td>
								<td class="FieldInput2"><select class="easyui-combobox" id="Opbutton" name="Opbutton" data-options="panelHeight:'auto',editable:false" style="height:25px;width:130px;">
							<option value="1">有</option>
							<option value="0">无</option>
					        </select></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									功能名称：</td>
								<td class="FieldInput2"><input id="Opbuttonname"
									style="height:25px" name="Opbuttonname" 
									data-options="required:true" /></td>

							</tr>
							<tr>
								<td class="FieldLabel2">功能URL：</td>
								<td class="FieldInput2"><input id="Ophtml"
									style="height:25px" name="Ophtml" 
									data-options="required:true"  /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">状态编号：</td>
								<td class="FieldInput2"><input id="fstatusid"
									style="height:25px" name="fstatusid" class="easyui-validatebox"
									data-options="required:true"  /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">状态名称：</td>
								<td class="FieldInput2"><input id="fstatus"
									style="height:25px" name="fstatus" 
									data-options="required:true"  /><font color="red">*</font></td>
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
</body>	