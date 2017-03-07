(function($){
	
//	var neid = "于颜华-small";
	var neid = inserver_neid ;
	var inserver_status_action = context_path + "/inserver_runoverview/getInserverRunStatus.do";
	var inserver_alarmnum_action = context_path + "/inserver_runoverview/getInserverRunAlarm.do";
	var inserver_useage_action = context_path + "/inserver_runoverview/getInserverUseage.do";
	var inserver_index_action = context_path + "/inserver_runoverview/getInserverIndexData.do";
	var inserver_disk_action = context_path + "/inserver_runoverview/getInserverDiskData.do";
	var inserver_disk_mount_action = context_path + "/inserver_runoverview/getInserverDiskSize.do";

/********************************************************************************************
 *跳转至详情 
 */
	
	$('#inserver-more').click(function(){
		pass_neid = neid;
		$('#centerTab').panel({
			href:'/icpmg/web/omsMonitor/inserver/jsp/inserverDetails.jsp',
			queryParams:{
				neid:pass_neid
			 }
			});	
	});
	
/********************************************************************************************
/*
 *  加载健康状态、计费状态、设备名称、IP地址
 */

	function setStatusMessage(healthStatus,feeStatus,nename,ipaddr)
	{
		if(healthStatus == "1")
		{
			$("#inserver-health").css('background-position','0 0');
		}	

		$("#inserver-nename").empty();
		$("#inserver-nename").append("云服务器名称 : &nbsp;&nbsp;&nbsp" + neid);
		$("#inserver-ipaddr").empty();
		$("#inserver-ipaddr").append("云服务器IP地址 : " + ipaddr);
	}	
	
	function setStatusTime(day,hour,minute)
	{
		$("#inserver-day").empty();
		$("#inserver-day").append(day);
		$("#inserver-hour").empty();
		$("#inserver-hour").append(hour);
		$("#inserver-min").empty();
		$("#inserver-min").append(minute);
	}

/***************************************************************************************************
/**
 * 加载告警数量、正常运行时间
 */	
	
	//获取状态信息及时间信息
	$.ajax
		({
		 	type : 'post',
			async:true, 
			data:{neid:neid},
			url:inserver_status_action,
			dataType:'json',
			success:
				function(ret)
				{
					setStatusMessage(ret.opstat,ret.feestat,ret.nename,ret.ipaddr);
					setStatusTime(ret.day,ret.hour,ret.minute);
				}
		});
	
	//获取对应设备的告警数量
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{neid:neid},
		url:inserver_alarmnum_action,
		dataType:'json',
		success:
			function(ret)
			{
				$("#inserver-alarm-num").empty();
				$("#inserver-alarm-num").append('&nbsp;' + ret + '&nbsp;');
			}
	});
	
