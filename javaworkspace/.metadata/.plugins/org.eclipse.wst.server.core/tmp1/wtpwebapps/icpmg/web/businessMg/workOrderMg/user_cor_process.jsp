<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <body>
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery-1.8.3.min.js"></script>
  
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.easyui.min.js" ></script>
    <link href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css" rel="stylesheet" type="text/css" /> 
  
  	<script >
  	$('#cc').combobox({    
		    url:'${pageContext.request.contextPath}/workorder/getClimanager.do',    
		    valueField:'climanagerid',    
		    textField:'climanagername',
            onLoadSuccess: function () { //加载完成后,设置选中第一项
                var val = $(this).combobox("getData");
                for (var item in val[0]) {
                    if (item == "climanagerid") {
                        $(this).combobox("select", val[0][item]);
                    }
                }
            }
	}); 
	
	function save(){
			$('#initRoleForm').form('submit',{
		    url:'${pageContext.request.contextPath}/authMgr/saveInitRole.do',
		    onSubmit: function(){
		    	debugger;
		    	var row = $('#rolelist').datagrid('getSelected');
		    	if(!row)
		    	{
		    		$.messager.alert('消息',"请先选中!");  
		    		return false;
		    	}
		    	$('#roleid').val(row.roleid);
		    	$('#datalevel').val(row.datalevel);
		    },
		    success:function(data){
				$.messager.alert('消息',"保存成功!");  
				$("#details").parent().dialog('close');
		    }
		});
		//$('#editForm').submit();	
	}	
	
	function redo(){
	    
		$("#details").parent().dialog('close');
	}
	</script >
    	<div id="details"
				style="padding:5px 5px 5px 5px;margin:10px 5px 10px 40px; ">

				<a href="#" onClick="javascript:save();" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp; <a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
				<div style="height:10px"></div>
				<form id="initRoleForm" method="post">
					<input type="hidden" id="flowid"  name="flowid" value='<%=request.getParameter("transferid")%>'>
					<input type="hidden" id="stepno"  name="stepno" value='<%=request.getParameter("stepno")%>'>
					<input type="hidden" id="roleid"   name="roleid" value=''>
					<input type="hidden" id="datalevel" name="datalevel" value=''>
				<div >客户经理：<input id="cc" style="height:30px" name="climanagerid" /><font color="red">*</font></div>
				</form>
				<div style="height:10px"></div>
				<div title="角色列表" style="width:80%;">
				<table id="rolelist" class="easyui-datagrid" style="width:100%"
					data-options="rownumbers:false,border:false,striped : true,nowarp:false,singleSelect: true,url:'${pageContext.request.contextPath}/authMgr/getEntityRole.do',method:'post',loadMsg:'数据装载中......',fitColumns:true">
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
			</div>
</body>
</html>
