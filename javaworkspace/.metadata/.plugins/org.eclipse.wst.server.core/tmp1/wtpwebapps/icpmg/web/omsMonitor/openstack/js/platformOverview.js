(function($){
	
	var platformid = 'lord';
	var os_component_health_action = context_path + "/os_ploverview/getOSComHealth.do";
	var os_vm_summary_action =  context_path + "/os_ploverview/getOSVMSummary.do";
	var os_vresource_action =  context_path + "/os_ploverview/getVResourceSummary.do";
	var os_vplatform_action =  context_path + "/os_ploverview/getPlatformList.do";
	
//	var os_process_nova =  context_path + "/os_ploverview/getPlatformList.do";
	
	
	
/***********************************************************************************************/
/**
 * 初始化平台
 */
	$('#vplat-comobox').combobox({    
	    valueField:'platformid',    
	    textField:'platformname',
	    url:os_vplatform_action,
		width:'100%',
		height:'40px',
	    onLoadSuccess:function(data){
	    	//设置第一个平台为默认选择
	    	$('#vplat-comobox').combobox("select",data[0].platformid);
	    	platformid = data[0].platformid;
	    },
	    onSelect:function(row){    
	    	platformid = row.platformid;
	    	loadOSPlatData();
	        
	    }
	});  
	
var loadOSPlatData = function ()
{
/***********************************************************************************************/
/**
 * 获取组件健康度
 */

	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{platformid:platformid},
		url:os_component_health_action,
		dataType:'json',
		success:
			function(ret)
			{
				var novaHealth = ret.novaHealth;
				var neutronHealth = ret.neutronHealth;
				var cinderHealth = ret.cinderHealth;
				var glanceHealth = ret.glanceHealth;
				var keystoneHealth = ret.keystoneHealth;
				
				var novaDescription = ret.novaDescription;
				var neutronDescription = ret.neutronDescription;
				var cinderDescription = ret.cinderDescription;
				var glanceDescription = ret.glanceDescription;
				var keystoneDescription = ret.keystoneDescription;
				
				InitComHealth('nova', novaHealth,novaDescription);
				InitComHealth('neutron', neutronHealth,neutronDescription);
				InitComHealth('cinder', cinderHealth,cinderDescription);
				InitComHealth('glance', glanceHealth,glanceDescription);
				InitComHealth('keystone', keystoneHealth,keystoneDescription);
			}
	});
	
	function InitComHealth(componentName,componentHealth,componentDescription)
	{
		switch(componentHealth)
		{
			case 'unknown':
			{

				$('#os-com-' + componentName).prop('title','健康状态：未知\n' + componentDescription);
				$('#os-com-' + componentName).css({"background-color":"#c5c5c5"});
				$('#os-com-' + componentName).hover
				(
					      function () 
					      {
					          $(this).css(
					        	{
					        		"background-color":"#c5c5c5",
					        	    'filter':'alpha(opacity=60)',  
					            	'-moz-opacity':'0.6',
					            	'-khtml-opacity': '0.6',  
					            	'opacity': '0.6',
									'cursor':'pointer'
					        	}
					          );
					      },
					      function () 
					      {
					    	  $(this).css(
							        	{
							        		"background-color":"#c5c5c5",
							        	    'filter':'alpha(opacity=100)',  
							            	'-moz-opacity':'1',
							            	'-khtml-opacity': '1',  
							            	'opacity': '1',
							            	'cursor':'pointer'
							        	}
					    	  );
					      }
				);
				
				$('#'+ componentName +'-status').css({background:
					"url(" + context_path + "/web/omsMonitor/openstack/img/unknown.png)"});
				break;
			}	
			case 'error':
			{
				$('#os-com-' + componentName).prop('title','健康状态：故障\n故障信息：' + componentDescription);
				$('#os-com-' + componentName).css({
						background:"#EFAD4D"
					}
				);
				$('#os-com-' + componentName).hover
				(
					      function () 
					      {
					          $(this).css(
					        	{
					        		"background-color":"#EFAD4D",
					        	    'filter':'alpha(opacity=60)',  
					            	'-moz-opacity':'0.6',
					            	'-khtml-opacity': '0.6',  
					            	'opacity': '0.6',
					            	'cursor':'pointer'
					        	}
					          );
					      },
					      function () 
					      {
					    	  $(this).css(
							        	{
							        		"background-color":"#EFAD4D",
							        	    'filter':'alpha(opacity=100)',  
							            	'-moz-opacity':'1',
							            	'-khtml-opacity': '1',  
							            	'opacity': '1',
							            	'cursor':'pointer'
							        	}
					    	  );
					      }
				);
				$('#'+ componentName +'-status').css({background:
					"url(" + context_path + "/web/omsMonitor/openstack/img/error.png)"});
				break;
			}
			default:
			{
				$('#os-com-' + componentName).prop('title','健康状态：健康\n组件日志：' + componentDescription);
				$('#os-com-' + componentName).css({
						background:"#5CB85C"
					}
				);
				$('#os-com-' + componentName).hover
				(
					      function () 
					      {
					          $(this).css(
					        	{
					        		"background-color":"#5CB85C",
					        	    'filter':'alpha(opacity=60)',  
					            	'-moz-opacity':'0.6',
					            	'-khtml-opacity': '0.6',  
					            	'opacity': '0.6',
					            	'cursor':'pointer'
					        	}
					          );
					      },
					      function () 
					      {
					    	  $(this).css(
							        	{
							        		"background-color":"#5CB85C",
							        	    'filter':'alpha(opacity=100)',  
							            	'-moz-opacity':'1',
							            	'-khtml-opacity': '1',  
							            	'opacity': '1',
							            	'cursor':'pointer'
							        	}
					    	  );
					      }
				);
				$('#'+ componentName +'-status').css({background:
				"url(" + context_path + "/web/omsMonitor/openstack/img/health.png)"});
				break;
			}
		}
	}
	
	
/***********************************************************************************************/
/**
 * 获取虚机状态统计情况
 */
	
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{platformid:platformid},
		url:os_vm_summary_action,
		dataType:'json',
		success:
			function(ret)
			{
				var runningvm = ret.runningvm;
				var errorvm = ret.errorvm;
				var pausevm = ret.pausevm;
				var totalvm = ret.totalvm;
				setOSVMSummary("total", totalvm);
				setOSVMSummary("running", runningvm);
				setOSVMSummary("error", errorvm);
				setOSVMSummary("stop", pausevm);
			}
	});
	
	function setOSVMSummary(stat,num)
	{
		$('#os-vm-'+ stat +' >  .vm-status-val').empty();
		$('#os-vm-'+ stat +' >  .vm-status-val').append(num);
	}
	
	
