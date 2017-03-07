<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java" %>
<%@ include file="/icp/include/taglib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>申请资源查看</title>
  <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/easyui-1.4/jquery.easyui.min.js" ></script>
  <link href="${pageContext.request.contextPath}/easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
  <link href="${pageContext.request.contextPath}/easyui-1.4/themes/icon.css" rel="stylesheet" type="text/css" /> 
  <style type="text/css">
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
}
.content {
	font-family: "微软雅黑", "华文细黑", "时尚中黑简体",;
	font-size: 12px;
	color: #333;
	margin-top: 5px;
	margin-right: auto;
	margin-bottom: 20px;
	margin-left: auto;
	width: 100%;
}
.content .title {
	font-family: "微软雅黑", "宋体", "时尚中黑简体";
	font-size: 16px;
	color: #FFF;
	height: 45px;
	background-color: #25b7de;
	line-height: 45px;
	padding-left: 20px;
	overflow: hidden;
}
.content .subtitle {
	border-left-width: 5px;
	border-left-style: solid;
	border-left-color: #25b7de;
	margin-top: 5px;
	margin-bottom: 5px;
	line-height: 25px;
	padding-left: 20px;
	color: #25b7de;
	font-size: 14px;
	
}
.content .table {
}
.content .table table {
	text-align: left;
}
.content .table table tbody tr {
height: 10px;
}
.content .table table tr td {
	padding-left: 20px;
	border: 1px solid #e8e8e8;
	height: 5px;
	line-height: 20px;
}
.content .table2 {
}
.content .table2 table tbody tr {
height: 10px;
}
.content .table2 table tr td {
	border: 1px solid #e8e8e8;
	height: 5px;
	text-align: center;
	line-height: 20px;
}
.content .table2 table tr th {
	height: 5px;
	line-height: 20px;
	background-color: #f0f0f0;
	border: 1px solid #e8e8e8;
}
.content .table2 table tr td a {
	color: #25b7de;
	list-style-type: none;
}
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
</style>
<script type="text/javascript">
	function redo(){
		var mainTab =  window.parent.$("#centerTab").find("#tabs");
		var currentTab = mainTab.tabs("getSelected");
		var index =mainTab.tabs('getTabIndex',currentTab);
		mainTab.tabs("close",index);
	}
	function save(){
		var flowid="${flowid}";
		var data =$("tr.data").length;
		var arr= new Array(data);
		var waf,av,vpn,ips,fw;
		var shopid;
		var tlong;
		var detailid;
		for(var i=1;i<=data;i++){
			detailid=String(i);
			tlong=$("#tlong_"+i).val();
			shopid =$("#shopid_"+1).val();
			if($("#waf_"+i).is(":checked")){
				 waf="开通";
			}else{
				waf="未开通";
			}
			if($("#fw"+i).is(":checked")){
				 fw="开通";
			}else{
				fw="未开通";
			}
			if($("#av_"+i).is(":checked")){
				 av="开通";
			}else{
				av="未开通";
			}
			if($("#ips_"+i).is(":checked")){
				 ips="开通";
			}else{
				ips="未开通";
			}
			if($("#vpn_"+i).is(":checked")){
				vpn="开通";
			}else{
				vpn="未开通";
			}
			arr[i-1]=shopid+","+tlong+","+detailid+","+fw+","+av+","+ips+","+waf+","+vpn;
		}
		var list =arr.join(":");
		$.ajax({  
		    url:'${pageContext.request.contextPath}/security/updateSEconf.do',
		   	data:{'list' : list,'flowid':flowid},
		    type:'post',  
		    async: false,
		    dataType:'json',  
		    success:function(data){ 
		    	if(data.result){
		    		alert("操作成功！");
		    	}else{
		    		alert("操作失败！");
		    	}
	    	}
	    });
		var mainTab =  window.parent.$("#centerTab").find("#tabs");
		var currentTab = mainTab.tabs("getSelected");
		var index =mainTab.tabs('getTabIndex',currentTab);
	 
	    var _showtab = mainTab.tabs("getTab",'申请资源查看');
	    var refresh_tab =  _showtab;
	    var _infowshowurl ;
	    if(refresh_tab && refresh_tab.find('iframe').length > 0){
	    	 var _refresh_ifram = refresh_tab.find('iframe')[0];
	    	var refresh_url = _refresh_ifram.src;
	    	_infowshowurl = refresh_url;
	    }
	    var _centerTab = window.parent.$("#centerTab");
	    var _options  = _centerTab.panel('options');
	    _centerTab.panel({
	    	onOpen:function (){
	    	}
	    });
	    _centerTab.panel('refresh');
	}
	
</script>
</head>
<body>
  
  


