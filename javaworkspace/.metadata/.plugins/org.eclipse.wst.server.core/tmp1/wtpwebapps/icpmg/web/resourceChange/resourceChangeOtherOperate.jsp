<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String flowid = request.getParameter("transferid")==null?"":request.getParameter("transferid").toString();
String configSs = URLDecoder.decode(request.getParameter("configSs") == null ? "" : request.getParameter("configSs"),"UTF-8");
String networktype = URLDecoder.decode(request.getParameter("networktype") == null ? "" : request.getParameter("networktype"),"UTF-8");
String tnumber = request.getParameter("tnumber")==null?"1":request.getParameter("tnumber").toString();
String danwei = URLDecoder.decode(request.getParameter("danwei") == null ? "" : request.getParameter("danwei"),"UTF-8");
String appname = URLDecoder.decode(request.getParameter("appname") == null ? "" : request.getParameter("appname"),"UTF-8");
String detailid = request.getParameter("detailid")==null?"":request.getParameter("detailid").toString();
String operType = request.getParameter("operType")==null?"":request.getParameter("operType").toString();//工单拆分实施操作 gdcf
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
	
  </head>
  	<link href="<%=basePath%>/css/default.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=basePath%>/css/regcore.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
	
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
  	<script type="text/javascript" src="<%=basePath%>/js/sockjs-0.3.min.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" /> 
  
  <body>
     <style>
     html {overflow-y: auto;/* overflow-x: auto; */}
   
    </style>
    
    <!-- 其他弹出层1 -->
    <div id="serviceWindowZybgSs_other2" style="dispaly:none;">
    	<!-- 占位 
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 10px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>-->
    	<div class="lcy-window-item">
            <div class="lcy-window-item-body">
                <textarea id="configSs" style="width: 500px;height:130px; " disabled></textarea>
            </div>
            <div class="lcy-window-item-header">规格配置</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                <textarea id="remarkSs" style="width: 500px;height: 130px; "></textarea>
            </div>
            <div class="lcy-window-item-header">实施信息</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="networkSs_other" >
                    <li value="10001">政务外网</li>
                    <li value="10002">互联网</li>
                </ul>
            </div>
            <div class="lcy-window-item-header">网络</div>
        
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                 <input id="resourceappSs_other" style="width: 320px;height: 30px; "disabled>
            </div>
            <div class="lcy-window-item-header">应用名称</div>
        </div>
         <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 10px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    	<div class="lcy-window-item" >
            <div class="lcy-window-item-body" >
                <div class="add-sub" >
                    <input class="input-num" id="inptNumSs" type="text" value="1" style="border-left:1px solid #ddd;border-right:1px solid #ddd;width:50px !important;" disabled />
               		&nbsp;<span id="danwei"></span>
                </div>
            </div>
            <div class="lcy-window-item-header">数量</div>
        </div>
       <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    </div>
    <!-- 其他弹出层 结束 -->
    
    
    <script>
      $(function(){
    	  $("#configSs").val('<%=configSs%>');
    	  $("#danwei").text('<%=danwei%>');
    	 if('<%=networktype%>' == "政务外网"){
			     $("#networkSs_other").eq(0).find("li").eq(0).addClass('active').siblings().removeClass('active');
		  }else{
	      	 $("#networkSs_other").eq(0).find("li").eq(1).addClass('active').siblings().removeClass('active');
		 }
    	 $("#resourceappSs_other").val('<%=appname%>');
    	 $("#inptNum").val('<%=tnumber%>');
      })
      
  	  //取消按钮事件
 	  var closeWindows = function($dialog) {
 			$dialog.dialog('destroy');
 	  }
      
     //提交按钮事件
     var submitForm = function($dialog, $row,$stepsno,$flowsid) {
		 	submitSave($dialog, $row,$stepsno,$flowsid);
	 }
     
	 var submitSave = function($dialog, $row,$stepsno,$flowsid){
			  var remark = $("#remarkSs").val();
	          //确定提交事件
	          $.ajax({
	        	    url:'${pageContext.request.contextPath}/resourcechange/resourceChangeOperateOther.do',
					type:'post',
					cache:false,
					async:false,
					data:{
						  flowid:'<%=request.getParameter("transferid")%>',
	  					  updateorderid:$row['updateorderid'],
	  					  detailid:$row['detailid'],
	  					  neid:$row['neid'],
	  					  shopid:$row['shopid'],
	  					  newconfigure:$row['newconfigure'],
	  					  tnumber: $row['tnumber'],
	  					  status: $row['status'],
	  					  newtprice: $row['newtprice'],
	  					  stepno: $row['stepno'],
	  					  operatetype: $row['operatetype'],
	  				  	  newtprice: $row['newtprice'],
	  				  	  remark:remark,
	  				  	  measureunit: $row['measureunit'],
	  				  	  operType:'<%=operType%>'
					},
					success:function(b){
	  				  	   $dialog.dialog('destroy');
					}
				});
		 }
    </script>
</body>

</html>
  