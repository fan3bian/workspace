<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String flowid = (String)request.getAttribute("flowid");
//String flowid = request .getParameter("flowid" );
	if (flowid == null) {
		flowid = "";
}
String detailid = (String)request.getAttribute("detailid");
//String detailid = request .getParameter("detailid" );

if (detailid == null) {
	detailid = "";
}
String appname = URLDecoder.decode(request.getParameter("appname") == null ? "" : request.getParameter("appname"),"UTF-8");

String network = URLDecoder.decode(request.getParameter("network") == null ? "" : request.getParameter("network"),"UTF-8");

String configure = URLDecoder.decode(request.getParameter("configure") == null ? "" : request.getParameter("configure"),"UTF-8");

String tnumber = request.getParameter("tnumber");

if (tnumber == null) {
	tnumber = "";
}
String measureunit = URLDecoder.decode(request.getParameter("measureunit") == null ? "" : request.getParameter("measureunit"),"UTF-8");

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
  <!-- 弹层结束 -->
    <!-- 其他弹出层1 -->
    <div id="serviceWindow_other">

    	<!-- 占位 -->
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 1px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    	<div class="lcy-window-item">
            <div class="lcy-window-item-body">
                  <textarea id="config" readonly="readonly" style="width: 500px;height: 150px; "></textarea>
            </div>
            <div class="lcy-window-item-header">规格配置</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                  <textarea id="operconfig" style="width: 500px;height: 150px; "></textarea>
            </div>
            <div class="lcy-window-item-header">实施信息</div>
        </div>
       
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul class="network_other">
                    <li class="active" value="10001">政务外网</li>
                    <li value="10002">互联网</li>
                </ul>
                </ul>
            </div>
            <div class="lcy-window-item-header">网络</div>
        
        </div>
        
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                 <input id="resourceapp_other" type="text" readonly="readonly" style="width: 320px;height: 30px; ">
            </div>
            <div class="lcy-window-item-header">应用名称</div>
        </div>
        
    	<div class="lcy-window-item" >
            <div class="lcy-window-item-body j-item-body" >
                 <input id="inptNum" type="text" readonly="readonly" value="1" style="width: 120px;height: 30px; ">
                 &nbsp;<span id="productunit"></span>
            </div>
            <div class="lcy-window-item-header">数量</div>
        </div>
       <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 1px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    
    </div>
    <!-- 其他弹出层 结束 -->
    <script>
      $(function(){
    	 
    	 var networkname='<%=network%>';
    	 var measureunit='<%=measureunit%>';
    	 $("#config").val('<%=configure%>');
    	 $("#productunit").text(measureunit);
    	 if(networkname=="政务外网")
		  {
			     $("#serviceWindow_other .network_other ").eq(0).find("li").eq(0).addClass('active').siblings().removeClass('active');
		  }
		  else
			  {
			      $("#serviceWindow_other .network_other ").eq(0).find("li").eq(1).addClass('active').siblings().removeClass('active');
			  }
    	
    	 $("#resourceapp_other").val('<%=appname%>');
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
		 	  
			  var vips=[];
             
              var vipsfee = {};

			//实施信息
			   vipsfee.operconfig = $("#operconfig").val();
			   vipsfee.measureunit = $("#productunit").text();
			   vipsfee.tnumber = $row.tnumber;
			   vipsfee.configure = $row.configure;
			   vipsfee.appid = $row.appid;
	           vipsfee.appname = $row.appname;
               vipsfee.ostatus = $row.ostatus;
               vipsfee.tprice = $row.tprice; 
               vipsfee.networkid = $row.networkid;
               vipsfee.network = $row.network;
               
               vipsfee.shopid = $row.shopid;
               vipsfee.shopname = $row.shopname; 
               vipsfee.useunitname = $row.useunitname;
               vipsfee.useunitid = $row.useunitid;
               vipsfee.proid = $row.proid;
               vipsfee.proname = $row.proname;  
               vipsfee.orderid = $row.orderid;
		       vipsfee.detailid = $row.detailid;
		       vipsfee.userid = $row.userid;
		       vipsfee.uname = $row.uname;
		       vipsfee.typeid = $row.typeid;
		       
	           vipsfee.stepno = $stepsno;
		       vipsfee.flowid = $flowsid;
		     
	                      
               vips.push(vipsfee);
               var vipsfees =   JSON.stringify(vips);
               
          //确定提交事件
          $.ajax({
			url:'${pageContext.request.contextPath}/workorder/excuteOper.do',
			type:'post',
			cache:false,
			async:false,
			data:{
				stepsno:$stepsno,
				othersJson:vipsfees,
				operType: '<%=operType%>'
			},
			success:function(b){
            	
            	 $dialog.dialog('destroy');
				}
			});
              // $.post('${pageContext.request.contextPath}/workorder/vipsOperAdd.do',{vipEquipJson:equipmentstr,vipsJson:vipsfees},function(){});
              // $('#boxManagedWindow').dialog('close');
            
	
		 }
    
    </script>
</body>

</html>
  