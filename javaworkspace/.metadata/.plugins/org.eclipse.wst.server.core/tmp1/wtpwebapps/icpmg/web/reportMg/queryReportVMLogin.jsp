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
<title>报表查询</title>
</head>
<body>
<div style="height:440px;">			
<iframe id="reportframe" src="<%=reportRootPath%>/action?obj=query.GotoQueryDetailAction&amp;queryId=<%=reportQueryId%>&amp;operate=View&amp;parentId=<%=reportParentId%>&amp;isPrivate=0&amp;partName=Query" style="width: 100%;height:100%;"></iframe>			
</div>						
</body>
</html>