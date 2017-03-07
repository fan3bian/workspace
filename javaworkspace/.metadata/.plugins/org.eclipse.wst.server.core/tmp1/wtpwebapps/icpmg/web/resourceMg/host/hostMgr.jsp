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
					$("#serverid").val('');
					//resetContent('resetContent');
					$('#w').window('open');
				}
			},{
					text:'删除',
					iconCls:'icon-remove',
					handler:host_removeFun
					},{
						text:'修改',
						iconCls:'icon-modify',
						handler:host_preEdit
						},{
							text: '运行概况',
							iconCls: 'icon-objmanage',
							handler: function () {
								var rows = $('#dg').datagrid('getChecked');
								if (rows.length != 1) {
									$.messager.alert('消息', '请选择一条记录！');
									return;
								} 				
								var neid = rows[0].serverid;
								var orgUrl = '/icpmg/web/omsMonitor/inhost/jsp/runOverview.jsp';
								
								//alert(neid);
								$('#centerTab').panel({
									href:encodeURI(orgUrl),
									queryParams:{
										typeid:'HOST',
										neid:neid
									}
									});	

							}
						}];
	
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

		function resetContent(formId) {
			var clearForm = document.getElementById(formId);
			if (null != clearForm && typeof(clearForm) != "undefined") {
				clearForm.reset();
				}
			}

		function host_removeFun() {
			var rows = $('#dg').datagrid('getChecked');
			//var rows = $('#dg').datagrid('getChecked');
			var ids = [];
			if (rows.length > 0) {
				$.messager.confirm('确认', '您是否要删除当前选中的项目？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
								ids.push(rows[i].serverid);
						}
						$.ajax({
							url : urlrootpath+'/host/deleteHosts.do',
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
		
		function host_preEdit(){
			var rows = $('#dg').datagrid('getSelections');
			var ids = [];
			if (rows.length ==1) {
						for ( var i = 0; i < rows.length; i++) {
								ids.push(rows[i].serverid);
						}
						$.ajax({
							url : urlrootpath+'/host/queryHosts.do',
							data : {
								ids : ids.join(',')
							},
							dataType : 'json',
							success : function(result) {
								$('#tableform').form('load',result.obj);
								$('#w').window('open');
							}
						});
			} else if (rows.length ==0) {
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
					border:false,
					striped:true,
					sortName:'fname',
					sortOrder:'asc',
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'serverid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar, 
				//	 singleSelect:true,
				    url:'${pageContext.request.contextPath}/host/hostMgrAction.do'
				   
					}); 
				
			}
			
		function searchDataGrid(){
			
			$('#dg').datagrid('load',icp.serializeObject($('#funcmgr_searchform')));
		};
		 function reset() {
				$('#funcmgr_searchform input').val('');
				$('#dg').datagrid('load', {});}
		function submitSave(){
			  if(!$("#tableform").form('validate')){
			    	 return false;
			     }
			  ////////
			 
		//	var obj = icp.serializeObject($("#tableform"));
		var serverid = $("#tableform input[id='serverid']").val();
		var url =null;
		$("#poolname").val($("#poolid").combobox('getText'));
		
		if(serverid== null ||serverid=='undefined'||serverid==''){
			 url =urlrootpath+'/host/addHost.do';
		}else{
			url =urlrootpath+'/host/modifyHost.do';
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
	
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
			<form id="funcmgr_searchform">
				<table class="tableForm datagrid-toolbar">
					<tr>
						<td>宿主机名称：<input class="easyui-textbox" name="servername"  id="servername" style="width:200px"></td>
						<td>状态：<select class="easyui-combobox" name="status" id="status" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px">
								<option value="-1" selected>全部</option>
								<option value="running">运行中</option>
								<option value="stopped">已停止</option>
								<option value="starting">正在启用</option>
								<option value="stoping">正在停止</option>
								</select>
						</td>
						<td>		
						    &nbsp;&nbsp;所属平台：<input
							class="easyui-combobox" 
							name="searchPlatform" 
						    id="searchPlatform"
							style="width: 120px; align-text: center"
							data-options="panelHeight:100,
								url:'${pageContext.request.contextPath}/alarm/getPlatfrom.do',
							    valueField:'id',
								textField:'name',
								" />
					    
						</td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="reset();$('#funcmgr_searchform input').val('');$('#servername').textbox('clear');$('#status').combobox('select','-1');">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<input id="poolname" name="poolname" type="hidden"  />
			<table title="" style="width:100%;"  id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th> 
						<th data-options="field:'serverid',hidden:true"></th>
						<th data-options="field:'servername',width:120,align:'center',sortable:true">宿主机名称</th>
						<th data-options="field:'platformid',width:80,align:'center',hidden:true">所属平台id</th>
						<th data-options="field:'cpunum',width:80,align:'center'">cpu核数</th>
						<th data-options="field:'cpuappnum',width:80,align:'center'">CPU可用核数</th>
						<th data-options="field:'memnum',width:80,align:'center'">内存大小</th>
						<th data-options="field:'memappnum',width:80,align:'center'">内存可用大小</th>
						<th data-options="field:'throughput',width:80,align:'center'">磁盘吞吐量</th>
						<th data-options="field:'plattype',width:80,align:'center'">平台类型</th>
						<th data-options="field:'platformname',width:80,align:'center'">所属平台</th>
						<th data-options="field:'cluster',width:80,align:'center',hidden:true">所属集群</th>
						<th data-options="field:'dataCenter',width:80,align:'center',hidden:true">所属数据中心</th>
						<th data-options="field:'netcardnum',width:80,align:'center',hidden:true">网卡数</th>
						<th data-options="field:'netcardtype',width:80,align:'center',hidden:true">网卡类型</th>
						<th data-options="field:'Bandwidth',width:80,align:'center'">带宽</th>
						<th data-options="field:'flowload',width:80,align:'center'">吞吐量</th>
						<th data-options="field:'ip',width:80,align:'center',hidden:true">IP地址</th>
						<th data-options="field:'ipmi',width:80,align:'center',hidden:true">IP管理信息</th>
						<th data-options="field:'hba',width:80,align:'center',hidden:true">HBA</th>
						<th data-options="field:'osname',width:80,align:'center'">操作系统</th>
						<th data-options="field:'curstatus',width:80,align:'center',formatter:curStatFormatter">状态</th>
						
					</tr>
				</thead>
			</table>
		</div>
		
		<div id="w" class="easyui-window" title="宿主机信息维护" data-options="closed:true,iconCls:'icon-save',inline:true" 
						style="width:600px;height:420px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<form id="tableform" method="post">
							<input id="serverid" name="serverid" type="hidden"  />
						<table align="center"  style="width:100%">
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									宿主机名称：</td>
								<td class="FieldInput2"><input id="servername"
									style="height:25px" name="servername" class="easyui-textbox"
									data-options="required:true,missingMessage:'该输入项为必填项'" /><font color="red">*</font></td>

							<td class="FieldLabel2">描述信息：</td>
								<td class="FieldInput2"><input id="description"
									style="height:25px" name="description" class="easyui-textbox"
								 /></td>
								
							</tr>
							<tr>
								<td class="FieldLabel2">cpu颗数：</td>
								<td class="FieldInput2"><input id="cpunum"
									style="height:25px" name="cpunum" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
						
								<td class="FieldLabel2">cpu可用数：</td>
								<td class="FieldInput2"><input id="cpuappnum"
									style="height:25px" name="cpuappnum" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">内存总数(G)：</td>
								<td class="FieldInput2"><input id="memnum"
									style="height:25px" name="memnum" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
						
								<td class="FieldLabel2">内存可用数：</td>
								<td class="FieldInput2"><input id="memappnum"
									style="height:25px" name="memappnum" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">硬盘吞吐量:(MB/s)：</td>
								<td class="FieldInput2"><input id="throughput"
									style="height:25px" name="throughput" class="easyui-numberbox"
									  /></td>
						
								<td class="FieldLabel2">流量负载:(MB/s)</td>
								<td class="FieldInput2"><input id="flowload"
									style="height:25px" name="flowload" class="easyui-numberbox"
									  /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">网卡数量：</td>
								<td class="FieldInput2"><input id="netcardnum"
									style="height:25px" name="netcardnum" class="easyui-numberbox"
									data-options="required:true,min:1"  /></td>
						
								<td class="FieldLabel2">网卡类型：</td>
								<td class="FieldInput2"><input id="netcardtype"
									style="height:25px" name="netcardtype" class="easyui-textbox"
									/></td>
							</tr>
					
							<tr>
							
						<td class="FieldLabel2">操作系统：</td>
								<td class="FieldInput2">
								<select id="oname" class="easyui-combobox" name="osname" >   
								    <option value="linux">linux</option> 
								     <option value="ubantu14"> ubantu14</option>    
								    <option  value="ws2008">window server2008</option>   
								    <option  value="ws2003">window server2003</option>   
								</select>  <font color="red">*</font></td>
								
								<td class="FieldLabel2">所属平台：</td>
								<td class="FieldInput2">
									<input id="platformid"
									style="height:25px" name="platformid" class="easyui-combobox"
									data-options="valueField:'platformid',textField:'platformname',url:'../../host/platform.do'" />
									</td>
							</tr>
							<tr>
								<td class="FieldLabel2">IP：</td>
								<td class="FieldInput2"><input id="ip"
									style="height:25px" name="ip" class="easyui-textbox"
									data-options="required:true,prompt:'IP',validType:'ip',missingMessage:'请输入正确的ip地址'"  /><font color="red">*</font></td>
						
								<td class="FieldLabel2">IPMI：</td>
								<td class="FieldInput2"><input id="ipmi"
									style="height:25px" name="ipmi" class="easyui-textbox"
									 /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">HBA：</td>
								<td class="FieldInput2"><input id="hba"
									style="height:25px" name="hba" class="easyui-textbox"
									/></td>
								<td class="FieldLabel2">带宽：</td>
								<td class="FieldInput2"><input id="bandwidth"
									style="height:25px" name="bandwidth" class="easyui-textbox"
									 /></td>
							</tr>
							<tr>
								<td class="FieldLabel2">所属资源池 ：</td>
								<td class="FieldInput2">
								<input id="poolid"
									style="height:25px" name="poolid" class="easyui-combobox"
									data-options="valueField:'poolid',textField:'poolname',url:'../../pool/getAllPool.do',panelHeight:60,height:60" /></td>
								<td class="FieldLabel2">所属集群 ：</td>
								<td class="FieldInput2">
								<input id="clutter"
									style="height:25px" name="clutter" class="easyui-textbox"
									  />
								</td>
						
							</tr>
								<tr>
							
								<td class="FieldLabel2">所属数据中心：</td>
								<td class="FieldInput2">
								<input id="dataCenter"
									style="height:25px" name="dataCenter" class="easyui-textbox"
									data-options=""  />
								</td>
								<td class="FieldLabel2"></td>
								<td class="FieldInput2">
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