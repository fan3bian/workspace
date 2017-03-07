<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportRootPath =  application.getInitParameter("reportRootPath");
String reportQueryId = request.getParameter("reportQueryId"); //3da3bd79-d54b-43c2-8839-c77ea5756ab4
String reportParentId = request.getParameter("reportParentId"); //53656a5f-e680-4ada-b99d-1290d40883e7


System.out.println(basePath);
System.out.println(reportRootPath);
System.out.println(reportQueryId);
System.out.println(reportParentId);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<title></title>
</head>
<body>

<script type="text/javascript">
var context_path = '${pageContext.request.contextPath}';
var groupid = '${pageContext.request.getParameter("groupid")}';
document.getElementById("groupid").value=groupid;

var ifms= document.getElementById("iframediv");
var max_height = document.getElementById("centerTab").style.height;
ifms.style.height = max_height;
</script>
<div id="iframediv">
<input type="hidden" id="groupid" name="groupid">		
<iframe id="kpiframe" src="${pageContext.request.contextPath}/web/omsMonitor/host/jsp/hostKpiOverviewFrame.jsp" style="border: 0;width: 100%;height: 99%"></iframe>			
</div>						
</body>
</html>