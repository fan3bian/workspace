<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>

<body>
	<style type="text/css">
.FieldInput2 {
	width: 77%;
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
	width: 23%;
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
			
			$("#details").hide();
			loadUUcFunction();
			loadAppid();
			loadDataGrid();
			//loadOrgTree();
			//loadOrgTree(roleid);
		});
		function loadAppid()
		{
			$('#appid').combobox({ 
				data: [{
					id: '1',
					appname: '运维'
				},{
					id: '2',
					appname: '门户'
				}],   
			    valueField:'id',    
			    textField:'appname'  
			});  
			
		}
		function loadUUcFunction()
		{
			$('#fnameuuc').combobox({    
			    url:'${pageContext.request.contextPath}/authMgr/getComboFunction.do?',    
			    valueField:'fid',    
			    textField:'fname',
			    onSelect:function(param)
			    {
				    $("#fname").val(param.fname);
					$("#ename").val(param.ename);
					$("#fid").val(param.fid);
					$("#hname").val(param.hname);
					$("#fic").val(param.fic);
			    } 
			});  
			
		}
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								url : '${pageContext.request.contextPath}/authMgr/getAllRole.do',
								onSelect : function(rowIndex, rowData) {
									loadOrgTree(rowData.roleid);
									loadDataOrg(rowData.datalevel);
								},
								onLoadSuccess : function(data) {
									//debugger;
									$(this).datagrid('selectRow', 0);
								}
							});

		}
		function loadOrgTree(roleid) {
			$("#details").hide();
			$("#roleid").val(roleid);
			$
					.ajax({
						type : 'post',
						url : '${pageContext.request.contextPath}/authMgr/getCheckedFunction.do?roleid='
								+ roleid,
						//url : '${pageContext.request.contextPath}/web/systemMg/tree_data1.json',
						success : function(data) {
							//debugger;
							var myJson = eval('(' + data + ')');
							// alert(data);
							$("#tree")
									.tree(
											{
												animate : true,
												lines : true,
												checkbox : false,
												data : myJson,
												onSelect : function(node) {

													//根节点
													if (node.id == "0") {
															$("#details").hide();
													} else {
															$("#details").show();
														setTableValue(node);
													}
												},
												onClick : function(node) {
													$(this)
															.tree(
																	node.state === 'closed' ? 'expand'
																			: 'collapse',
																	node.target);
													node.state = node.state === 'closed' ? 'open'
															: 'closed';

												},
												onContextMenu : function(e,
														node) {
													e.preventDefault();
													//alert(node.target);
													// 查找节点
													$('#tree').tree('select',
															node.target);
													//alert(node.target);
													if (node.mlevel == 0) {
														// 显示快捷菜单
														$('#mr').menu('show', {
															left : e.pageX,
															top : e.pageY
														});
													} else if (node.mlevel != 3) {
														// 显示快捷菜单
														$('#mf').menu('show', {
															left : e.pageX,
															top : e.pageY
														});

													} else {
														// 显示快捷菜单
														$('#ms').menu('show', {
															left : e.pageX,
															top : e.pageY
														});
													}

												}

											});
						}
					});
		}
		function loadDataOrg(datalevel) {
			$("input[name='datalevel']").attr("checked", false);
			$("input[name='datalevel'][value=" + datalevel + "]").attr(
					"checked", true);
		}
		function dataUndo() {
			$("input[name='datalevel']").attr("checked", false);
		}

		function setTableValue(node) {
			//alert(node.mlevel+"级菜单");
			
			$('#tablepanel').panel({
				title : node.mlevel + "级菜单"
			});
			$("#fnameuuc").combobox("disable");
			$("#fnameuuc").combobox('setValue',node.fid);
			$("#fname").val(node.text);
			$("#mid").val(node.id);
			$("#fid").val(node.fid);
			$("#ename").val(node.text);
			$("#lastfuncname").val(
			$('#tree').tree('getParent', node.target).text);
			$("#parentid").val($('#tree').tree('getParent', node.target).id);
			$("#hname").val(node.hname);
			$("#fic").val(node.fic);
			$("#mno").val(node.mno);
			$("#mlevel").val(node.mlevel);
		
			$("#appid").combobox("disable"); 
			$("#appid").combobox('setValue',node.appid);
			$("#details").show();
		}
		function redo() {
			//alert('dddd');
			$("#fname").val('');
			$("#ename").val('');
			//$("#lastfuncname").val($('#tree').tree('getParent',node.target).text);
			$("#mno").val('-1');
		}
		function append()
		{
			$("#details").show();
			var node = $('#tree').tree('getSelected');
			$("#fnameuuc").combobox("enable");
			$("#fnameuuc").combobox('setValue','');
			if((node.mlevel+1)==1)
			{
				$("#appid").combobox("enable");
				$("#appid").combobox('select',1);
			}else
			{
				
				$("#appid").combobox("disable");
				$("#appid").combobox('setValue',node.appid);
			}
			$('#tablepanel').panel({ title: (node.mlevel+1)+"级菜单"});
			$("#fname").val('');
			$("#ename").val('');
			$("#mlevel").val(node.mlevel+1);
			$("#mid").val('');
			$("#fid").val('');
			$("#lastfuncname").val(node.text);
			$("#parentid").val(node.id);
			$("#hname").val('');
			$("#fic").val('');
			$("#mno").val('-1');
			$("#details").show();
		}
		function save()
		{
			var node = $('#tree').tree('getSelected');
			//alert(node.text);
			//alert(node.target);
			//$.messager.progress(); 
			$('#tableform').form('submit',{
		    url:urlrootpath+'/authMgr/addorupdateFuncAuth.do', 
		    onSubmit: function(){
		    	if($("#fnameuuc").combobox('getValue')==null || $.trim($("#fnameuuc").combobox('getValue'))=="")
		    	{
		    		$.messager.alert('消息',"功能名称不能为空!");  
		    		return false;
		    	}
		    	if($("#fname").attr("value")==null || $.trim($("#fname").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"功能别名不能为空!");  
		    		return false;
		    	}
		    	if(isNaN($("#mno").attr("value")))
		    	{
		    		$.messager.alert('消息',"序列值只能为数字!");  
		    		return false;
		    	}
		    	$("#ename").val( $("#fname").attr("value"));
		    	debugger;
		    },
		    success:function(retr){
		    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
		    	var _data =  JSON.parse(retr); 
		    	//alert("success: "+_data.success);
				if(_data.success){
					var id = $("#mid").attr("value");
					if(!id)
					{
						//如果id为null说明是插入得
						$('#tree').tree('append', {
							parent: (node?node.target:$('#tree').tree('getRoot')),
							data: [{
							    id: _data.obj,
							    text: $("#fname").attr("value"),
						        children: [],
						        state: "closed",
							    hname:$("#hname").attr("value"),
							    fid: $("#fid").attr("value"),
							    appid:$("#appid").combobox('getValue'),
							    fic:$("#fic").attr("value"),
								mno:$("#mno").attr("value"),
								mlevel:node.mlevel+1
						                }]
						});
						 $('#tree').tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);  
    					 node.state = node.state === 'closed' ? 'open' : 'closed';  
						//$('#tree').tree('reload', node.target);
						$('#tree').tree('select', $('#tree').tree('find', _data.obj).target);
					}else
					{
						//反之为更新的
						$('#tree').tree('update', {
								target: node.target,
								text: $("#fname").attr("value"),
								hname:$("#hname").attr("value"),
								fic:$("#fic").attr("value"),
								mno:$("#mno").attr("value"),
							});

					}
					
		    	}
		    	$.messager.alert('消息',_data.msg);  
				
		    }
		});
		}
		function removes()
		{
			var node = $('#tree').tree('getSelected');
			$.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
			    if (r){ 
			    	$('#tableform').form('submit',{
		   				 	url:urlrootpath+'/authMgr/delFuncAuth.do',
		   				 	 onSubmit: function(){
		   				 	 	debugger;
		   				 	 		var ids ="";
									ids = node.id+",";
									var children = $('#tree').tree('getChildren',node.target);
									for(var i = 0 ;i<children.length;i++)
									{
										ids= ids + children[i].id+",";
									}
		   				 	 	$("#mid").val(ids);
		   				 	 },
		      				success:function(retr){
			      				var data =  JSON.parse(retr); 
						    	if(data.success)
						    	{
						    		var parent = $('#tree').tree('getParent',node.target);
						    	
						    		$('#tree').tree('remove', node.target);
						    		//remove 最后一个变为叶子节点，bug，占且无法修改。
						    		$('#tree').tree('select', parent.target);
						    		if(parent.id!="0")
						    		{
						    			setTableValue(parent);
						    		}
						    	}
						    	$.messager.alert('消息',data.msg);   
					  		  } 
					});
			    	//$.messager.alert('消息','确认删除');     
			   	 }    
			});  		
		}
		function dataSave()
		{
			
		    var role =  $("#dg").datagrid('getSelected');
		    var roleid = role.roleid;
			var value = $("input[name='datalevel']:checked").val();
			$.ajax({
						type : 'post',
						url : '${pageContext.request.contextPath}/authMgr/updateRoleDataAuth.do?roleid='
								+ roleid+'&value='+value,
						//url : '${pageContext.request.contextPath}/web/systemMg/tree_data1.json',
						success : function(retr) {
							var _data =  JSON.parse(retr); 
							if(_data.success)
					    	{
					    		debugger;
					    		//$('#dg').datagrid('updateRow',{index:$('#dg').datagrid('getRowIndex','数据行的id'),row:{name:'xxxxxx00000'}})
					    		$("#dg").datagrid(('updateRow'),{
									index:$('#dg').datagrid('getRowIndex',role),
									row: {
										roleid: value
									}
									});
					    		
					    	}
					    	$.messager.alert('消息',_data.msg);   
						}
					});
		}
	</script>
	<div class="easyui-layout" data-options="border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px; width:100%;height:93%">
			<div data-options="region:'west',split:true,border:false" title="角色列表"
				style="width:25%;">
				<table id="dg" title="" style="width:100%;"
					data-options="singleSelect:true,border:false,fitColumns:true,method:'post'">
					<thead>
						<tr>
							<th data-options="hidden:'true',field:'roleid'"></th>
							<th data-options="field:'rolename',width:30,align:'center'">角色名称</th>
							<th data-options="hidden:'true',field:'datalevel'"></th>
							<!-- <th data-options="field:'roledesc',width:70,align:'left'">角色说明</th>  -->
						</tr>
					</thead>
				</table>
			</div>
			<div class="easyui-tabs" style="width:75%;height:100%"
				data-options="border:false,region:'center',title:'权限分配',iconCls:'icon-ok'">
				
				<div id="fucntion" title="功能权限分配"  class="easyui-layout" data-options="border:false"
					style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px; width:100%;height:93%">
					<div data-options="region:'west',split:true,border:true" title=""
						style="width:30%;"
						style="padding:5px 5px 5px 5px;margin:10px 5px 10px 40px; ">
						<ul id="tree" class="easyui-tree"></ul>
					</div>
					<div id="details" data-options="border:false,region:'center',title:'详细信息',iconCls:'icon-ok'"
						style="padding:5px 5px 5px 5px;margin:10px 5px 10px 40px;width:70%;">
						<a href="#" onClick="javascript:save();"
							class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp;
						<a href="#" onClick="javascript:redo();"
							class="easyui-linkbutton" data-options="iconCls:'icon-redo'">重置</a>
						<div style="height:10px"></div>
						<div id="tablepanel" class="easyui-panel" title="菜单项"
								style="width:80%;">
								<form id="tableform" method="post">
								
										<input id="roleid" name="roleid" type="hidden" />
										<input id="mid" name="mid" type="hidden" />
										<input id="fid" name="fid" type="hidden" /> <input
											id="parentid" name="parentid" type="hidden" />
										<input id="ename" name="ename" type="hidden" value="1" /> <input
											id="mlevel" name="mlevel" type="hidden" />
										<table align="center" name="" style="width:80%">
											<tr>
												<td class="FieldLabel2" style="border-top:!important;">
													功能名称：</td>
												<td class="FieldInput2"><select class="easyui-combobox" id="fnameuuc" name="fnameuuc" style="height:25px;width:50%;"></select><font color="red">*</font>
												</td>
												</tr>
												<tr>
												<td class="FieldLabel2" style="border-top:!important;">
													功能别名：</td>
												<td class="FieldInput2"><input id="fname"
													style="height:25px;width:50%;" name="fname" class="easyui-validatebox"
													data-options="required:true" /><font color="red">*</font></td>

											</tr>
											<tr>
												<td class="FieldLabel2">上一级菜单：</td>
												<td class="FieldInput2"><input type="text"
													name="lastfuncname" id="lastfuncname" readonly="readonly"
													style="border:none !important;background:none !important;height:25px;width:100%;"
													value="上一级菜单" /></td>
											</tr>
											<tr>
												<td class="FieldLabel2">所属系统：</td>
												<td class="FieldInput2"><select style="height:25px;width:50%;" class="easyui-combobox" id="appid"
													name="appid">
												</select></td>
											</tr>
											<tr>
												<td class="FieldLabel2">URL：</td>
												<td class="FieldInput2"><input type="text" id="hname" readonly="readonly"
													style="border:none !important;background:none !important;height:25px;width:100%;" name="hname"
													 value="#" /></td>
											</tr>
											<tr>
												<td class="FieldLabel2">前置图标：</td>
												<td class="FieldInput2"><input id="fic" type="text" readonly="readonly"
													style="border:none !important;background:none !important;height:25px;width:100%;" name="fic" value="images/normal.png" /></td>
											</tr>
											<tr>
												<td class="FieldLabel2">序列值：</td>
												<td class="FieldInput2"><input id="mno"
													style="height:25px" name="mno" class="easyui-validatebox"
													data-options="required:true" value="0" /><font color="red">*（只填数字）</font></td>
											</tr>
										</table>
									</form>
						</div>
					</div>
				</div>
				
				
				<div title="数据权限分配"
					style="padding:5px 5px 5px 5px;margin:10px 5px 10px 40px; ">
					<a href="#" onClick="javascript:dataSave();"
						class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
					<a href="#" onClick="javascript:dataUndo();"
						class="easyui-linkbutton" data-options="iconCls:'icon-undo'">重置</a>
					<div style="height:10px"></div>
					<div>
						<input type="radio" name="datalevel" value="1"><span>资源</span><br />
						<input type="radio" name="datalevel" value="10"><span>资源池</span><br />
						<input type="radio" name="datalevel" value="2"><span>机房</span><br />
						<input type="radio" name="datalevel" value="3"><span>地市</span><br />
						<input type="radio" name="datalevel" value="4"><span>省</span><br />
						<input type="radio" name="datalevel" value="5"><span>节点</span><br />
						<input type="radio" name="datalevel" value="6"><span>子账户</span><br />
						<input type="radio" name="datalevel" value="7"><span>父账户</span><br />
						<input type="radio" name="datalevel" value="8"><span>角色</span><br />
						<input type="radio" name="datalevel" value="9"><span>全部</span>
					</div>
				</div>
			</div>
		</div>
		<div id="mr" class="easyui-menu" style="width:120px;">
			<div onclick="append()" data-options="iconCls:'icon-add'">追加</div>
		</div>
		<div id="mf" class="easyui-menu" style="width:120px;">
			<div onclick="append()" data-options="iconCls:'icon-add'">追加</div>
			<div onclick="removes()" data-options="iconCls:'icon-remove'">移除</div>
		</div>
		<div id="ms" class="easyui-menu" style="width:120px;">
			<div onclick="removes()" data-options="iconCls:'icon-remove'">移除</div>
		</div>
</body>