/**************************************************************************************************
 * cpu利用率图表
 */	
	
	var cpuGaugeChart = echarts.init(document.getElementById('inserver-cpu-zone'));
	var cpuGaugeOption = {
			title : {
		        text: '云服务器及宿主机CPU利用率',
		        x:'left',
		        y:'top',
	            textStyle:
	        	{
	            	color:'#666'
	        	}
    		},
		    tooltip : {
		        formatter: "{a}: {c}%"
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
	        noDataLoadingOption:
	        {
	        	text:'无监控数据',
	        	effect:'ring',
	        	textStyle:
	        	{
	        		fontSize:'18',
	        		fontWeight:'bold'
	        	}
	        },
		    backgroundColor:'white',
		    series : [
		        {
		            name:'云服务器cpu利用率',
		            type:'gauge',
		            center : ['30%', '60%'],    
		            radius : [0, '66%'],
		            startAngle: 220,
		            endAngle : -40,
		            min: 0,
		            max: 100,
		            precision: 0,
		            splitNumber: 10,
		            axisLine: {
		                show: true,
		                lineStyle: {
		                    color: [[0.2, 'lightgreen'],[0.4, 'skyblue'],[0.8, 'orange'],[1, '#ff4500']], 
		                    width: 30
		                }
		            },
		            axisTick: {
		                show: true,
		                splitNumber: 5,
		                length :3,
		                lineStyle: {
		                    color: '#eee',
		                    width: 1,
		                    type: 'solid'
		                }
		            },
		            axisLabel: {
		                show: true,
		                formatter: function(v){
		                    switch (v+''){
		                        case '10': return '弱';
		                        case '30': return '低';
		                        case '60': return '中';
		                        case '90': return '高';
		                        default: return '';
		                    }
		                },
		                textStyle: {
		                    color: '#333'
		                }
		            },
		            splitLine: {
		                show: true,
		                length :30, 
		                lineStyle: {
		                    color: '#eee',
		                    width: 2,
		                    type: 'solid'
		                }
		            },
		            pointer : {
		                length : '80%',
		                width : 8,
		                color : 'auto'
		            },
		            title : {
		                show : true,
		                offsetCenter: ['-65%', -10], 
		                textStyle: {  
		                    color: '#333',
		                    fontSize : 15
		                }
		            },
		            detail : {
		                show : true,
		                backgroundColor: 'rgba(0,0,0,0)',
		                borderWidth: 0,
		                borderColor: '#ccc',
		                width: 100,
		                height: 40,
		                offsetCenter: ['0%', 50],
		                formatter:'\n{value}%\n\n云服务器',
		                textStyle: { 
		                    color: '#333',
		                    fontSize : 20
		                }
		            },
		            data:[]
		        },
		        {
		            name:'物理机cpu利用率',
		            type:'gauge',
		            center : ['75%', '60%'],
		            radius : [0, '50%'],
		            startAngle: 220,
		            endAngle : -40,
		            min: 0,
		            max: 100,
		            precision: 0,
		            splitNumber: 10,            
		            axisLine: { 
		                show: true,        
		                lineStyle: {       
		                	color: [[0.2, 'lightgreen'],[0.4, 'skyblue'],[0.8, 'orange'],[1, '#ff4500']], 
		                    width: 30
		                }
		            },
		            axisTick: {
		                show: true,
		                splitNumber: 5,
		                length :3,
		                lineStyle: {
		                    color: '#eee',
		                    width: 1,
		                    type: 'solid'
		                }
		            },
		            axisLabel: {
		                show: true,
		                formatter: function(v){
		                    switch (v+''){
		                        case '10': return '弱';
		                        case '30': return '低';
		                        case '60': return '中';
		                        case '90': return '高';
		                        default: return '';
		                    }
		                },
		                textStyle: {
		                    color: '#333'
		                }
		            },
		            splitLine: {
		                show: true,
		                length :30,
		                lineStyle: {
		                    color: '#eee',
		                    width: 2,
		                    type: 'solid'
		                }
		            },
		            pointer : {
		                length : '80%',
		                width : 8,
		                color : 'auto'
		            },
		            title : {
		                show : true,
		                offsetCenter: ['-65%', -10],
		                textStyle: {
		                    color: '#333',
		                    fontSize : 15
		                }
		            },
		            detail : {
		                show : true,
		                backgroundColor: 'rgba(0,0,0,0)',
		                borderWidth: 0,
		                borderColor: '#ccc',
		                width: 100,
		                height: 40,
		                offsetCenter: ['0%', 50],
		                formatter:'\n{value}%\n\n宿主机',
		                textStyle: {
		                    color: '#333',
		                    fontSize : 17
		                }
		            },
		            data:[]
		        }
		    ]
		};	
	
/**************************************************************************************************
 * 内存利用率图表
 */	
	var memGaugeChart = echarts.init(document.getElementById('inserver-mem-zone'));
	
	var memGaugeOption = {
			title : {
		        text: '云服务器及宿主机内存占用率',
		        x:'left',
		        y:'top',
	            textStyle:
	        	{
	            	color:'#666'
	        	}
    		},
		    tooltip : {
		        formatter: "{a}: {c}%"
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
	        noDataLoadingOption:
	        {
	        	text:'无监控数据',
	        	effect:'ring',
	        	textStyle:
	        	{
	        		fontSize:'18',
	        		fontWeight:'bold'
	        	}
	        },
		    backgroundColor:'white',
		    series : [
		        {
		            name:'云服务器内存占用率',
		            type:'gauge',
		            center : ['30%', '60%'],    
		            radius : [0, '66%'],
		            startAngle: 220,
		            endAngle : -40,
		            min: 0,
		            max: 100,
		            precision: 0,
		            splitNumber: 10,
		            axisLine: {
		                show: true,
		                lineStyle: {
		                    color: [[0.2, 'lightgreen'],[0.4, 'skyblue'],[0.8, 'orange'],[1, '#ff4500']], 
		                    width: 30
		                }
		            },
		            axisTick: {
		                show: true,
		                splitNumber: 5,
		                length :3,
		                lineStyle: {
		                    color: '#eee',
		                    width: 1,
		                    type: 'solid'
		                }
		            },
		            axisLabel: {
		                show: true,
		                formatter: function(v){
		                    switch (v+''){
		                        case '10': return '弱';
		                        case '30': return '低';
		                        case '60': return '中';
		                        case '90': return '高';
		                        default: return '';
		                    }
		                },
		                textStyle: { 
		                    color: '#333'
		                }
		            },
		            splitLine: { 
		                show: true,
		                length :30, 
		                lineStyle: {
		                    color: '#eee',
		                    width: 2,
		                    type: 'solid'
		                }
		            },
		            pointer : {
		                length : '80%',
		                width : 8,
		                color : 'auto'
		            },
		            title : {
		                show : true,
		                offsetCenter: ['-65%', -10], 
		                textStyle: {  
		                    color: '#333',
		                    fontSize : 15
		                }
		            },
		            detail : {
		                show : true,
		                backgroundColor: 'rgba(0,0,0,0)',
		                borderWidth: 0,
		                borderColor: '#ccc',
		                width: 100,
		                height: 40,
		                offsetCenter: ['0%', 50],     
		                formatter:'\n{value}%\n\n云服务器',
		                textStyle: {     
		                    color: '#333',
		                    fontSize : 20
		                }
		            },
		            data:[]
		        },
		        {
		            name:'物理机内存占用率',
		            type:'gauge',
		            center : ['75%', '60%'],
		            radius : [0, '50%'],
		            startAngle: 220,
		            endAngle : -40,
		            min: 0,
		            max: 100,
		            precision: 0,
		            splitNumber: 10,            
		            axisLine: { 
		                show: true,        
		                lineStyle: {       
		                	color: [[0.2, 'lightgreen'],[0.4, 'skyblue'],[0.8, 'orange'],[1, '#ff4500']], 
		                    width: 30
		                }
		            },
		            axisTick: {
		                show: true,
		                splitNumber: 5,
		                length :3,
		                lineStyle: {
		                    color: '#eee',
		                    width: 1,
		                    type: 'solid'
		                }
		            },
		            axisLabel: {
		                show: true,
		                formatter: function(v){
		                    switch (v+''){
		                        case '10': return '弱';
		                        case '30': return '低';
		                        case '60': return '中';
		                        case '90': return '高';
		                        default: return '';
		                    }
		                },
		                textStyle: {
		                    color: '#333'
		                }
		            },
		            splitLine: {
		                show: true,
		                length :30,
		                lineStyle: {
		                    color: '#eee',
		                    width: 2,
		                    type: 'solid'
		                }
		            },
		            pointer : {
		                length : '80%',
		                width : 8,
		                color : 'auto'
		            },
		            title : {
		                show : true,
		                offsetCenter: ['-65%', -10],
		                textStyle: {
		                    color: '#333',
		                    fontSize : 15
		                }
		            },
		            detail : {
		                show : true,
		                backgroundColor: 'rgba(0,0,0,0)',
		                borderWidth: 0,
		                borderColor: '#ccc',
		                width: 100,
		                height: 40,
		                offsetCenter: ['0%', 50],
		                formatter:'\n{value}%\n\n宿主机',
		                textStyle: {
		                    color: '#333',
		                    fontSize : 17
		                }
		            },
		            data:[]
		        }
		    ]
		};	
	
/**************************************************************************************************
 * 加载利用率
 */
	
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{neid:neid},
		url:inserver_useage_action,
		dataType:'json',
		success:
			function(ret)
			{
				if(ret.vmCpuUsage == '' || ret.vmCpuUsage == undefined || ret.vmCpuUsage == null)
					{
						cpuGaugeOption.series[0].data = [];
						cpuGaugeOption.series[1].data = [];
					}
				else
					{
						cpuGaugeOption.series[0].data = [ret.vmCpuUsage];
						cpuGaugeOption.series[1].data = [ret.hostCpuUsage];
					}
				if(ret.vmMemUsage == '' || ret.vmMemUsage == undefined || ret.vmMemUsage == null)
					{
						memGaugeOption.series[0].data = [];
						memGaugeOption.series[1].data = [];
					}
				else
					{
						memGaugeOption.series[0].data = [ret.vmMemUsage];
						memGaugeOption.series[1].data = [ret.hostMemUsage];
					}
				
				cpuGaugeChart.setOption(cpuGaugeOption);
				memGaugeChart.setOption(memGaugeOption);
			}
	});	
	
	
	
