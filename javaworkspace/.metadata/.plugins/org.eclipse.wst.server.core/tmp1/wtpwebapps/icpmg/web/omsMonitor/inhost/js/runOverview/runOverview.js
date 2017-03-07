(function($){

//var neid = "172.23.8.200";
var neid = inhost_neid;
var inhost_status_action = context_path + "/inhost_runoverview/getInhostRunStatus.do";
var inhost_alarmnum_action = context_path + "/inhost_runoverview/getInhostRunAlarm.do";
var inhost_useage_action = context_path + "/inhost_runoverview/getInhostUseage.do";
var inhost_index_action = context_path + "/inhost_runoverview/getInhostIndexData.do";
var inhost_cpu_action = context_path + "/inhost_runoverview/getInhostCpuData.do";
var inhost_disk_action = context_path + "/inhost_runoverview/getInhostDiskData.do";
var inhost_nic_action = context_path + "/inhost_runoverview/getInhostNicData.do";

/********************************************************************************************
 *跳转至详情 
 */

	$('#inhost-more').click(function(){
		var pass_neid = neid;
		var pass_typeid = inhost_typeid;
		if(pass_typeid == 'INHOST')
			{
				$('#centerTab').panel({
					href:'/icpmg/web/omsMonitor/inhost/jsp/inhostDetails.jsp',
					queryParams:{
						neid:pass_neid
					}
					});	
				return;
			}
		if(pass_typeid == 'HOST')
			{
				$('#centerTab').panel({
					href:'/icpmg/web/omsMonitor/host/jsp/hostDetails.jsp',
					queryParams:{
						neid:pass_neid
					}
					});	
				return;
			}

	});


/********************************************************************************************
/*
 *  加载健康状态、计费状态、设备名称、IP地址
 */

	function setStatusMessage(healthStatus,feeStatus,nename,ipaddr)
	{
		if(healthStatus == "1")
		{
			$("#inhost-health").css('background-position','0 0');
		}
		
		switch(feeStatus)
		{
			case "1":
					{
						$("#inhost-fee-status1").addClass("inhost-fee-selected");
						$("#inhost-fee-status1").css('background-position','-5px -108px');
						break;
					}
			case "2":
					{
						$("#inhost-fee-status2").addClass("inhost-fee-selected");
						$("#inhost-fee-status2").css('background-position','-76px -108px');
						break;
					}
			case "3": 
					{
						$("#inhost-fee-status3").addClass("inhost-fee-selected");
						$("#inhost-fee-status3").css('background-position','-145px -108px');
						break;
					}
		}
		
		$("#inhost-nename").empty();
		$("#inhost-nename").append("服务器名称 : &nbsp;&nbsp;&nbsp" + nename);
		$("#inhost-ipaddr").empty();
		$("#inhost-ipaddr").append("服务器IP地址 : " + ipaddr);
	}
	
	function setStatusTime(day,hour,minute)
	{
		$("#inhost-day").empty();
		$("#inhost-day").append(day);
		$("#inhost-hour").empty();
		$("#inhost-hour").append(hour);
		$("#inhost-min").empty();
		$("#inhost-min").append(minute);
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
			url:inhost_status_action,
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
		url:inhost_alarmnum_action,
		dataType:'json',
		success:
			function(ret)
			{
				$("#inhost-alarm-num").empty();
				$("#inhost-alarm-num").append('&nbsp;' + ret + '&nbsp;');
			}
	});

/**************************************************************************************************
 * cpu利用率图表
 */
	
	var cpuGaugeChart = echarts.init(document.getElementById('inhost-cpu-zone'));
	var cpuGaugeOption = {
		title : {
	        text: '服务器整体CPU利用率',
	        x:'left',
	        y:'top',
            textStyle:
        	{
            	color:'#666',
            	size:'16'
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
	    backgroundColor:'white',
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
	    series : [
	        {
	            name:'CPU利用率',
	            type:'gauge',
	            center : ['50%', '60%'],   
	            radius : [0, '80%'],
	            startAngle: 220,
	            endAngle : -40,
	            min: 0,               
	            max: 100,            
	            precision: 0,           
	            splitNumber: 10,           
	            axisLine: 
	            { 			     
	                show: true,        
	                lineStyle: 
	                {       
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
	            axisLabel: 
	            {
	                show: true,
	                formatter: function(v)
	                {
	                    switch (v+'')
	                    {
	                        case '10': return '弱';
	                        case '30': return '低';
	                        case '60': return '中';
	                        case '90': return '高';
	                        default: return '';
	                    }
	                },
	                textStyle: 
	                {      
	                    color: '#333'
	                }
	            },
	            splitLine: 
	            {   
	                show: true,
	                length :30,
	                lineStyle: 
	                {
	                    color: '#eee',
	                    width: 2,
	                    type: 'solid'
	                }
	            },
	            pointer : 
	            {
	                length : '80%',
	                width : 8,
	                color : 'auto'
	            },
	            title : 
	            {
	                show : true,
	                offsetCenter: ['-65%', -10],       
	                textStyle: 
	                {      
	                    color: '#333',
	                    fontSize : 15
	                }
	            },
	            detail : 
	            {
	                show : true,
	                backgroundColor: 'rgba(0,0,0,0)',
	                borderWidth: 0,
	                borderColor: '#ccc',
	                width: 100,
	                height: 40,
	                offsetCenter: ['0%', 50],
	                formatter:'{value}%\n\nCPU',
	                textStyle: 
	                {
	                    color: '#333',
	                    fontSize : 20
	                }
	            },
	            data:[]
	        }
	    ]
	};		
	
//	cpuGaugeChart.setOption(cpuGaugeOption);
	
/**************************************************************************************************/
/**
 * 内存利用率图表
 */
	
	var memGaugeChart = echarts.init(document.getElementById('inhost-mem-zone'));
	var memGaugeOption = 
	{
		title : {
	        text: '服务器内存占用率',
	        x:'left',
	        y:'top',
            textStyle:
        	{
            	color:'#666',
            	size:'16'
        	}
	        
		},
	    tooltip : {
	        formatter: "{a}: {c}%"
	    },
	    toolbox: 
	    {
	        show : true,
	        feature : 
	        {
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    backgroundColor:'white',
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
	    series : [
	        {
	            name:'内存利用率',
	            type:'gauge',
	            center : ['50%', '60%'],    
	            radius : [0, '80%'],
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
	                textStyle: 
	                {       
	                    color: '#333'
	                }
	            },
	            splitLine: 
	            {    
	                show: true,        
	                length :30,     
	                lineStyle: {   
	                    color: '#eee',
	                    width: 2,
	                    type: 'solid'
	                }
	            },
	            pointer : 
	            {
	                length : '80%',
	                width : 8,
	                color : 'auto'
	            },
	            title : 
	            {
	                show : true,
	                offsetCenter: ['-65%', -10],     
	                textStyle: {      
	                    color: '#333',
	                    fontSize : 15
	                }
	            },
	            detail : 
	            {
	                show : true,
	                backgroundColor: 'rgba(0,0,0,0)',
	                borderWidth: 0,
	                borderColor: '#ccc',
	                width: 100,
	                height: 40,
	                offsetCenter: ['0%', 50], 
	                formatter:'{value}%\n\n内存',
	                textStyle: {       
	                    color: '#333',
	                    fontSize : 20
	                }
	            }, 
	            data:[]
	        }
	    ]
	};		
	
//	memGaugeChart.setOption(memGaugeOption);	
	
/**************************************************************************************************
 * 获取利用率
 */	
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{neid:neid},
		url:inhost_useage_action,
		dataType:'json',
		success:
			function(ret)
			{
				if(([ret.cpuUseage]) == "" ||  (ret.cpuUseage == undefined))
				{
					cpuGaugeOption.series[0].data = [];
					cpuGaugeChart.setOption(cpuGaugeOption);
				}
				else
				{
					cpuGaugeOption.series[0].data = [ret.cpuUseage];
					cpuGaugeChart.setOption(cpuGaugeOption);
				}
				
				if([ret.memUseage] == "")
				{
					memGaugeOption.series[0].data = [];
					memGaugeChart.setOption(memGaugeOption);
				}
				else
				{
					memGaugeOption.series[0].data = [ret.memUseage];
					memGaugeChart.setOption(memGaugeOption);
				}
			}
	});
	
	
/**************************************************************************************************/	
/**
 * 指标根据列表的加载
 */
	
		var indexXdata=[];
		var cpuIndexData=[];
		var memIndexData=[];
		var bandIndexData=[];

		
/**************************************************************************************************/
/**
 * 指标图表
 */	
    
    var indexChart = echarts.init(document.getElementById('inhost-index-zone'));
    
    var indexLineOption = 
    {
	    	title: 
	        {
	            text: '指标趋势监控',
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
	            data:["CPU利用率","内存利用率","带宽利用率"],
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
	            data: indexXdata
	        },
	    	yAxis: 
	        {
	        	show:true,
	        	name:'百分比/%',
	        	position:'left',
	        	nameLocation:'end',
	        	splitNumber:10,
	        	type : 'value',
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
                }
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
	        	},
	        	{
	        		name:'带宽利用率',
	        		type: 'line',
	        		smooth:true,
	        		itemStyle: {normal: {areaStyle: {type: 'default'}}},
	        		data: []
	        	}
	        	
	        ]
	    };
	

    	
/****************************************************************************************************/
/**
 * 指标列表
 */		
    
    	
	var cpuIndexFlag = '1';
	var memIndexFlag = '0';
	var bandIndexFlag = '0';
	
	$('#time-cobbox').hide('slow');
	
	$.ajax
	({
	 	type : 'post',
		async:true, 
		data:{neid:neid,timeField:1},
		url:inhost_index_action,
		dataType:'json',
		success:
			function(ret)
			{
				$('#inhost-index-list-zone .index-menu .index-list .index-dropdown').show('slow');
				$('#time-cobbox').show('slow');
				indexXdata = ret.starttimeList;
				cpuIndexData=ret.cpuList;
				memIndexData=ret.memList;
				bandIndexData=ret.bandwidthusageList;

				$('#cpu-box').prop('checked',true);
				$('#cpu-box').val('1');
				indexChart = echarts.init(document.getElementById('inhost-index-zone'));
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

				indexChart = echarts.init(document.getElementById('inhost-index-zone'));
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
				
				indexChart = echarts.init(document.getElementById('inhost-index-zone'));
				indexChart.setOption(indexLineOption);
				break;
			}
			case 'bandusage-box':
			{
				if(bandIndexFlag == '0')
				{
					bandIndexFlag = '1';
					indexLineOption.series[2].data = bandIndexData;
				}
				else
				{
					bandIndexFlag = '0';
					indexLineOption.series[2].data = [];
				}
				
				indexChart = echarts.init(document.getElementById('inhost-index-zone'));
				indexChart.setOption(indexLineOption);
				break;
			}
			
		}
		
	}); 
	
/****************************************************************************************************/	
/**
 * 时间范围选择
 */
	$('#inhost-time-cobbox').combobox({    
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
						async:false, 
						data:{neid:neid,timeField:row.type},
						url:inhost_index_action,
						dataType:'json',
						success:
							function(ret)
							{
								//重置指标列表及标志位
								$(".drop-down-title").children("input").prop('checked',false);
								$(".drop-down-title").children("input").val('0');
								cpuIndexFlag = '1';
								memIndexFlag = '0';
								bandIndexFlag = '0';
								$('#cpu-box').prop('checked',true);
								$('#cpu-box').val('1');
								                                 
								indexXdata = ret.starttimeList;
								cpuIndexData=ret.cpuList;
								memIndexData=ret.memList;
								bandIndexData=ret.bandwidthusageList;

								indexChart = echarts.init(document.getElementById('inhost-index-zone'));
								indexLineOption.xAxis.data = ret.starttimeList;
								indexLineOption.series[0].data = ret.cpuList;
								indexLineOption.series[1].data = [];
								indexLineOption.series[2].data = [];
						    	indexChart.setOption(indexLineOption);
							}
					});
	        
	    }
	});  





