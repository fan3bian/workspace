<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>运行概况</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	
	<script type="text/javascript" charset="UTF-8">
  		var context_path = '${pageContext.request.contextPath}';
  		var inhost_neid = '${pageContext.request.getParameter("neid")}';
  		var inhost_typeid = '${pageContext.request.getParameter("typeid")}';
  		
  	</script>
	<style type="text/css">
		.inhost-error
		{
			background-position: -55px 0;
		}
	
		#inhost-main
		{
			min-width:1200px;
			min-height:1200px;
			//background-color: red;
		}

		#inhost-head-status
		{
			width: 100%;
			overflow:hidden;
			height: 100px;
			background-color: #fff;
		}		
		#inhost-status
		{
			margin-left: 20px;
			width:280px;
			height: 80px;
			margin-top:8px;
			float:left;
		}
		
		
		#inhost-health
		{
			height:60px;
			width:60px;
			float:left;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/runOverview/status.png);
			margin: 10px;
			background-position: -55px 0;
		}
		
		
		.inhost-fee-selected
		{
			color: #fff;
			font-weight:bold;
		}
				
		#inhost-fee-status1
		{
			width: 63px;
			height: 37px;
			float:left;
			margin-top:20px;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/runOverview/status.png);
			background-position: -5px -62px;
			line-height: 37px;
		}
		
		#inhost-fee-status2
		{
			width: 63px;
			height: 37px;
			float:left;
			margin-top:20px;
			margin-left:2px;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/runOverview/status.png);
			background-position: -76px -62px;
			line-height: 37px;
		}
		
		#inhost-fee-status3
		{
			width: 61px;
			height: 37px;
			float:left;
			margin-top:20px;
			margin-left:2px;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/runOverview/status.png);
			background-position: -145px -62px;
			line-height: 37px;
		}
		#inhost-details
		{
			height:70px;
			width:380px;
			float:left;
			margin-top:10px;
			overflow:hidden;
			background-color: #EEEEEE; 
		}
		#inhost-nename
		{
			margin-left: 20px;
			margin-top: 8px;
			font-size:13px;
		}
		#inhost-ipaddr
		{
			margin-left: 20px;
			margin-top:5px;
			font-size:13px;
		}

		#inhost-alarm
		{
			height:70px;
			width:130px;
			float:left;
			margin-left: 10px;
			margin-top:10px;
			background-color: #EEEEEE;
			line-height: 70px;
			font-size: 14px;
		}
		#inhost-running-time
		{
			height:70px;
			width:250px;
			float:left;
			margin-left: 10px;
			margin-top:10px;
			background-color: #EEEEEE;
			line-height: 70px;
			font-size: 14px;
		}
		
		#inhost-more
		{
			height:70px;
			width: 70px;
			float:right;
			margin-right: 4%;
			margin-top:10px;
			background-color: #EEEEEE;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/runOverview/more.png);
			background-position: 63px 0;
			line-height: 69px;

		}
		#inhost-more:hover
		{
			background-color: #ddd;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/runOverview/more_hover.png);
			background-position: 63px 0;
			line-height: 69px;
			cursor:pointer;
		}
		
		#inhost-more-title
		{
			margin-left:15px;
			margin-bottom:3px;
			font-size: 14px;
			color: white;
		}
		
		#inhost-compute-zone
		{
			width: 97%;
			height:400px;
			overflow:hidden;
			margin:10px;
			padding:10px;
		}
		
		#inhost-cpu-zone
		{
			width:45%;
			height:400px;
			float:left;
			margin-right: 3.5%;
		}
		#inhost-mem-zone
		{
			width:45%;
			height:400px;
			float:left;
		}
		
		#inhost-index-monitor-zone
		{
			width:97%;
			height:500px;
			margin: 10px;
		}
		
		
/********************************************************/		
		
#inhost-index-list-zone {
  width: 15%;
  margin-left:10px;
  margin-right:20px;
  background: white;
  overflow: hidden;
  float:left;
}
#inhost-index-list-zone .index-menu .index-list:hover .index-dropdown {
  //display: block !important;
  background: #00B8EE;
}
#inhost-index-list-zone .index-menu .index-list .index-title {
  width: 100%;
  height: 50px;
  line-height: 50px;
  background: white;
  color:#4074E1;
  font-size: 18px;
}
#inhost-index-list-zone .index-menu .index-list .index-dropdown {
  width: 100%;
  background: #00B8EE;
  display: none;
}
#inhost-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title {
  height: 50px;
  line-height: 50px;
  font-size: 16px;
  color: white;
}
#inhost-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title:hover {
  background: #7ecef4;
}		

