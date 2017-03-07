<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
  
   .createInstances_success_wrap .success_up .success_up_text{
     margin-top: 15px;
   }
   .createInstances_success_wrap .success_up .success_up_text a{
     color: blue;
   }
   .createInstances_success_wrap .success_down{
       height: 100%;
       width: 100%;
       padding-left:0 10px;
       margin:0px auto;
       
       overflow: hidden;
   }
  .vmA_detail_basic_wrap{
      margin-top:5px;
      margin-left:32px;
      border:none;
      width:92%;
      overflow:hidden;
   }
   .vmA_detail_basicinfo_wrap{
      margin-top:2px;
     
      background-color:#dce0e4;
      margin-left:32px;
      border:none;
      width:92%;
      overflow:hidden;
   }
   .vmA_detail_network_wrap{
      margin-top:2px;    
      background-color: #eee;
      margin-left:32px;
      border:none;
      width:92%;
      overflow:hidden; 
   }
   
   .vmA_detail_basic_th1{
     float:left;
     border-right:1px solid white;
     background-color: #dce0e4;
     width: 18%;
   }
   .vmA_detail_basic_th2{
     float:left;
       border-right:1px solid white;
       background-color: #dce0e4;
       width: 12%;
   }
   .vmA_detail_basic_th3{
       float:left;
       padding-right:5px;
       background-color: #dce0e4;
       width: 69%;
   }
   
   .vmA_detail_network_th1{
     float:left;
      border-right:1px solid #fff;
      width: 18%;
    
   }
    .vmA_detail_network_th2{
     float:left;
     border-right:1px solid #fff;
      width: 12%;
   
   }
    .vmA_detail_network_th3{
     float:left;
   
      width: 69%;
    }
   
   .vmA_detail_basicinfo_th1{
    float:left;
      border-right:1px solid #fff;
    
    width: 18%;
    height: 130px;
    text-align: center;
   color: blue;
   line-height:130px;
   font-size: 14px;
   }
    .vmA_detail_basicinfo_th2{
      float:left;
      margin-top:3px;
      border-right:1px solid #fff;
      width: 12%; 
      height: 130px;
   }
    .vmA_detail_basicinfo_th3{
      float:left;
     
      width: 69%;
      height: 130px;
   }
   
   .vmA_detail_basic_th1 {
  
       height:100px;
      line-height:100px; 
     text-align:center;
     color: blue;
     font-size: 14px;
   border-right:1px solid #fff;
   }
   
    .vmA_detail_network_th1 {
      height:150px;
      line-height:150px; 
     text-align:center;
     color: blue;
      font-size: 14px; 
      border-right:1px solid #fff;
   }
   
   .vmA_detail_text{
      height:25px;
      line-height:25px; 
      text-align:right;
      padding-right: 13px;
   }
      
   .vmA_detail_text_th3{
      height:25px;
      line-height:25px; 
      text-align:left;
       padding-left: 18px;
      margin-left:5px;
         
   }
</style>
 <body>
   <div id="createInstances_success" class="easyui-window" title="创建云服务器-创建成功" data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,resizable:false" style="width:814px;height:570px;">
	  <div class="createInstances_flow"> 	
		<img alt="step4" src="${pageContext.request.contextPath}/images/flow_04.png">
	  </div>	
	  <input type="hidden" id="createInstances_success_hidden_sid"><input type="hidden" id="createInstances_success_hidden_sname">
	  <input type="hidden" id="createInstances_success_hidden_ptype"><input type="hidden" id="createInstances_success_hidden_nettype">
	   <div class="createInstances_success_wrap" style="width: 100%;height: 425px; overflow: hidden;">
	     <div class="success_up">
	        <p align="center" class="success_up_text">
	            <img alt="complete" src="${pageContext.request.contextPath}/web/resourceMg/vm/images/success.png" style="position:relative;top:11px;margin-right: 15px">
	           <span style="margin-left: 10px;font-size: x-large; font-weight: bold;margin-top: 35px">创建成功!</span>
	        </p>
	        <!-- <p align="center" class="success_up_text">您可以为云服务器<span id="vmname_that_create">【icloud-vm-015】</span>配置IP端口。<a href="javascript:void(0)" onclick="ipPortConfig()">前去配置→</a></p> -->
	     </div>
	     <div class="success_down">
	      <div class="vmA_detail_basic_wrap">
	 	 <div class="vmA_detail_basic_th1">基础配置</div>
	     <div class="vmA_detail_basic_th2">
		     <div class="vmA_detail_text">CPU</div>
		     <div class="vmA_detail_text">内存</div>
		     <div class="vmA_detail_text">镜像</div>
		     <div class="vmA_detail_text">数据盘</div>
	     </div>
	     <div class="vmA_detail_basic_th3">
	     	 
	         <div class="vmA_detail_text_th3" id="vmA_detail_text_cpu"></div>
	         <div class="vmA_detail_text_th3" id="vmA_detail_text_mem"></div>
	         <div class="vmA_detail_text_th3" id="vmA_detail_text_image"></div>
	         <div class="vmA_detail_text_th3" id="vmA_detail_text_disks"></div>
	     
	     </div>
	     <div style="clear:both"></div>
	   </div>
	   <div class="vmA_detail_network_wrap">
	    <div class="vmA_detail_network_th1" style="height:50px;line-height: 50px">网络配置</div>
	    <div class="vmA_detail_network_th2" style="height:50px">
	   	 
	      <div class="vmA_detail_text">资源池</div>
	      <div class="vmA_detail_text">网络(vlan)</div>
 
	    </div>
	    <div class="vmA_detail_network_th3" style="height:50px">
	 
	      <div class="vmA_detail_text_th3" id="vmA_detail_resourcepool"></div>
	      <div class="vmA_detail_text_th3" id="vmA_detail_vlan"></div>
	 	 
	    </div>
	      <div style="clear:both"></div>
	   </div>
	   
	   <div class="vmA_detail_basicinfo_wrap">
	    <div class="vmA_detail_basicinfo_th1">基本信息</div>
	    <div class="vmA_detail_basicinfo_th2">
	   	  <div class="vmA_detail_text">虚机名称</div>
	      <div class="vmA_detail_text">数量</div>
	      <div class="vmA_detail_text">单位</div>
	      <div class="vmA_detail_text">项目</div>
	      <div class="vmA_detail_text">应用</div>
	      <div class="vmA_detail_text"></div>
	     
	    </div>
	    <div class="vmA_detail_basicinfo_th3">
	      <div class="vmA_detail_text_th3" id="vmA_detail_text_vmname"></div>
	      <div class="vmA_detail_text_th3" id="vmA_detail_text_vmnum"></div>
	      <div class="vmA_detail_text_th3" id="vmA_detail_text_unit"></div>
	      <div class="vmA_detail_text_th3" id="vmA_detail_text_project"></div>
	      <div class="vmA_detail_text_th3" id="vmA_detail_text_app"></div>
	 	  <div class="vmA_detail_text_th3"></div>
	    </div>
	      <div style="clear:both"></div>
	   </div>
	     </div>
      </div> 
	  <div style="background-color: #dce0e4;padding: 6px;text-align:center;">
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="createNext()">继续创建</a>&nbsp;&nbsp;&nbsp;&nbsp;
	   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true" onclick="javascript:$('#createInstances_success').window('close')">确定</a>&nbsp;&nbsp;
      </div>
   </div>
</body>
</html>
<script type="text/javascript">
  $(function(){
  
    
  })
</script>