/***********************************************************************************************
 * 时间力度选择
 */
	
	$('#vcpu-time-comobox').combobox({    
	    valueField:'type',    
	    textField:'text',
    	data: [{
			type: '1',
			text: '        最近一天',
			selected:true
		},{
			type: '7',
			text: '        最近一周'
		},{
			type: '14',
			text: '        最近两周'
		},{
			type: '30',
			text: '        最近一个月'
		}
		],
		width:'100%',
		height:'40px',
	    onSelect:function(row){    
	    	
	    	$.ajax
	    	({
	    	 	type : 'post',
	    		async:true, 
	    		data:{platformid:platformid,timeField:row.type},
	    		url:os_vresource_action,
	    		dataType:'json',
	    		success:
	    			function(ret)
	    			{
	    				//重载vcpu资源监控图表
	    				$('vcpu-index-chart').empty();
	    				vCpuChartOption.series[0].data = ret.vcpuTotalList;
	    				vCpuChartOption.series[1].data = ret.vcpuUsedList;
	    				vCpuChartOption.xAxis.data = ret.timeList;		    
	    				vCpuChart = echarts.init(document.getElementById('vcpu-index-chart'));
	    				vCpuChart.setOption(vCpuChartOption);
	    				
	    			}
	    	});
	        
	        
	    }
	});  

