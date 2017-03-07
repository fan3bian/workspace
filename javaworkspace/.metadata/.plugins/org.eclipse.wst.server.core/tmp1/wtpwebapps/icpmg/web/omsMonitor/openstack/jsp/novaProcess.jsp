<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Nova Process</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
  		<script type="text/javascript"> 
			var context_path = '${pageContext.request.contextPath}';
		</script>
    	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/web/omsMonitor/openstack/js/novaProcess.js"></script>
  		
  		<div class="nova-process-main">
  			<div id="nova-process-title">
  				
  			</div>
  			<div id="nova-process-zone">
  				<div id="nova-process-datagrid"></div>
  			</div>
  		</div>
  		
  		
  </body>
</html>
