<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();%>
<%String contextPath = request.getContextPath();%>
<!DOCTYPE HTML>
<html>
<head>
<%--easyui 或extjs 在IE 9不兼容可以用以下代码解决 (2016-05-30屏蔽)
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" content="ie=edge"/> --%>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /><%--兼容版本要求：ie9及以上  2016.05.30添加--%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ICP后台管理</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/gproducts.css"> 
<jsp:include page="../inc.jsp"></jsp:include>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
<style type="text/css">
 
	.ys_00 {
	font-family: "汉仪菱心体简";
	font-size: 24px;
	color: #FFF;
}

.ys_01 {
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	text-align: center;
	font-size: 18px;
	color: #FFF;
}
.ys_01 table tr td {
	text-align: center;
}
.ys_02 {
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	font-size: 14px;
	color: #FFF;
}
.ys_03 {
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	font-size: 18px;
	color: #FFF;
}
.ys_05 {
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	font-size: 14px;
	color: #999;
}
.ys_06 {
	color: #0d5d9e;
}
.ys_07 {
	color: #666;
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	font-size: 16px;
}
.ys_08 {
	font-size: 16px;
	color: #333;
}
.zyzx {
	font-family: "华文细黑", "时尚中黑简体", "微软雅黑";
	font-size: 16px;
	color: #333;
}
</style>
<style type="text/css">
#css3menu li {
	float: left;
	list-style-type: none;
}

#css3menu li a {
	color: #fff;
	padding-right: 35px;
	font-size: 18px;
	text-decoration: none;
}

#css3menu li a.active {
	
	color: #1697f2;	
}
</style>

