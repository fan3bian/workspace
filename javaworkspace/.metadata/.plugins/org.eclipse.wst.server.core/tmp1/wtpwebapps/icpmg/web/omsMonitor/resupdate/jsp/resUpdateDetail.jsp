<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>  
  <body>
  		<script type="text/javascript" charset="UTF-8">
	  		var context_path = '${pageContext.request.contextPath}';
	  		var aaa = '${pageContext.request.getParameter("aaa")}';
	  		alert(aaa);
	  		//var inserver_neid = '${pageContext.request.getParameter("neid")}';
	  	</script>
	  	
					<style type="text/css">
				#res-update-detail-dialog
				{
					overflow:hidden;
				}

				#res-update-detail-table,#res-update-detail-table tr,#res-update-detail-table td
				{
					border:1px solid blue;
				}
							
				#res-update-detail-table
				{
					width: 650px;
					overflow:hidden;
				}
				
				#res-update-detail-table tr
				{
					height: 30px;
					oveflow:hiden;
				}
				#res-update-detail-table td
				{
					text-align:center;
					oveflow:hidden;
				}
				
				
				.res-update-detail-title-col
				{
					width: 80px;
				}
				.res-update-detail-value-col
				{
					width: 120px;
					text- overflow : clip;
					oveflow:hidden;
				}
				.res-update-detial-title-space
				{
					width: 150px;
				}
				#res-update-detail-nename
				{
					width: 120px;
					height: 30px;
					oveflow:hidden;
				}
		  	</style>
	  	
	  	<div class="foo" id="foo3">
	  		<table id="res-update-detail-table" >
					<!-- tr>td.detail-title-col+td.detail-value-col -->
					<tr>
						<td id="res-update-" class="res-update-detail-title-col" >设备ID</td>
						<td id="res-update-detail-neid" class="res-update-detail-value-col"></td>
						<td class="res-update-detial-title-space">&nbsp;</td>
						<td id="res-update-" class="res-update-detail-title-col">设备名称</td>
						<input id="detail" class="easyui-textbox">
						<td id="res-update-detail-nename" class="res-update-detail-value-col">
							<input id="detail" class="easyui-textbox" />
						</td>
					</tr>
					
					<tr>
						<td id="res-update-" class="res-update-detail-title-col">设备类型</td>
						<td id="res-update-detail-netypename" class="res-update-detail-value-col"></td>
						<td class="res-update-detial-title-space">&nbsp;</td>
						<td id="res-update-" class="res-update-detail-title-col">组件名称</td>
						<td id="res-update-detail-nename" class="res-update-detail-value-col"></td>
					</tr>
	
				</table>   
	  	</div>
	  	
  </body>
</html>
