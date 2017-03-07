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
		var osinserver_nename = '${pageContext.request.getParameter("nename")}';	
		var inserver_neid = '${pageContext.request.getParameter("neid")}';
	//	var onane=$('#inserver_name').val();
	/* 	$.ajax({ 
			url:'${pageContext.request.contextPath}/os_inserver_runoverview/getDiskData.do',
	        type:'post',
	        dataType:"json",
	        data:{
	        	nename:osinserver_nename,
	        	neid:inserver_neid
	        }, 
	        async : true, //默认为true 异步
	error:function(){ 
		alert('sent neid&nename error');
		},
	success:function(data){
	
	       } 
	}); */
		
	</script>
	<style type="text/css">
	
	/* 虚机状态信息 */
		.osinserver-error
		{
			background-position: -55px 0;
		}
		#osinserver-main
		{
			width:1200px;
			height:1200px;
			//overflow:hidden;
			/* background-color: red; */
		}
		#osinserver-head-status
		{
			width: 91%;
			margin-left: 20px;
			overflow:hidden;
			height: 98px;
			/* background-color: #fff; */
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/headerbg.png);
			border-radius: .45em;
		}		
		#osinserver-status
		{
			margin-left: 20px;
			width:120px;
			height: 72px;
			float:left;
		}
		#osinserver-health-title
		{
			margin-left: 70px;
			margin-top: 27px;
			font-style: 17px;
			color: #fff;
			font-weight: bold;
		}
		#osinserver-health
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
		#osinserver-details
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
		#osinserver-nename
		{
			margin-top: 8px;
			width:100%;
			font-size:12px;
		}
		#osinserver-ipaddr
		{
			margin-top:5px;
			font-size:12px;
		}
		#osinserver-life-details
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
		#osinserver-life-detail1
		{
			width: 140px;
			height: 60px;
			margin-top: 10px;
			margin-left: 10px;
			float:left;
			overflow:hidden;
			/* background-color: green; */
		}
		#osinserver-life-detail2
		{
			margin-left: 10px;
			width: 140px;
			height: 60px;
			margin-top: 10px;
			overflow:hidden;
			float:left;
			/* background-color: blue; */
		}
		#osinserver-buy-time,#osinserver-test-time,#osinserver-use-time,#osinserver-useend-time
		{
			width: 140px;
			height: 20px;
			overflow:hidden;
			font-size:12px;
		}
		#osinserver-time-alarm
		{
			height:70px;
			width:200px;
			margin-top: 30px;
			margin-left: 20px;
			float:left;
			/* background-color: #87CEEB; */
			overflow:hidden;
		}
		#osinserver-alarm
		{
			height: 18px;
			width:200px;
			overflow:hidden;
			margin-left: 0px;
			margin-top:0px;
			//background-color: #EEEEEE;
		}

		#osinserver-running-time
		{
			height:18px;
			width:200px;
			overflow:hidden;
			margin-left: 0px;
			margin-top:0px;
			//background-color: #EEEEEE;
		}
		#osinserver-more
		{
			height:70px;
			width: 70px;
			float:right;
			margin-right: 15px;
			margin-top:14px;
			background-color: #EEEEEE;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/more.png);
			background-position: 63px 0;
			line-height: 69px;
			border-radius: .45em;
		}
		#osinserver-more:hover
		{
			background-color: #ddd;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/more_hover.png);
			background-position: 63px 0;
			line-height: 69px;
			cursor:pointer;
		}
		#osinserver-more-title
		{
			margin-left:15px;
			margin-bottom:3px;
			font-size: 14px;
			color: white;
		}
		
		
	/* 利用率 */		
		#osinserver-compute-zone
		{
			width: 91%;
			height:300px;
			overflow:hidden;
			margin-top:15px;
			margin-left: 20px;
			margin-bottom: 20px;			
			padding:0px;
			border-radius: .45em;
		}
		#osinserver-cpu-zone
		{
			width:50%;
			height:300px;
			float:left;
			margin-right: 0;
			/* background-color: blue; */
		}
		#osinserver-mem-zone
		{
			width:50%;
			height:300px;
			float:left;
			/* background-color: blue; */		
		}
		
		#osinserver-index-monitor-zone
		{
			width:97%;
			height:550px;
			border-radius: .45em;
			margin-top: 5px;
			margin-left: 10px;
			/* background-color: green; */
			
		}
		
	/********************************************************/		
	/*计算指标列表*/		
		#osinserver-index-list-zone {
		  width: 15%;
		  height:530px;
		  margin-left:10px;
		  margin-right:20px;
		  background: white;
		  overflow: hidden;
		  float:left;
		  border-radius: .45em;
		}
		#osinserver-index-list-zone .index-menu .index-list:hover .index-dropdown {
		  /* display: block !important; */
		  background: #00B8EE;
		}
		#osinserver-index-list-zone .index-menu .index-list .index-title {
		  width: 100%;
		  height: 50px;
		  line-height: 50px;
		  background: white;
		  color:#4074E1;
		  font-size: 18px;
		}
		#osinserver-index-list-zone .index-menu .index-list .index-dropdown {
		  width: 100%;
		  background: #00B8EE;
		  cursor:pointer;
		  display:none;
		}
		#osinserver-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title {
		  height: 50px;
		  line-height: 50px;
		  font-size: 16px;
		  color: white;
		}
		#osinserver-index-list-zone .index-menu .index-list .index-dropdown .drop-down-title:hover {
		  background: #7ecef4;
		}		
		
		#osinserver-time-cobbox-out
		{
			/* float:left; */
			margin:10px -1px;
			padding:1px 0;
			width:100%;
			background-color: #eee;
		}
	
	/*指标图表*/	
	/********************************************************/
			#osinserver-index-zone
			{
				width:77%;
				height:530px;
				float:left;
				background-color: white;
				border-radius: .45em;
			}
	
	/*网络指标区域*/
	/********************************************************/
		#osinserver-network-index-monitor-zone
		{
			width:97%;
			height:550px;
			margin-top: 0px;
			margin-left: 10px;
			border-radius: .45em;
			/* background-color: green; */
			
		}
		/*disk指标区域*/
	/********************************************************/
		#osinserver-disk-index-monitor-zone
		{
			width:97%;
			height:550px;
			margin-top: 0px;
			margin-left: 10px;
			border-radius: .45em;
			/* background-color: green; */
			
		}
	
	/*网络指标列表*/		
	/********************************************************/
		#osinserver-network-index-list-zone {
		  width: 15%;
		  height:530px;
		  margin-left:10px;
		  margin-right:20px;
		  background: white;
		  overflow: hidden;
		  float:left;
		  border-radius: .45em;
		}
		#osinserver-network-index-list-zone .index-menu .index-list:hover .index-dropdown {
		  //display: block !important;
		  background: #00B8EE;
		}
		#osinserver-network-index-list-zone .index-menu .index-list .index-title {
		  width: 100%;
		  height: 50px;
		  line-height: 50px;
		  background: white;
		  color:#4074E1;
		  font-size: 18px;
		}
		#osinserver-network-index-list-zone .index-menu .index-list .index-dropdown {
		  width: 100%;
		  background: #00B8EE;
		  cursor:pointer;
		  display:none;
		}
		#osinserver-network-index-list-zone .index-menu .index-list .index-dropdown .osnet-drop-down-title {
		  height: 50px;
		  line-height: 50px;
		  font-size: 16px;
		  color: white;
		}
		#osinserver-network-index-list-zone .index-menu .index-list .index-dropdown .osnet-drop-down-title:hover {
		  background: #7ecef4;
		}		
		
		#osinserver-network-time-cobbox-out
		{
			/* float:left; */
			margin:10px -1px;
			padding:1px 0;
			width:100%;
			background-color: #eee;
		}
		/*disk指标列表*/		
	/********************************************************/
		#osinserver-disk-index-list-zone {
		  width: 15%;
		  height:530px;
		  margin-left:10px;
		  margin-right:20px;
		  background: white;
		  overflow: hidden;
		  float:left;
		  border-radius: .45em;
		}
		#osinserver-disk-index-list-zone .index-menu .index-list:hover .index-dropdown {
		  //display: block !important;
		  background: #00B8EE;
		}
		#osinserver-disk-index-list-zone .index-menu .index-list .index-title {
		  width: 100%;
		  height: 50px;
		  line-height: 50px;
		  background: white;
		  color:#4074E1;
		  font-size: 18px;
		}
		#osinserver-disk-index-list-zone .index-menu .index-list .index-dropdown {
		  width: 100%;
		  background: #00B8EE;
		  cursor:pointer;
		  display:none;
		}
		#osinserver-disk-index-list-zone .index-menu .index-list .index-dropdown .osnet-read-title {
		  height: 50px;
		  line-height: 50px;
		  font-size: 16px;
		  color: white;
		}
		#osinserver-disk-index-list-zone .index-menu .index-list .index-dropdown .osnet-read-title:hover {
		  background: #7ecef4;
		}		
		
		#osinserver-disk-time-cobbox-out
		{
			/* float:left; */
			margin:10px -1px;
			padding:1px 0;
			width:100%;
			background-color: #eee;
		}
	
	/*disk指标图表*/
	/********************************************************/
		#osinserver-disk-index-zone
		{
			width:77%;
			height:530px;
			margin-bottom: 18px;
			float:left;
			background-color: white;
			border-radius: .45em;
		}
			
		#osinserver-disk-time-cobbox-out
		{
			/* float:left; */
			margin:10px -1px;
			padding:1px 0;
			width:100%;
			background-color: #eee;
		}
	/*网络指标图表*/
	/********************************************************/
		#osinserver-network-index-zone
		{
			width:77%;
			height:530px;
			margin-bottom: 18px;
			float:left;
			background-color: white;
			border-radius: .45em;
		}
			
		#osinserver-network-time-cobbox-out
		{
			/* float:left; */
			margin:10px -1px;
			padding:1px 0;
			width:100%;
			background-color: #eee;
		}

	/* 其他网络指标 */
	/********************************************************/
		#osinserver-network-zone
		{
			width:90%;
			min-width:1092px;
			height:400px;
			margin-left: 20px;
			overflow:hidden;
			border-radius: .45em;
			/* background-color: green; */
		}
		
		#osinserver-network-datagrid-out
		{
			
		}
		
		.panel-title
		{
		
			color: #666;
			font-size: 16px;
			font-weight: bold;
			border-radius: .45em;
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
			
	/* 磁盘IO */
	/********************************************************/
		#osinserver-disk-io-zone 
		{
			width:91%;
			height:450px;
			margin-left: 20px;
			margin-top: -10px;
			margin-bottom: 20px;
			/* background-color: green; */
		}
		#osinserver-disk-io-chart
		{
			float:left;
			width:100%;
			height:450px;
			border-radius: .45em;
			background-color: white;
		}	
	
	/*导航*/
	/*************************************************************************/
		#osinserver-gotop,#osinserver-go-usage,#osinserver-go-computeindex,#osinserver-go-network
		{
			filter:alpha(opacity=70); 
           	-moz-opacity:0.7;
           	-khtml-opacity:0.7;  
           	opacity:0.7;
		}
		#osinserver-gotop:hover,#osinserver-go-usage:hover,
		#osinserver-go-computeindex:hover,#osinserver-go-network:hover
		{
			filter:alpha(opacity=50); 
           	-moz-opacity:0.5;
           	-khtml-opacity:0.5;  
           	opacity:0.5;
		}


		#osinserver-gotop
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
		#osinserver-go-usage
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
		#osinserver-go-computeindex
		{
			width:48px;
			height:48px;
			background-color: #1970D5;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/goicon/go-index.png);
			background-repeat:no-repeat;
			background-position: 50% 50%;
			position:fixed; right:50px;	bottom:165px; 
			border-radius: .45em;
			cursor:pointer;
		}
		#osinserver-go-network
		{
			width:48px;
			height:48px;
			background-color: #1970D5;
			background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/runOverview/goicon/go-network.png);
			background-repeat:no-repeat;
			background-position: 50% 50%;
			position:fixed; right:50px;	bottom:215px; 
			border-radius: .45em;
			cursor:pointer;
		}

	
	
	
	/********************************************************/
		#osinserver-bottom
		{
			width:100%;
			height:10px;
			margin-top:0;
		}
	</style>
			
	<div id="osinserver-main">
		<div id="osinserver-head-status">
			<div id="osinserver-status">
				<div id="osinserver-health">
					<div id="osinserver-health-title"></div>	
				</div>
			</div>
			<div id="osinserver-details">
				<p id="osinserver-nename"></p>
				<p id="osinserver-ipaddr"></p>
			</div>
			<div id="osinserver-life-details" title="设备生命周期">
				<div id="osinserver-life-detail1">
					<p id="osinserver-buy-time"></p>
					<p id="osinserver-test-time"></p>
				</div>
				<div id="osinserver-life-detail2">
					<p id="osinserver-use-time"></p>
					<p id="osinserver-useend-time"></p>
				</div>
			</div>
			
			<div id="osinserver-time-alarm" title="设备告警数量">
				<div id="osinserver-alarm">
					<span style="padding-left: 20px;">
						告警：<span id="osinserver-alarm-num" style="color: red;font-weight: bold;"></span>
					</span>
				</div>
				<div id="osinserver-running-time">
					<span style="padding-left: 20px;">
						正常运行时间：
						<span id="osinserver-day" style="color: red;"></span>&nbsp;天
						<span id="osinserver-hour" style="color: red;"></span>&nbsp;时
						<span id="osinserver-min" style="color: red;"></span>&nbsp;分
					</span>
				</div>
			</div>
			
			<div id="osinserver-more" title="跳转至设备信息详情">
				<span id="osinserver-more-title">详情</span>
			</div>
			
		</div>
		
		<div id="osinserver-compute-zone">
			<div id="osinserver-cpu-zone"></div>
			<div id="osinserver-mem-zone"></div>
		</div>
		