#time-cobbox
{
	margin:10px -1px;
	padding:1px 0;
	width:100%;
	background-color: #eee;
}

/********************************************************/
		
		#inhost-index-zone
		{
			width:77%;
			height:480px;
			float:left;
			background-color: white;
		}
		
		#inhost-single-compute-zone
		{
			width:97%;
			height:400px;
			margin: 10px;
			padding:10px;
			overflow:hidden;
			background-color: #eeeeee;
		}
		
		#inhost-single-cpu-zone
		{
			width:93.5%;
			height:400px;
			float:left;
			margin-right: 3.5%;
			background-color: #ffffff;
		}
		
		#inhost-single-disk-zone
		{
			width:93.5%;
			height:400px;
			float:left;
			background-color: white;				
		}
		
		#inhost-single-device-zone
		{
			width:97%;
			height:400px;
			margin: 10px;
			padding:10px;
			overflow:hidden;
			//background-color: green;
		}
		
		#inhost-single-mac-zone
		{
			width:93.5%;
			height:400px;
			float:left;
			margin-right: 3.5%;
			background-color: white;
		}
		
		#inhost-single-mem-zone
		{
			width:45%;
			height:400px;
			float:left;
			background-color: white;	
		}
		
		#inhost-bottom
		{
			width:100%;
			height:40px;
			margin-top:40px;
		}
		
		.panel-title
		{
			color: #666;
			font-size: 16px;
			font-weight: bold;
		}
		
	</style>
	
	
	<div id="inhost-main">
		<div id="inhost-head-status">
			<div id="inhost-status">
				<div id="inhost-health"></div>
				<div id="inhost-fee-status1"><span style="padding-left:12px;">试运行</span></div>
				<div id="inhost-fee-status2"><span style="padding-left:18px;">计费</span></div>
				<div id="inhost-fee-status3"><span style="padding-left:6px;">计费结束</span></div>
			</div>
			<div id="inhost-details">
				<p id="inhost-nename"></p>
				<p id="inhost-ipaddr"></p>
			</div>
			<div id="inhost-alarm">
				<span style="padding-left: 20px;">
					告警数：<span id="inhost-alarm-num" style="color: red;font-weight: bold;"></span>
				</span>
			</div>
			<div id="inhost-running-time">
				<span style="padding-left: 20px;">
					正常运行时间：
					<span id="inhost-day" style="color:green;"></span>&nbsp;天
					<span id="inhost-hour" style="color:green;"></span>&nbsp;时
					<span id="inhost-min" style="color:green;"></span>&nbsp;分
				</span>
			</div>
			<div id="inhost-more">
				<span id="inhost-more-title">详情</span>
			</div>
			
		</div>
		
		<div id="inhost-compute-zone">
			<div id="inhost-cpu-zone"></div>
			<div id="inhost-mem-zone"></div>
		</div>
		
		<div id="inhost-index-monitor-zone">
			<div id="inhost-index-list-zone">
				<div class="index-menu">
				
					<div class="index-list">
						<p class="index-title">&nbsp;&nbsp;时间范围选择</p>
						<p id="time-cobbox" >
							<input id="inhost-time-cobbox" />
						</p>
					</div>				
				
					<div class="index-list">
						<p class="index-title">&nbsp;&nbsp;计算指标选择</p>
						<div class="index-dropdown">
							<p class="drop-down-title">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="cpu-box" value="0" />
								CPU利用率
							</p>
							<p class="drop-down-title">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="mem-box" value="0" />
								内存利用率
							</p>
						</div>
					</div>
					
					<div class="index-list">
						<p class="index-title">&nbsp;&nbsp;网络指标选择</p>
						<div class="index-dropdown">
							<p class="drop-down-title">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="bandusage-box" value="0" />
								带宽占用率
							</p>
				
						</div>
					</div>
				</div>
			</div>
			<div id="inhost-index-zone"></div>
		</div>
		
		<div id="inhost-single-compute-zone">
			<div id="inhost-single-cpu-zone"></div>			
		</div>
		<div id="inhost-single-compute-zone">
		    <div id="inhost-single-disk-zone"></div>
		</div>
		<div id="inhost-single-device-zone">
			<div id="inhost-single-mac-zone">
				<div id="inhost-mac-datagrid"></div>
			</div>
		</div>
		
		<div id="inhost-bottom"></div>
	</div>
	
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/runOverview/runOverview.js"></script>
</body>
</html>
