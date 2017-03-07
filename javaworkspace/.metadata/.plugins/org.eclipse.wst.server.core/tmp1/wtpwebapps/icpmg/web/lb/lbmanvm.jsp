<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
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
var grid1;
var vmtoolbar = [
						{
							text:'新增后端服务器配置',
							iconCls:'icon-add',
							handler:function(){ 
								$('#w2CreateForm').form('clear');
								//initacl();
								initCombobox();
								$('#w2').window('open');
							} 
						}
                       ];
$(document).ready(function() {
	loadDataGrid1();
	$('#vm_backport').textbox({//端口
		onChange: function(param){
			checkPort(param);
		}
	});
	$('#ebackport').textbox({//端口
		onChange: function(param){
			checkPort(param);
		}
	});
});
function initacl(listtype){
	if(listtype=='1'){
		$('#acltr').show();
	}else{
		$('#acltr').hide();
	}
	$('#acl').combobox({    
		url:'${pageContext.request.contextPath}/lb/lbBvmAclInit.do?lbid=' + $("#tabs_lbid").val(),    
		valueField:'aclid',    
		textField:'aclname',
		onSelect: function(rec){
	    }
	});  
}
function einitacl(listtype,aclid){
	$('#eacl').combobox({    
		url:'${pageContext.request.contextPath}/lb/lbBvmAclInit.do?lbid=' + $("#tabs_lbid").val(),    
		valueField:'aclid',    
		textField:'aclname',
		onSelect: function(rec){
	    }
	});  
	if(listtype=='1'){
		$('#eacltr').show();
		$('#eacl').combobox('select',aclid);
	}else{
		$('#eacltr').hide();
	}
}
function initCombobox(){
	$('#listport_v').combobox({    
	    url:'${pageContext.request.contextPath}/lb/beforeSaveLbServer1.do?lbid=' + $("#tabs_lbid").val(),    
	    valueField:'listport',    
	    textField:'listport',
	    type:'listtype',
    	onSelect: function(rec){
    		initacl(rec.listtype);
    		//getvms(rec.listport);
    		getapp(rec.listport);
        }
	});
}
function getapp(listport){
	$('#appname').combobox({    
	    url:'${pageContext.request.contextPath}/lb/getAppname.do?lbid=' + $("#tabs_lbid").val() + '&listport=' + listport,    
	    valueField:'appname',    
	    textField:'appname',
    	onSelect: function(rec){  
    		//getvmipCombobox(rec.serverid);
    		getvms(listport,rec.appname);
        }
	});
}