/**************************************************************************************************
 * 
 * 指标图标
 */	
	
	var indexXdata=[];
	var memIndexData=[];
	var diskIndexData=[];
	
	
    var indexChart = echarts.init(document.getElementById('inserver-index-zone'));
    
    var indexLineOption = 
    {
	    	title: 
	        {
	            text: '指标趋势监控',
	            textStyle:
            	{
	            	color:'#666'
            	}
	        },
	        tooltip: 
	        {
	        	trigger: 'axis'
	        },
	        legend:
	        {
	        	textStyle: 
                {
                    color: '#666',
                    fontWeight:'bold'
                },
	            data:["CPU利用率","内存利用率"],
	        },
	        toolbox: 
	        {
	            show : true,
	            feature : {
	                //mark : {show: true},
	                //dataView : {show: true, readOnly: false},
	                //magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
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
	        	nameTextStyle:
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
	            data: indexXdata
	        },
	    	yAxis: 
	        {
	        	show:true,
	        	name:'百分比/%',
	        	position:'left',
	        	nameLocation:'end',
	        	splitNumber:10,
	        	nameTextStyle:
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
	        	type : 'value'
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'未选中任何监控指标',
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
		            name: 'CPU利用率',
		            type: 'line',
		            smooth:true,
		            itemStyle: {normal: {areaStyle: {type: 'default'}}},
		            data: []
	        	},
	        	{
	        		name:'内存利用率',
	        		type: 'line',
	        		smooth:true,
	        		itemStyle: {normal: {areaStyle: {type: 'default'}}},
	        		data: []
	        	}
//	        	{
//	        		name:'磁盘利用率',
//	        		type: 'line',
//	        		smooth:true,
//	        		itemStyle: {normal: {areaStyle: {type: 'default'}}},
//	        		data: []
//	        	}
	        	
	        ]
	    };
	
	
