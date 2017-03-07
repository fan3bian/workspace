<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  </head>
  
  <body>
    	<style type="text/css">
    		#lord-netypename
    		{
    			clear:both;
    			margin-left:20px;
    			margin-top:40px;
    		}
    		
    		#ping-netypename-title
    		{
    			float:left;
    		}
    		
    		#ping-netypename-combobox
    		{
    			margin-left:70px;
    		}
    		

  		 	#lord-nename,#lord-neip
			{
				clear:both;
    			margin-left:20px;
    			margin-top:20px;
			}
    		
			#ping-nename-title
			{
				float:left;
			}
    		
    		#ping-nename-combobox
    		{
    			margin-left:70px;
    		}
    					

			#ping-neip-title
			{
				float:left;
			}
			
			#ping-neip-title
			{
				float:left;
				height:25px;
			}
			
			#ping-neip-area
			{
				float:left;
				margin-left:10px;
				height:25px;
			}
			
			#ping-config-button
			{
				clear:both;
    			margin-left:110px;
    			margin-top:110px;
			}
			
			#ping-config-add-button
			{
				clear:both;
				float:left;
				width:100px;
			}
			
			#ping-config-cancel-button
			{
				float:left;
				margin-left:30px;
				width:100px;
			}
			
			#ping-netypename-inputcombobox,#ping-nename-inputcombobox
			{
				width:300px;
			}
    	</style>
    	
    	<script type="text/javascript"> 
			var context_path = '${pageContext.request.contextPath}';
		</script>
    	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/web/alarmMg/alarmConfig/addPingConfig.js"></script>
    	
      	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:0px 20px 10px 20px;margin:10px 20px 10px 20px;">
			<div data-options="region:'center',border:false" style="height:30px;overflow:hidden;">
						
						<div id="lord-netypename">
							<div id="ping-netypename-title">
								设备类型：
							</div>
							<div id="ping-netypename-combobox">
								<input id="ping-netypename-inputcombobox" name="ping-netypename" value="">  
							</div>
						</div>
						<div id="lord-nename">
							<div id="ping-nename-title">
								设备名称：
							</div>
							<div id="ping-nename-combobox">
								<input id="ping-nename-inputcombobox" name="ping-nename" value="">  
							</div>
						</div>
						<div id="lord-neip">
							<div id="ping-neip-title">
								&nbsp;&nbsp;&nbsp;设备IP：
							</div>
							<div id="ping-neip-area">
								
							</div>
						</div>
						
						<div id="ping-config-button">
							<a href="javascript:void(0);" id="ping-config-add-button"
							class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
							onclick="">添加</a>
							<a href="javascript:void(0);" id="ping-config-cancel-button"
							class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
							onclick="">取消</a>
						</div>
			</div>
    	</div>
    
  </body>
</html>
