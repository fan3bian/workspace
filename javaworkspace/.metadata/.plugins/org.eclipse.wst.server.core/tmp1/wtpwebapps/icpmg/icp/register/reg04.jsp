<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String msg = String.valueOf(request.getAttribute("msg")).toString();
String url = String.valueOf(request.getAttribute("url")).toString();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<title>浪潮云平台-云服务第一平台</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="${ctx}/icp/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${ctx}/icp/js/slide.js"></script>
	<script type="text/javascript" src="${ctx}/icp/js/TweenMax.min.js"></script>
	<script type="text/javascript" src="${ctx}/icp/js/myScroll.js"></script>
	<script type="text/javascript" src="${ctx}/icp/js/util.js"></script>
	<link rel="stylesheet" href="${ctx}/icp/style/index.css" type="text/css"></link>
	<link rel="stylesheet" href="${ctx}/icp/style/error.css"></link>
  </head>
  
  <body>
  	<jsp:include page="/icp/include/indexHead.jsp" />
  	<div class="error-wrap">
		<div class="error">
			<div class="hd">
				<img src="${ctx}/icp/images/logo2.png" alt="">
			</div>
			<div class="bd">
				<span class="span_a"><img src="${ctx}/icp/images/icon/succ.png" /><%=msg%><a href="<%=url%>">返回首页</a></span> 
			</div>
		</div>
	</div>
  	<jsp:include page="/icp/include/indexFoot.jsp" />
  </body>
</html>
