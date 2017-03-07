<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>资源变更监控</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  
	<body>
		<script type="text/javascript" charset="UTF-8">
			var context_path = '${pageContext.request.contextPath}';
		</script>
		
	  	<style type="text/css">
	  		#res-update-main
	  		{
	  			width:95%;
	  			//background-color: red;
	  		}
	  		
	  		#res-update-querybar
	  		{
	  			width:100%;
	  			height:30px;
	  			margin-left: 20px;
	  			background-color: #EEEEEE;
	  		}
	  		
	  		#res-update-netype-select,#res-update-nename-input
	  		{
	  			width:150px;height:25px;border:false;overflow:hidden;
	  		}
	  		
	  		#res-update-table
	  		{
	  			width:100%;
	  			margin-left: 20px;
	  			background-color: #EEEEEE;
	  		}
	  		
	  		.datagrid-toolbar
	  		{
	  			background-color: #EEEEEE;
	  		}
	  		
	  		#res-update-table,#res-update-datagrid
	  		{
	  			width: 100%;
	  		}
	  		
	  		.resupdate-detail-link,.resupdate-history-link,.resupdate-detail-spliter
	  		{
	  			color: #0068B7;
	  		}
	  		
	  		.resupdate-detail-link:hover,.resupdate-history-link:hover
	  		{
	  			color: red;
	  			cursor:pointer;
	  		}
	  			
	  			/*详情窗口*/
	  			#res-update-detail-dialog
				{
					overflow:hidden;
				}

				#res-update-detail-table,#res-update-detail-table tr,#res-update-detail-table td
				{
					//border:1px solid blue;
				}
							
				#res-update-detail-table
				{
					width: 650px;
					margin-top: 30px;
					margin-left: 20px;
					overflow:hidden;
				}
				
				#res-update-detail-table tr
				{
					height: 50px;
					oveflow:hiden;
				}
				#res-update-detail-table td
				{
					text-align:center;
					oveflow:hidden;
				}
				
				
				.res-update-detail-title-col,#res-update-detial-content-value input
				{
					width: 70px;
					font-size: 15px;
					//font-weight: bold;
				}
				.res-update-detail-value-col
				{
					width: 120px;
					font-size: 15px;
					oveflow:hidden;
					cursor: default;
				}
				
				.res-update-detail-value-col input
				{
					cursor: default;
				}
				.res-update-detial-title-space
				{
					width: 60px;
				}
				
				/* 详情 */
				#res-update-detial-content
			 	{
			 		margin-left: 21px;	
			 		margin-top: 25px;
			 	}
			 	
			 	#res-update-detial-content-title
			 	{
			 		float:left;
			 	}
			 	#res-update-detial-content-value
			 	{
			 		float:left;
			 		width:400px;
			 		margin-left: 40px;
			 		margin-top: 5px;
			 		cursor: default;
			 	}
			 	#res-update-detail-content-input,#res-update-detial-content-value span textarea
			 	{
			 		cursor: default;
			 	}
			 	
			 	#res-update-detial-content-title-span
			 	{
			 		margin-top: 60px;
			 		font-size: 15px;
			 	}
			 	
			 	#res-update-detail-button
			 	{
			 		clear:both;
			 		margin-left: 290px;
			 		margin-top: 228px;
			 	}
			/* 台账 */
			
	  		
	  	</style>
		
		
		<div id="res-update-main">
			<div id="res-update-querybar">
				<span style="margin:0 5px;">设备类型</span>
				<input id="res-update-netype-select" name="res-update-netype-select" value="">
				
				<span style="margin:0 5px;">设备名称</span>
				<input id="res-update-nename-input">
			
				<a id="res-update-query-button" class="easyui-linkbutton" href="javascript:void(0);" 
					style="margin-left:10px;" data-options="iconCls:'icon-search',plain:true">
					查询
				</a>&nbsp;&nbsp;
				 
				<a id="res-update-reset-button" class="easyui-linkbutton" href="javascript:void(0);"
					data-options="iconCls:'icon-redo',plain:true" >
					重置
				</a>&nbsp;&nbsp;
			</div>
			<div id="res-update-table">
				<table id="res-update-datagrid"></table>  
			</div>
			
			
			<div id="res-update-detail-dialog">
				<table id="res-update-detail-table" hidden>
					<!-- tr>td.detail-title-col+td.detail-value-col -->
					<tr>
						<td id="res-update-detail-neid-title" class="res-update-detail-title-col">&nbsp;&nbsp;&nbsp;设备ID ：</td>
						<td id="res-update-detail-neid-value" class="res-update-detail-value-col">
							<input id="res-update-detail-neid-input" />
						</td>
						<td class="res-update-detial-title-space">&nbsp;</td>
						<td id="res-update-detail-nename-title" class="res-update-detail-title-col">设备名称 ：</td>
						<td id="res-update-detail-nename-value" class="res-update-detail-value-col">
							<input id="res-update-detail-nename-input" />
						</td>
					</tr>
					
					<tr>
						<td id="res-update-detail-netypenename-title" class="res-update-detail-title-col">设备类型  ：</td>
						<td id="res-update-detail-netypename-value" class="res-update-detail-value-col">
							<input id="res-update-detail-netypename-input" />
						</td>
						<td class="res-update-detial-title-space">&nbsp;</td>
						<td id="res-update-detail-updatenode-title" class="res-update-detail-title-col">变更字段 ：</td>
						<td id="res-update-detail-updatenode-value" class="res-update-detail-value-col">
							<input id="res-update-detail-updatenode-input" />
						</td>
					</tr>
					
					<tr>
						<td id="res-update-detail-isleagleText-title" class="res-update-detail-title-col">是否授权 ：</td>
						<td id="res-update-detail-isleagleText-value" class="res-update-detail-value-col">
							<input id="res-update-detail-isleagleText-input" />
						</td>
						<td class="res-update-detial-title-space">&nbsp;</td>
						<td id="res-update-detial-mtime-title" class="res-update-detail-title-col">变更时间 ：</td>
						<td id="res-update-detail-mtime-value" class="res-update-detail-value-col">
							<input id="res-update-detail-mtime-input" >
						</td>
					</tr>
				</table>				  
				<div id="res-update-detial-content" >
					<div id="res-update-detial-content-title">
						<span id="res-update-detial-content-title-span">变更内容 ：</span>
					</div>
					<div id="res-update-detial-content-value">
						<!-- <input id="res-update-detail-content-input" > -->
						<div style="width: 485px;height:150px;border-radius: 10px;margin-left: 10px;padding: 5px;border-style:solid;border-width:1px;border-color: #EAEAEA;" 
						id="res-update-detail-content-block"></div>
					</div>
				</div>
				
				<div id="res-update-detail-button">
					<a id="res-update-detail-button-close" href="javascript:void(0);">关闭</a>
				</div>
			</div>
			
			<style>
				#res-update-history-main
				{
					width: 750px;
					margin-top: 1px;
					margin-left: 20px;
					overflow:hidden;							
				}
				#res-update-history-title
				{
					font-size: 15px;
					font-weight: bold;
				}
				#res-update-history-querybar
				{
					margin-left: 30px;
					margin-top: 5px;
				}
				#res-update-history-querybar div
				{
					margin-top: 5px;
				}
				#res-update-history-querybar div span
				{
					font-size: 14px;
				}
				#res-update-history-table
				{
					margin-top: 20px;
				}
				
				#res-update-history-table,#res-update-history-datagrid
				{
					width: 100%;
				}
				#res-update-history-button
				{
					clear:both;
			 		margin-left: 315px;
			 		margin-top: 20px;
				}
			</style>
						
			<div id="res-update-history-dialog">
				<div id="res-update-history-main" hidden>
					<div id="res-update-history-title"></div>
					<div id="res-update-history-querybar">
						<div class="ip">
							<span style="margin-left: -2px;" class="iptitle">&nbsp;&nbsp;&nbsp;&nbsp;IP地址 :</span>
							<span class="ipvalue"></span>
						</div>
						
						<div class="mtime">
							<span class="mtime-title">变更时间 :</span>
							<span class="mtime-value"></span>
						</div>
						<div class="curstat">
							<span class="curstat-title">当前状态 :</span>
							<span class="curstat-value"></span>
						</div>
						
					</div>
					<div id="res-update-history-table">
						<table id="res-update-history-datagrid"></table>  
					</div>
					
					<div id="res-update-history-button">
						<a id="res-update-history-button-close" href="javascript:void(0);">关闭</a>
					</div>
				</div>
		  </div>
			
		</div>  	
		
		
		
	  	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/web/omsMonitor/resupdate/js/resUpdateMonitor.js"></script>
	  	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/web/omsMonitor/resupdate/js/resUpdateDetail.js"></script>
	</body>
</html>
