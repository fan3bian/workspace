<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
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
		url:'${pageContext.request.contextPath}/authMgr/getUsersByRole.do?roleids=<%=id%>',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		fit:true,
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'email',
		sortName:'email',
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
				<th data-options="field:'email',width:100,align:'center',sortable:true">电子邮箱</th>
				<th data-options="field:'mobile',width:100,align:'center'">手机号码</th>
				<th data-options="field:'uname',width:100,align:'center'">用户名称</th>
				<th data-options="field:'userlevel',width:100,align:'center'">帐号类型</th>
				<th data-options="field:'pemail',width:100,align:'center'">父帐号邮箱</th>
				<th data-options="field:'usertype',width:100,align:'center'">用户类型</th>
				<th data-options="field:'status',width:100,align:'center'">状态</th>
				<th data-options="field:'alias',width:100,align:'center'">别名</th>
				<!-- <th data-options="field:'pwdpp',width:100,align:'center'">密保问题</th>
				<th data-options="field:'pwdppanswer',width:100,align:'center'">密保答案</th> -->
			</tr>
		</thead>
	</table>
</body>
</html>