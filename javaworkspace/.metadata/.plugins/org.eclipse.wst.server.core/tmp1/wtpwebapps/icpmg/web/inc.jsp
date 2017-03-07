<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();%>
<%String contextPath = request.getContextPath();%>
<%String version = "20141119";%>
<%
Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
Cookie[] cookies = request.getCookies();
if (null != cookies) {
	for (Cookie cookie : cookies) {
		cookieMap.put(cookie.getName(), cookie);
	}
}
String easyuiTheme = "bootstrap";//指定如果用户未选择样式，那么初始化一个默认样式
if (cookieMap.containsKey("easyuiTheme")) {
	Cookie cookie = (Cookie) cookieMap.get("easyuiTheme");
	easyuiTheme = cookie.getValue();
}
%>


<%-- 引入jQuery --%>
<script type="text/javascript" src="<%=contextPath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/easyui-1.4/jquery.blockUI.js"></script>

<%-- 引入EasyUI --%>
<link rel="stylesheet" href="<%=contextPath%>/easyui-1.4/themes/default/easyui.css" type="text/css"/>
<link rel="stylesheet" href="<%=contextPath%>/easyui-1.4/themes/icon.css" type="text/css"/>
<link rel="stylesheet" href="<%=contextPath%>/css/icpExtIcon.css" type="text/css"/>
<link rel="stylesheet" href="<%=contextPath%>/css/regcore.css" type="text/css"/>

<script type="text/javascript" src="<%=contextPath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/js/json-minified.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/validate.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/icpExtJquery.js"></script>
<script type="text/javascript" src="<%=contextPath%>/highchart/4.2.1/highcharts.js"></script>