<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<%
	String userEmail = request.getParameter("id");
	if (userEmail == null) {
		userEmail = "";
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
	$('#role_allUsers_datagrid').datagrid({
		url:'${pageContext.request.contextPath}/authMgr/getUserAllOperaLog.do?userEmail=<%=userEmail%>',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		fit:true,
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'accessUserID',
		sortName:'createTime',
		sortOrder:'asc',
	});
});
</script>
</head>
<body>
	<table style="width:100%;" id="role_allUsers_datagrid">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'operationUserID',width:100,align:'center',hidden:true">访问用户编码</th>
				<th data-options="field:'operationUser',width:100,align:'center'">访问用户名称</th>
				<th data-options="field:'ipAddr',width:100,align:'center'">访问用户IP</th>
				<th data-options="field:'ipLocation',width:100,align:'center'">IP所在地</th>
				<th data-options="field:'projectName',width:100,align:'center'">项目名称</th>
				<th data-options="field:'moduleName',width:100,align:'center'">模块名称</th>
				<th data-options="field:'actionName',width:100,align:'center'">Action名称</th>
				<th data-options="field:'methodName',width:100,align:'center'">方法名称</th>
				<th data-options="field:'result',width:100,align:'center'">操作结果</th>
				<th data-options="field:'createTime',width:100,align:'center',sortable:true">创建时间</th>
				<th data-options="field:'sessionID',width:100,align:'center'">sessionID</th>
			</tr>
		</thead>
	</table>
</body>
</html>