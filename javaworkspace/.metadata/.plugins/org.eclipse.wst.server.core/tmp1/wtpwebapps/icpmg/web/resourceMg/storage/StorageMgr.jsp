<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<style type="text/css">
		.FieldInput2 {
			width:35%;
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
			width:20%;
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
	<script type="text/javascript">
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
				{
					$("#tableform").form('reset'); 
					$("#storageid").val('');
					//resetContent('resetContent');
					$('#w').window('open');
				}
			},{
					text:'删除',
					iconCls:'icon-remove',
					handler:storage_removeFun
					},{
						text:'修改',
						iconCls:'icon-modify',
						handler:storage_preEdit
						}];
		function resetContent(formId) {
			var clearForm = document.getElementById(formId);
			if (null != clearForm && typeof(clearForm) != "undefined") {
				clearForm.reset();
				}
			}

		function storage_removeFun() {
			var rows = $('#dg').datagrid('getChecked');
			//var rows = $('#dg').datagrid('getChecked');
			var ids = [];
			if (rows.length > 0) {
				$.messager.confirm('确认', '您是否要删除当前选中的项目？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
								ids.push(rows[i].storageid);
						}
						$.ajax({
							url : urlrootpath+'/storage/deleteStorages.do',
							data : {
								ids : ids.join(',')
							},
							dataType : 'json',
							success : function(result) {
								if (result.success) {
									$.messager.alert('消息',result.msg); 
									$('#dg').datagrid('load');
									$('#dg').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
								}else{
									$.messager.alert('消息','删除失败'); 
								}
							}
						});
					}
				});
			} else {
				$.messager.alert('消息','请至少选择一条记录！'); 
			}
		}
		
		function storage_preEdit(){
			var rows = $('#dg').datagrid('getSelections');
			//var rows = $('#dg').datagrid('getChecked');
			var ids = [];
			
			if (rows.length ==1) {
			
						for ( var i = 0; i < rows.length; i++) {
								ids.push(rows[i].storageid);
						}
						console.log(ids);
						console.log(rows);
						$.ajax({
							url : urlrootpath+'/storage/queryStorage.do',
							data : {
								ids : ids.join(',')
							},
							dataType : 'json',
							success : function(result) {
								console.log(result);
								$('#tableform').form('load',result.obj);
								$('#w').window('open');
							}
						});
			} else if (rows.length == 0) {
				$.messager.alert('消息','请至少选择一条记录！'); 
			}else if (rows.length >1) {
				$.messager.alert('消息','只能选择一条记录！'); 
			}
		}
		$(document).ready(function() {
			loadDataGrid();
		});
		function loadDataGrid()
			{
				$('#dg').datagrid({
					rownumbers:false,
					checkOnSelect:true,
					selectOnCheck:true,
					border:false,
					striped:true,
					sortName:'fname',
					sortOrder:'asc',
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'storageid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/storage/storageMgrAction.do',   
					}); 
				
			}
			
		function searchDataGrid(){
			
			$('#dg').datagrid('load',icp.serializeObject($('#funcmgr_searchform')));
		};
		function submitSave(){
		//	var obj = icp.serializeObject($("#tableform"));
		var serverid = $("#tableform input[id='storageid']").val();
		var url =null;
		$("#poolname").val($("#poolid").combobox('getText'));
		if(serverid== null ||serverid=='undefined'||serverid==''){
			 url =urlrootpath+'/storage/addStorage.do';
		}else{
			url =urlrootpath+'/storage/modifyStorage.do';
		}
		//console.log(serverid+','+url);
		//return false;	
		
			$('#tableform').form('submit',{
			    url:url,
			    onSubmit: function(){
			    	
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			     	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
						$('#dg').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
			    	} 
			    	
					$('#w').window('close');
			    }
			});
		}
		
		
		function curStatFormatter (value,row,index){
			if (value =="Running"){
				return '运行中';
			} else if(value =="Stopped") {
				return '已停止';
			} else if(value =="Starting"){
				return '正在启用';
			} else if(value =="Stopping"){
				return '正在停止';
			}else{
				return value;
			}
		}
	
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
			<form id="funcmgr_searchform">
				<table class="tableForm datagrid-toolbar">
					<tr>
						<td>存储名称：<input class="easyui-textbox" name="servername"  id="servername" style="width:200px"></td>
						<td>状态：<select class="easyui-combobox" name="status" id="status" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px">
								<option value="-1" selected>全部</option>
								<option value="running">运行中</option>
								<option value="stopped">已停止</option>
								<option value="starting">正在启用</option>
								<option value="stoping">正在停止</option>
								</select>
						</td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#funcmgr_searchform input').val('');$('#servername').textbox('clear');$('#status').combobox('select','-1');">重置</a>
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
						<th data-options="field:'storageid',hidden:true"></th>
						<th data-options="field:'storagename',width:120,align:'center',sortable:true">存储名称</th>
						<th data-options="field:'description',width:80,align:'center',hidden:true">描述信息</th>
						<th data-options="field:'storagetotal',width:80,align:'center'">总容量</th>
						<th data-options="field:'storageleft',width:80,align:'center'">剩余容量</th>
						<th data-options="field:'storageready',width:80,align:'center'">置备容量</th>
					
						<th data-options="field:'curstatus',width:80,align:'center',formatter:curStatFormatter">状态</th>
						
					</tr>
				</thead>
			</table>
		</div>
		
		<div id="w" class="easyui-window" title="存储信息维护" data-options="closed:true,iconCls:'icon-save',inline:true" 
						style="width:600px;height:220px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<form id="tableform" method="post">
							<input id="storageid" name="storageid" type="hidden"  />
							<input id="poolname" name="poolname" type="hidden"  />
						<table align="center"  style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									存储名称：</td>
								<td class="FieldInput2"><input id="storagename"
									style="height:25px" name="storagename" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							<td class="FieldLabel2">描述信息：</td>
								<td class="FieldInput2"><input id="description"
									style="height:25px" name="description" class="easyui-textbox"
									data-options="required:true"  /></td>
								
							</tr>
							<tr>
								<td class="FieldLabel2">总容量：</td>
								<td class="FieldInput2"><input id="storagetotal"
									style="height:25px" name="storagetotal" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
						
								<td class="FieldLabel2">剩余容量：</td>
								<td class="FieldInput2"><input id="storageleft"
									style="height:25px" name="storageleft" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">置备容量(G)：</td>
								<td class="FieldInput2"><input id="storageready"
									style="height:25px" name="storageready" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
								<td class="FieldLabel2">所属资源池 ：</td>
								<td class="FieldInput2">
									<input id="poolid" style="height:25px" name="poolid" class="easyui-combobox"
									data-options="valueField:'poolid',textField:'poolname',url:'../../pool/getAllPool.do',panelHeight:60,height:60" />
								</td>
								
							</tr>
						
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="submitSave();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
	</div>
	
		
</body>
</html>