/****************************************************************************************************/
/**
 * 指标列表
 */		
    	
	var cpuIndexFlag = '1';
	var memIndexFlag = '0';
//	var diskIndexFlag = '0';
	$('#inserver-time-cobbox-out').hide('slow');
	
		$.ajax
		({
		 	type : 'post',
			async:true, 
			data:{neid:neid,timeField:1},
			url:inserver_index_action,
			dataType:'json',
			success:
				function(ret)
				{
				$('#inserver-index-list-zone .index-menu .index-list .index-dropdown ').show('slow');
				$('#inserver-time-cobbox-out').show('slow');
					indexXdata = ret.starttimeList;
					cpuIndexData=ret.cpuList;
					memIndexData=ret.memList;
//					diskIndexData=ret.diskList;
					
					$('#cpu-box').prop('checked',true);
					$('#cpu-box').val('1');
					indexChart = echarts.init(document.getElementById('inserver-index-zone'));
					indexLineOption.xAxis.data = ret.starttimeList;
					indexLineOption.series[0].data = ret.cpuList;
			    	indexChart.setOption(indexLineOption);
				}
		});
	
	$(".drop-down-title").click(function(){
		var flag = $(this).children("input").val();
		var indexId = $(this).children("input").attr('id');
		if(flag == '0')
		{
			$(this).children("input").prop('checked',true);
			$(this).children("input").val('1');
		}
		else
		{
			$(this).children("input").prop('checked',false);
			$(this).children("input").val('0');
		}
		
		switch(indexId)
		{
			case 'cpu-box':
			{
				if(cpuIndexFlag == '0')
				{
					cpuIndexFlag = '1';
					indexLineOption.series[0].data = cpuIndexData;
				}
				else
				{
					cpuIndexFlag = '0';
					indexLineOption.series[0].data = [];
				}

				indexChart = echarts.init(document.getElementById('inserver-index-zone'));
				indexChart.setOption(indexLineOption);
				break;
			}
			case 'mem-box':
			{
				if(memIndexFlag == '0')
				{
					memIndexFlag = '1';
					indexLineOption.series[1].data = memIndexData;
				}
				else
				{
					memIndexFlag = '0';
					indexLineOption.series[1].data = [];
				}
				
				indexChart = echarts.init(document.getElementById('inserver-index-zone'));
				indexChart.setOption(indexLineOption);
				break;
			}
//			case 'disk-box':
//			{
//				if(diskIndexFlag == '0')
//				{
//					diskIndexFlag = '1';
//					indexLineOption.series[2].data = diskIndexData;
//				}
//				else
//				{
//					diskIndexFlag = '0';
//					indexLineOption.series[2].data = [];
//				}
//				
//				indexChart = echarts.init(document.getElementById('inserver-index-zone'));
//				indexChart.setOption(indexLineOption);
//				break;
//			}
		}
		
	}); 
