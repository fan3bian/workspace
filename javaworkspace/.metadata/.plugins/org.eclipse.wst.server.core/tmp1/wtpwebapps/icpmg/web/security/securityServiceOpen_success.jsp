<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<style type="text/css">
  .createInstances_success_wrap .success_up{
  
   height: 105px;
   width: 90%;
   padding:10px;
   margin:auto auto;
   border-bottom: 1px solid #ddd;
   
  }
  
   .createInstances_success_wrap .success_up p{
     margin-top: 15px;
   }
   .createInstances_success_wrap .success_up p a{
     color: blue;
   }
   
   .security_detail_basic_wrap{
      margin-top:10px;
      margin-left:10px;
      margin-right:10px;
      border:none;
      height:100px;
   }
   
   .security_detail_network_wrap{
      margin-top:2px;
      margin-left:10px;
      margin-right:10px;
      background-color: white;
      border:none;
      height:150px;
   }
   
   .security_detail_basic_th1{
     float:left;
     border:1px solid white;
      background-color: #dce0e4;
     width: 18%;
   }
   .security_detail_basic_th2{
     float:left;
      border:1px solid white;
       background-color: #dce0e4;
       width: 12%;
   }
   .security_detail_basic_th3{
     float:left;
      border:1px solid white;
       background-color: #dce0e4;
       width: 69%;
   }
   
   .security_detail_network_th1{
     float:left;
     border:1px solid #dce0e4;
      width: 18%;
   }
    .security_detail_network_th2{
     float:left;
     border:1px solid #dce0e4;
      width: 12%;
   }
    .security_detail_network_th3{
     float:left;
     border:1px solid #dce0e4;
      width: 69%;
   }
   
 
   
   .security_detail_basic_th1 {
  
       height:100px;
      line-height:100px; 
     text-align:center;
     color: blue;
     font-size: 14px;

   }
   
    .security_detail_network_th1 {
      height:150px;
      line-height:150px; 
     text-align:center;
     color: blue;
      font-size: 14px;
   }
   
   .security_detail_text{
      height:25px;
      line-height:25px; 
      text-align:right;
      padding-right: 18px;
   }
      
   .security_detail_text_th3{
      height:25px;
      line-height:25px; 
      text-align:left;
       padding-left: 18px;
      margin-left:5px
      
   }
  
</style>
<body>
   <div id="securityServiceOpen_success" class="easyui-window" title="安全服务开通-创建成功" data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:814px;height:550px;">
	  <div class="createInstances_flow"> 	
		<img alt="step4" src="${pageContext.request.contextPath}/images/safe_flow_03.png">
	  </div>	
	   <div class="createInstances_success_wrap" style="width: 100%;height: 405px; overflow: hidden;">
	     <div class="success_up">
	        <p align="center">
	            <img alt="complete" src="${pageContext.request.contextPath}/web/resourceMg/vm/images/success.png" style="position:relative;top:11px;margin-right: 15px">
	           <span style="margin-left: 10px;font-size: x-large; font-weight: bold;margin-top: 35px">创建进行中，请稍后查看状态</span>
	        </p>
	       
	     </div>
	     <div class="success_down">
	   <div class="security_detail_basic_wrap">
	     <div class="security_detail_basic_th1">基础配置</div>
	     <div class="security_detail_basic_th2">
	       <div class="security_detail_text">规格</div>
	       <div class="security_detail_text">服务</div>
	       <div class="security_detail_text">用户</div>
	       <div class="security_detail_text">名称</div>
	     </div>
	     <div class="security_detail_basic_th3">
	       <div class="security_detail_text_th3" id="security_detail_text_shopname"></div>
	       <div class="security_detail_text_th3" id="security_detail_text_funtype"></div>
	       <div class="security_detail_text_th3" id="security_detail_text_suserid"></div>
	       <div class="security_detail_text_th3" id="security_detail_text_displayname"></div>
	     </div>
	     <div style="clear:both"></div>
	   </div>
	   <div class="security_detail_network_wrap">
	    <div class="security_detail_network_th1">网络配置</div>
	    <div class="security_detail_network_th2">
	      <div class="security_detail_text">管理网络</div>
	      <div class="security_detail_text"></div>
	      <!-- <div class="security_detail_text">管理IP</div>-->
	      <div class="security_detail_text">业务网络</div>
	      <div class="security_detail_text"></div>
	      <!-- <div class="security_detail_text">业务IP</div>-->
	      <div class="security_detail_text">外连网络</div>
	      <div class="security_detail_text"></div>
	      <!-- <div class="security_detail_text">外连IP</div>-->
	    </div>
	    <div class="security_detail_network_th3">
	      <div class="security_detail_text_th3" id="security_detail_text_manvlan"></div>
	      <div class="security_detail_text_th3" ></div>
	      <div class="security_detail_text_th3" id="security_detail_text_funvlan"></div>
	      <div class="security_detail_text_th3" ></div>
	      <div class="security_detail_text_th3" id="security_detail_text_connvlan"></div>
	      <div class="security_detail_text_th3" ></div>
	    </div>
	      <div style="clear:both"></div>
	   </div>
	     </div>
      </div> 
	  <div style="background-color: #dce0e4;padding: 6px;text-align:center;">
	
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true" onclick="$('#securityServiceOpen_success').window('close');">确定</a>
      </div>
   </div>
</body>
</html>
