<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<html>
  <head>
	<title>消息发布</title>
  </head>
  
  <body>
  <script type="text/javascript">
  
  $(function(){
		$('#tipshow').tooltip({
			position : 'right',
			content : '上传图片小贴士：<br><font color="red">图片的尺寸为1600*327</font>',
			hideDelay:600,
			trackMouse:true,
			onShow : function() {
				 $(this).tooltip('tip').css({
			     backgroundColor : '#EEE',
			     borderColor : '#95B8E7'
				});
			}
		});
		
		$('#tipshow1').tooltip({
			position : 'right',
			content : '上传图片小贴士：<br><font color="red">图片的尺寸为1600*327</font>',
			hideDelay:600,
			trackMouse:true,
			onShow : function() {
				 $(this).tooltip('tip').css({
			     backgroundColor : '#EEE',
			     borderColor : '#95B8E7'
				});
			}
		});
		
		$('#tipshow2').tooltip({
			position : 'right',
			content : '上传图片小贴士：<br><font color="red">图片的尺寸为1600*327</font>',
			hideDelay:600,
			trackMouse:true,
			onShow : function() {
				 $(this).tooltip('tip').css({
			     backgroundColor : '#EEE',
			     borderColor : '#95B8E7'
				});
			}
		});
											
	})

  	function submitSave(){
  	
  		
  		$('#imageform').form('submit',{
		    url:'${pageContext.request.contextPath}/content/saveImage.do', 
		    onSubmit: function(){
		    	
				
				if($("#windowimagefiles1").val())
						{
							var bizlic = $("#windowimagefiles1").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
				if($("#windowimagefiles2").val())
						{
							var bizlic = $("#windowimagefiles2").val();
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
				if($("#windowimagefiles3").val())
						{
							var bizlic = $("#windowimagefiles3").val();							
							var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();							
							if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
								$.messager.alert('消息', "请选择一张图片【jpg/jpeg/png/gif】！");
								return false;
							}
						}
		    	
		    	
		    }, 
		    success:function(retr){
				    
		    debugger;
		    var data =  JSON.parse(retr); 
		    		    
		    	
		    if(data.success){
            
            
            $.messager.alert('提示',data.msg,"info");
    
           }else{
            $.messager.alert('提示',data.msg,"info");
           }

		    	
		    	
		    }
		});
  	}
  	
	
  </script>
  
    <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 30px 10px 20px;">
    	<div data-options="region:'center',border:false" style="background:#eee;height:30px;overflow_y:scroll;">
    		<!-- <div style="margin: 20px 30px;padding:7px; border-bottom: 1px solid #eee;">
    			<span style="font-family:华文中宋; color:blue; ">消息发布</span>
    		</div> -->
    		<img alt="top" src="${ctx}/images/upload-shouye-pic.png" style="margin-top:20px">
    		<div class="pro-wrap">
    			<form id="imageform" method="post" enctype="multipart/form-data">
    				<div style="margin: 18px 450px;">
					    <span>附件上传：</span>	
					    <input type="file" style="width: 136px;height:30px"  id="windowimagefiles1" name="imagefiles1"/>	
					    	
					    <a class="easyui-linkbutton" id="tipshow" data-options="iconCls:'icon-tishi',plain:true" href="javascript:void(0)"></a>
					    			        
					</div>
					
					<div class="detail-line"  style="margin: 18px 450px;">
					    <span>缩略图：</span>
					    <img src="${pageContext.request.contextPath}/icp/portal/images/banner0.jpg" style="width:150px;height:30px;" alt=""/>										        								
					    
					</div>
					<div class="detail-line"  style="margin: 18px 450px;">
					    <span>附件上传：</span>		
					    <input type="file" style="width: 136px;height:30px"  id="windowimagefiles2" name="imagefiles2"/>				        
						<a class="easyui-linkbutton" id="tipshow1" data-options="iconCls:'icon-tishi',plain:true" href="javascript:void(0)"></a>
						
	
					</div>
					<div class="detail-line"  style="margin: 18px 450px;">
					    <span>缩略图：</span>
					    <img src="${pageContext.request.contextPath}/icp/portal/images/banner00.jpg" style="width:150px;height:30px;" alt=""/>										        								
					    
					</div>					
					<div class="detail-line"  style="margin: 18px 450px;">
					
					    <span>附件上传：</span>		
					    <input type="file" style="width: 136px;height:30px"  id="windowimagefiles3" name="imagefiles3"/>				        
						<a class="easyui-linkbutton" id="tipshow2" data-options="iconCls:'icon-tishi',plain:true" href="javascript:void(0)"></a>
						      
	
					</div>
					
					<div class="detail-line"  style="margin: 18px 450px;">
					    <span>缩略图：</span>
					    <img src="${pageContext.request.contextPath}/icp/portal/images/banner000.jpg" style="width:150px;height:30px;" alt=""/>										        								
					    
					</div>
					
					<div class="detail-line"  style="margin: 18px 320px;">
						
						<div class="detail-line"  style="margin: 15px 50px">
							<a id="btn" href="javascript:void(0)" onclick="submitSave()" data-options="iconCls:'icon-ok'" class="easyui-linkbutton" style="margin-left: 150px;width: 100px;height: 30px">提交</a>
						</div>
					</div>
    			</form>
    		</div>
    	</div>
    </div>
    
  </body>
</html>
