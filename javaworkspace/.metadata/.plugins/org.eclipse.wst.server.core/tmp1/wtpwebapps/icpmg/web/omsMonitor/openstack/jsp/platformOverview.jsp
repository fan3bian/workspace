<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>OpenStack平台监控</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	
	<script type="text/javascript" charset="UTF-8">
  		var context_path = '${pageContext.request.contextPath}';
  	</script>
  	<style type="text/css">
  			
  			#vplat-select-zone
  			{
  				overflow:hidden;
  				width:500px;
  			}
  			
  			#os-vplat-select--title
  			{
  				float:left;
				margin-left: 40px;
				margin-top: 20px;
				margin-bottom: 20px;
  			}
  			#vplat-title
  			{
				width: 178px;
				background-color: #EBCFCF;
				color: #A94442;
				font-size:15px;
				padding: 7px;
				font-weight: bold;
				border-radius: .25em;
  			}
  			
  			#vplat-wrap
  			{
  				overflow:hidden;
  				float:left;
				width:220px;
				margin-top: 19px;
				margin-left: 27px;
				margin-bottom: 20px;
  			}
  			

			#os-com-health-zone
			{
				overflow:hidden;
				clear:both;
				width: 1100px;
				height: 150px;
				margin-left: 20px;
				margin-bottom: 10px;
				/*background-color: pink;*/
			}
				#os-com-health-title
				{
					margin-left: 20px;
					margin-top: 10px;
					margin-bottom: 10px;
				}
				#health-title
				{
					width: 178px;
					background-color: #D0E8C5;
					color: #3C763D;
					font-size:15px;
					padding: 7px;
					font-weight: bold;
					border-radius: .25em;
				}
				.os-com
				{
					height: 50px;
					width: 180px;
					margin-top: 10px;
					margin-left: 30px;
					background-color: #c5c5c5;
					float: left;
				}
				
				#os-com-keystone
				{
					margin-left: 33px;
					width:187px; 
				}
			
				#nova-span,#neutron-span,#cinder-span,#glance-span,
				#keystone-span
				{
					float: left;
					margin-left: 12%;
					margin-top: 14px;
					font-weight: bold;
					font-size: 15px;
					color: #fff;
				}
				
				.com-status
				{
					float: left;
					height: 34px;
					width: 34px;
					margin-left: 10%;
					margin-top: 8px;
					/*background-color: red;*/
					background-image: url(${pageContext.request.contextPath}/web/omsMonitor/openstack/img/unknown.png);
				}
				

				
/********************************************************************************************/


			#os-vm-zone-label
			{
				clear:both;
				margin-left: 40px;
				margin-bottom: 25px;
			}
			#os-vm-span-label
			{
				background-color: #C4E3F2;
				color: #31708F;
				width: 178px;
				font-size:15px;
				padding: 7px;
				font-weight: bold;
				margin-top: 30px;
				border-radius: .25em;	
			}

			#os-vm-zone
			{
				overflow:hidden;
				width: 1100px;
				height: 160px;
				margin-top: 0;
				margin-left: 35px;
				/* background-color: dodgerblue; */
			}
			
				.vm-status-zone
				{
					float: left;
					height: 126px;
					width: 195px;
					margin-top: 0px;
					margin-left: 14px;
					/* background-color: greenyellow; */
					background-image: url(${pageContext.request.contextPath}/web/omsMonitor/openstack/img/os-vm-bg.png);
				}
				.vm-status-zone:hover
				{
				 	border-style:solid;
					border-width:2px;
					border-color:#5BC0DE;
					cursor:pointer;
					background-image: url(${pageContext.request.contextPath}/web/omsMonitor/openstack/img/os-vm-bg-hover.png);
				}
				
				#os-vm-zone-title
				{
					background-image: url(${pageContext.request.contextPath}/web/omsMonitor/openstack/img/os-vm-title.png);
				}
				#os-vm-zone-title:hover
				{
					border:none;
				}
				#os-vm-title-span
				{
					margin-left: 35%;
					margin-top: 50px;
					font-size:20px;
					font-weight: bold;
					color: #fff;
				}
				.vm-status-title
				{
					float: left;
					margin-left: 10px;
					margin-top: 10px;
					font-size: 16px;
					font-weight: bold;
					color: #5E5E5E;
				}
				.vm-status-val
				{
					float: right;
					margin-top: 30px;
					margin-right: 20px;
					font-weight: bold;
					font-size: 30px;
				}
