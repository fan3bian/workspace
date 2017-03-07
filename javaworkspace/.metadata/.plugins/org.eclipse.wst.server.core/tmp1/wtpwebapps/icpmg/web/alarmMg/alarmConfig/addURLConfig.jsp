<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>addurlconfig.jsp</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  
  <body>
      	<style type="text/css">
    		#lord-netypename
    		{
    			clear:both;
    			margin-left:20px;
    			margin-top:20px;
    		}
    		
    		#url-netypename-title
    		{
    			float:left;
    		}
    		
    		#url-netypename-combobox
    		{
    			margin-left:70px;
    		}
    		

  		 	#lord-nename,#lord-neip
			{
				clear:both;
    			margin-left:20px;
    			margin-top:20px;
			}
    		
			#url-nename-title
			{
				float:left;
			}
    		
    		#url-nename-combobox
    		{
    			margin-left:70px;
    		}
    					

			#url-neip-title
			{
				float:left;
			}
			
			#url-neip-title
			{
				float:left;
				height:25px;
			}
			
			#url-neip-area
			{
				float:left;
				margin-left:10px;
				height:25px;
			}
			
			#url-config-button
			{
				clear:both;
    			margin-left:110px;
    			margin-top:90px;
			}
			
			#url-config-add-button
			{
				clear:both;
				float:left;
				width:100px;
			}
			
			#url-config-cancel-button
			{
				float:left;
				margin-left:30px;
				width:100px;
			}
			
			#url-netypename-inputcombobox,#url-nename-inputcombobox
			{
				width:300px;
			}
			
			#url-alarm-port
			{
				clear:both;
    			margin-left:20px;
    			margin-top:60px;
			}
			
			#url-alarm-app
			{
				clear:both;
    			margin-left:20px;
    			margin-top:20px;
			}
			
			#url-alarm-port-title,#url-alarm-app-title
			{
				float:left;
			}
			
			#url-alarm-port-area,#url-alarm-app-area
			{
				margin-left:70px;
			}
			
			#url-alarm-port-input,#url-alarm-app-input
			{
				width:150px;
			}
			#url-alarm-urlstr
			{
				clear:both;
    			margin-left:12px;
    			margin-top:20px;
			}
			
			#url-alarm-urlstr-title
			{
				float:left;
				height:25px;
			}
			
			#url-alarm-urlstr-area
			{
				float:left;
				margin-left:10px;
				height:25px;
				display:block;
				overflow:hidden;
			}
			
    	</style>
  		<script type="text/javascript" charset="utf-8"> 
			var context_path = '${pageContext.request.contextPath}';
		</script>
    	  <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/web/alarmMg/alarmConfig/addURLConfig.js"></script>
  	
  	      	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:0px 20px 10px 20px;margin:10px 20px 10px 20px;">
			<div data-options="region:'center',border:false"
				style="height:30px;overflow:hidden;">
						
						<div id="lord-netypename">
							<div id="url-netypename-title">
								设备类型：
							</div>
							<div id="url-netypename-combobox">
								<input id="url-netypename-inputcombobox" class="easyui-combobox" name="url-netypename" value="">  
							</div>
						</div>
						<div id="lord-nename">
							<div id="url-nename-title">
								设备名称：
							</div>
							<div id="url-nename-combobox">
								<input id="url-nename-inputcombobox" class="easyui-combobox" name="url-nename" value="">  
							</div>
						</div>
						<div id="lord-neip">
							<div id="url-neip-title">
								&nbsp;&nbsp;&nbsp;设备IP：
							</div>
							<div id="url-neip-area">
								
							</div>
						</div>
						<div id="url-alarm-port">
							<div id="url-alarm-port-title">
								应用端口：
							</div>
							<div id="url-alarm-port-area">
								<input id="url-alarm-port-input"  class="easyui-numberbox" value="80" data-options="min:0,max:65535,precision:0"></input> 
							</div>
						</div>
						<div id="url-alarm-app">
							<div id="url-alarm-app-title">
								应用名称：
							</div>
							<div id="url-alarm-app-area">
								<input id="url-alarm-app-input" class="easyui-textbox" value="" ></input> 
							</div>
						</div>
						<div id="url-alarm-urlstr">
							<div id="url-alarm-urlstr-title">
								待检验URL：
							</div>
							<div id="url-alarm-urlstr-area"></div>
						</div>
						<div id="url-config-button">
							<a href="javascript:void(0);" id="url-config-add-button"
							class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
							onclick="">添加</a>
							<a href="javascript:void(0);" id="url-config-cancel-button"
							class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
							onclick="">取消</a>
						</div>
			</div>
  	
  </body>

</html>