<script type="text/javascript">
//浏览器及其版本号判定。用法：如果js对象Sys中(ie、firefox、chrome、opera、safari)某个存在，则Sys.X即为版本号
var Sys = {};
var ua = navigator.userAgent.toLowerCase();
var s;
(s = ua.match(/rv:([\d.]+)\) like gecko/)) ? Sys.ie = s[1] :
(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
var os_deploy_ws =null;
var urlrootpath = "<%=contextPath%>";
var roleids = "";
function userCenter(){
		$('body').layout('hidden','west'); 
		if(roleids == "1000000050"||roleids == "1000000052"){
			 $("#overviewframe").attr("src","../homePage.jsp");
		}else{
			$("#overviewframe").attr("src","../indexPage.jsp");
		}
	 	$("#title").hide();
		$("#centerTab").hide();
	 	$("#overview").show();
	}

//function passwdChange(){
			 
		//$('#passwdChange_email').val("${sessionUser.email}");
		//$('#passwdChange_dialog').dialog('open');
		
	//}
function shouye(){
	$('body').layout('hidden','west'); 
	 $("#shouyeframe").attr("src","../indexPage0522.jsp");
	$("#title").hide();
	 $("#centerTab").hide();
	 $("#shouye").show();
}
function showHomePage(){
	$('body').layout('hidden','west'); 
	 $("#overviewframe").attr("src","../homePage.jsp");
	 $("#title").hide();
	 $("#centerTab").hide();
	 $("#overview").show();
}
function showIndexPage(){
	$('body').layout('hidden','west'); 
	 $("#overviewframe").attr("src","../indexPage.jsp");
	 $("#title").hide();
	 $("#centerTab").hide();
	 $("#overview").show();
}
function showLeaderPage(){
	
}
function showOtherPage(){
	//隐藏相关元素
	$("#overviewframe").attr("src", "");
	$("#overview").hide();
	$("#shouye").hide();
	$('body').layout('panel', 'west');
	$("#title").show();
	$("#centerTab").show();
	$("#css3menu a").eq(0).trigger("click");
	$("#wnav li a").eq(0).trigger("click");
}
function querymenu(urlstr){
	$.ajax({
	  		type : 'post',
	  		url:'${pageContext.request.contextPath}/homepage/querySelectedMenu.do',
	  		data:{
	  			menutype:urlstr
	  		},
	  		success:function(rets){
	  		var ret = JSON.parse(rets);
	  		showAlarm(ret.rootid,ret.secondid);
		 }
	 });
}

function showAlarm(rootid,secondid){
	//隐藏相关元素
	$("#overviewframe").attr("src", "");
	$("#overview").hide();
	$("#shouye").hide();
	$('body').layout('show', 'west');
	$("#title").show();
	$("#centerTab").show();
	//触发相应元素的指定事件   需要换成查找指定的一级菜单
	var rootNum = $("#css3menu a").size();
	for(var i=0;i<rootNum;i++){
		var rootidstr = $("#css3menu a").eq(i).attr("name");
		if(rootidstr==rootid){
			$("#css3menu a").eq(i).trigger("click");
		}
	}
	//触发相应元素的指定事件   需要换成查找指定的二级菜单
	 var secondNum = $("#wnav li a").size();
	for(var j=0;j<secondNum;j++){
		var secondidstr = $("#wnav li a").eq(j).attr("ref");
		if(secondidstr==secondid){
			$("#wnav li a").eq(j).trigger("click");
		}
	} 
	
}

 $(function(){
 var $loginfirst = $("#loginfirst").val();
	 
	 if($loginfirst == '0'){
		 document.getElementById("passwdChangeFirst_dialog").style.display="";
		 $('#passwdChangeFirst_email').val('${sessionUser.email}');
		 $('#passwdChangeFirst_dialog').dialog('open'); 
	 }
	var obj = "${sessionUser.roleid}";
	var maintenanceflag =0;//运维
	var operateflag =0;       //运营
	var leaderflag =0;         //领导
	var roleid=obj.split(",");   
	for(var i=0;i<roleid.length;i++){
		if(roleid[i]=="1000000050"||roleid[i]=="1000000052"){
			maintenanceflag=1;
			roleids="1000000050";
		};
		if(roleid[i]=="1000000049"||roleid[i]=="1000000053"){
			operateflag=1;
		};
		if(roleid[i]=="1000000054"){
			leaderflag=1;
		};
	}
	
	/* if(maintenanceflag==1){
		showHomePage();
	}
	if(operateflag==1){
		showIndexPage();
	}
	if(leaderflag==1){
		showLeaderPage();
	}
	 if((maintenanceflag+operateflag+leaderflag)==0){
		showOtherPage();
	}  */
	if(maintenanceflag==1){
	//	showHomePage();
		showIndexPage();
	}else{
		showIndexPage();
	}

	
	 $.ajax({
		 url:'${pageContext.request.contextPath}/workorder/queryToDoNum.do',
		 method:'post',
		 dataType:'json',
		 success:function(_data){
// 			 if(_data>0){
// 				 $.messager.show({ 
// 					 title:'我的消息',
// 					 msg:'你尚有'+_data+'条工单未处理，消息将在3秒后关闭。',
// 					 showType:'show',
// 					 timeout:3000,
// 					 style:{
// 						 right:'',
// 						 top:document.body.scrollTop+document.documentElement.scrollTop+200,
// 						 bottom:''
// 					 }

// 				 })
// 			 }

		 }
	 });
	 //定时器，每1分钟向后请，监测session失效
	 var intervalId = setInterval("heartbeat()",60 * 1000);
 });
 function heartbeat(){
	 $.ajax({
		url: '${pageContext.request.contextPath}/heartbeat.do',
		method: 'GET',
		success: function(data){
			
		}
	 });
 }
</script>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/outlook.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/easyuilayoutextend.js"></script>
</head>

<body class="easyui-layout">
	<noscript>
		<div
			style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
			<img src="${pageContext.request.contextPath}/images/noscript.gif"
				alt='抱歉，请开启脚本支持！' />
		</div>
	</noscript>

	<div data-options="region:'north',border:false"
		style="overflow: hidden;height:60px;border-bottom:1px solid #2b2726;background:#2b2726">
		<div style="position:absolute;left:24px;top:8px;">
			<a href="/icpmg/icp/portal/home.html"><img
				src="${pageContext.request.contextPath}/images/icon_logo_inspur.png" /></a>
		</div>
		<div style="position:absolute;left:80px;top:15px">
			<a href="#" onclick="userCenter()"><img src="${pageContext.request.contextPath}/images/public/system_name_01.png"/></a>
		</div>
		
     	<input type="hidden" value=${sessionUser.ischeck} id="loginfirst" >
     	
		<div style="position: absolute; left: 260px;top:18px; bottom: 15px;font-size:20px;font-family:'Times New Roman',Georgia,Serif">
			<ul id="css3menu"
				style="padding:0px; margin:0px;list-type:none; float:left; margin-left:30px;">
			</ul>
		</div>
		<div style="position:absolute;right:0px;top:18px;font-size:14px;">
			<!-- <img src="${pageContext.request.contextPath}/images/icon_tips.png" /> -->
			<%--<span style="color: #fff;">您好，${sessionUser.uname}</span>&nbsp;|&nbsp;
			<span style="color: #fff;">距密码过期还有<font color="red">${sessionUser.timelength}</font>天</span><br>
			--%>
			<a  href="/icpmg/icp/portal/home.html" title="门户首页" style="color: #fff;margin-right:12px;"><img alt="门户" src="${pageContext.request.contextPath}/images/menhu_icon.png" /></a>
			<a href="#" onclick="userCenter()" title="概况" style="color:#fff;margin-right:12px;"><img alt="运维" src="${pageContext.request.contextPath}/images/yunwei_icon.png" /></a>
			<a href="<%=basePath %>/userMgr/logout.do" title="退出" style="color: #fff;margin-right:16px;"><img alt="退出" src="${pageContext.request.contextPath}/images/tuichu_icon.png" /></a>
		</div>
		
		<%-- <div style="position:absolute;right:215px;top:23px;font-size:14px;">
			<img src="${pageContext.request.contextPath}/images/icon_tips.png" />&nbsp;|
		</div> --%>
	</div>

	<div
		data-options="region:'south',border:false,href:'${pageContext.request.contextPath}/web/Frames/layout/footer.jsp'"
		style="height:30px;overflow: hidden;background:#dcdcdc"></div>
<div id="west" data-options="region:'west',border:true"
		style="width:180px;overflow:hidden;background:#4c4847;border-right:0px solid #2d3e50">
		<div id='wnav'
			style="background:#4c4847;overflow:hidden;border-right:0px solid #2d3e50"
			class="easyui-accordion1" fit="true" border="false">
			<!--  导航内容 -->
		</div>
</div>
		<div id="center" data-options="region:'center',border:false" style="height:100%;">
			<div id="title" style="width:100%;height:35px;background:#eee;border:0;display:block;padding-top: 10px;" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td width="5%" height="18px" align="center" valign="middle" ><img id = "titleimg" src=""/></td>
						<td width="95%" class="ys_05" id="titletd" ></td>
					</tr>
					<tr>
	             <td colspan="2" align="center" valign="top"><img src="${pageContext.request.contextPath}/images/workorder/henggang_01.png" width="96%" height="1" /></td>
	        		</tr>
				</table>
			</div>
			<div class="easyui-panel"  id="centerTab"
				data-options="border:false,fit:true" style="background:#eee;display:block;">
			
			</div>
			
			<div  id="shouye" style="display:none;width: 100%;height:100%;">
				<iframe id="shouyeframe" src="" style="width: 100%;height:100%;"></iframe>			
			</div>
			
			<div  id="overview" style="display:none;width: 100%;height:100%;">
				<iframe id="overviewframe" src="" style="width: 100%;height:100%;border:0;"></iframe>			
			</div>
						
	</div>
		
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/datagrid-detailview.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sockjs-0.3.min.js"></script>	

	<jsp:include page="../systemMg/passwdChangeFirst.jsp"></jsp:include>
	
</body>
</html>
<script type="text/javascript" src="<%=basePath%>/js/startOrders.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath%>/js/allowMove.js" charset="utf-8"></script>