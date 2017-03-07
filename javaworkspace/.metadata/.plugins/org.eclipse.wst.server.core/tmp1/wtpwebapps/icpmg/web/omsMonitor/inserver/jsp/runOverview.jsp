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
  		var inserver_neid = '${pageContext.request.getParameter("neid")}';
  	</script>
	<style type="text/css">
	
	/* 虚机状态信息 */
		.inserver-error
		{
			background-position: -55px 0;
		}
		#inserver-main
		{
			width:1200px;
			height:1200px;
			/* background-color: red; */
		}
		#inserver-head-status
		{
			width: 91%;
			margin-left: 20px;
			overflow:hidden;
			height: 98px;
			/* background-color: #fff; */
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/headerbg.png);
			border-radius: .45em;
		}		
		#inserver-status
		{
			margin-left: 20px;
			width:120px;
			height: 72px;
			float:left;
		}
		#inserver-health-title
		{
			margin-left: 70px;
			margin-top: 27px;
			font-style: 17px;
			color: #fff;
			font-weight: bold;
		}
		#inserver-health
		{
			height:72px;
			width:120px;
			float:left;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/error.png);
			margin-left: -10px;
			margin-top: 10px;
			margin-right: 15px;
			/* background-color: red; */
		}
		#inserver-details
		{
			height:70px;
			width:275px;
			float:left;
			margin-top:20px;
			margin-left: 20px;
			overflow:hidden;
			//background-color: #87CEEB; 
			border-radius: .45em;
		}
	
		#inserver-nename
		{
			margin-top: 8px;
			width:100%;
			font-size:12px;
		}
		#inserver-ipaddr
		{			
			margin-top:5px;
			font-size:12px;
		}
		#inserver-life-details
		{
			height:70px;
			width:300px;
			float:left;
			margin-top:20px;
			margin-left: 20px;
			overflow:hidden;
			//background-color: #87CEEB;
			overflow:hidden;
			border-radius: .45em;
		}
		#inserver-life-detail1
		{
			width: 140px;
			height: 60px;
			margin-top: 10px;
			margin-left: 10px;
			float:left;
			overflow:hidden;
			/* background-color: green; */
		}
		#inserver-life-detail2
		{
			margin-left: 10px;
			width: 140px;
			height: 60px;
			margin-top: 10px;
			overflow:hidden;
			float:left;
			/* background-color: blue; */
		}
		#inserver-buy-time,#inserver-test-time,#inserver-use-time,#inserver-useend-time
		{
			width: 140px;
			height: 20px;
			overflow:hidden;
			font-size:12px;
		}
		
		#inserver-time-alarm
		{
			height:70px;
			width:200px;
			margin-top: 30px;
			margin-left: 20px;
			float:left;
			//background-color: #87CEEB;
			overflow:hidden;
		}
		
		
		#inserver-alarm
		{
			height: 18px;
			width:200px;
			overflow:hidden;
			margin-left: 0px;
			margin-top:0px;
			//background-color: #EEEEEE;
		}
		#inserver-running-time
		{
			height:18px;
			width:200px;
			overflow:hidden;
			margin-left: 0px;
			margin-top:0px;
			//background-color: #EEEEEE;
		}
		
		#inserver-more
		{
			height:70px;
			width: 70px;
			float:right;
			margin-right: 15px;
			/* float:left; */
			/* margin-left: 1%; */
			margin-top:14px;
			background-color: #EEEEEE;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/more.png);
			background-position: 63px 0;
			line-height: 69px;
			border-radius: .45em;

		}
		#inserver-more:hover
		{
			background-color: #ddd;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/more_hover.png);
			background-position: 63px 0;
			line-height: 69px;
			cursor:pointer;
		}
		#inserver-more-title
		{
			margin-left:15px;
			margin-bottom:3px;
			font-size: 14px;
			color: white;
		}
	
	/* 利用率 */		
		#inserver-compute-zone
		{
			width: 91%;
			height:300px;
			overflow:hidden;
			margin-top:15px;
			margin-left: 20px;
			/* margin:10px; */
			padding:0px;
			border-radius: .45em;
		}
		#inserver-cpu-zone
		{
			width:50%;
			height:300px;
			float:left;
			margin-right: 0;
			/* background-color: blue; */
		}
		#inserver-mem-zone
		{
			width:50%;
			height:300px;
			float:left;
			/* background-color: blue; */		
		}
		
		#inserver-index-monitor-zone
		{
			width:97%;
			height:550px;
			margin-left: 10px;
			margin-top: 10px;
			//background-color: green;
			
		}
		
	/* 指标趋势 */	
		
	
		/*计算指标列表*/
		/*************************************************************************/
			#inserver-index-list-zone {
			  width: 15%;
			  height:530px;
			  margin-left:10px;
			  margin-right:20px;
			  background: white;
			  overflow: hidden;
			  float:left;
			  border-radius: .45em;
			}
			#inserver-index-list-zone .index-menu .index-list:hover .index-dropdown {
			  /* display: block !important; */
			  background: #00B8EE;
			}
			#inserver-index-list-zone .index-menu .index-list .index-title {
			  width: 100%;
			  height: 50px;
			  line-height: 50px;
			  background: white;
			  color:#4074E1;
			  font-size: 18px;
			}
			#inserver-index-list-zone .index-menu .index-list .index-dropdown {
			  width: 100%;
			  background: #00B8EE;
			  cursor:pointer;
			  display:none;
			}
			#inserver-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title {
			  height: 50px;
			  line-height: 50px;
			  font-size: 16px;
			  color: white;
			}
			#inserver-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title:hover {
			  background: #7ecef4;
			}		
			
			#inserver-time-cobbox-out
			{
				//float:left;
				margin:10px -1px;
				padding:1px 0;
				width:100%;
				background-color: #eee;
			}
		
		/*计算指标图表*/
		/*************************************************************************/

			#inserver-index-zone
			{
				width:77%;
				height:530px;
				float:left;
				background-color: white;
				border-radius: .45em;
			}
				
		/*网络指标区域*/
		/*************************************************************************/
		
			#inserver-network-index-monitor-zone
			{
				width:97%;
				height:550px;
				margin-left: 10px;
				margin-top: -5px;
				//background-color: green;
				
			}
		
		/*网络指标列表*/
		/*************************************************************************/
			#inserver-network-index-list-zone {
			  width: 15%;
			  height: 530px;
			  margin-left:10px;
			  margin-right:20px;
			  background: white;
			  overflow: hidden;
			  float:left;
			  border-radius: .45em;
			}
			#inserver-network-index-list-zone .index-menu .index-list:hover .index-dropdown {
			  //display: block !important;
			  background: #00B8EE;
			}
			#inserver-network-index-list-zone .index-menu .index-list .index-title {
			  width: 100%;
			  height: 50px;
			  line-height: 50px;
			  background: white;
			  color:#4074E1;
			  font-size: 18px;
			}
			#inserver-network-index-list-zone .index-menu .index-list .index-dropdown {
			  width: 100%;
			  background: #00B8EE;
			  cursor:pointer;
			  display:none;
			}
			#inserver-network-index-list-zone .index-menu .index-list .index-dropdown .insnet-drop-down-title {
			  height: 50px;
			  line-height: 50px;
			  font-size: 16px;
			  color: white;
			}
			#inserver-network-index-list-zone .index-menu .index-list .index-dropdown .insnet-drop-down-title:hover {
			  background: #7ecef4;
			}		
			
			#inserver-network-time-cobbox-out
			{
				//float:left;
				margin:10px -1px;
				padding:1px 0;
				width:100%;
				background-color: #eee;
			}
			
	/*网络指标图表*/
	/*************************************************************************/
			#inserver-network-index-zone
			{
				width:77%;
				height:530px;
				float:left;
				background-color: white;
				border-radius: .45em;
			}
				
			#inserver-network-time-cobbox-out
			{
				//float:left;
				margin:10px -1px;
				padding:1px 0;
				width:100%;
				background-color: #eee;
			}
			
	/*磁盘*/
	/*************************************************************************/
			#inserver-single-device-zone2
			{
				width:91%;
				height:450px;
				margin-left: 15px;
				margin-top: 15px;
				margin-bottom: 5px;
				/* background-color: green; */
			}
			#inserver-disk-mount-zone
			{
				float:left;
				width:100%;
				height:450px;
				margin: 5px;
				border-radius: .45em;
				background-color: white;
			}
			#inserver-single-device-zone
			{
				width:91%;
				height:400px;
				margin-left: 15px;
				margin-top: 20px;
				/* background-color: green; */
				
			}
			#inserver-single-disk-zone
			{
				float:left;
				width:100%;
				height:380px;
				margin: 5px;
				border-radius: .45em;
				background-color: white;
			}
			
			#inserver-disk-io-zone 
			{
				width:91%;
				height:450px;
				margin-left: 20px;
				margin-top: 5px;
				margin-bottom: 20px;
				/* background-color: green; */
			}
			#inserver-disk-io-chart
			{
				float:left;
				width:100%;
				height:450px;
				border-radius: .45em;
				background-color: white;
			}
			
	/*导航*/
	/*************************************************************************/
			#inserver-gotop,#inserver-go-usage,#inserver-go-disk,#inserver-go-computeindex
			{
				filter:alpha(opacity=70); 
            	-moz-opacity:0.7;
            	-khtml-opacity:0.7;  
            	opacity:0.7;
			}
			#inserver-gotop:hover,#inserver-go-usage:hover,#inserver-go-disk:hover,
			#inserver-go-computeindex:hover
			{
				filter:alpha(opacity=50); 
            	-moz-opacity:0.5;
            	-khtml-opacity:0.5;  
            	opacity:0.5;
			}
	
	
			#inserver-gotop
			{
				width:48px;
				height:48px;
				background-color: #1970D5;
				background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/goicon/go-top.png);
				background-repeat:no-repeat;
				background-position: 50% 50%;
				position:fixed; right:50px;	bottom:65px; 
				border-radius: .45em;
				cursor:pointer;

			}		
			#inserver-go-usage
			{
				width:48px;
				height:48px;
				background-color: #1970D5;
				background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/goicon/go-usage.png);
				background-repeat:no-repeat;
				background-position: 50% 50%;
				position:fixed; right:50px;	bottom:115px; 
				border-radius: .45em;
				cursor:pointer;
			}
			#inserver-go-disk
			{
				width:48px;
				height:48px;
				background-color: #1970D5;
				background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/goicon/go-disk.png);
				background-repeat:no-repeat;
				background-position: 50% 50%;
				position:fixed; right:50px;	bottom:165px; 
				border-radius: .45em;
				cursor:pointer;
			}
			#inserver-go-computeindex
			{
				width:48px;
				height:48px;
				background-color: #1970D5;
				background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/goicon/go-index.png);
				background-repeat:no-repeat;
				background-position: 50% 50%;
				position:fixed; right:50px;	bottom:215px; 
				border-radius: .45em;
				cursor:pointer;
			}

			
			/*******************************************************/
			#inserver-bottom
			{
				width:100%;
				height:50px;
				margin-top:20px;
			}
		
	</style>
	
	
	<div id="inserver-main">
		<div id="inserver-head-status">
			<div id="inserver-status">
				<div id="inserver-health">
					<div id="inserver-health-title"></div>				
				</div>
			</div>
			<div id="inserver-details">
				<p id="inserver-nename"></p>
				<p id="inserver-ipaddr"></p>
			</div>
			<div id="inserver-life-details" title="设备生命周期">
				<div id="inserver-life-detail1">
					<p id="inserver-buy-time"></p>
					<p id="inserver-test-time"></p>
				</div>
				<div id="inserver-life-detail2">
					<p id="inserver-use-time"></p>
					<p id="inserver-useend-time"></p>
				</div>
			</div>
			
			<div id="inserver-time-alarm" title="设备告警数量">
				<div id="inserver-alarm">
					<span style="padding-left: 20px;">
						设备告警：<span id="inserver-alarm-num" style="color: red;font-weight: bold;"></span>
					</span>
				</div>
				<div id="inserver-running-time">
					<span style="padding-left: 20px;">
						正常运行时间：
						<span id="inserver-day" style="color: red;"></span>&nbsp;天
						<span id="inserver-hour" style="color: red;"></span>&nbsp;时
						<span id="inserver-min" style="color: red;"></span>&nbsp;分
					</span>
				</div>
			</div>
			
			<div id="inserver-more" title="跳转至设备信息详情">
				<span id="inserver-more-title" title="跳转至设备信息详情">详情</span>
			</div>
			
		</div>
		
		<div id="inserver-compute-zone">
			<div id="inserver-cpu-zone"></div>
			<div id="inserver-mem-zone"></div>
		</div>
		
				
		<div id="inserver-single-device-zone2">
			<div id="inserver-disk-mount-zone"></div>
		</div>	
		
		<div id="inserver-single-device-zone">
			<div id="inserver-single-disk-zone"></div>
		</div>
	
		<!-- <div id="inserver-disk-io-zone">
			<div id="inserver-disk-io-chart"></div>
		</div> -->
		
		<div id="inserver-index-monitor-zone">
			<div id="inserver-index-list-zone">
				<div class="index-menu">
					
					<div class="index-list" title="时间范围选择">
						<p class="index-title">&nbsp;&nbsp;时间范围选择</p>
						<p id="inserver-time-cobbox-out" >
							<input id="inserver-time-cobbox" />   
						</p>
					</div>	
				
					<div class="index-list" title="可选指标列表">
						<p class="index-title">&nbsp;&nbsp;计算指标选择</p>
						<div class="index-dropdown">
							<p class="drop-down-title" title="虚拟机CPU使用率">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="cpu-box" value="0" />
								CPU利用率
							</p>
							<p class="drop-down-title" title="虚拟机内存使用率">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="mem-box" value="0" />
								内存利用率
							</p>		
						</div>
					</div>
					
				</div>
			</div>
			<div id="inserver-index-zone"></div>
		</div>
		
		<div id="inserver-network-index-monitor-zone">
			<div id="inserver-network-index-list-zone">
				<div class="index-menu">
					
					<div class="index-list"  title="时间范围选择">
						<p class="index-title">&nbsp;&nbsp;时间范围选择</p>
						<p id="inserver-network-time-cobbox-out" >
							<input id="inserver-network-time-cobbox" />   
						</p>
					</div>	
				
					<div class="index-list" title="可选指标列表">
						<p class="index-title">&nbsp;&nbsp;网络指标选择</p>
						<div class="index-dropdown">
							<p class="insnet-drop-down-title" title="虚拟机网卡接收速度">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="rxusage-box" value="0" />
								接收流速
							</p>
							<p class="insnet-drop-down-title" title="虚拟机网卡发送速度">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="txusage-box" value="0" />
								发送流速
							</p>		
						</div>
					</div>
					
					
				</div>
			</div>
			<div id="inserver-network-index-zone"></div>
		</div>

	
	</div>

	
	<div id="inserver-gotop" title="回到顶部"></div>
	<div id="inserver-go-usage" title="跳转至利用率"></div>
	<div id="inserver-go-disk" title="跳转至磁盘"></div>
	<div id="inserver-go-computeindex" title="跳转至指标趋势"></div>
	
	
	
	<div id="inserver-bottom"></div>
	
	
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/vmware/runOverviewStatus.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/vmware/runOverviewUsage.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/vmware/runOverviewIndex.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/vmware/runOverviewDisk.js"></script>
</body>
</html>