<!-- 		<div id="osinserver-disk-io-zone">
			<div id="osinserver-disk-io-chart"></div>
		</div> -->
		
		<div id="osinserver-index-monitor-zone">
			<div id="osinserver-index-list-zone">
				<div class="index-menu">
					
					<div class="index-list" title="时间范围选择">
						<p class="index-title">&nbsp;&nbsp;时间范围选择</p>
						<p id="osinserver-time-cobbox-out" >
							<input id="osinserver-time-cobbox" />   
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
			<div id="osinserver-index-zone"></div>
		</div>
		
		<div id="osinserver-network-index-monitor-zone">
			<div id="osinserver-network-index-list-zone">
				<div class="index-menu">
					
					<div class="index-list" title="时间范围选择">
						<p class="index-title">&nbsp;&nbsp;时间范围选择</p>
						<p id="osinserver-network-time-cobbox-out" >
							<input id="osinserver-network-time-cobbox" />   
						</p>
					</div>	
				
					<div class="index-list" title="可选指标列表">
						<p class="index-title">&nbsp;&nbsp;网络指标选择</p>
						<div class="index-dropdown">
							<p class="osnet-drop-down-title" title="虚拟机网卡接收速度">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="rxusage-box" value="0" />
								接收流速
							</p>
							<p class="osnet-drop-down-title" title="虚拟机网卡发送速度">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="txusage-box" value="0" />
								发送流速
							</p>		
						</div>
					</div>
					
				</div>
			</div>
			<div id="osinserver-network-index-zone"></div>
		</div>

   
		<div id="osinserver-disk-index-monitor-zone">
			<div id="osinserver-disk-index-list-zone">
				<div class="index-menu">
															
					 <div class="index-list" title="所属磁盘">
						   <p id="diskdrop" class="index-title"> &nbsp;&nbsp;磁盘选择</p>
						   <p id="osinserver-disk" >
						      <input id="DiskName" class="easyui-combobox" name="name" style="width: 175px; height: 40px; align-text: center"/>
							  <input id="inserver_name" type=hidden ></input>
							  
					       </p>
						</div>
						
					
					<div class="index-list" title="时间范围选择">
						<p class="index-title">&nbsp;&nbsp;时间范围选择</p>
						<p id="osinserver-disk-time-cobbox-out" >
							<input id="osinserver-disk-time-cobbox"/>   
						</p>
					</div>	
				
					<div class="index-list" title="可选指标列表">
						<p class="index-title">&nbsp;&nbsp;磁盘指标选择</p>
						<div class="index-dropdown">
							<p class="osnet-read-title" title="磁盘读速率">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="read-box" value="0" />
								读速率
							</p>
							<p class="osnet-read-title" title="磁盘写速率">
								&nbsp;&nbsp;&nbsp;<input type="checkbox" name="" id="write-box" value="0" />
								写速率
							</p>		
						</div>
					</div>
					
				</div>
			</div>
			<div id="osinserver-disk-index-zone"></div>
		</div>
		
		<div id="inserver-single-device-zone2">
			<div id="inserver-disk-mount-zone"></div>
		</div>	
		
		
		
	</div>
	<div id="osinserver-network-zone">
		<div id="osinserver-network-datagrid-out">
			<table id="osinserver-network-datagrid"></table>
		</div>
	</div>
		
		
	<div id="osinserver-gotop" title="回到顶部"></div>
	<div id="osinserver-go-usage" title="跳转至利用率"></div>
	<div id="osinserver-go-computeindex" title="跳转至虚拟机计算指标"></div>
	<div id="osinserver-go-network" title="跳转至虚机你网络指标"></div>
		
		
	<div id="osinserver-bottom"></div>
	
	
	
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/openstack/osRunOverviewStatus.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/openstack/osRunOverviewUsage.js"></script>
	<%-- <script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/openstack/osRunOverviewDisk.js"></script> --%>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/openstack/osRunOverviewIndex.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/runOverview/openstack/osRunOverviewNetwork.js"></script>
</body>
</html>
