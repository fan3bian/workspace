<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>pingConfig</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  
  <body>
		<script type="text/javascript"> 
			var context_path = '${pageContext.request.contextPath}';
		</script>
  		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/web/alarmMg/alarmConfig/pingconfig.js"></script>
  		
  		<div class="easyui-layout" data-options="fit:true,border:false" style="padding:0px 20px 10px 20px;margin:10px 20px 10px 20px;">
			<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background:#EEEEEE;">
					<div>
							<div style="float:left;margin-left:10px;overflow:hidden;">
								<span style="margin:0 5px;">IP地址:</span>
								<input class="easyui-textbox" name="ping-config-ip" id="ping-config-ip" 
								style="width:150px;height:25px;border:false;overflow:hidden;">
								
								<a href="javascript:void(0);" id="ping-query-button" style="margin-left:10px;"
								class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
								onclick="">查询
								</a>&nbsp;&nbsp;
								 
								<a href="javascript:void(0);" id="ping-reset-button" style=""
								class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true"
								onclick="">重置
								</a>&nbsp;&nbsp;
							</div>
					</div>
			</div>
			
			<div data-options="region:'center',border:false" id="pingconfigdiv">
				<table title="" style="width:100%;" id="pingconfig-datagrid" ></table>
			</div>
			
			<div id="add-ping-config-dialog"></div>  

			
	</div>	
</body>
  
</html>