/****************************************************************************************************/	
/**
 * 时间范围选择
 */
		$('#inserver-time-cobbox').combobox({    
		    valueField:'type',    
		    textField:'text',
	    	data: 
		    [
		     	{
					type: '1',
					text: '        最近一天',
					selected:true
				},
				{
					type: '7',
					text: '        最近一周'
				},
				{
					type: '14',
					text: '        最近两周'
				},
				{
					type: '30',
					text: '        最近一个月'
				}
			],
			width:'100%',
			height:'40px',
		    onSelect:function(row)
			    {    
					$.ajax
					({
						 	type : 'post',
							async:false, 
							data:{neid:neid,timeField:row.type},
							url:inserver_index_action,
							dataType:'json',
							success:
								function(ret)
								{
									//重置指标列表及标志位
									$(".drop-down-title").children("input").prop('checked',false);
									$(".drop-down-title").children("input").val('0');
									cpuIndexFlag = '1';
									memIndexFlag = '0';

									$('#cpu-box').prop('checked',true);
									$('#cpu-box').val('1');
									                                 
									indexXdata = ret.starttimeList;
									cpuIndexData=ret.cpuList;
									memIndexData=ret.memList;
	
									indexChart = echarts.init(document.getElementById('inserver-index-zone'));
									indexLineOption.xAxis.data = ret.starttimeList;
									indexLineOption.series[0].data = ret.cpuList;
									indexLineOption.series[1].data = [];
							    	indexChart.setOption(indexLineOption);
								}
						});
		        
			    }
		});  

	
