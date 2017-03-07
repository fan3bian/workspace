<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/web/osdeploy/css/osdeploy.css" type="text/css"/>
<script src="${pageContext.request.contextPath}/web/osdeploy/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
<script>

var toolbar =[{
	text:'创建',
	iconCls:'icon-add',
	handler:function(){ 
		$('#host_dg').dialog('open');
		$('#host_form').form('clear');
	}
},{
	text:'批量创建',
	iconCls:'icon-add',	
	handler:function(){ 
		$('#hosts_dg').dialog('open');
		$('#hosts_tx').textbox('clear');
	}
},{
	text:'删除',
	iconCls:'icon-delete',
	handler:delHost
}];
	$(function(){
		loadComboParam();
		loadgrid();
		$.extend($.fn.validatebox.defaults.rules, {    
		    Enghfwidth: {    
		        validator: function(value){   
		        	var reg =/[，；]/;	
		            return value.match(reg)==null;    
		        },    
		        message: '请使用英文半角符号'   
		    }    
		}); 
	});
	function loadgrid(){
		$('#host_grid').datagrid({
			singleSelect:false,
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
			sortName:'environname',
			sortOrder:'desc',
// 			multiSort:true,
			toolbar :toolbar,
		    url:'${pageContext.request.contextPath}/osdeploy/queryHostList.do',
			 onLoadSuccess: function (data) {
			      var pageopt = $('#host_grid').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#host_grid').datagrid("getRows").length;
			      var total = pageopt.total;
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            $(this).datagrid('appendRow', {status :''  });
			         }
			         $('#host_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				     });
			       
			      }else{
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if   (val.status ==''){ 
								$('#host_grid_div  input:checkbox').eq(idx+1).css("display","none");
							}
						}); 
			      }
			 } ,
			 onClickRow: function (rowIndex, rowData) {
						if   (rowData.status ==''){
							 $(this).datagrid('unselectRow', rowIndex);
						}else{
							flagck=0;
						}
						if(flagck ==1){
							$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
						}
			}, 
			onCheckAll: function(rows) {
				flagck = 1;
					$.each(rows, function (idx, val) {
						if   (val.status ==''){
							$("#host_grid").datagrid('uncheckRow', idx);
							$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
						}
					});
			}, 
			onUncheckAll: function(rows) {
				flagck = 0;
			}
		});
	};
	function loadComboParam(){
		$('#param').combobox({
			valueField: 'value',
			textField: 'text',
			data: [{
				text: 'IP地址',
				value: 'ipaddr'
			},{
				text: '名称',
				value: 'hostname'
			},{
				text: '状态',
				value: 'curstate'
			}]
		});
	}
	
