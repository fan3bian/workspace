<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String operType = request.getParameter("operType")==null?"":request.getParameter("operType").toString();//工单拆分 子流程 实施操作标记 gdcf
String operFlowSign = "1";//1资源申请，2资源变更
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">

.lcy-search{ margin: 0 20px; }
.lcy-search td{ padding:10px 20px 10px 0; }
.lcy-body .panel-body{ background: #eee; }
/*发起订单*/
.lcy-fqdd{margin: 0 20px; position: relative;}
.lcy-fqdd-select{ border-radius: 3px; border-color: #dddddd; border-width: 1px; border-style: solid; padding:15px 10px; padding-right: 80px; position: relative; padding-left: 34px;background: url('../icons/edit_add.png') no-repeat center center #fff; height: 36px; overflow: hidden;margin-bottom: 10px;z-index:1;}
.lcy-fqdd-select .icon-add-p{ position: absolute; top:25px; left: 10px; width: 16px; height: 16px; }
.lcy-fqdd-select .btn-toggle{ position: absolute; top:20px; right: 18px;}
.lcy-fqdd-select .btn-toggle a{color:#999999;}
.lcy-fqdd-select ul li{ position: relative; }
.lcy-fqdd-select  .header{ width: 100px; color: #999999; font-size: 12px; border-right: 1px solid #dcdcdc; height:25px;line-height: 25px; position: absolute; left:0px;top:5px; }
.lcy-fqdd-select .body{ padding-left: 120px; }
.lcy-fqdd-select .body a{color:#427def; font-size: 12px; display: inline-block; line-height: 35px; width: 175px; margin-bottom: 5px; }
.lcy-fqdd-select .body a:hover{color:#222; text-decoration:none; }

.btn-toggle-s{ display: none; }
.icon-btn-arrow-up{ background:url(../../images/public.png) no-repeat -21px 0; display: block; width: 16px; height: 16px; float: right;margin-left: 2px; }
.icon-btn-arrow-down{background:url(../../images/public.png) no-repeat -2px 0; display: block; width: 16px; height: 16px;float: right;margin-left: 2px;}
/*表格部分*/

#serviceWindow.window-body{ overflow: hidden; }
#serviceWindow.window-body {padding:0;}
.lcy-fqdd-t .header{ font-size: 20px; color: #333; font-family: 宋体; font-weight: bold; text-align: center; padding:10px 0; }
.lcy-fqdd-t{ border-radius: 3px; border-color: #dddddd; border-width: 1px; border-style: solid; padding:15px 15px 15px 15px; overflow: hidden;margin-bottom: 10px; background: #fff; position: absolute;top:80px;left:0;right:0;}
.lcy-fqdd-t .panel-header{ background: #fff; padding:0;  border-width: 1px; border-style: solid; border-color: #e5e5e5;progid:DXImageTransform.Microsoft.gradient(startColorstr=#fff,endColorstr=#fff,GradientType=0);}
.lcy-fqdd-t .panel-title{ color: #00b7ee; font-size: 18px; font-family: 宋体; line-height: 26px;height: 26px; padding-left: 5px; }
.t-wrap-iaas,.t-wrap-paas,.t-wrap-saas { margin: 0 15px 20px 0px}
.t-wrap-iaas .panel-title{ color: #427def;}
.t-wrap-paas .panel-title{ color: #f0b910; }
.t-wrap-saas .panel-title{ color: #0fb373; }
.lcy-fqdd-t .datagrid-header .datagrid-cell { background-color: #fff; height: 45px;line-height: 45px;}
.lcy-fqdd-t .datagrid-header td, .datagrid-body td, .datagrid-footer td { border-width: 0 1px 1px 0; border-style: solid; margin: 0; padding: 0;}
.lcy-body .lcy-fqdd-t .panel-body {background: #fff; border-left: 1px solid #e5e5e5;}
.lcy-fqdd-t .datagrid-header-row, .datagrid-row { height: 45px;}
.lcy-fqdd-t  .datagrid-header td,.lcy-fqdd-t   .datagrid-body td, .datagrid-footer td {  border-color: #e5e5e5;  height:45px; border-style: solid;}
/*页脚*/
.lcy-fqdd-t .info{ overflow: hidden; margin:10px 0; }
.lcy-fqdd-t .fqr{ width: 30%; float: left; text-align: left;}
.lcy-fqdd-t .fqdw{ width: 40%;float: left;text-align: center; }
.lcy-fqdd-t .fqdate{ width: 30%;float: right;text-align: right;  }
.lcy-fqdd-t .btn-box{ text-align: center; margin: 40px 0; }
.lcy-fqdd-t .btn-box a{ padding:0 10px; margin: 0 10px; }
/*配置弹层*/
.lcy-window-item{ overflow: hidden;background: #eee; }
.lcy-window-item-body{ width: 620px; float: right; background: #fff; padding:10px 0 0 10px; line-height: 32px;}
.lcy-window-item-body ul li{border: 1px solid #ccc; height: 30px; line-height: 30px; padding:0 30px; margin:0 10px 10px 0px; float: left;border-radius: 3px; cursor: pointer; min-width: 30px; text-align: center;}
.lcy-window-item-body ul li.active{   background: #1dcbf8; color:#fff;border: 1px solid #1dcbf8;}
.lcy-window-item-header{ width: 150px; line-height: 32px;   padding-top:10px;text-align: right; font-size: 12px;padding-right: 30px;  }
.item-sildebox{padding-top:20px; padding-left: 10px; height: 50px; position: relative;}

.lcy-window-item-body  .l-btn-text {   line-height:30px; padding: 0 10px;}
.item-right{position: absolute; top:13px; right: 10px;}
.item-right input{ border:1px solid #ddd; line-height: 30px; height: 30px; padding-left: 5px; width: 50px; }
.item-right span{ border-width: 1px 1px 1px 0; border-style: solid; border-color: #ddd;line-height: 30px;display: inline-block; padding: 0 5px; }
.lcy-window-item-body  .add-sub{ overflow: hidden; }
.lcy-window-item-body  .add-sub a:hover{text-decoration: none;}
.lcy-window-item-body  .subbtn{ font-size: 20px; line-height: 30px; border-width: 1px; border-style: solid; border-color: #ddd;float:left; width: 30px; text-align: center; }
.lcy-window-item-body  .addbtn{font-size: 20px; line-height: 30px; border-width: 1px; border-style: solid; border-color: #ddd;float:left; width: 30px;text-align: center;  }
.lcy-window-item-body .input-num{line-height: 30px; height: 30px; border-width: 1px 0 1px 0; border-style: solid; border-color: #ddd; vertical-align: top;float:left; width: 60px; text-align: center;}
 /*  tan2 */
 
 .ty-select{ border-color: #ddd; height: 25px; line-height: 25px; border-radius: 3px; }
.ty-icon{ height: 23px; line-height: 23px; border: 1px solid #ddd; border-radius: 3px;display: inline-block; color: #000; background:url(images/icons-collect.png) no-repeat 10px center #efefef; padding:0 10px 0 30px; margin-left:20px;}
.ty-icon-warning{background-image:url(images/icons-warning.png)}
.ty-tabscon-top{ text-align: center; }
.ty-top-input{ height: 23px; line-height: 23px; border: 1px solid #ddd; border-radius: 3px; width: 400px;  padding:0 5px; color: #333;}
.ty-top-input:focus{ border-color: #f8b551; box-shadow: 0 0 1px 1px  #f8b551}
.ty-top-button{ height: 23px; line-height: 23px; border: 1px solid #ddd; border-radius: 3px;display: inline-block; color: #000; background:url(images/icons-collect.png) no-repeat 10px center #efefef; padding:0 10px 0 30px; margin-left:20px;}
.ty-tabs-title{ overflow: hidden; position: relative; z-index: 2; padding-left: 10px;  }
.ty-tabs-title li{ height: 23px; line-height: 23px; padding:0 25px;  border-color: #e5e5e5; border-style: solid; border-width: 1px 1px 0 1px; float: left;
margin-right: 3px; border-radius: 3px; background: #fff; cursor: pointer; color: #000;}
.ty-tabs-title li.active{ height: 23px; border-top: 2px solid #0075a9; }
.ty-tabs-content{border-top: 1px solid #e5e5e5; margin-top: -1px;}
.ty-tabscon-top{ padding:10px; border-bottom: 1px solid #e5e5e5; }
.ty-tabscon-main{ padding:0px 20px 0 20px; }
.ty-tabscon-item{ margin-top: 25px; position: relative; border:1px solid #ddd; padding:10px 0px 5px 0px; color: #333; }
.ty-tabscon-item-title{ position: absolute; top:-15px; left: 13px; line-height: 20px; border:1px solid #ddd; padding:0px 20px; color: #0582c3; background: #fff; }
.must-star{ color: #f0a73b; }
.ty-tabcon-table-layout td{ padding:5px; font-size:12px; }
.ty-tabscon-item-ul{list-style: none;    overflow: hidden;
    padding-left: 0;}
.ty-tabscon-item-ul li{ float: left; margin-right: 10px; border: 1px solid #ddd; border-radius: 3px;     height: 23px;
    line-height: 23px;    width: 73px;    padding: 0 5px;    color: #333; text-align: center;cursor: pointer; }
.ty-tabscon-item-ul li.active{border-color:#f0a73b; background: #f8b551; color: #fff; }
.table-yy { width:100%;border-bottom:1px solid #ddd; border-right:1px solid #ddd; border-spacing:0;}
.table-yy th,.table-yy  td{ padding:2px 0px; font-size:12px; border-top:1px solid #ddd; border-left:1px solid #ddd;}
.table-yy th{ background:#eee;}
.table-yy input{ width:100%}
*{font-size:12px; font-family:Tahoma,Verdana,Microsoft YaHei,NSimSun}
body{background:#eee; }
</style>
  </head>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
	<link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
   <script type="text/javascript" src="<%=basePath%>/js/sockjs-0.3.min.js"></script>
    
  
  <body >
     	<%--  <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" /> --%>
     	<div> 
     	
			<table id="dg_resource"  style="width:99%" height='auto'>
				<thead>
				<tr>
					<th data-options="field:'detailsortnum',width:20,hidden:true">子序号</th>
					<th data-options="field:'shopid',width:40,align:'center'">资源编码</th>
					<th data-options="field:'shopname',width:60,align:'center'">资源名称</th>
					<th data-options="field:'proid',width:20,align:'center',hidden:true">项目id</th>
					<th data-options="field:'proname',width:20,align:'center',hidden:true">项目名称</th>
					<th data-options="field:'useunitid',width:20,align:'center',hidden:true">单位id</th>
					<th data-options="field:'useunitname',width:20,align:'center',hidden:true">单位</th>
					<th data-options="field:'userid',width:20,align:'center',hidden:true">申请人id</th>
				    <th data-options="field:'uname',width:20,align:'center',hidden:true">申请人</th>
					<th data-options="field:'appid',width:20,align:'center',hidden:true">应用id</th>
					<th data-options="field:'appname',width:80,align:'center'">应用</th>
					<th data-options="field:'typeid',width:20,align:'center',hidden:true">应用</th>
					<th data-options="field:'measureunit',width:20,align:'center',hidden:true">计量单位</th>
					<th data-options="field:'configure',width:170,align:'center',title:'www'">规格</th>
					<th data-options="field:'orderid',width:10,align:'center',hidden:true"></th>
					<th data-options="field:'detailid',width:10,align:'center',hidden:true"></th>
					<th data-options="field:'tprice',width:10,align:'center',hidden:true">价格</th>
					<th data-options="field:'network',width:40,align:'center'">网络类型</th>
					<th data-options="field:'tnumber',width:20,align:'center'">数量</th>
					<th data-options="field:'impusername',width:30,align:'center'">实施人</th>
					<th data-options="field:'ostatus',width:30,align:'center',formatter:statusformater">状态</th>
					<th data-options="field:'statusT',width:30,align:'center',formatter:operformater">操作</th>
					 
				</tr>
				</thead>
			</table>
     	 </div>
 <div id="serviceWindow_network">
   
	     <form id="serviceWindow_network_form">
	     
	    	<div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	           <label for="resourcepool">资源池:</label>   
	           <input id="resourcepool" style="width: 222px;height: 30px; "  name="resourcepool">
				<span id="resourcemust" style="margin-left:5px;color:red;"></span>
	        </div>
 
	    	<div class="order_vlan"  style="margin:15px 25px 15px 25px">
	    	  <label for="instancesnetwork" >VLAN&nbsp;&nbsp;:</label>  
	          <input   id="instancesnetwork" style="width: 222px;height: 30px; "  name="instancesnetwork">   
	         <span id="networkmust" style="margin-left:5px; color:red;"></span>
	        </div>
	     </form>
    
     
    </div> 
 

  <!-- 防火墙 -->
  
  <div id="serviceWindow_firewalls">
   
	     <form id="serviceWindow_firewalls_form">
	     
	    	<div class="order_vlan1" style="margin: 15px 25px 15px 25px">
	           <label for="gvlan">管理网络:</label>   
	           <input  id="gvlan" style="width: 222px;height: 30px; " >
			   <span id="gvlanmust" style="margin-left:5px; color:red;"></span>
	        </div>
 
	    	<div class="order_vlan2"  style="margin:15px 25px 15px 25px">
	    	  <label for="bvlan" >业务网络:</label>  
	          <input id="bvlan" style="width: 222px;height: 30px; " >   
	         <span id="bvlanmust" style="margin-left:5px; color:red;"></span>
	        </div>
	        
	        <div class="order_vlan3"  style="margin:15px 25px 15px 25px">
	    	  <label  >外联网络:</label>  
	          <input  id="ovlan" name="dept"  style="width: 222px;height: 30px; ">   
	          <span id="ovlanmust" style="margin-left:5px; color:red;"></span>
	        </div>
	     </form>
    
     
    </div> 
 
 	<!-- 云硬盘实施 -->
 	<div id="yyp_window">
 	<style>
	 	.hjb-textbox{margin-left: 0px;
		margin-right: 0px;
		padding-top: 6px;
		padding-bottom: 6px;
		width: 212px;font-size: 12px;
		border:1px solid #ddd;
		margin: 0;
		padding: 4px;
		vertical-align: middle;
		outline-style: none;
		resize: none;
		border-radius: 5px 5px 5px 5px;}
		
		.not-allowed{background: #eee;
    	cursor: not-allowed;}
	</style>
	     <form id="yyp_form">
	     	<div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	            <label for="storeName" style="display:inline-block;width:80px;">硬盘名称:</label>   
	           	<input id="storeName" style="width: 222px;height: 30px; "  name="storeName"  readonly="readonly"  autocomplete="off" class="hjb-textbox not-allowed">
	        	<input id="platformid" type="hidden">
	        	<input id="storeinfo" type="hidden">
	        </div>
	        <div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	            <label for="storeNum" style="display:inline-block;width:80px;">硬盘容量(G):</label>   
	           	<input  id="storeNum" style="width: 222px;height: 30px; "  name="storeNum"  readonly="readonly"  autocomplete="off" class="hjb-textbox not-allowed">
	        </div>
	        <div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	            <label for="attachNeid" style="display:inline-block;width:80px;">挂载云服务器:</label>   
	           	<input id="attachNeid" style="width: 222px;height: 30px; " autocomplete="off" class="hjb-textbox">
	        </div>
	        <!-- <div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	           	<label for="ipaddress" style="display:inline-block;width:80px;">云服务器IP:</label>   
	           	<input  id="ipaddress" style="width: 222px;height: 30px; "  name="ipaddress" autocomplete="off" class="hjb-textbox not-allowed">
	        </div> -->
	     </form>
    </div>
 	
	<%--负载均衡实施 --%>
	<div id="fzjhss_window">
	     <form id="fzjhss_form">
	     	<%--
	     	<div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	           <label for="networktype" style="display:inline-block;width:70px;">区&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;域:</label> 
	             <span id="networktype"></span>
	        </div>
	     	<div class="order_resourcepool" style="margin: 15px 25px 15px 25px">
	           <label for="connnum" style="display:inline-block;width:70px;">最大连接数:</label> 
	             <span id="connnum"></span>
	        </div>
	      	 --%>
	        <div class="fzjh_glwl" style="margin: 15px 25px 15px 25px">
	           <label for="fzjhGlwl" style="display:inline-block;width:60px;">管理网络:</label>   
	           <input id="fzjhGlwl" style="width: 222px;height: 30px;" >
			   <span id="fzjhGlwlSpan" style="margin-left:5px;color:red;"></span>
	        </div>
	        <div class="fzjh_ywwl"  style="margin:15px 25px 15px 25px">
	    	  <label for="fzjhYwwl" style="display:inline-block;width:60px;">业务网络:</label>  
	          <input id="fzjhYwwl" style="width: 222px;height: 30px; " >
	          <span id="fzjhYwwlSpan" style="margin-left:5px; color:red;"></span>
	        </div>
	     </form>
    </div> 
 
 	<%--实施任务指派选择人员弹框  start--%>
 	<div id="assignUserWindow" style="padding:3px 0px;">
	    <table class="" width="100%">
	        <tr>
	            <td align="right" width="20%">姓名：</td>
	            <td align="left" width="80%">
	                <input type="text"  id="searchName" name="searchName" class="ty-top-input" style="width: 120px;">
	                <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="queryUserDg()">查询</a>
					<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="queryChongzhi()">重置</a>
									   
	            </td>
	        </tr>
	    </table>
        <div style="overflow-y: !important;" id="dgDiv">
			<table  id="dg_assignUser" width="100%" border="0" cellpadding="0" cellspacing="0" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true,align:'center',width:'40px'"></th>
						<th data-options="field:'uname',align:'center',width:'80px'">姓名</th>
						<th data-options="field:'sysname',align:'center',width:'120px'">部门</th>
						<th data-options="field:'email',align:'center',width:'120px'">邮箱</th>
						<th data-options="field:'mobile',align:'center',width:'80px'">手机</th>
					</tr>
				</thead>
			</table>
        </div>
     </div>
     <%--实施任务指派选择人员弹框 end--%>                   
                        
  </body>
  
  <script type="text/javascript">
  var detailsortnum="";//负载均衡、防火墙等拆分后的时候子序号
  var operTypeTwo = "";//再次拆分实施标记
   var rowObject;//实施页面，列表数据
   var resourceStatus = 0; 
   var resourcepoolurl="${pageContext.request.contextPath}/vmconfig/queryResourcePool.do";
   var instancesnetworkurl="${pageContext.request.contextPath}/vmconfig/queryVlan.do";
   var row;
   var ws = null;
   var url = null;
   var modifyFlag = 1;
   var transports = [];
   updateUrl('/icpmg/sockjs/echo');
   connect();
  
  /* var windowHtml3 = $('#serviceWindow3').html(); */
  function updateUrl(urlPath) {
		if (urlPath.indexOf('sockjs') != -1) {
			url = urlPath;

		} else {
			if (window.location.protocol == 'http:') {
				url = 'ws://' + window.location.host + urlPath;
			} else {
				url = 'wss://' + window.location.host + urlPath;
			}

		}
	} 
  
  function connect() {
	
	     if(window.eventactive){
					 window.eventactive.close();
					 window.eventactive=null;
		}
		if (!url) {
			alert('Select whether to use W3C WebSocket or SockJS');
			return;
		}
		ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
			protocols_whitelist : transports
		}) : new WebSocket(url);
        window.eventactive = ws;
		ws.onopen = function() {
          
		};
		ws.onmessage = function(event) {
		var data = event.data;
		var data =  JSON.parse(data);
		var info = data.msg;
		
		if(data.step=="vmSuccess"){
		    var displayname = data.displayname;
		    $.messager.alert('提示',displayname+"创建成功!","info");
		    $('#dg_resource').datagrid('reload');
		}else if(data.step=="lbtrue"){
		    var displayname = data.displayname;
		    $.messager.alert('提示',"负载均衡"+displayname+"创建成功!","info");
		    $('#dg_resource').datagrid('reload');
		}else if(data.step=="lbfalse"){
		    var displayname = data.displayname;
		    $.messager.alert('提示',"负载均衡"+displayname+"创建失败!","info");
		    $('#dg_resource').datagrid('reload');
		}else if(data.step=="securitytrue"){
		    var displayname = data.displayname;
		    $.messager.alert('提示',"防火墙"+displayname+"创建成功!","info");
		    $('#dg_resource').datagrid('reload');
		}else if(data.step=="securityfalse"){
		    var displayname = data.displayname;
		    $.messager.alert('提示',"防火墙"+displayname+"创建失败!","info");
		    $('#dg_resource').datagrid('reload');
		}else if(data.step=="indisktrue"){
		    var displayname = data.displayname;
		    $.messager.alert('提示',"云硬盘"+displayname+"创建成功!","info");
		    $('#dg_resource').datagrid('reload');
		}else if(data.step=="indisktrue"){
		    var displayname = data.displayname;
		    $.messager.alert('提示',"云硬盘"+displayname+"创建失败!","info");
		    $('#dg_resource').datagrid('reload');
		}else if(info===''){
			  $('#dg_resource').datagrid('reload');
		}else{
	      $.messager.alert('提示',info,"info");
	   	  $('#dg_resource').datagrid('reload');
		}		
	    //$('#dg_resource').datagrid('load', {});
		};
		ws.onclose = function(event) {
 
		};
	}
	
	$('#dg_resource').datagrid({
	               rownumbers:false,
			     
			       striped:true,
			       nowarp:false,
			       
			       scrollbarSize: 0,
			       singleSelect: true,
				   sortName:'detailid',
				   sortOrder:'asc',
				   url:'<%=basePath%>/workorder/resourceOper.do?flowid=<%=request.getParameter("transferid")%>&operType=<%=operType%>',
				   method:'post',
				   loadMsg:'数据装载中......',
				   fitColumns:true,
				   idField:'detailid',
				   onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					}
	
	})
	
   
  
      	$('#serviceWindow_network').dialog({
    	   width: 380,
           height: 220,
           closed: true,
           modal: true,
           collapsible: false,
           minimizable: false,
           maximizable: false,
           resizable: false,
           
           buttons: [{
               text: '确定',
               iconCls: 'icon-ok',
               handler: function() {
 
              /*  
                 alert(row.configure);
	    
	            alert($("#resourcepool").combobox('getValue'));
	            alert($("#instancesnetwork").combobox('getValue')); */
	          /*    resourcepool network networktypeid networktypename template cpunum memnum serverNum disk1 disk2
                 servername appid appname proid proname unitid unitname */
                //基本配置            
              
                 var configure = row.configure;
                 var re =/[^0-9]/g; 
                 var formats = configure.split(";");
                 var cpus = formats[0].split(":");
				 var cpu = cpus[1].replace(re, '');
				 var mems = formats[1].split(":");
				 var mem = mems[1].replace(re, '');
				 var oss = formats[2].split(":");
				 var os = oss[1];
				 var disks = formats[3].split(":");
				 var diskSplit = disks[1].split(",");
				 var disk1 = diskSplit[0];
				 var disk2 = diskSplit[1];
				 var  disktype = 1;
				 if("应用盘"===formats[4].split(":")[1]){
				    disktype = 0;
				 }
                var orderid = row.orderid;
                var detailid = row.detailid;
				 var serverNum = row.tnumber;
                  if(resourceStatus==3){               
                    var numvm = getAlreadyDoneVms(orderid,detailid);           
                    serverNum = serverNum-numvm;
                    if(serverNum==0){
                      return;
                    }
                 }
                 var typeid = row.typeid;
                //网络
                var resourcepool = $("#resourcepool").combobox('getValue');
                var network = $("#instancesnetwork").combobox('getValue');
                if(''==resourcepool){
                  $("#resourcemust").html("必选");
                   return;
                }else{
                 $("#resourcemust").html(" ");
                }
                
                if(''==network){
                  $("#networkmust").html("必选");
                  return;
                }else{
                 $("#networkmust").html(" ");
                }
                var temp1 = resourcepool.split(",");
               	var platformid = temp1[1];
               	var resourcepoolid = temp1[0];
               	var networkypeid = temp1[2];
               	var networkypename = temp1[3];
              
               
               //用户	 
			    var unitid = row.useunitid;var unitname = row.useunitname;var proid =row.proid ;var proname = row.proname;var userid =row.userid ;var username = row.uname;
                var appid = row.appid; var appname = row.appname;var shopname = row.shopname;var shopid = row.shopid;
                var flowid = "<%=request.getParameter("transferid")%>";
                var stepno = "<%=request.getParameter("stepno")%>";
                var servername="";
                for(var i=0;i<serverNum;i++){
                  servername += appname+"-"+(i+1)+";"
                }
                servername = servername.substring(0,servername.lastIndexOf(";"));
             
                $.post('${pageContext.request.contextPath}/vmmanage/createVM.do',{platformid:platformid,resourcepool:resourcepoolid,
                	shopid:shopid,shopname:shopname,stepno:stepno,flowid:flowid,network:network,typeid:typeid,template:os,
                	serverNum:serverNum,servername:servername,configure:configure,orderid:orderid,detailid:detailid,userid:userid,
                	cpunum:cpu,memnum:mem,disk1:disk1,disk2:disk2,disktype:disktype,networktypeid:networkypeid,
                	networktypename:networkypename,appname:appname,appid:appid,unitname:unitname,proid:proid,proname:proname,
                	unitid:unitid,operType:'<%=operType%>'},function(){});
                	 	modifyFlag = 0;
                $('#serviceWindow_network').dialog('close');
               }
           }, {
               text: '取消',
               iconCls: 'icon-cancel',
               handler: function() {
                   $('#serviceWindow_network').dialog('close');
               }
           }]
       });
       
       //防火墙
       $('#serviceWindow_firewalls').dialog({
    	   width: 380,
           height: 250,
           closed: true,
           modal: true,
           collapsible: false,
           minimizable: false,
           maximizable: false,
           resizable: false,
           
           buttons: [{
               text: '确定',
               iconCls: 'icon-ok',
               handler: function() {
                
               /*  var ovlan = $("#ovlan").combobox('getVlaue');//外联网络
                var ovlan1 = $("#ovlan").combobox('getText');//外联网络
            	var bvlan = $("#bvlan").combobox('getVlaue');//业务网络
                var gvlan = $("#gvlan").combobox('getVlaue');//管理网络 */
              
            	  var gvlan = $("#gvlan").combobox('getValue');
            	  var gvlan1 = $("#gvlan").combobox('getText');
            	  var bvlan = $("#bvlan").combobox('getValue');
            	  var bvlan1 = $("#bvlan").combobox('getText');
            	  var ovlan = $("#ovlan").combobox('getValue');
            	  var ovlan1 = $("#ovlan").combobox('getText');
            	  if(''==gvlan){
                  $("#gvlanmust").html("必选");
                   return;
                   }else{
                  $("#gvlanmust").html(" ");
                  }
                
            	   if(''==bvlan){
                  $("#bvlanmust").html("必选");
                   return;
                   }else{
                  $("#bvlanmust").html(" ");
                  }
                  
                  if(''==ovlan){
                  $("#ovlanmust").html("必选");
                   return;
                   }else{
                  $("#ovlanmust").html(" ");
                  }
                  
                  
            	  ovlan = ovlan+";"+ovlan1;
            	  bvlan = bvlan+";"+bvlan1;
            	  gvlan = gvlan+";"+gvlan1;
                  var unitid = row.useunitid;
		       	var unitname = row.useunitname;
		       	var proid =row.proid;
		       	var proname = row.proname;
		       	var userid =row.userid ;
		       	var username = row.uname;
		       	var shopname = row.shopname;
		       	var shopid = row.shopid;
		       	var typeid = row.typeid;
		       	var flowid = "<%=request.getParameter("transferid")%>";
		       	var stepno = "<%=request.getParameter("stepno")%>";
		       	var orderid = row.orderid;
		       	var detailid = row.detailid;
		       	var networkid = row.networkid;
		       	var network = row.network;
                var config = row.configure;
                var tnumber= row.tnumber;
             	$.post('${pageContext.request.contextPath}/fwmanage/createFW.do',{
            	 		bvlan:bvlan,gvlan:gvlan,ovlan:ovlan,unitid:unitid,userid:userid,typeid:typeid,
            	 		config:config,flowid:flowid,orderid:orderid,detailid:detailid,fwtype:"snfw",
            	 		stepno:stepno,shopid:shopid,shopname:shopname,proid:proid,proname:proname,tnumber:tnumber,
            	 		networkid:networkid,network:network,unitname:unitname,operType:'<%=operType%>'
            	 	},function(){});
            	 	 	modifyFlag = 0;
                $('#serviceWindow_firewalls').dialog('close');
               }
           }, {
               text: '取消',
               iconCls: 'icon-cancel',
               handler: function() {
                   $('#serviceWindow_firewalls').dialog('close');
                  // $('#dg_resource').datagrid('reload');
               }
           }]
       });
       
      //操作
     function operformater(value, row, index){ 
		switch (value) {
			case "1":
				return "";
			case "3":
				return "<a  style=\"color:red;cursor:pointer;\" onclick=\"resourceOper('" + index+"','"+value + "');\">实施</a>";
			case "2":
				return "";
			case "0":
				if('<%=operType%>' == "gdcfAssign"){//工单拆分，指派实施人员
					return "<a  style=\"color:green;cursor:pointer;\" onclick=\"assignResourceToDo('" + index+"','"+value + "');\">指派</a>";
				}else{
					return "<a  style=\"color:green;cursor:pointer;\" onclick=\"resourceOper('" + index+"','"+value + "','');\">实施</a>";
				}
			case "4":
				if('<%=operType%>' == "gdcf"){//工单拆分，实施人员
					return "<a  style=\"color:green;cursor:pointer;\" onclick=\"resourceOper('" + index+"','"+value + "','<%=operType%>');\">实施</a>";
				}else{//实施经理页面
					return "";
				}
			case "5":
				return "<a  style=\"color:green;cursor:pointer;\" onclick=\"assignResourceToDo('" + index+"','"+value + "');\">重新指派</a>";
			case "6":
				return "";
			case "7":
				return "<span style='color:#ccc'>实施</span>";
		}
 
     }
     
     //状态
     function statusformater(value, row, index){ 
 		switch (value) {
 			case "1":
 				return "开通成功";
 			case "3":
 				return "开通失败";
 			case "2":
 				return "实施中";
 			case "0":
 				return "未完成";
 			case "4":
 				return "待实施";
 			case "5":
 				return "驳回";
 			case "6":
 				return "废弃";
 		}
      }
     
      function getAlreadyDoneVms(orderid ,detailid){
        var count = 0;
           $.ajax({
       
              type:'post',
			  url:'${pageContext.request.contextPath}/vmmanage/getAlreadyDoneVms.do?orderid='+orderid+'&detailid='+detailid,
			  async: false,//使用同步的方式,true为异步方式
			  dataType:'json',
			  success:function(retr){
			    
               count = retr.msg;
			  }
          
        });
        return count;
      }
      
      //实施
	  function resourceOper(index,status,operType){
		 detailsortnum = "";
	     row = $('#dg_resource').datagrid('getData').rows[index];
	     detailsortnum = row.detailsortnum;
	     if(detailsortnum == "" || detailsortnum == "null" || detailsortnum == null){
	    	 operTypeTwo = "";
	     }else{
	    	 operTypeTwo = "cfssTwo";
	     }
	     
	     $('#dg_resource').datagrid('updateRow',{
			index: index,
			row: {
				statusT: '7', 
			}
		});
 
	     if('200001'==row.shopid){
	         var configure = row.configure;
	         var formats = configure.split(";");
             var oss = formats[2].split(":");
		     var os = oss[1];
		    
		     if('其它'===os){
		      var dialog = parent.icp.modalDialog({
                title : '云服务器实施',
                width:650,
                height:500,
                draggable:true,
                url:'${pageContext.request.contextPath}/web/businessMg/workOrderMg/flow2/ivmOper2.jsp?flowid=<%=request.getParameter("transferid")%>&detailid='+row.detailid+'&servernum='+row.tnumber+'&operType='+operType,
                buttons: [{
            	text: '确定',
            	iconCls: 'icon-ok',
           	 	handler: function() {
            	  var stepsno = "<%=request.getParameter("stepno")%>";
		          var flowsid = "<%=request.getParameter("transferid")%>";
		           	modifyFlag = 0;
                  dialog.find('iframe').get(0).contentWindow.submitForm(dialog,row,stepsno,flowsid);

           		 }
        		}, {
            	text: '取消',
           		iconCls: 'icon-cancel',
            	handler: function() {
               	dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
           	 }
        	}]
               });
		     }
		     else{
	     	     resourcepoolurl= "${pageContext.request.contextPath}/vmconfig/queryResourcePool.do?networktypeid="+row.networkid;
	             
			     $("#resourcepool").combobox({    
					    url:resourcepoolurl,    
					    valueField:'poolid',    
					    textField:'poolname',
					    loadFilter:function(data){
						        data.unshift({poolid:'',poolname:"---请选择---"});
						        return data;
						  },
					    onLoadSuccess: function () { //加载完成后,设置选中第一项
					       var data = $('#resourcepool').combobox('getData');
					           if (data.length > 0) {
					                 $('#resourcepool').combobox('select', data[0].poolid);
					             } 
					    },   
					    onSelect:function(rec){
					       var temp  = rec.poolid;
					  
					       var temp1 = temp.split(",");
					     /*   $("#resourceId").val(temp1[0]);
					       $("#platformid").val(temp1[1]);
					       $("#mnetworkypeid").val(temp1[2]);
					       $("#mnetworkypename").val(temp1[3]); */
					       $("#instancesnetwork").combobox('reload','${pageContext.request.contextPath}/vmconfig/queryVlan.do?platformid='+temp1[0]);
					    }
					  });
	    
					   $("#instancesnetwork").combobox({    
					    url:instancesnetworkurl,    
					    valueField:'networkid',    
					    textField:'networkname',
					    loadFilter:function(data){
						        data.unshift({networkid:'',networkname:"---请选择---"});
						        return data;
						 },
					    onLoadSuccess: function () { //加载完成后,设置选中第一项
					       var data = $('#instancesnetwork').combobox('getData');
					           if (data.length > 0) {
					                 $('#instancesnetwork').combobox('select', data[0].networkid);
					             } 
					            }
					    
					  });
			        	resourceStatus =  status;
			        	if(resourceStatus == 3){
			        	    var numvm = getAlreadyDoneVms(row.orderid,row.detailid);           
			                numvm = row.tnumber-numvm;
			                $("#serviceWindow_network #tishi").html(" ");
			                $("#serviceWindow_network").append('<p id="tishi" style="margin-left:30px"><font color="red" size="5px">'+numvm+"</font> 台云服务器需要创建！</p>");
				         }
				            $("#resourcemust").html(" ");$("#networkmust").html(" ");
					        $('#serviceWindow_network').dialog({
					            closed: false,
					            title: "网络配置",
					            top:"60px" 
				        	});
             }
	     }
	     else if('200060'==row.shopid){//专享云服务
            var dialog = parent.icp.modalDialog({
               title : '专享云服务实施',
               draggable:true,
               url:'${pageContext.request.contextPath}/workorder/getVipDlg.do?flowid=<%=request.getParameter("transferid")%>&detailid='+row.detailid+'&operType=<%=operType%>',
               buttons: [{
            	text: '确定',
            	iconCls: 'icon-ok',
           	 	handler: function() {
            	  var stepsno = "<%=request.getParameter("stepno")%>";
		          var flowsid = "<%=request.getParameter("transferid")%>";
		           	modifyFlag = 0;
                dialog.find('iframe').get(0).contentWindow.submitForm(dialog,row,stepsno,flowsid);

           		 }
        		}, {
            	text: '取消',
           		iconCls: 'icon-cancel',
            	handler: function() {
               	dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
           	 }
        	}]
               });
	   //end
	   }
	     else if('200009'==row.shopid){
	
        
         var dialog = parent.icp.modalDialog({
               title : '互联网线路实施',
               width:730,
               height:540,
               draggable:true,
               url:'${pageContext.request.contextPath}/web/businessMg/workOrderMg/flow2/ipOper.jsp?flowid='+row.orderid+'&detailid='+row.detailid+'&unitid='+row.useunitid+'&operType=<%=operType%>',
        		onClose: function () {
 
	            $('#dg_resource').datagrid('reload');  
	            $(this).dialog('destroy');
            
               },
               buttons: [{
            	text: '确定',
            	iconCls: 'icon-ok',
           	 	handler: function() {
            	  var stepsno = "<%=request.getParameter("stepno")%>";
		          var flowsid = "<%=request.getParameter("transferid")%>";
		           	modifyFlag = 0;
                dialog.find('iframe').get(0).contentWindow.submitForm(dialog,row,stepsno,flowsid);

           		 }
        		}, {
            	text: '取消',
           		iconCls: 'icon-cancel',
            	handler: function() {
            	 $('#dg_resource').datagrid('reload');
               	dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
           	 }
        	}]
               });
	   }
	   
	   else if('200008'==row.shopid||'200012'==row.shopid){
	    if('200008'==row.shopid){
	         var dialog = parent.icp.modalDialog({
               title : '机房机柜服务实施',
               width:730,
               draggable:true,
               url:'${pageContext.request.contextPath}/web/businessMg/workOrderMg/flow2/cabinetJGOper.jsp?flowid='+row.orderid+'&detailid='+row.detailid+'&appname='+row.appname+'&operType=<%=operType%>'+'&unitid='+row.useunitid,
                onClose: function () {
 
	            $('#dg_resource').datagrid('reload');  
	            $(this).dialog('destroy');
            
        },buttons: [{
            	text: '确定',
            	iconCls: 'icon-ok',
           	 	handler: function() {
            	  var stepsno = "<%=request.getParameter("stepno")%>";
		          var flowsid = "<%=request.getParameter("transferid")%>";
		           	modifyFlag = 0;
                dialog.find('iframe').get(0).contentWindow.submitForm(dialog,row,stepsno,flowsid);

           		 }
        		}, {
            	text: '取消',
           		iconCls: 'icon-cancel',
            	handler: function() {
            	$('#dg_resource').datagrid('reload');  
               	dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
           	 }
        	}]
               });
	    }
	    
	    if('200012'==row.shopid){
	     
	        var dialog = parent.icp.modalDialog({
	        id:'dddd',
               title : '机柜机位服务实施',
               width:730,
               draggable:true,
               url:'${pageContext.request.contextPath}/web/businessMg/workOrderMg/flow2/cabinetJWOper.jsp?flowid='+row.orderid+'&detailid='+row.detailid+'&appname='+row.appname+'&unitid='+row.useunitid+'&operType=<%=operType%>',
               onClose: function () {
 
	            $('#dg_resource').datagrid('reload');  
	            $(this).dialog('destroy');
            
              },
               buttons: [{
            	text: '确定',
            	iconCls: 'icon-ok',
           	 	handler: function() {
            	  var stepsno = "<%=request.getParameter("stepno")%>";
		          var flowsid = "<%=request.getParameter("transferid")%>";
		           	modifyFlag = 0;
                dialog.find('iframe').get(0).contentWindow.submitForm(dialog,row,stepsno,flowsid);

           		 }
        		}, {
            	text: '取消',
           		iconCls: 'icon-cancel',
            	handler: function() {
            	
            	$('#dg_resource').datagrid('reload'); 
               	dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
           	 }
        	}]
               });
	    }
	   }else if("200003" == row.shopid){//负载均衡
	       var conf = row.configure;//区域:互联网;最大连接数:5000;数量:2
	       //var confArray = new Array();
	       //confArray = conf.split(";");
	       //var name = confArray[0].split(":")[1];
	       $("#fzjhGlwlSpan").text('');
	       $("#fzjhYwwlSpan").text('');
    	   
    	   //servicetype:0：管理vlan；1：业务vlan 2：外连vlan
    	   //管理网络
    	   $("#fzjhGlwl").combobox({    
			    url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=0',//?servicetype=0
			    valueField:'vlanid',    
			    textField:'vlanname',
			    loadFilter:function(data){
				        data.unshift({vlanid:'',vlanname:"---请选择---"});
				        return data;
				  },
				onLoadSuccess:function(data){
				    var vlaues = "";var texts = "";
				    for(var i=0;i<data.length;i++){
				      values = values.join(data.vlanid);
				      texts =  texts.join(data.vlanname);
				    }
				    $('#fzjhGlwl').combobox('setValues', vlaues);
 					$('#fzjhGlwl').combobox('setTexts', texts);
				  }
		   });
    	   //业务网络
    	   $("#fzjhYwwl").combobox({    
			    url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=1',//?servicetype=1
			    valueField:'vlanid',    
			    textField:'vlanname',
			    loadFilter:function(data){
				        data.unshift({vlanid:'',vlanname:"---请选择---"});
				        return data;
				  },
				onLoadSuccess:function(data){
				    var vlaues = "";var texts = "";
				    for(var i=0;i<data.length;i++){
				      values = values.join(data.vlanid);
				      texts =  texts.join(data.vlanname);
				    }
				    $('#fzjhYwwl').combobox('setValues', vlaues);

				      $('#fzjhYwwl').combobox('setTexts', texts);
				  }
		   });
    	   
	       $('#fzjhss_window').dialog({
	            closed: false,
	            title: "负载均衡创建",
	            top:"60px" 
       		});	            
	   }
	   else if('200061'==row.shopid){//防火墙
	     
	    var fwtype = "snfw";
	     
	    $.ajax({
	      
	      url:'${pageContext.request.contextPath}/workorder/getFwDetail.do?orderid='+row.orderid+'&detailid='+row.detailid,
	   
	      async:false,
	      dataType:'json',
	      success:function(data){
	         fwtype = data.fwtype;
	      }
	      
	     })
	     
	     if("snfw"==fwtype){
	     
	      $("#gvlan").combobox({    
					    url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=0',    
					    valueField:'vlanid',    
					    textField:'vlanname',
					    loadFilter:function(data){
						        data.unshift({vlanid:'',vlanname:"---请选择---"});
						        return data;
						  },
						  onLoadSuccess:function(data){
						    var vlaues = "";var texts = "";
						    for(var i=0;i<data.length;i++){
						      values = values.join(data.vlanid);
						      texts =  texts.join(data.vlanname);
						    }
						    $('#gvlan').combobox('setValues', vlaues);

						      $('#gvlan').combobox('setTexts', texts);
						  }
					  });
					  
		  $("#bvlan").combobox({    
					    url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=1',    
					    valueField:'vlanid',    
					    textField:'vlanname',
					    loadFilter:function(data){
						        data.unshift({vlanid:'',vlanname:"---请选择---"});
						        return data;
						  },
						onLoadSuccess:function(data){
						    var vlaues = "";var texts = "";
						    for(var i=0;i<data.length;i++){
						      values = values.join(data.vlanid);
						      texts =  texts.join(data.vlanname);
						    }
						    $('#bvlan').combobox('setValues', vlaues);

						      $('#bvlan').combobox('setTexts', texts);
						  }
				 });
					  
		  $("#ovlan").combobox({    
					    url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=2',    
					    valueField:"vlanid",    
					    textField:'vlanname',
					    selectOnNavigation:false,
					    loadFilter:function(data){
						        data.unshift({vlanid:'',vlanname:"---请选择---"});
						        
						        return data;
						  },
						  onLoadSuccess:function(data){
						   var data = $('#ovlan').combobox('getData');
					          
					          
						  } 
					  });
					   
	       $('#serviceWindow_firewalls').dialog({
	            closed: false,
	            title: "网络配置",
	            top:"60px" 
			});
	     
	     }
	     else {//东西防火墙操作
	        ewfwOper(fwtype,row);
	     }
	   
	   }else if("200005" == row.shopid){//云硬盘
		   
		   var confInfo = row.configure;//容量：0
		   var store = confInfo.split(":")[1];//容量
		   $.messager.confirm('提示','您确定要创建该云硬盘吗?',function(b){
 		  	  if(b){
	    		  $.ajax({
					  type:'post',
					  url:'${pageContext.request.contextPath}/indisk/implementStore.do',
					  data:{
						  disknum: store,
						  configure: row.configure,
						  unitid: row.useunitid,
						  unitname: row.useunitname,
						  projectid: row.proid,
						  projectname: row.proname,
						  userid: row.userid,
						  shopid: row.shopid,
						  shopname: row.shopname,
						  typeid: row.typeid,
						  orderid: row.orderid,
						  tnumber: row.tnumber,
						  detailid: row['detailid'],
						  stepno: "<%=request.getParameter("stepno")%>",
						  flowid: '<%=request.getParameter("transferid")%>',
						  operType:'<%=operType%>'
					  },
					  success:function(retr){
					  	  var data = JSON.parse(retr);
				  		  $.messager.alert('消息',data.msg);
					  	  $('#dg_resource').datagrid('reload');
					  }
				  });
 		  	  }else{
 		  		  $('#dg_resource').datagrid('reload');
 		  	  }
 	  	  });
	   }
	   else{
		     
	     	 excute(row);
	     }    
	  }
 	  //ip实施界面初始化

	  //统一实施页面
	  function excute(row){
		 
		  var shopname = row.shopname;
		  
		  var dialog = parent.icp.modalDialog({
               title : shopname,
               width:820,
               draggable:true,
               url:'${pageContext.request.contextPath}/web/businessMg/workOrderMg/flow2/otherOperate.jsp?flowid=<%=request.getParameter("transferid")%>&detailid='+row.detailid+'&configure='+encodeURI(encodeURI(row.configure))+'&tnumber='+row.tnumber+
            		   			'&network='+encodeURI(encodeURI(row.network))+'&measureunit='+encodeURI(encodeURI(row.measureunit))+
            		   			'&appname='+encodeURI(encodeURI(row.appname))+'&operType=<%=operType%>',
               onClose: function () {
 
	            $('#dg_resource').datagrid('reload');  
	            $(this).dialog('destroy');
            
        	 }, 
               buttons: [{
            	text: '确定',
            	iconCls: 'icon-ok',
           	 	handler: function() {
            	  var stepsno = "<%=request.getParameter("stepno")%>";
		          var flowsid = "<%=request.getParameter("transferid")%>";
		           	modifyFlag = 0;
                  dialog.find('iframe').get(0).contentWindow.submitForm(dialog,row,stepsno,flowsid);
                  
           		 }
        		}, {
            	text: '取消',
           		iconCls: 'icon-cancel',
            	handler: function() {
            	 $('#dg_resource').datagrid('reload'); 
               	dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
           	 }
        	}]
               });
		  
		
	  }
	  //东西防火墙操作
	  
	  function ewfwOper(fwtype,row){
	     
	    var fwtype = fwtype;
	    var unitid = row.useunitid;
       	var unitname = row.useunitname;
       	var proid =row.proid;
       	var proname = row.proname;
       	var userid =row.userid ;
       	var username = row.uname;
       	var shopname = row.shopname;
       	var shopid = row.shopid;
       	var typeid = row.typeid;
       	var flowid = "<%=request.getParameter("transferid")%>";
       	var stepno = "<%=request.getParameter("stepno")%>";
       	var orderid = row.orderid;
       	var detailid = row.detailid;
        var tnumber = row.tnumber;
       	var networkid = row.networkid;
       	var network = row.network;
        var config = row.configure;
       
      	$.post('${pageContext.request.contextPath}/fwmanage/createFW.do',{
     	 		unitid:unitid,userid:userid,typeid:typeid,fwtype:fwtype,
     	 		config:config,flowid:flowid,orderid:orderid,detailid:detailid,tnumber:tnumber,
     	 		stepno:stepno,shopid:shopid,shopname:shopname,proid:proid,proname:proname,
     	 		networkid:networkid,network:network,unitname:unitname,operType:'<%=operType%>'
     	 	},function(){});
     	  
	  }
	  
	  function load(msg) {  
	     $("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");  
	     $("<div class=\"datagrid-mask-msg\"></div>").html(msg).appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });  
 	 } 
	 //取消加载层  
	 function disLoad() {  
	     $(".datagrid-mask").remove();  
	     $(".datagrid-mask-msg").remove();  
	 }

 
         function beforCheck(){
            var flag = true;
                $('.table-yy .j-input').each(function(){
                  if($(this).val()==''||$(this).val().trim()==''){
                     
                       flag = false;
                      
                       return flag;
                  }
                  
                })
                 return flag;
                
            }
            

    $(document).on("click", ".j-tosub", function() {
        $.messager.confirm('提示', '确定要删除吗?', function(r) {
            if (r) {
                $(this).parents('.j-com').remove();
                $(".window-shadow").css({
                    height: 'auto'
                });
            }
        });
        $(this).parents('.j-com').remove();
    })
     
		
			
    //datagrid悬浮框处理
		$.extend($.fn.datagrid.methods, {
	        /**
	         * 开打提示功能
	         * @param {} jq
	         * @param {} params 提示消息框的样式
	         * @return {}
	         */
	        doCellTip: function(jq, params){
	            function showTip(data, td, e){
	                if ($(td).text() == "") 
	                    return;
	                data.tooltip.text($(td).text()).css({
	                    top: (e.pageY + 10) + 'px',
	                    left: (e.pageX + 20) + 'px',
	                    'z-index': $.fn.window.defaults.zIndex,
	                    display: 'block'
	                });
	            };
	            return jq.each(function(){
	                var grid = $(this);
	                var options = $(this).data('datagrid');
	                if (!options.tooltip) {
	                    var panel = grid.datagrid('getPanel').panel('panel');
	                    //var fields=$(this).datagrid('getColumnFields',false);////获取列
	                    var defaultCls = {
	                        'border': '1px solid #333',
	                        'padding': '2px',
	                        'color': '#333',
	                        'background': '#f7f5d1',
	                        'position': 'absolute',
	                        'max-width': '200px',
							'border-radius' : '4px',
							'-moz-border-radius' : '4px',
							'-webkit-border-radius' : '4px',
	                        'display': 'none'
	                    }
	                    var tooltip = $("<div id='celltip'></div>").appendTo('body');
	                    tooltip.css($.extend({}, defaultCls, params.cls));
	                    options.tooltip = tooltip;
	                    panel.find('.datagrid-body').each(function(){
	                        var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
	                        $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {
	                            'mouseover': function(e){
	                                if (params.delay) {
	                                    if (options.tipDelayTime) 
	                                        clearTimeout(options.tipDelayTime);
	                                    var that = this;
	                                    options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                                }
	                                else {
	                                    showTip(options, this, e);
	                                }
	                                
	                            },
	                            'mouseout': function(e){
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                options.tooltip.css({
	                                    'display': 'none'
	                                });
	                            },
	                            'mousemove': function(e){
									var that = this;
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                //showTip(options, this, e);
									options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                            }
	                        });
	                    });
	                    
	                }
	                
	            });
	        },
	        /**
	         * 关闭消息提示功能
	         *
	         * @param {}
	         *            jq
	         * @return {}
	         */
	        cancelCellTip: function(jq){
	            return jq.each(function(){
	                var data = $(this).data('datagrid');
	                if (data.tooltip) {
	                    data.tooltip.remove();
	                    data.tooltip = null;
	                    var panel = $(this).datagrid('getPanel').panel('panel');
	                    panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')
	                }
	                if (data.tipDelayTime) {
	                    clearTimeout(data.tipDelayTime);
	                    data.tipDelayTime = null;
	                }
	            });
	        }
	    });
 
    //负载均衡 
    $('#fzjhss_window').dialog({
 	   width: 420,
        height: 220,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
            	var fzjhGlwl = $("#fzjhGlwl").combobox('getValue');//管理网络
            	if(fzjhGlwl==""){
            		$("#fzjhGlwlSpan").text('必选');
            		return;
            	}else{
            		$("#fzjhGlwlSpan").text('');
            	}
            	var fzjhYwwl = $("#fzjhYwwl").combobox('getValue');//业务网络
            	if(fzjhYwwl==""){
            		$("#fzjhYwwlSpan").text('必选');
            		return;
            	}else{
            		$("#fzjhYwwlSpan").text('');
            	}
             	//基本信息	 
			 	var unitid = row.useunitid;
             	var unitname = row.useunitname;
             	var proid =row.proid;
             	var proname = row.proname;
             	var userid =row.userid ;
             	var username = row.uname;
             	var shopname = row.shopname;
             	var shopid = row.shopid;
             	var typeid = row.typeid;
             	var flowid = "<%=request.getParameter("transferid")%>";
             	var stepno = "<%=request.getParameter("stepno")%>";
             	var orderid = row.orderid;
             	var detailid = row.detailid;
             	var networkid = row.networkid;
             	var network = row.network;
             	var operType = "<%=operType%>";
             	//configure: 区域:互联网;最大连接数:10000;数量:2
             	var configure = row.configure;
             	var confArray = new Array();
      	        confArray = configure.split(";");
      	        var connnum = confArray[1].split(":")[1];
      	       
            	$.post('${pageContext.request.contextPath}/ordermg/fzjhImplement.do',{
            	 		fzjhGlwl:fzjhGlwl,fzjhYwwl:fzjhYwwl,unitid:unitid,userid:userid,typeid:typeid,
            	 		flowid:flowid,orderid:orderid,detailid:detailid,fzjhName: row.beforeName,
            	 		stepno:stepno,shopid:shopid,shopname:shopname,proid:proid,proname:proname,
            	 		networkid:networkid,network:network,unitname:unitname,operType:operType,
            	 		connnum:connnum,detailsortnum:detailsortnum,operTypeTwo:operTypeTwo
            	 	},function(){});
            	 	modifyFlag = 0;
                $('#fzjhss_window').dialog('close');
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#fzjhss_window').dialog('close');
            }
        }]
    });
    //云硬盘
    $('#yyp_window').dialog({
 	    width: 400,
        height: 230,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
            	var serverid = $("#attachNeid").combobox('getValue');//云服务器id
            	var platformid = $("#platformid").val();//平台
            	var displayname = $("#storeName").val();//名称
            	var storeNum = $("#storeNum").val();//容量
            	var storeinfo = $("#storeinfo").val();//描述
             	//基本信息	 
			 	var unitid = row.useunitid;
             	var unitname = row.useunitname;
             	var projectid =row.proid;
             	var projectname = row.proname;
             	var userid =row.userid;
             	var shopname = row.shopname;
             	var shopid = row.shopid;
             	var typeid = row.typeid;
             	var flowid = "<%=request.getParameter("transferid")%>";
             	var stepno = "<%=request.getParameter("stepno")%>";
             	var orderid = row.orderid;
             	var detailid = row.detailid;
             	var networkid = row.networkid;
             	var network = row.network;
             	var configure = row.configure;
             	var operType = "<%=operType%>";
            	$.post('${pageContext.request.contextPath}/indisk/implementStore.do',{
            			displayname:displayname,storeNum:storeNum,unitid:unitid,userid:userid,typeid:typeid,serverid:serverid,
            	 		flowid:flowid,orderid:orderid,detailid:detailid,platformid:platformid,storeinfo:storeinfo,configure:configure,
            	 		stepno:stepno,shopid:shopid,shopname:shopname,projectid:projectid,projectname:projectname,
            	 		networkid:networkid,network:network,unitname:unitname,operType:operType
            	 	},function(){});
            	 	modifyFlag = 0;
                $('#yyp_window').dialog('close');
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#yyp_window').dialog('close');
            }
        }]
    });

    //选择实施人员弹框
    $('#assignUserWindow').dialog({
        title: "选择实施人",
        width: 560,
        height: 350,
        top: 20,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
            	var rows = $('#dg_assignUser').datagrid('getChecked');
            	if(rows.length != 1) {
					$.messager.alert('消息', '请选择一个实施人员！','info');
					return;
				}
            	var userRow = $('#dg_assignUser').datagrid('getSelected');
            	var userId = userRow.email;
            	var userName =userRow.uname;
            	
            	//基本信息	 
             	var flowid = "<%=request.getParameter("transferid")%>";
             	var orderid = rowObject.orderid;
             	var detailid = rowObject.detailid;
             	
            	$.post('${pageContext.request.contextPath}/workSplit/workAssign.do',{
            		userId:userId,userName:userName,flowid:flowid,orderid:orderid,detailid:detailid,
            		operFlowSign:'<%=operFlowSign%>'
        	 	},function(data){
        	 		if(data == true || data == "true"){
        	 			$.messager.alert('提示', "指派成功！");
        	 		}else{
        	 			$.messager.alert('提示', "指派失败，请重新指派！");
        	 		}
        	 		$('#dg_resource').datagrid('reload');
        	 	});
            	
                $('#assignUserWindow').dialog('close');

            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#assignUserWindow').dialog('close');
            }
        }]
    });
    
    //工单实施指派
    function assignResourceToDo(index,status){
    	rowObject = $('#dg_resource').datagrid('getData').rows[index];
    	loadUserData("");
    	$("#assignUserWindow").dialog({
    		closed:false
    	});
    }
    
    //实施人员列表查询
    function queryUserDg(){
    	var searchName = $("#searchName").val();
    	loadUserData(searchName);
    }
    
    //实施人员列表查询重置按钮
    function queryChongzhi(){
    	$("#searchName").val("");
    	loadUserData("");
    }
    
    //实施人员列表数据
    function loadUserData(searchName){
    	$('#dg_assignUser').datagrid({
			rownumbers:false,
			border:true,
			striped:true,
			//sortName:'email',
			//sortOrder:'asc',
			nowarp:false,
			singleSelect:false,
			method:'post',
			loadMsg:'数据装载中......',
			fitColumns:true,
			idField:'email',
			pagination:true,
			pageSize:5,
			pageList:[5,10,20],
	    	singleSelect:true,
	    	url:'${pageContext.request.contextPath}/authMgr/getUsersByRole.do?roleids=1000000075',//工单拆分实施角色(实施人员)
		    queryParams:{uname:searchName},
		    onLoadSuccess:function(data){  
		    	var pageopt = $('#dg_assignUser').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;//每页分页条数
				var  _rows = $('#dg_assignUser').datagrid("getRows").length;//当前页实际条数
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 5) {
					for(i=5;i>_rows;i--){
						//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						$(this).datagrid('appendRow', {email:''  })
					}
					$('#dg_assignUser').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    	total: total,
				     });
				}else{
					//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
				//设置不显示复选框
		        var rows = data.rows;
		        if (rows.length) {
					 $.each(rows, function (idx, val) {
						if(val.email==''){ 
							//dgDiv为datagrid上一层的div id
							$('#dgDiv  input:checkbox').eq(idx+1).css("display","none");
							 
						}
					}); 
		        }
				$('.j-variation').linkbutton({
                    iconCls: 'icon-variation',
                    plain: true
                });
                $('.j-cancellation').linkbutton({
                    iconCls: 'icon-cancellation',
                    plain: true
                });
            }
    	});
    }

    //废弃操作
    function feiqi(index,status){
    	rowObject = $('#dg_resource').datagrid('getData').rows[index];
    	//基本信息	 
     	var flowid = "<%=request.getParameter("transferid")%>";
     	var stepno = "<%=request.getParameter("stepno")%>";
     	var orderid = rowObject.orderid;
     	var detailid = rowObject.detailid;
        $.messager.confirm('提示','确定要废弃吗？',function(r){
			if(r){
				$.post('${pageContext.request.contextPath}/workSplit/workFeiqi.do',{
            		flowid:flowid,stepno:stepno,orderid:orderid,detailid:detailid,operFlowSign:'<%=operFlowSign%>'
        	 	},function(data){
        	 		if(data == true || data == "true"){
        	 			$.messager.alert('提示', "操作成功！");
        	 		}else{
        	 			$.messager.alert('提示', "操作失败，请重新操作！");
        	 		}
        	 		$('#dg_resource').datagrid('reload');
        	 	});
			}        	 
        });
    }
    
    
     $('#serviceWindow_network,#serviceWindow_firewalls,#fzjhss_window,#yyp_window').dialog({
       onBeforeClose:function(){ 
         if(modifyFlag==1) {
           
          $('#dg_resource').datagrid('reload');  
         }
          modifyFlag = 1;
         
       } 
   });
   
  
  </script>
</html>
