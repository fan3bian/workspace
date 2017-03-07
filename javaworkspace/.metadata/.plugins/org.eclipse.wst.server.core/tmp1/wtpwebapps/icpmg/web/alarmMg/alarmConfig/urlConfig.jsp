<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>urlconfig</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  
  <body>
	<script type="text/javascript"> 
		var context_path = '${pageContext.request.contextPath}';
	</script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/web/alarmMg/alarmConfig/urlConfig.js"></script>
  		
  		<div class="easyui-layout" data-options="fit:true,border:false" style="padding:0px 20px 10px 20px;margin:10px 20px 10px 20px;">
			<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;background:#EEEEEE;">
					<div>
							<div style="float:left;margin-left:5px;">
								<span>应用URL:&nbsp;</span>
								<input class="easyui-textbox" name="url-config-url"
								id="url-config-url" style="width:400px;height:25px;border:false;">
								
								<a href="javascript:void(0);" id="url-query-button" style="margin:0 10px 0 15px;"
								class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
								onclick="">查询
								</a>
								<a href="javascript:void(0);" id="url-reset-button" style=""
								class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true"
								onclick="">重置
								</a>
							</div>
					</div>
			</div>
			
			<div data-options="region:'center',border:false" id="urlconfigdiv">
				<table title="" style="width:100%;" id="urlconfig-datagrid" ></table>
			</div>
			
			<div id="add-url-config-dialog"></div>  

			
	</div>		
	
  </body>
</html>