/***********************************************************************************************/	
	
	$('#vmem-time-comobox').combobox({    
	    valueField:'type',    
	    textField:'text',
    	data: [{
			type: '1',
			text: '        最近一天',
			selected:true
		},{
			type: '7',
			text: '        最近一周'
		},{
			type: '14',
			text: '        最近两周'
		},{
			type: '30',
			text: '        最近一个月'
		}
		],
		width:'100%',
		height:'40px',
	    onSelect:function(row){    
	    	
	    	$.ajax
	    	({
	    	 	type : 'post',
	    		async:true, 
	    		data:{platformid:platformid,timeField:row.type},
	    		url:os_vresource_action,
	    		dataType:'json',
	    		success:
	    			function(ret)
	    			{
						$('vmem-index-chart').empty();
						vMemChartOption.series[0].data = ret.memoryList;
						vMemChartOption.series[1].data = ret.memoryUsedList;
						vMemChartOption.xAxis.data = ret.timeList;		    
						vMemChart = echarts.init(document.getElementById('vmem-index-chart'));
						vMemChart.setOption(vMemChartOption);
	    			}
	    	});
	        
	    }
	});  
	
/***********************************************************************************************/		
	$('#vdisk-time-comobox').combobox({    
	    valueField:'type',    
	    textField:'text',
    	data: [{
			type: '1',
			text: '        最近一天',
			selected:true
		},{
			type: '7',
			text: '        最近一周'
		},{
			type: '14',
			text: '        最近两周'
		},{
			type: '30',
			text: '        最近一个月'
		}
		],
		width:'100%',
		height:'40px',
	    onSelect:function(row){    
	    	$.ajax
	    	({
	    	 	type : 'post',
	    		async:true, 
	    		data:{platformid:platformid,timeField:row.type},
	    		url:os_vresource_action,
	    		dataType:'json',
	    		success:
	    			function(ret)
	    			{
						$('vdisk-index-chart').empty();
						vDiskChartOption.series[0].data = ret.diskTotalList;
						vDiskChartOption.series[1].data = ret.diskUsedList;
						vDiskChartOption.xAxis.data = ret.timeList;		    
						vDiskChart = echarts.init(document.getElementById('vdisk-index-chart'));
						vDiskChart.setOption(vDiskChartOption);
	    			}
	    	});
	        
	    }
	});  
	
/***********************************************************************************************
 * VCPU统计
 */	
//    var vCpuChart = echarts.init(document.getElementById('vcpu-index-chart'));
    
    var xdata = ["2016-05-16 11:35:00","2016-05-16 11:40:00","2016-05-16 11:45:00","2016-05-16 11:50:00","2016-05-16 11:55:00","2016-05-16 12:00:00","2016-05-16 12:05:00",
 				"2016-05-16 12:10:00","2016-05-16 12:15:00","2016-05-16 12:20:00","2016-05-16 12:25:00"];
    var vcpuTotalData = [80,80,80,80,80,80,80,90,90,90,90,90];
 	var vcpuUsedData = [78,65,72,61,44,59,44,34,65,42,34];
    
    var vCpuChartOption = 
    {
	    	title: 
	        {
	            text: '平台总VCPU数量',
	            textStyle:
            	{
	            	color:'#666',
	            	size:'16'
            	}
	        },
	        tooltip: 
	        {
	        	trigger: 'axis'
	        },
	        legend:
	        {
	            data:["VCPU总数","已分配数"],
                textStyle: 
                {
                	color:'#666',
                    fontWeight:'bold'
                }
	        },
	        toolbox: 
	        {
	            show : true,
	            feature : {
	                mark : {show: true},
	                dataView : {show: true, readOnly: false},
	                restore : {show: true},
	                saveAsImage : {show: true}
	            }
	        },
	      	dataZoom : 
	      	{
		        show : true
	    	},
	        xAxis: 
	        {
	        	name:'时间',
	            type: 'category',
	            boundaryGap : false,
	        	nameTextStyle : 
                {
	        		fontWeight:'bold'
                },
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                },
	            data: xdata
	        },
	    	yAxis: 
	        {
	        	show:true,
	        	name:'数量/个',
	        	position:'left',
	        	nameLocation:'end',
	        	splitNumber:10,
	        	type : 'value',
	        	nameTextStyle : 
                {
	        		fontWeight:'bold'
                },
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                }
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'无监控数据',
	        	effect:'ring',
	        	textStyle:
	        	{
	        		fontSize:'20',
	        		fontWeight:'bold'
	        	}
	        },
	        series: 
	        [
	        	{
		            name: 'VCPU总数',
		            type: 'line',
		            smooth:true,
		            //itemStyle: {normal: {areaStyle: {type: 'default'}}},
		            data: vcpuTotalData
	        	},
	        	{
	        		name:'已分配数',
	        		type: 'line',
	        		smooth:true,
	        		itemStyle: {normal: {areaStyle: {type: 'default'}}},
	        		data: vcpuUsedData
	        	}
	        	
	        ]
	    };
    
