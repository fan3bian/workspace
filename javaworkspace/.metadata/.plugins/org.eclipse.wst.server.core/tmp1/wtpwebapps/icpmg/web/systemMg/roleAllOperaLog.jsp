<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<%
	String roleid = request.getParameter("id");
	if (roleid == null) {
		roleid = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<%-- <jsp:include page="../inc.jsp"></jsp:include> --%>
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/themes/color.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/easyui-1.4/demo/demo.css">
<script type="text/javascript" src="<%=contextPath %>/easyui-1.4/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/easyui-1.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	$('#role_log_datagrid').datagrid({
		url:'${pageContext.request.contextPath}/authMgr/getRoleAllOperaLog.do?roleid=<%=roleid%>',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		fit:true,
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'operaUserID',
		sortName:'createTime',
		sortOrder:'asc',
	});
});
</script>
</head>
<body>
	<table style="width:100%;" id="role_log_datagrid">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'roleID',width:100,align:'center',hidden:true">角色ID</th>
				<th data-options="field:'roleName',width:100,align:'center'">角色名称</th>
				<th data-options="field:'operaUserID',width:100,align:'center'">操作用户ID</th>
				<th data-options="field:'operaUser',width:100,align:'center'">操作用户名称</th>
				<th data-options="field:'result',width:100,align:'center'">操作结果</th>
				<th data-options="field:'createTime',width:100,align:'center',sortable:true">创建时间</th>
				<th data-options="field:'operaNote',width:100,align:'center'">备注</th>
			</tr>
		</thead>
	</table>
</body>
</html>