function getvms(listport,appname){// get backend VMs by listenport
	$('#vms').combobox({    
	    url:'${pageContext.request.contextPath}/lb/queryExitOwnVMs.do?lbid=' + $("#tabs_lbid").val() + '&listport=' + listport+ '&appname=' + appname,     
	    valueField:'serverid',    
	    textField:'serverid',
    	onSelect: function(rec){  
    		//getvmipCombobox(rec.serverid);
    		$('#vm_ip').combobox('setValue',rec.sip);
        }
	});
}
function getvmipCombobox(serverid){
	$('#vm_ip').combobox({    
	    url:'${pageContext.request.contextPath}/lb/getIpsByServerid.do?serverid=' + serverid,    
	    valueField:'ip',    
	    textField:'ip',
    	onSelect: function(rec){  
        }
	});
}
//修改   backvm 获取 ip
function getvmipCombobox2(serverid){
	$('#evm_ip').combobox({    
	    url:'${pageContext.request.contextPath}/lb/getIpsByServerid.do?serverid=' + serverid,    
	    valueField:'ip',    
	    textField:'ip',
    	onSelect: function(rec){  
        }
	});
}
//查询结果
function loadDataGrid1(){
	grid1 = $('#vm_grid').datagrid({
		singleSelect:true,
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar:vmtoolbar,    
	    url:'${pageContext.request.contextPath}/lb/queryLbServers.do?lbid=' + $("#tabs_lbid").val(),
	    onLoadSuccess: function (data) {
		      var pageopt = $('#vm_grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#vm_grid').datagrid("getRows").length;
		      var total = pageopt.total;
		        
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {lbid :''  });
		         }
		         $('#vm_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
		       
		      }else{
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		      var rows = data.rows;
		      if (rows.length) {
					 $.each(rows, function (idx, val) {
						if   (val.lbid ==''){ 
							$('#acl_grid_div input:checkbox').eq(idx+1).css("display","none");
						}
					}); 
		      }
		 }
	 }); 
}
function reset(){
	$('#vm_grid').datagrid('load',{});
}
function curstatformater(value, row, index) {
	switch (value) {
		case "UP":
			return "运行中";
		case "DOWN":
			return "停止";
	}
}
function vmoptionformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = "<a href=\"javascript:void(0);\" onclick=\"editlbserver(\'" 
		 + row.lbname + "\', \'" + row.listport + "\', \'" 
		 + row.serverid + "\', \'" + row.serverip + "\', \'" 
		 + row.backport + "\', \'" + row.weight + "\', \'" + row.acl +"\');\">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"delbefore1(\'" + row.serverid + "\',\'" + row.backport + "\',\'" + row.listport +"\',\'" + row.serverip + "\',\'" + row.acl +"\');\">删除</a>"; 
	return str;
} 
function editlbserver(lbname,listport,serverid,serverip,backport,weight,aclid) {
		jQuery.ajax( {
		url : "${pageContext.request.contextPath}/lb/queryBackVmName.do",
		data : {'serverid' :serverid ,
				'lbid':$("#tabs_lbid").val(),
				'listport':listport,
				'aclid':aclid},
		type : "post",
		cache : false,
		dataType : "json",
		success : function(result) {
			$('#evms').combobox('setValue', serverid).textbox('setText', serverid);
			$('#w2CreateForm').form('clear');
			$('#elbname').textbox('setValue', lbname).textbox('setText', lbname);
			$('#elistport_v').combobox('setValue', listport).textbox('setText', listport);
			$('#oldbackport').val(backport);
			$('#oldacl').val(aclid);
			$('#ebackport').textbox('setValue', backport).textbox('setText', backport);
			$('#oldip').val(serverip);
			$('#eweight').textbox('setValue', weight).textbox('setText', weight);
		//	getvmipCombobox2(serverid);
			$('#evm_ip').combobox('select', serverip);
			einitacl(result.listtype,aclid);
			$('#eappname').combobox('select', result.appname);
			$('#w3').window('open');
		}
	}); 
}
//后端服务器修改
function lbServerModify(){
	var lbname = $('#elbname').textbox('getValue');
	if(null == lbname || "" == lbname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var listport = $('#elistport_v').combobox('getValue');
	if(null == listport || "" == listport){
		$.messager.alert('提示信息','请选择端口！', 'info');
		return;
	}
	var serverid = $('#evms').combobox('getValue');
	if(null == serverid || "" == serverid){
		$.messager.alert('提示信息','请选择主机！', 'info');
		return;
	}
	var serverip = $('#evm_ip').combobox('getValue');
	if(null == serverip || "" == serverip){
		$.messager.alert('提示信息','请选择主机IP！', 'info');
		return;
	}
	var backport = $('#ebackport').textbox('getValue');
	if(null == backport || "" == backport){
		$.messager.alert('提示信息','请填写后端协议端口！', 'info');
		return;
	}
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(backport)){
		$.messager.alert('提示信息','后端协议端口请填写数字！', 'info');  
		return;
	}else if(backport<1 || backport>65535){
		$.messager.alert('提示信息','后端协议端口范围为1-65535！', 'info'); 
		return;
	}else if(backport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
	var weight = $('#eweight').textbox('getValue');
	if(isNaN(weight)){
		$.messager.alert('提示信息','权重要求填写数字！', 'info');
		return;
	}
	if(weight > 100 || weight < 0){
		$.messager.alert('提示信息','权重填写范围为0-100！', 'info');
		return;
	}
	if ($('#ew2CreateForm').form('validate')) {
		$('#ew2CreateForm').form('submit',{
				url : '${pageContext.request.contextPath}/lb/lbServerModify.do',
				onSubmit : function(param) {
					param.lbname = $('#elbname').textbox('getValue');
					param.listport = $('#elistport_v').combobox('getValue');
					param.serverid = $('#evms').combobox('getValue');
					param.serverip = $('#evm_ip').combobox('getValue');
					param.backport = $('#ebackport').textbox('getValue');
					param.weight = $('#eweight').textbox('getValue');
					param.lbid = $("#tabs_lbid").val();
					param.oldip=$("#oldip").val();
					param.oldbackport=$("#oldbackport").val();
					param.oldacl=$("#oldacl").val();
					param.acl=$('#eacl').combobox('getValue');
				},
				success : function(retr) {
					var _data = $.parseJSON(retr);
					if (_data.success) {
						$.messager.alert('提示', _data.msg,'info');
						loadDataGrid1();
					} else {
						$.messager.alert('提示', _data.msg,'error');
					}
					$('#w3').window('close');
					
				}
			});
	}
	
}
function delbefore1(serverid,backport,listport,serverip,acl){
	$.messager.confirm('系统提示信息', '当前配置删除后无法恢复，请谨慎操作，确定删除吗？', function(r){
		if (r){
			$('#vmManForm').form('submit',{
			    url:'${pageContext.request.contextPath}/lb/deleteLbServer.do', 
			    onSubmit : function(param) {
			    	param.lbid= $("#tabs_lbid").val();
					param.serverid=serverid;
					param.backport=backport;
					param.serverip=serverip;
					param.listport=listport;
					param.acl=acl;
				},
			    success:function(retr){
			    	var _data = $.parseJSON(retr);
					if (_data.success) {
						$.messager.alert('提示', _data.msg, 'info');
						loadDataGrid1();
					} else {
						$.messager.alert('提示', _data.msg, 'error');
					}
			    }
			});
		}
	});
}
function checkPort(backport){
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(backport)){
		$.messager.alert('提示信息','端口请填写数字！', 'info');  
		return;
	}else if(backport<1 || backport>65535){
		$.messager.alert('提示信息','端口范围为1-65535！', 'info'); 
		return;
	}else if(backport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
}
function addLbServer(){
	debugger;
	var lbname = $('#lbname').textbox('getValue');
	if(null == lbname || "" == lbname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var listport = $('#listport_v').combobox('getValue');
	if(null == listport || "" == listport){
		$.messager.alert('提示信息','请选择端口！', 'info');
		return;
	}
	var appname = $('#appname').combobox('getValue');
	if(null == appname || "" == appname){
		$.messager.alert('提示信息','请选择应用！', 'info');
		return;
	}
	var serverid = $('#vms').combobox('getValue');
	if(null == serverid || "" == serverid){
		$.messager.alert('提示信息','请选择主机！', 'info');
		return;
	}
	var serverip = $('#vm_ip').combobox('getValue');
	if(null == serverip || "" == serverip){
		$.messager.alert('提示信息','请选择主机IP！', 'info');
		return;
	}
	var backport = $('#vm_backport').textbox('getValue');
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(backport)){
		$.messager.alert('提示信息','后端协议端口请填写数字！', 'info');  
		return;
	}else if(backport<1 || backport>65535){
		$.messager.alert('提示信息','后端协议端口范围为1-65535！', 'info'); 
		return;
	}else if(backport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
	var weight = $('#weight').textbox('getValue');
	if(isNaN(weight)){
		$.messager.alert('提示信息','权重要求填写数字！', 'info');
		return;
	}
	if(weight > 100 || weight < 0){
		$.messager.alert('提示信息','权重填写范围为0-100！', 'info');
		return;
	}
	var acl= $('#acl').textbox('getValue');
	$('#w2CreateForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/saveLbServer.do', 
	    onSubmit : function(param) {
	    	param.lbid= $("#tabs_lbid").val();
			param.lbname=lbname;
			param.listport=listport;
			param.serverid=serverid;
			param.serverip=serverip;
			param.backport=backport;
			param.weight=weight;
			param.acl=acl;
			param.appname=appname;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				loadDataGrid1();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#w2').window('close');
	    }
	});
	
}
</script>
<form id="vmManForm"></form>
<div data-options="region:'center',border:false" id="vm_grid_div">
	<table title="" style="width:100%;"  id="vm_grid">
		<thead>
			<tr>
				<th data-options="field:'lbname',width:20,align:'center'">名称</th>
				<th data-options="field:'listport',width:12,align:'center'">监听端口</th>
				<th data-options="field:'serverip',width:18,align:'center'">IP</th>
				<th data-options="field:'backport',width:10,align:'center'">端口</th>
				<th data-options="field:'lsstatus',width:15,align:'center',formatter:curstatformater">状态</th>
				<th data-options="field:'weight',width:10,align:'center'">权重</th>
				<th data-options="field:'acl',width:10,align:'center',hidden:true">aclid </th>
				<th data-options="field:'serverid',width:15,align:'center',formatter:vmoptionformater">操作</th>
			</tr>
		</thead>
	</table>
</div>  
<div id="w2" class="easyui-window" title="新增后端服务器配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',singleSelect:true" 
style="width:480px;height:350px;padding:5px;top:57px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="w2CreateForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="listtpye">
			<table align="center" style="width:100%">
				<tr>
					<td class="FieldLabel2">名称：</td>
					<td class="FieldInput2">
						<input id="lbname" class="easyui-textbox" data-options="required:true,missingMessage:'此处为必填项'" style="height:30px;width:160px;"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">监听端口：</td>
					<td class="FieldInput2">	
						<select id="listport_v" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'"></select>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">应用名称：</td>
					<td class="FieldInput2">
						<select id="appname" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'">
						</select>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">主机：</td>
					<td class="FieldInput2">
						<select id="vms" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'">
						</select>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">主机IP：</td>
					<td class="FieldInput2">
						<select id="vm_ip" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'">
						</select><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">后端协议端口：</td>
					<td class="FieldInput2">
						<input id="vm_backport" class="easyui-textbox"	data-options="required:true,missingMessage:'请填写后端应用服务端口号'" style="height:30px;width:160px;" />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">权重：</td>
					<td class="FieldInput2">
						<input id="weight" class="easyui-textbox" data-options="required:true,missingMessage:'范围：1~100'" style="height:30px;width:160px;" />
						<font color="red">*</font>
					</td>
				</tr>
				<tr id ="acltr">
					<td class="FieldLabel2">Acl策略：</td>
					<td class="FieldInput2">
						<select id="acl" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'">
						</select><font color="red"></font>
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="addLbServer();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w2').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="w3" class="easyui-window" title="修改后端服务器配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',singleSelect:true" 
style="width:480px;height:350px;padding:5px;top:57px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="ew2CreateForm" method="post" data-options="novalidate:true">
			<input type="hidden" id ="oldip"/>
			<input type="hidden" id ="oldbackport"/>
			<input type="hidden" id ="oldacl"/>
			<input type="hidden" id="elisttpye">
			<table align="center" style="width:100%">
				<tr>
					<td class="FieldLabel2">名称：</td>
					<td class="FieldInput2">
						<input id="elbname" class="easyui-textbox" data-options="required:true" style="height:30px;width:160px;"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">监听端口：</td>
					<td class="FieldInput2">	
						<select id="elistport_v" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto',disabled:true"></select>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">应用名称：</td>
					<td class="FieldInput2">
						<select id="eappname" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto',disabled:true">
						</select>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">主机：</td>
					<td class="FieldInput2">
						<select id="evms" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto',disabled:true">
						</select>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">主机IP：</td>
					<td class="FieldInput2">
						<select id="evm_ip" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'">
						</select><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">后端协议端口：</td>
					<td class="FieldInput2">
						<input id="ebackport" class="easyui-textbox" data-options="required:true" style="height:30px;width:160px;" />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">权重：</td>
					<td class="FieldInput2">
						<input id="eweight" class="easyui-textbox" data-options="required:true" style="height:30px;width:160px;" />
						<font color="red">*</font>
					</td>
				</tr>
				<tr id="eacltr">
					<td class="FieldLabel2">Acl策略：</td>
					<td class="FieldInput2">
						<select id="eacl" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'">
						</select><font color="red"></font>
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="lbServerModify();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w3').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>
</body>