/****************************************************************************************************/
/**
 * 磁盘详细信息图标
 */


    
    var diskDetailChart = echarts.init(document.getElementById('inserver-single-disk-zone'));
	var diskDetailXdata = ["disk1","disk2","disk3"];
	var diskUsedData = [5, 20, 36, 10, 10, 20,12,33,42,12];
	var diskUnusedData = [15,50, 66, 100, 120, 220,77,45,78,88];
	
	
    var diskDetailOption = 
    {
	        title: 
	        {
	            text: '挂载磁盘空间占用详情',
	            x:'left',
	            y:'top',
	            textStyle:
            	{
	            	color:'#666'
            	}
	        },
	        tooltip: 
	        {
	        	trigger:'axis',
	        	axisPointer:{
	        		type:'shadow'
	        	}
	        },
	        legend: 
	        {
	            data:['已用空间','未用空间'],
	            x:'center',
	            orient:'horizontal',
                textStyle: 
                {
                    color: '#666',
                    fontWeight:'bold'
                }
	        },
	        xAxis: 
	        {
	        	show:true,
	        	name:'存储空间/G',
	        	type:'value',
	        	nameTextStyle:
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
	        	lineStyle:
	        	{
	        		color: 'red',
	    			width: 2,
	    			type: 'solid'
	        	}
	        },
	        yAxis:
	        {
	        	name:'磁盘名称',
	        	type:'category',
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
                	},
//                	formatter : function(name,value,cvalue)
//                	{
//                		return name.substring(0,10);
//                	} 
                },
	            data: diskDetailXdata
	        	
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'无监控数据',
	        	effect:'ring',
	        	textStyle:
	        	{
	        		fontSize:'15',
	        		fontWeight:'bold'
	        	}
	        },
	        series: 
	        [
	        	{
		            name: '已用空间',
		            type: 'bar',
		            stack: 'cpu',
		            barWidth:30,
		            itemStyle:
		            {
		                normal: 
		                {
		                    color: '#FFB53E',
		                    barBorderColor: '#FFB53E',
		                    barBorderWidth: 5,
		                    barBorderRadius:0,
		                    label :
		                    {
		                        show: false, 
		                        position: 'insideRight',
		                        textStyle: 
		                        {
		                            color: 'white',
		                            fontWeight:'bold'
		                        }
		                    }
		                },
		                emphasis:
		                {
		                	color: '#FFC900',
		                    barBorderColor: '#FFC900',
		                    barBorderWidth: 5,
		                    barBorderRadius:0,
		                    label :
		                    {
		                        show: true, 
		                        position: 'top',
		                        textStyle: 
		                        {
		                            fontWeight:'bold',
		                            color: 'black',	
		                        }
		                    }
		                }
		            },

		            data: diskUsedData
	        	},
	        	{
	        		name:'未用空间',
	        		type: 'bar',
	        		stack: 'cpu',
	        		barWidth:30,
		            itemStyle:
		            {
		            	normal: 
		                {
		                    color: '#5AB1EF',
		                    barBorderColor: '#5AB1EF',
		                    barBorderWidth: 5,
		                    barBorderRadius:0,
		                    label :
		                    {
		                        show: false, 
		                        position: 'insideRight',
		                        textStyle: 
		                        {
		                            color: 'white',
		                            fontWeight:'bold'
		                        }
		                    }
		                },
		                emphasis:
		                {
		                	color: '#7ECEF4',
		                    barBorderColor: '#7ECEF4',
		                    barBorderWidth: 5,
		                    barBorderRadius:0,
		                    label :
		                    {
		                        show: true, 
		                        position: 'top',
		                        textStyle: 
		                        {
		                            fontWeight:'bold',
		                            color:'black'
		                        }
		                    }
		                }
		            },
	        		data: diskUnusedData
	        	}
	        ]
	    };
    
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{neid:neid},
		url:inserver_disk_action,
		dataType:'json',
		success:
			function(ret)
			{
				if(ret.diskName == null || ret.diskName == "" || ret.diskName == []
				|| ret.diskName == undefined )
					{
						$('#inserver-single-device-zone').hide();
						return;
					}
				else
					{
						diskDetailOption.series[0].data = ret.diskUsed;
						diskDetailOption.series[1].data = ret.diskFree;
						diskDetailOption.yAxis.data = ret.diskName;
					    diskDetailChart.setOption(diskDetailOption);
					}	

			}
	});
	