//    vCpuChart.setOption(vCpuChartOption);
/********************************************************************************************
 * 
 */	
//    var vMemChart = echarts.init(document.getElementById('vmem-index-chart'));
    
    var xdata = ["2016-05-16 11:35:00","2016-05-16 11:40:00","2016-05-16 11:45:00","2016-05-16 11:50:00","2016-05-16 11:55:00","2016-05-16 12:00:00","2016-05-16 12:05:00",
 				"2016-05-16 12:10:00","2016-05-16 12:15:00","2016-05-16 12:20:00","2016-05-16 12:25:00"];
    var vMemTotalData = [800,800,800,800,800,800,800,900,900,900,900,900];
 	var vMemUsedData = [280,250,202,210,104,109,340,340,750,120,340];
    
    var vMemChartOption = 
    {
	    	title: 
	        {
	            text: '平台内存资源总量监控',
	            textStyle:
            	{
	            	color:'#666',
	            	size:'16'
            	}
	        },
	        tooltip: 
	        {
	        	trigger: 'axis'
	        },
	        legend:
	        {
	            data:["内存总量","已分配量"],
                textStyle: 
                {
                	color:'#666',
                    fontWeight:'bold'
                }
	        },
	        toolbox: 
	        {
	            show : true,
	            feature : {
	                mark : {show: true},
	                dataView : {show: true, readOnly: false},
	                restore : {show: true},
	                saveAsImage : {show: true}
	            }
	        },
	      	dataZoom : 
	      	{
		        show : true
	    	},
	        xAxis: 
	        {
	        	name:'时间',
	            type: 'category',
	            boundaryGap : false,
	        	nameTextStyle : 
                {
//	            	color:'#666',
	        		fontWeight:'bold'
                },
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                },
	            data: xdata
	        },
	    	yAxis: 
	        {
	        	show:true,
	        	name:'空间占用/MB',
	        	position:'left',
	        	nameLocation:'end',
	        	splitNumber:10,
	        	type : 'value',
	        	nameTextStyle : 
                {
	        		fontWeight:'bold'
                },
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                }
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'无监控数据',
	        	effect:'ring',
	        	textStyle:
	        	{
	        		fontSize:'20',
	        		fontWeight:'bold'
	        	}
	        },
	        series: 
	        [
	        	{
		            name: '内存总量',
		            type: 'line',
		            smooth:true,
		            itemStyle: 
		            {
		            	normal: 
		            	{
		            		color:'#87CEFA',
		            	}
		            },
		            data: vMemTotalData
	        	},
	        	{
	        		name: '已分配量',
	        		type: 'line',
	        		smooth:true,
		            itemStyle: 
		            {
		            	normal: 
		            	{
		            		color:'#FF7F50',
		            		areaStyle: {type: 'default'}
		            	}
		            },
	        		data: vMemUsedData
	        	}
	        	
	        ]
	    };
    
//    vMemChart.setOption(vMemChartOption);
/********************************************************************************************
 * 平台磁盘图表
 */	
