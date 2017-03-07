<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   	 
  </head>
  <body>
 <script>
   	$(function(){
   		$.ajax({
   			url:'${pageContext.request.contextPath}/obsMgr/querySecretKey.do',
   			type:'GET',
   			dataType:'json',
   			success:function(data){
   				if(data){
	   				$('#accesskey').textbox('setValue',data.accesskey);
	   				$('#secretkey').textbox('setValue',data.secretkey);
	   				$('#createtime').textbox('setValue',data.ctime);
   				}
   			}
   		});
   		
   	});
   	</script>
   <style type="text/css">
   .sptx{
		display:inline-block;
		width:80px;
	} 	
    .sdk-head{
    	margin:10px;
    	width:800px;
	    font-size: 18px;
		color: #333333;
		padding: 16px;	
		box-shadow: 0 1px 2px -1px #565656;
    }
    .sdk-body{
    	margin:10px;
 		width:790px;
 		height:300px;
	    font-size: 18px;
		color: #333333;
		padding: 10px 20px;	
		box-shadow: 0 1px 2px -1px #565656;
    }
     .sdk-foot{
 		width:960px;
	    font-size: 18px;
		color: #333333;
		padding: 10px 20px;	
		box-shadow: 0 1px 2px -1px #565656;
    }
    
 	a:hover{text-decoration:none; cursor:pointer}  
	.dis_text{
		width:300px;
		height:30px;
		border-width:0;
	}
   	
    </style>
    
	<div class="easyui-panel" data-options="width:970,height:600">
		<div class="sdk-head">密钥管理 </div>
		<div class="sdk-body">
			<div>
				<span class="sptx">SecreKey:</span>
				<input type="text" class="dis_text easyui-textbox" data-options="editable:false" id="secretkey">
			</div>
			<div style="margin-top:10px;">
				<span class="sptx">AccessKey:</span>
				<input type="text" class="dis_text easyui-textbox" data-options="editable:false" id="accesskey">
			</div>
			<div style="margin-top:10px;">
				<span class="sptx">创建时间:</span>
				<input type="text" class="dis_text easyui-textbox" data-options="editable:false" id="createtime">
			</div>

		</div>
	</div>
</body>
</html>