<div id="details" class="content"  >
 <div class="title">客户需求表（云安全）</div>
  <div class="subtitle">用户及应用信息</div>
  <div class="table">
	  <table  width="98%" align="center">
		    <tr>
		      <td width="15%" align="center" bgcolor="#f0f0f0" scope="row">用户单位</td>
		      <td width="30%" align="center">${coprInfoVo.cmpyname}</td>
		      <td colspan="2" align="center" bgcolor="#f0f0f0">业务应用</td>
		      <td colspan="2" align="center">${coprInfoVo.bizlic}</td>
		    </tr>
		    <tr>
		      <td align="center" bgcolor="#f0f0f0">联系人</td>
		      <td align="center">${coprInfoVo.uname}</td>
		      <td width="14%" align="center" bgcolor="#f0f0f0">联系电话</td>
		      <td width="10%" align="center">${coprInfoVo.mobile}</td>
		      <td width="6%" align="center" bgcolor="#f0f0f0">邮箱</td>
		      <td width="15%" align="center">${coprInfoVo.email}</td>
		    </tr>
	  </table>
  </div>
  <div class="subtitle">云服务器配置</div>
  <div class="table2">
	  <table id="baseinfo" width="98%" align="center" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		      <th align="center" scope="col"><strong>产品序号</strong></th>
		      <th align="center" scope="col"><strong>CPU（核）</strong></th>
		      <th align="center" scope="col"><strong>内存（G)</strong></th>
		      <th align="center" scope="col"><strong>操作系统</strong></th>
		      <th align="center" scope="col"><strong>防火墙</strong></th>
	          <th align="center" scope="col"><strong>病毒过滤</strong></th>
              <th align="center" scope="col"><strong>入侵防御</strong></th>
              <th align="center" scope="col"><strong>VPN</strong></th>
              <th align="center" scope="col"><strong>WAF</strong></th>
		    </tr>
		    <c:if test="${fn:length(bmdFlowSecurityVos) > 0}">
			<c:forEach items="${bmdFlowSecurityVos}" var="vo">
			<tr align="center" class="data">
				<input id="tlong_${vo.detailid}" type="hidden"  value="${vo.tlong}"/>
				<input id="shopid_${vo.detailid}" type="hidden" value="${vo.shopid}"/>
				<td>${vo.detailid}</td>
				<td>${vo.cpunum}</td>
				<td>${vo.memnum}</td>
				<td>${vo.osname}</td>
				<td><input id="fw_${vo.detailid}" type="checkbox" <c:if test="${fn:contains(vo.funtype,'1')}">checked</c:if>/></td>
				<td><input id="av_${vo.detailid}" type="checkbox" <c:if test="${fn:contains(vo.funtype,'2')}">checked</c:if>/></td>
				<td><input id="ips_${vo.detailid}" type="checkbox" <c:if test="${fn:contains(vo.funtype,'3')}">checked</c:if>/></td>
				<td><input id="waf_${vo.detailid}" type="checkbox" <c:if test="${fn:contains(vo.funtype,'4')}">checked</c:if>/></td>
				<td><input id="vpn_${vo.detailid}" type="checkbox" <c:if test="${fn:contains(vo.funtype,'5')}">checked</c:if>/></td>
				
			</tr>
			</c:forEach>
			</c:if>
	  </table>
  </div>
  <c:if test="${1 eq vo2.iseditprice}">
   <div class="subtitle">数量时长信息</div>
   <div class="table2">
	  <table width="98%" border="0" cellpadding="0" cellspacing="0"  align="center">
		  <tr>
		  <th width="15%" rowspan="1" align="center" bgcolor="#66CC99"><strong>产品序号</strong></th>
		    <th width="7%" rowspan="1" align="center"><strong>时长(月)</strong></th>
		    <th width="9%" rowspan="1" colspan="2" align="center"><strong>单价(元/月)</strong></th>
		    <th width="14%" rowspan="1" colspan="2" align="center"><strong>总价(元)</strong></th>
		  </tr>
		    <c:if test="${fn:length(bmdFlowSecurityVos) > 0}">
			<c:forEach items="${bmdFlowSecurityVos}" var="vo">
		  <tr>
		    <td align="center">${vo.detailid}</td>
		    <td align="center">${vo.tlong}</td>
		    <td align="center" colspan="2">${vo.iprice}</td>
			<td align="center" colspan="2">${vo.totalprice}</td>
		  </tr>
		  </c:forEach>
		  </c:if>
 	  </table>
   </div>
   </c:if>
   <div style="height:70px;"></div>
	<div style="margin-left:550px;">
		<a href="#" onClick="save();" class="easyui-linkbutton" data-options="iconCls:'icon-ok',width:72,height:32">保存</a>
		<a href="#" style="margin-left:40px;" onClick="redo();" class="easyui-linkbutton" data-options="iconCls:'icon-undo',width:72,height:32">返回</a>
	</div>
</div>
	


