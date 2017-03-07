<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<style type="text/css">
.networkConfig-left p{
    width:60px;
    text-align:right;
    line-height: 29px;
    margin-left:82px;
    margin-top:26px; 
    font-size: 14px;
  }
.netchoose  #netchoose_gov {height: 30px; width: 90px; text-align: center;  display:inline-block;  border-radius: 2px; border:1px solid #d6d6d6; line-height:30px;  margin-right: 7px; cursor: pointer;}
.netchoose #netchoose_intel {height: 30px; width: 90px; text-align: center; display:inline-block; border-radius: 2px; border:1px solid #d6d6d6;  line-height:30px;  margin-left: 10px; cursor: pointer;}
.on {background: #1dcbf8; border:1px solid #1dcbf8;}
</style>
<body>

<div id="ip_port_config" class="easyui-window" title="IP端口配置"
		data-options="iconCls:'icon-add',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,resizable:false"
		style="width:814px;height:550px;">
   <div class="createInstances_flow">   
	 <img alt="step2" src="${pageContext.request.contextPath}/images/IP_01.png" >
   </div>
	 	
	 <div id="networkConfig-wrap" style="width: 100%; height: 405px;overflow: hidden;">
	 
	   <div class="networkConfig-left ip_port_config">
	      
	        <p>类型</p>
	       
	        <p>内网IP</p>
	        <p>内网端口</p>
	        <p>域名</p>
	        
	        <p id="gov_internet">外网IP</p>
	        <p id="www_chinaunicom">联通IP</p>
	        <p id="www_chinamobile">电信IP</p>
	        <p>外网端口</p>
	      
	   </div>
	   <div class="networkConfig-right">
	   <form action="#" id="ip_port_configForm">
	   <input type="hidden" id="ip_port_neid" name="objectid">
	    <input type="hidden" id="ip_port_nename" name="objectname">
	   <input type="hidden" id="server_ip_portType"  name="networktype">
	       <div class="resourcepool networkConfig">	           
	           <div class="netchoose">
	              <span class="on" id="netchoose_gov">政务外网</span>
	              <span id="netchoose_intel">互&nbsp;&nbsp;联&nbsp;&nbsp;网</span>	           
	           </div>
	            	
	       </div>
	 
	       <div class="instancesnetwork networkConfig">
	             <input class="easyui-textbox" data-options="required:'ture',validType:'ip',missingMessage:'内网IP必填'" style="width: 340px;height: 30px;" id="ip_prot_interaip" name="interaip">
	       </div>
	       <div class="instancesnetwork networkConfig">
	             <input class="easyui-textbox" data-options="required:'ture',validType:'port',missingMessage:'内网端口必填'" style="width: 340px;height: 30px;" id="ip_prot_interaport" name="interaport">
	       </div>
	       <div class="instancesnetwork networkConfig">
	             <input class="easyui-textbox" data-options="required:'ture',missingMessage:'域名必填'"     style="width: 340px;height: 30px;" id="ip_prot_domainname" name="domainname">
	       </div>
	       <div class="instancesnetwork networkConfig" id="gov_internetInput">
	             <input class="easyui-textbox" data-options="required:'ture',validType:'ip',missingMessage:'政务外网IP必填'"     style="width: 340px;height: 30px;" id="ip_prot_interipgov" name="interipgov">
	       </div>
	       <div class="instancesnetwork networkConfig" id="www_chinaunicomInput">
	             <input class="easyui-textbox" data-options="required:'ture',validType:'ip',missingMessage:'联通IP必填'"     style="width: 340px;height: 30px;" id="ip_prot_interipunincom" name="interipunincom">
	       </div>
	       <div class="instancesnetwork networkConfig" id="www_chinamobileInput">
	             <input class="easyui-textbox" data-options="required:'ture',validType:'ip',missingMessage:'电信IP必填'"     style="width: 340px;height: 30px;" id="ip_prot_interiptelecom" name="interiptelecom">
	       </div>
	       <div class="instancesnetwork networkConfig">
	             <input class="easyui-textbox" data-options="required:'ture',validType:'port',missingMessage:'外网端口必填'"     style="width: 340px;height: 30px;" id="ip_prot_interport" name="interport">
	       </div>
	     </form>
	   </div>
	</div>	
<div style="background-color: #dce0e4;padding: 6px;text-align:center;">
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="$('#ip_port_config').window('close');">取消&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true,iconAlign:'right'" onclick="toIpPortConfig()">确定</a>&nbsp;&nbsp;
</div>
</div>

</body>
</html>
<script type="text/javascript">

</script>
