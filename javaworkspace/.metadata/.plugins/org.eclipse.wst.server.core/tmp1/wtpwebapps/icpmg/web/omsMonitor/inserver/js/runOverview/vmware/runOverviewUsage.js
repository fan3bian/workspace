(function($){

//	var neid = "于颜华-采集机";
	var neid = inserver_neid ;
	var inserver_useage_action = context_path + "/inserver_runoverview/getInserverUseage.do";

/**************************************************************************************************
 * cpu利用率图表
 */	
	
	var cpuGaugeChart = echarts.init(document.getElementById('inserver-cpu-zone'));
	var cpuGaugeOption = {
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
	        	effect:'bar',
	        	textStyle:
	        	{
	        		fontSize:'18',
	        		fontWeight:'bold'
	        	}
	        },
		    backgroundColor:'white',
		    series : [
		        {
		            name:'虚拟机CPU使用率',
		            type:'gauge',
		            center : ['50%', '55%'],    
		            radius : [0, '90%'],
		            startAngle: 220,
		            endAngle : -40,
		            min: 0,
		            max: 100,
		            precision: 0,
		            splitNumber: 10,
		            axisLine: {
		                show: true,
		                lineStyle: {
		                    color: [[0.2, 'lightgreen'],[0.4, 'skyblue'],[0.6, 'orange'],[0.8,'#F87748'],[1, '#ff4500']], 
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
		                    color: '#666',
	    	            	fontWeight:'bold'
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
		                formatter:'\n{value}%\n\nCPU利用率',
		                textStyle: { 
		                    color: '#333',
		                    fontSize : 20
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
	        	effect:'bar',
	        	textStyle:
	        	{
	        		fontSize:'18',
	        		fontWeight:'bold'
	        	}
	        },
		    backgroundColor:'white',
		    series : [
		        {
		            name:'虚拟机内存使用率',
		            type:'gauge',
		            center : ['50%', '55%'],    
		            radius : [0, '90%'],
		            startAngle: 220,
		            endAngle : -40,
		            min: 0,
		            max: 100,
		            precision: 0,
		            splitNumber: 10,
		            axisLine: {
		                show: true,
		                lineStyle: {
		                    color: [[0.2, 'lightgreen'],[0.4, 'skyblue'],[0.6, 'orange'],[0.8,'#F87748'],[1, '#ff4500']], 
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
		                    color: '#666',
	    	            	fontWeight:'bold'
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
		                formatter:'\n{value}%\n\n内存利用率',
		                textStyle: {     
		                    color: '#333',
		                    fontSize : 20
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
						//cpuGaugeOption.series[1].data = [];
					}
				else
					{
						cpuGaugeOption.series[0].data = [ret.vmCpuUsage];
						//cpuGaugeOption.series[1].data = [ret.hostCpuUsage];
					}
				if(ret.vmMemUsage == '' || ret.vmMemUsage == undefined || ret.vmMemUsage == null)
					{
						memGaugeOption.series[0].data = [];
						//memGaugeOption.series[1].data = [];
					}
				else
					{
						memGaugeOption.series[0].data = [ret.vmMemUsage];
						//memGaugeOption.series[1].data = [ret.hostMemUsage];
					}
				
				cpuGaugeChart.setOption(cpuGaugeOption);
				memGaugeChart.setOption(memGaugeOption);
			}
	});	
	
	


})(jQuery);