/****************************************************************************************************/		
/**
 * 	Cpu单条负荷率图标
 */	
	
    var cpuDetailChart = echarts.init(document.getElementById('inhost-single-cpu-zone'));
    var cpuDetailOption = 
    {
	        title: 
	        {
	            text: 'CPU每核利用率',
		        x:'left',
		        y:'top',
	            textStyle:
            	{
	            	color:'#666',
	            	size:'16'
            	}
	            
	        },
	        tooltip: {},
	        legend: 
	        {
	            data:['CPU每核利用率'],
	            x:'center',
	            orient:'horizontal',
                textStyle: 
                {
                	color:'#666',
                    fontWeight:'bold'
                }
	        },
	        xAxis: 
	        {
	        	name:'CPU名称',
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
	            data: []
	        },
	        yAxis:
	        {
	        	show:true,
	        	name:'%',
	        	position:'left',
	        	nameLocation:'end',
	        	splitNumber:10,
	        	max:100,
	        	lineStyle:
	        	{
	        		color: 'red',
	    			width: 2,
	    			type: 'solid'
	        	},
	            axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	}
                },
	        	nameTextStyle : 
                {
//	            	color:'#666',
	        		fontWeight:'bold'
                }
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
		            name: 'CPU每核利用率',
		            type: 'bar',
		            itemStyle:
		            {
		                normal: 
		                {
		                    color: '#FF7100',
		                    barBorderColor: '#FF7100',
		                    barBorderWidth: 3,
		                    barBorderRadius:0,
		                    label :
		                    {
		                        show: false, 
		                        position: 'top',
		                        textStyle: 
		                        {
		                            color: '#FF7100',
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
		                            color: '#000000',
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
		url:inhost_cpu_action,
		dataType:'json',
		success:
			function(ret)
			{
			    cpuDetailOption.series[0].data = ret.cpuLoadList;
				cpuDetailOption.xAxis.data = ret.cpuNameList;
			    cpuDetailChart.setOption(cpuDetailOption);
			}
	});
    
/****************************************************************************************************/	
/**
 * 磁盘使用空间详情
 */
    
    var diskDetailChart = echarts.init(document.getElementById('inhost-single-disk-zone'));
	
    var diskDetailOption = 
    {
	        title: 
	        {
	            text: '服务器挂载磁盘空间详情',
		        x:'left',
		        y:'top',           
	            textStyle:
            	{
	            	color:'#666',
	            	size:'16'
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
                	color:'#666',
                    fontWeight:'bold'
                }
	        },
	        yAxis: 
	        {
	        	name:'磁盘名称',
	        	type:'category',
	        	nameTextStyle : 
                {
//                	color:'#666',
	        		fontWeight:'bold'
                },
                axisLabel:{

                	formatter : function(name,value,cvalue)
                	{
                		return name
                	},
    	            textStyle:
                	{
                    	color:'#666',
                        fontWeight:'bold'
                	}
                },
	            data: []
	        },
	        grid: { // 控制图的大小，调整下面这些值就可以，
	             x: 330,
	             x2: 80,
	             y: 30,
	             y2: 20,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
	         },
	        xAxis:
	        {
	        	show:true,
	        	name:'存储空间/G',
	        	type:'value',
	        	nameTextStyle:
	        	{
//                	color:'#666',
	        		fontWeight:'bold'
		        },
	        	lineStyle:
	        	{
	        		color: 'red',
	    			width: 2,
	    			type: 'solid'
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
		                        position: 'top',
		                        textStyle: 
		                        {
		                            color: 'black',
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
		                        	 color: 'black',
		                            fontWeight:'bold'
		                        }
		                    }
		                }
		            },

		            data: []
	        	},
	        	{
	        		name:'未用空间',
	        		type: 'bar',
	        		stack: 'cpu',
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
		                        position: 'top',
		                        textStyle: 
		                        {
		                            color: 'black',
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
		                        	 color: 'black',
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
		url:inhost_disk_action,
		dataType:'json',
		success:
			function(ret)
			{
				diskDetailOption.series[0].data = ret.diskUsed;
				diskDetailOption.series[1].data = ret.diskFree;
				diskDetailOption.yAxis.data = ret.diskName;
			    diskDetailChart.setOption(diskDetailOption);
			}
	});
	
/****************************************************************************************************/	
/**
 * 网卡详情
 */
    
    
    $('#inhost-mac-datagrid').datagrid({
		striped:true,
		title:'服务器网卡详细指标监控',
		url:inhost_nic_action,
		queryParams: 
			{
				neid:neid									
			},
			showHeader:true,
			height:400,
        columns:
        	[	
        	 	[    
		            {field:'oname',title:'网卡名称',width:170,align:'center'},    
		            {field:'bandwidth',title:'带宽/kbps',width:100,align:'center'},
		            {field:'bandwidthusage',title:'带宽占用率/%',width:100,align:'center'},
		            {field:'nictottra',title:'总流量/kb',width:100,align:'center'},
		            {field:'innictra',title:'入流量/kb',width:100,align:'center'},
		            {field:'outnictra',title:'出流量/kb',width:100,align:'center'},
		            {field:'inerror',title:'入误包数',width:70,align:'center'},
		            {field:'indiscard',title:'入丢包数',width:70,align:'center'},
		            {field:'outerror',title:'出误包数',width:70,align:'center'},
		            {field:'outdiscard',title:'出丢包数',width:70,align:'center'},
//		            {field:'nictraspeed',title:'流速/kbps',width:100,align:'center'},
//		            {field:'inucastpkt',title:'入单播包数',width:120,align:'center'},
//		            {field:'outucastpkt',title:'出单播包数',width:120,align:'center'},
//		            {field:'innucastpkt',title:'入非单播包数',width:100,align:'center'},
//		            {field:'outnucastpkt',title:'出非单播包数',width:100,align:'center'},
		            {field:'mtu',title:'发送接收最大数',width:150,align:'center'},
		            {field:'operstatus',title:'操作状态',width:100,align:'center'}
	            ]
        	],
    	fitColumns:true
    	
    });  

   
    
    
    
    
    
    
    
    
    
    
	
})(jQuery);