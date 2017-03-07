<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<style type="text/css">
.product-product-close {
  position: absolute;
  top: 50%;
  margin-top: -8px;
  height: 16px;
  overflow: hidden;
  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
}
.FieldInput2 {
	width: 100%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}

.FieldLabel2 {
	width: 50%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: center;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>
	<script type="text/javascript">			
			function submitSave1()
			{		 				 		
		 		$('#guideindexform1').form('submit',{
			    url:'${pageContext.request.contextPath}/content/saveImage1.do', 
			    onSubmit: function(){
			    	
			    	
			    	debugger;
			    	
					
						if($("#windowimagefiles1").val())
						{
							var bizlic = $("#windowimagefiles1").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					
					/*else 
					{
						if(!$("#windowimagefiles").val())
						{
							$.messager.alert('消息',"请选择一张图片【jpg/jpeg/png/gif】！");  
			    			return false;
						}else
						{
							var bizlic = $("#windowimagefiles").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					}								*/						    	
			    },
			   success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#guideindex_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			}
			
			function submitSave2()
			{		 				 		
		 		$('#guideindexform2').form('submit',{
			    url:'${pageContext.request.contextPath}/content/saveImage2.do', 
			    onSubmit: function(){
			    	
			    	
			  	debugger;
			    	
					
						if($("#windowimagefiles2").val())
						{
							var bizlic = $("#windowimagefiles2").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					
					/*else 
					{
						if(!$("#windowimagefiles").val())
						{
							$.messager.alert('消息',"请选择一张图片【jpg/jpeg/png/gif】！");  
			    			return false;
						}else
						{
							var bizlic = $("#windowimagefiles").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					}				*/										    	
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#guideindex_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			}					
			function submitSave3()
			{		 				 		
		 		$('#guideindexform3').form('submit',{
			    url:'${pageContext.request.contextPath}/content/saveImage3.do', 
			    onSubmit: function(){
			    	
			    	
			   	debugger;
			    	
					
						if($("#windowimagefiles3").val())
						{
							var bizlic = $("#windowimagefiles3").val();							
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();							
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					
					/*else 
					{
						if(!$("#windowimagefiles").val())
						{
							$.messager.alert('消息',"请选择一张图片【jpg/jpeg/png/gif】！");  
			    			return false;
						}else
						{
							var bizlic = $("#windowimagefiles").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
					}				*/										    	
			    },
			    success:function(retr){
			    	//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			    	var _data =  JSON.parse(retr); 
			    	//alert("success: "+_data.success);			    	
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#dg').datagrid('load',
							icp.serializeObject($('#guideindex_searchform')));
						$('#window').window('close');
			    	}
			    }
			});
			}								
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">		
		<div data-options="region:'north',border:false"
			style="height:4000px;padding:5px 0 0;overflow:hidden;">
			<form id="guideindexform1" method="post" enctype="multipart/form-data" >
				<center>
				<table>
				<img src="${pageContext.request.contextPath}/icp/portal/images/banner0.jpg" style="width:169px;height:31px;" alt=""/>				         															        																													
							<tr>
								<td class="FieldLabel2">上传图片1：</td>
								<td class="FieldInput2"><input id="windowimagefiles1" type="file"
									style="height:25px" 
									name="imagefiles1" /><font
									color="red">选择一个图片*图片的尺寸为1600*327</font></td>
							</tr>										   						   
				</table>
				</center>					
			</form>	
				<div data-options="region:'south',border:false"
					style="text-align:center;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitSave1();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="$('#window').window('close');" style="width:80px">取消</a>
				</div>
				
				<form id="guideindexform2" method="post" enctype="multipart/form-data" >
				     <center>
				     <table>
				     <img src="${pageContext.request.contextPath}/icp/portal/images/banner00.jpg" style="width:169px;height:31px;" alt=""/>										        																													
							<tr>
								<td class="FieldLabel2">上传图片2：</td>
								<td class="FieldInput2"><input id="windowimagefiles2" type="file"
									style="height:25px" 
									name="imagefiles2" /><font
									color="red">选择一个图片*图片的尺寸为1600*327</font></td>
							</tr>										   						   
				     </table>
				     </center>					
				</form>	
				<div data-options="region:'south',border:false"
					style="text-align:center;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitSave2();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="$('#window').window('close');" style="width:80px">取消</a>
				</div>
				
				
				

				<form id="guideindexform3" method="post" enctype="multipart/form-data" >
				     <center>
				     <table>
				     <img src="${pageContext.request.contextPath}/icp/portal/images/banner000.jpg" style="width:169px;height:31px;" alt=""/>										        																													
							<tr>
								<td class="FieldLabel2">上传图片3：</td>
								<td class="FieldInput2"><input id="windowimagefiles3" type="file"
									style="height:25px" 
									name="imagefiles3" /><font
									color="red">选择一个图片*图片的尺寸为1600*327</font></td>
							</tr>										   						   
				     </table>
				     </center>				
				</form>	
				<div data-options="region:'south',border:false"
					style="text-align:center;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitSave3();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="$('#window').window('close');" style="width:80px">取消</a>
				</div>									
		
		</div>			        			
	</div>			
</body>

