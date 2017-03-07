<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<style type="text/css">
 
 .ip_port_success_wrap .success_up{
  
   height: 90px;
   width: 90%;
   padding:10px;
   margin:auto auto;
   border-bottom: 1px solid #ddd;
   
  }
   .ip_port_success_wrap .success_up p{
   
   margin-top: 14px;

  }
   #ip_port_success .success_down{
       height: 240px;
       width: 90%;
       padding-left:10px;
       padding-right:10px;
       margin:20px auto;
       background-color: #f5f5f5;
   }
   #ip_port_success .success_down .success_down_detail{
       
       float: left;
       height: 100%;
   }
  #ip_port_success .success_down  .success_down_1{
      width: 25%;
      text-align:center;
      line-height:240px;
      color:blue;
      font-size:18px;
      border-right: 1px solid #ddd;
   }
  #ip_port_success .success_down   .success_down_2{
       width: 15%;
        
       border-right: 1px solid #ddd;
   }
   #ip_port_success .success_down   .success_down_2 p{
        
        margin-top: 12px;
        text-align: right;
        padding-right: 15px
   }
   #ip_port_success .success_down .success_down_3 p{
    
       margin-top: 12px;
       text-left: right;
       padding-left: 15px
   }
</style>
 <body>
   <div id="ip_port_success" class="easyui-window" title="IP端口配置成功" data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,resizable:false" style="width:814px;height:550px;">
	  <div class="createInstances_flow"> 	
		<img alt="step4" src="${pageContext.request.contextPath}/images/IP_02.png">
	  </div>	
	   <div class="ip_port_success_wrap" style="width: 100%;height: 405px; overflow: hidden;">
	     <div class="success_up">
	        <p align="center">
	            <img alt="complete" src="${pageContext.request.contextPath}/web/resourceMg/vm/images/success.png" style="position:relative;top:11px;margin-right: 15px">
	           <span style="margin-left: 10px;font-size: x-large; font-weight: bold;margin-top: 35px">配置完成!</span>
	        </p>
	     
	     </div>
	     <div class="success_down">
	        <div class="success_down_1 success_down_detail">
	            <p>网络配置</p>
	        </div>
	        <div class="success_down_2 success_down_detail">
	          
	        </div>
	        <div  class="success_down_3 success_down_detail">
	     
	          
	        </div>
	     </div>
      </div> 
	  <div style="background-color: #dce0e4;padding: 6px;text-align:center;">
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="javascript:$('#ip_port_success').window('close')">取消</a>&nbsp;&nbsp;&nbsp;&nbsp;
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true" onclick="javascript:$('#ip_port_success').window('close')">确定</a>&nbsp;&nbsp;
      </div>
   </div>
</body>
</html>
<script type="text/javascript">
  $(function(){
  
    
  })
</script>