//    var vDiskChart = echarts.init(document.getElementById('vdisk-index-chart'));
    
    var xdata = ["2016-05-16 11:35:00","2016-05-16 11:40:00","2016-05-16 11:45:00","2016-05-16 11:50:00","2016-05-16 11:55:00","2016-05-16 12:00:00","2016-05-16 12:05:00",
 				"2016-05-16 12:10:00","2016-05-16 12:15:00","2016-05-16 12:20:00","2016-05-16 12:25:00"];
    var vDiskTotalData = [800,800,800,800,800,800,800,900,900,900,900,900];
 	var vDiskUsedData = [280,250,202,210,104,109,340,340,750,120,340];
    
    var vDiskChartOption = 
    {
	    	title: 
	        {
	            text: '平台磁盘存储资源总量监控',
	            textStyle:
            	{
	            	color:'#666',
	            	size:'16'
            	}
	        },
	        tooltip: 
	        {
	        	trigger: 'axis'
	        },
	        legend:
	        {
	            data:["总磁盘存储","已分配量"],
                textStyle: 
                {
                	color:'#666',
                    fontWeight:'bold'
                }
	        },
	        toolbox: 
	        {
	            show : true,
	            feature : {
	                mark : {show: true},
	                dataView : {show: true, readOnly: false},
//	                magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
	                restore : {show: true},
	                saveAsImage : {show: true}
	            }
	        },
	      	dataZoom : 
	      	{
		        show : true
	    	},
	        xAxis: 
	        {
	        	name:'时间',
	            type: 'category',
	            boundaryGap : false,
	        	nameTextStyle : 
                {
//    	            	color:'#666',
	        		fontWeight:'bold'
                },
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                },
	            data: xdata
	        },
	    	yAxis: 
	        {
	        	show:true,
	        	name:'空间占用/GB',
	        	position:'left',
	        	nameLocation:'end',
	        	splitNumber:10,
	        	type : 'value',
	        	nameTextStyle : 
                {
//    	            	color:'#666',
	        		fontWeight:'bold'
                },
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                }
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'无监控数据',
	        	effect:'ring',
	        	textStyle:
	        	{
	        		fontSize:'20',
	        		fontWeight:'bold'
	        	}
	        },
	        series: 
	        [
	        	{
		            name: '总磁盘存储',
		            type: 'line',
		            smooth:true,
		            itemStyle: 
		            {
		            	normal: 
		            	{
		            		color:'#2EC7C9',
		            	}
		            },
		            data: vDiskTotalData
	        	},
	        	{
	        		name: '已分配量',
	        		type: 'line',
	        		smooth:true,
		            itemStyle: 
		            {
		            	normal: 
		            	{
		            		color:'#BBA8E0',
		            		areaStyle: {type: 'default'}
		            	}
		            },
	        		data: vDiskUsedData
	        	}
	        	
	        ]
	    };
    
//    vDiskChart.setOption(vDiskChartOption);    
/********************************************************************************************/
/**
 * 载入虚拟化资源数据
 */
    
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{platformid:platformid,timeField:'1'},
		url:os_vresource_action,
		dataType:'json',
		success:
			function(ret)
			{
				//重载vcpu资源监控图表
				$('vcpu-index-chart').empty();
				vCpuChartOption.series[0].data = ret.vcpuTotalList;
				vCpuChartOption.series[1].data = ret.vcpuUsedList;
				vCpuChartOption.xAxis.data = ret.timeList;		    
				vCpuChart = echarts.init(document.getElementById('vcpu-index-chart'));
				vCpuChart.setOption(vCpuChartOption);
				
				$('vmem-index-chart').empty();
				vMemChartOption.series[0].data = ret.memoryList;
				vMemChartOption.series[1].data = ret.memoryUsedList;
				vMemChartOption.xAxis.data = ret.timeList;		    
				vMemChart = echarts.init(document.getElementById('vmem-index-chart'));
				vMemChart.setOption(vMemChartOption);
				
				$('vdisk-index-chart').empty();
				vDiskChartOption.series[0].data = ret.diskTotalList;
				vDiskChartOption.series[1].data = ret.diskUsedList;
				vDiskChartOption.xAxis.data = ret.timeList;		    
				vDiskChart = echarts.init(document.getElementById('vdisk-index-chart'));
				vDiskChart.setOption(vDiskChartOption);
			}
	});
    
    
/********************************************************************************************/    
};    

/********************************************************************************************/
/**
 * Nova进程监控 
 */
//
//		$('#').dialog({    
//		title: 'Nova关键进程监控',    
//		width: 500,    
//		height: 300,    
//		closed: true,    
//		cache: false,    
//		href: addPingConfig_path,    
//		modal: true,
//		onBeforeOpen:function(){
//			
//		    }
//		}); 


    
})(jQuery);