/****************************************************************************************************/
/**
 * 虚拟机所有磁盘容量图表
 */
	    
	var diskSizeChart = echarts.init(document.getElementById('inserver-disk-mount-zone'));
	
	var diskSizeOption = 
    {
	        title: 
	        {
	            text: '所有挂载磁盘容量',
	            x:'left',
	            y:'top',
	            textStyle:
            	{
	            	color:'#666'
            	}
	        },
	        tooltip: 
	        {
	        	trigger:'axis',
	        	axisPointer:{
	        		type:'shadow'
	        	}
	        },
	        legend: 
	        {
	            data:['磁盘总容量'],
	            x:'center',
	            orient:'horizontal',
                textStyle: 
                {
                    color: '#666',
                    fontWeight:'bold'
                }
	        },
	        xAxis: 
	        {
	        	show:true,
	        	name:'存储空间/G',
	        	type:'value',
	        	nameTextStyle:
	        	{
//		            	color:'#666',
	        		fontWeight:'bold'
		        },
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                },
	        	lineStyle:
	        	{
	        		color: 'red',
	    			width: 2,
	    			type: 'solid'
	        	}
	        },
	        yAxis:
	        {
	        	name:'磁盘名称',
	        	type:'category',
	        	nameTextStyle : 
                {
//		            	color:'#666',
	        		fontWeight:'bold'
                },
                axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	},
//	                	formatter : function(name,value,cvalue)
//	                	{
//	                		return name.substring(0,10);
//	                	} 
                },
	            data: []
	        	
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'无磁盘监控数据',
	        	effect:'ring',
	        	textStyle:
	        	{
	        		fontSize:'15',
	        		fontWeight:'bold'
	        	}
	        },
	        series: 
	        [
	        	{
		            name: '磁盘总容量',
		            type: 'bar',
		            stack: 'cpu',
		            barWidth:30,
		            itemStyle:
		            {
		                normal: 
		                {
		                    color: '#FFB53E',
		                    barBorderColor: '#FFB53E',
		                    barBorderWidth: 5,
		                    barBorderRadius:0,
		                    label :
		                    {
		                        show: true, 
		                        position: 'insideRight',
		                        textStyle: 
		                        {
		                            color: 'white',
		                            fontWeight:'bold'
		                        }
		                    }
		                },
		                emphasis:
		                {
		                	color: '#FFC900',
		                    barBorderColor: '#FFC900',
		                    barBorderWidth: 5,
		                    barBorderRadius:0,
		                    label :
		                    {
		                        show: true, 
		                        position: 'insideRight',
		                        textStyle: 
		                        {
		                            fontWeight:'bold'
		                        }
		                    }
		                }
		            },

		            data: []
	        	}
	        ]
	    };

	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{neid:neid},
		url:inserver_disk_mount_action,
		dataType:'json',
		success:
			function(ret)
			{
				diskSizeOption.series[0].data = ret.diskMountList;
				diskSizeOption.yAxis.data = ret.diskNameList;
			    diskSizeChart.setOption(diskSizeOption);
			}
	});
	
	
})(jQuery);