function nodeTypeFormat(value){
	if(!value) return "";
	if(value==='1'){
		return '<img src="${pageContext.request.contextPath}/web/osdeploy/image/isNode.png" alt="">';
	}else{
		return '<img src="${pageContext.request.contextPath}/web/osdeploy/image/notNode.png" alt="">';
	}
}
function newHost(){
	var hostname =$('#hostname').textbox('getValue').trim();
	var ipaddr =$('#ipaddr').textbox('getValue').trim();
	$.ajax({
		type:'post',
		url :'${pageContext.request.contextPath}/osdeploy/newHost.do',
		data:{hostname:hostname,ipaddr:ipaddr},
		async:false,
		dataType:'json',
		success:function(data){
			if(data.success){
				$.messager.alert('消息',data.msg,'info');
			}else{
				$.messager.alert('错误',data.msg,'error');
			}
		},
		error:function(){}
	});
	$('#host_dg').dialog('close');
	$('#host_grid').datagrid('reload');	
}
function delHost(){
	var rows =$('#host_grid').datagrid('getChecked');
	if(rows.length<1) return;
	$.messager.confirm('消息确认','您确认删除吗',function(r){
		if(r){
			var hostIds = '';
			for (var i = 0; i<rows.length;i++){
				if(rows.status==='使用中'){
					$.messager.alert("警告",rows[i].hostname+'正在使用中，无法删除','warning');
					return;
				}
				hostIds +=rows[i].hostid+",";
			}
			hostIds =hostIds.substring(0, hostIds.length-1);
			$.ajax({
				type:'post',
				url :'${pageContext.request.contextPath}/osdeploy/deleteHost.do',
				data:{hostIds:hostIds},
				async:false,
				dataType:'json',
				success:function(data){
					if(data.success){
						$.messager.alert('消息',data.msg,'info');
					}else{
						$.messager.alert('错误',data.msg,'error');
					}
				},
			});
			$('#host_grid').datagrid('reload');
		}
	});

}
// $.messager.progress({ 
//     title: 'Please waiting', 
//     msg: 'Loading data...', 
//     text: 'PROCESSING.......' 
// });
function opformt(value,row){
	var str ='';
	switch (value) {
	case "0":
		str ="<a class=\"easyui-linkbutton\" "+ 
			"href=\"javascript:void(0)\" onclick=\"checkHost('"+row.hostid+"','"+row.hostname+"','"+row.ipaddr+"');\""+
				"style=\"width:72px;margin-left:3px; \">进行检查</a>";
		break;
	case "1":
		str ="<a class=\"easyui-linkbutton\" "+ 
		"href=\"javascript:void(0)\" onclick=\"configSystem('"+row.hostid+"','"+row.ipaddr+"');\""+
			"style=\"width:72px;margin-left:3px; \">配置系统</a>";
		break;
	case '2':
		str ='准备就绪';
	case '3':
		str ='正在使用';
	case '9':
		str ='准备就绪';
	default:
		
		break;
	}
	return str;
}
//网络连通性检查
function checkHost(hostId,hostName,ipAddr){
	loadMask("正在进行【网络连通性】检查，请稍候...");
	$.ajax({ 
	   type: "GET",
	   dataType: "json",
	   url: "${pageContext.request.contextPath}/osdeploy/checkHost.do",
	   async:true,
	   data:{hostId:hostId,hostName:hostName,ipAddr:ipAddr},
	   success: function(data){        
		   if(data.success){
				$.messager.alert('消息',data.msg,'info');
			}else{
				$.messager.alert('错误',data.msg,'error');
			}
		   disLoad();
		   $('#host_grid').datagrid('reload');
		   }
	});
}
function configSystem(hostId,ipAddr){
	loadMask("正在进行【系统环境配置】，请稍后...");
	$.ajax({ 
	   type: "GET",
	   dataType: "json",
	   url: "${pageContext.request.contextPath}/osdeploy/configSystem.do",
	   async:true,
	   data:{hostId:hostId,ipAddr:ipAddr},
	   success: function(data){        
		   if(data.success){
				$.messager.alert('消息',data.msg,'info');
			}else{
				$.messager.alert('错误',data.msg,'error');
			}
		   disLoad();
		   $('#host_grid').datagrid('reload');
		   }
	});
}
function newHosts(){
	var hoststr=$('#hosts_tx').textbox('getValue');
	var ipReg =/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/;
	var arr =hoststr.split(";");
	for(var ar in arr){
		var ip =arr[ar].split(",")[1];
		if(ip){ //排除ip===""情况
			ip =ip.trim();
			if(!ipReg.test(ip)){
				$.messager.alert('错误',"请检查: 【"+arr[ar]+"】 中的IP",'error');
				return ;
			};
		}
	}
	$.ajax({
		type:'post',
		url :'${pageContext.request.contextPath}/osdeploy/newHostList.do',
		data:{hoststr:hoststr},
		async:false,
		dataType:'json',
		success:function(data){
			if(data.success){
				$.messager.alert('消息',data.msg,'info');
			}else{
				$.messager.alert('错误',data.msg,'error');
			}
			$('#host_grid').datagrid('reload');
			$('#hosts_dg').dialog('close');
		},
		error:function(){}
	});
}
//弹出加载层