/***************************************************************************************************/

			#os-index-title
			{
				margin-left: 40px;
				margin-bottom: 20px;
			}
			#index-title
			{
				background-color: #FAF3D2;
				color: #8A6D3B;	
				width: 178px;
				font-size:15px;
				padding: 7px;
				font-weight: bold;
				border-radius: .25em;	
			}

			.os-index-zone
			{
				/* height: 600px; */
				/* width: 85%; */
				width: 1030px;
				/* background-color: yellow; */
				margin-left: 30px;
				margin-top: 0;
			}	
			
			.index-header
			{
				margin-left: 20px;
				width: 100%;
			}
			
			#vcpu-wrap,#vmem-wrap,#vdisk-wrap
			{
				width:200px;
				margin-top: 30px;
				margin-bottom: 20px;
			}
			
			#vcpu-time-comobox,#vmem-time-comobox,#vdisk-time-comobox
			{
				height: 70px;
				width: 100px;
			}
			
			#vcpu-index-chart,#vmem-index-chart,#vdisk-index-chart
			{
				margin-top: 10px;
				margin-left: 18px;
				height: 400px;
				width: 100%;
			}
/******************************************************************************************************/			
			#page-bottom-space
			{
				margin-bottom: 50px;
			}
								
  	</style>
  	
  	<div id="vplat-select-zone">
  		<div id="os-vplat-select--title">
			 <div id="vplat-title">OpenStack平台选择 &nbsp;&nbsp;:</div>
		</div>
  		<div id="vplat-wrap" title="OpenStack平台选择">
			<input id="vplat-comobox" />
		</div>
	</div>
	
	<div id="os-com-health-zone">
		<hr style="width:100%;margin: 20px;margin-top: 10px;color:#EEEEEE"/>
		<div id="os-com-health-title">
			 <div id="health-title">OpenStack组件健康监控</div>
		</div>
		<div id="os-com-nova" class="os-com">
			<div id="nova-status" class="com-status"></div>
			<div id="nova-span">Nova</div>
		</div>
		<div id="os-com-neutron" class="os-com">
			<div id="neutron-status" class="com-status"></div>
			<div id="neutron-span">Neutron</div>
		</div>
		<div id="os-com-cinder" class="os-com">
			<div id="cinder-status" class="com-status"></div>
			<div id="cinder-span">Cinder</div>
		</div>
		<div id="os-com-glance" class="os-com">
			<div id="glance-status" class="com-status"></div>
			<div id="glance-span">Glance</div>
		</div>

		<div id="os-com-keystone" class="os-com">
			<div id="keystone-status" class="com-status"></div>
			<div id="keystone-span">Keystone</div>
		</div>
	</div>
	
	<div id="os-vm-zone-label">
		<div id="os-vm-span-label">OpenStack虚机实例统计</div>
	</div>
	<div id="os-vm-zone">
		<div class="vm-status-zone" id="os-vm-zone-title">
			<div id="os-vm-title-span">虚拟机统计</div>
		</div>
		<div class="vm-status-zone" id="os-vm-total" title="虚拟机总数">
			<div class="vm-status-title">总数</div>
			<div style="color: #44A7FA;" class="vm-status-val"></div>
		</div>
		<div class="vm-status-zone" id="os-vm-error" title="故障的虚拟机数量">
			<div class="vm-status-title">故障数</div>
			<div style="color:#F94244;" class="vm-status-val"></div>
		</div>
		<div class="vm-status-zone" id="os-vm-stop" title="处于暂停状态的虚拟机数量">
			<div class="vm-status-title">暂停数</div>
			<div style="color:#F8CD43;" class="vm-status-val"></div>
		</div>
		<div class="vm-status-zone" id="os-vm-running" title="处于运行状态的虚拟机数量">
			<div class="vm-status-title">运行数</div>
			<div style="color:#19CF6A;" class="vm-status-val"></div>
		</div>
	</div>

	<div id="os-index-title">
		<div id="index-title">OpenStack平台资源监控</div>
	</div>
	<div id="os-vcpu-zone" class="os-index-zone">
			<div class="index-header">
				<div id="vcpu-wrap" title="时间范围选择">
					<input id="vcpu-time-comobox" />
				</div>
			</div>
			<div id="vcpu-index-chart"></div>
			
			<hr style="width:100%;margin: 20px;"/>
			<div class="index-header">
			<div id="vmem-wrap" title="时间范围选择" >
				<input id="vmem-time-comobox" />
				</div>
			</div>
			<div id="vmem-index-chart"></div>
			<hr style="width:100%;margin: 20px;"/>
			
			<div class="index-header">
				<div id="vdisk-wrap" title="时间范围选择">
					<input id="vdisk-time-comobox" />
				</div>
			</div>
			<div id="vdisk-index-chart"></div>
	</div>
	<div id="page-bottom-space"></div>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
	<script src="${pageContext.request.contextPath}/web/omsMonitor/openstack/js/platformOverview.js"></script>
</body>
</html>