</script>


<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background:#eee;">
		<form id="conditionForm">
			<table>
				<tr>
					<td><input class="easyui-combobox" name="param" id="param" style="height:30px;width:160px"/></td>
					<td>&nbsp;&nbsp;<input class="easyui-textbox" name="value" id="value" style="width:160px;height:30px;border:false"/></td>
					<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" 
						onclick="searchDataGrid('conditionForm','host_grid')">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true"
						 onclick="reset('conditionForm','host_grid')">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" id="host_grid_div">
		<table title="" style="width:100%;" id="host_grid">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'hostid',width:50,align:'center',sortable:true">编码</th>
					<th data-options="field:'hostname',width:50,align:'center'">名称</th>
					<th data-options="field:'ipaddr',width:50,align:'center'">IP地址</th>
<!-- 					<th data-options="field:'macaddr',width:50,align:'center',formatter:formatter">mac地址</th> -->
					<th data-options="field:'ctime',width:50,align:'center',sortable:true">创建时间</th>
					<!-- <th data-options="field:'description',width:60,align:'center'">描述</th> -->
					<th data-options="field:'environname',width:50,align:'center',sortable:true">云平台</th>
<!-- 					<th data-options="field:'userid',width:60,align:'center'">用户名</th> -->
					<th data-options="field:'contype',width:30,align:'center',formatter:nodeTypeFormat,sortable:true">控制节点</th>
					<th data-options="field:'comtype',width:30,align:'center',formatter:nodeTypeFormat,sortable:true">计算节点</th>
					<th data-options="field:'stgtype',width:30,align:'center',formatter:nodeTypeFormat,sortable:true">存储节点</th>
<!-- 				<th data-options="field:'status',width:40,align:'center',formatter:opformt">状态</th> -->
				</tr>
			</thead>
		</table>		
	</div>  
	<div id="host_dg" class="easyui-dialog" title="新建主机" style="width:400px;padding:10px;"   
        data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: newHost        
         }, {
            text: '关闭',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#host_dg').dialog('close');
            }
        }]">  
			<div style="padding:10px; height:100px;">
				<form id="host_form">
					<div class="input-group">
						<label for=""class="control-label">名称:</label>
						<div class="control-input">
							<input id="hostname" type="text" class="easyui-textbox" data-options="height:28,width:180,required:false,validType:'length[0,64]',missingMessage:'必填项'"/>
						</div>
					</div>
					<div class="input-group">
						<label for=""class="control-label">IP:</label>
						<div class="control-input">
							<input id="ipaddr" type="text" class="easyui-textbox" data-options="height:28,width:180,required:false,validType:'ip',missingMessage:'必填项'"/>
						</div>
					</div>
	   			</form>
			</div>
	</div>  
	<div id="hosts_dg" class="easyui-dialog" title="批量创建" style="width:400px;height:240px;padding:10px;"   
        data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: newHosts        
         }, {
            text: '关闭',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#hosts_dg').dialog('close');
            }
        }]">  
			<div style="padding:10px 15px;">
<!-- 				<span style="align:center;display:inline-block;">请按照如下格式输入：</span> -->
<!-- 				<span style="align:center;color:red"></span> -->
				<input id="hosts_tx" class="easyui-textbox" data-options="multiline:true,height:120,width:320,prompt:'例:主机A,192.168.0.1;主机B,192.168.0.2',validType:'Enghfwidth'">
			</div>
<!-- 	        <div style="text-align:right;padding:5px 0 0;"> -->
<!-- 				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" -->
<!-- 					href="javascript:void(0)" style="width:72px" onclick="newHosts()">确定</a>  -->
<!-- 				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" -->
<!-- 					href="javascript:void(0)" onclick="$('#hosts_dg').dialog('close');" -->
<!-- 					style="width:72px;margin-left:3px;">关闭</a> -->
<!-- 			</div> -->
	</div> 
</div>