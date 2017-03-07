(function($){
	
	var neid = inserver_neid ;
	var inserver_index_action = context_path + "/inserver_runoverview/getInserverIndexData.do";
	var inserver_compute_index_action = context_path + "/inserver_runoverview/getInserverComputeIndexData.do";
	var inserver_network_index_action = context_path + "/inserver_runoverview/getInserverNetworkIndexData.do";

/**************************************************************************************************
 * 
 * 计算指标图表
 */	
	
	var indexXdata=[];
	var memIndexData=[];
	var rxusageIndexData=[];
	var txusageIndexData=[];
	
	
    var indexChart = echarts.init(document.getElementById('inserver-index-zone'));
    
    var indexLineOption = 
    {
	    	title: 
	        {
	            text: '计算指标趋势监控',
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
	                mark : {show: true},
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
	        	text:'所选时间段未发现监控数据',
	        	effect:'bar',
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
	        ]
	    };
	
/**************************************************************************************************
 * 
 * 网络指标图标
 */	
    var networkIndexChart = echarts.init(document.getElementById('inserver-network-index-zone'));
    
    var networkIndexLineOption = 
    {
	    	title: 
	        {
	            text: '网络流量速率监控',
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
	            data:["接收流速","发送流速"],
	        },
	        toolbox: 
	        {
	            show : true,
	            feature : {
	                mark : {show: true},
//	                dataView : {show: true, readOnly: false},
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
	        	nameTextStyle:
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
	            data: indexXdata
	        },
	    	yAxis: 
	        {
	        	show:true,
	        	name:'速率/KBps',
	        	position:'left',
	        	nameLocation:'end',
	        	splitNumber:10,
	        	nameTextStyle:
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
	        	type : 'value'
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'所选时间段未发现监控数据',
	        	effect:'bar',
	        	textStyle:
	        	{
	        		fontSize:'20',
	        		fontWeight:'bold'
	        	}
	        },
	        series: 
	        [
	        	{
		            name: '接收流速',
		            type: 'line',
		            smooth:true,
		            itemStyle: {normal: {areaStyle: {type: 'default'}}},
		            data: []
	        	},
	        	{
	        		name:'发送流速',
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
	
	var rxusageIndexFlag = '1';
	var txusageIndexFlag = '1';
	
	//隐藏,防止未加载前误操作
	$('#inserver-time-cobbox-out').hide('slow');
	$('#inserver-network-time-cobbox-out').hide('slow');
	
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
					//加载完成,显示
					$('#inserver-index-list-zone .index-menu .index-list .index-dropdown ').show('slow');
					$('#inserver-time-cobbox-out').show('slow');
					
					$('#inserver-network-index-list-zone .index-menu .index-list .index-dropdown ').show('slow');
					$('#inserver-network-time-cobbox-out').show('slow');
				
					indexXdata = ret.starttimeList;
					cpuIndexData=ret.cpuList;
					memIndexData=ret.memList;
					rxusageIndexData=ret.rxusageList;
					txusageIndexData=ret.txusageList;
					
					//初始化计算指标图表
					$('#cpu-box').prop('checked',true);
					$('#cpu-box').val('1');
					indexChart = echarts.init(document.getElementById('inserver-index-zone'));
					indexLineOption.xAxis.data = ret.starttimeList;
					indexLineOption.series[0].data = ret.cpuList;
			    	indexChart.setOption(indexLineOption);
			    	
			    	//初始化网络指标图表
					$('#rxusage-box').prop('checked',true);
					$('#rxusage-box').val('1');
					$('#txusage-box').prop('checked',true);
					$('#txusage-box').val('1');
			    	networkIndexChart = echarts.init(document.getElementById('inserver-network-index-zone'));
			    	networkIndexLineOption.xAxis.data = ret.starttimeList;
			    	networkIndexLineOption.series[0].data = ret.rxusageList;
			    	networkIndexLineOption.series[1].data = ret.txusageList;
			    	networkIndexChart.setOption(networkIndexLineOption);
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
		}
		
	}); 
	
	//网络指标选择
	$(".insnet-drop-down-title").click(function(){
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
			case 'rxusage-box':
			{
				if(rxusageIndexFlag == '0')
				{
					rxusageIndexFlag = '1';
			    	networkIndexLineOption.series[0].data = rxusageIndexData;
				}
				else
				{
					rxusageIndexFlag = '0';
					networkIndexLineOption.series[0].data = [];
				}
				
				networkIndexChart = echarts.init(document.getElementById('inserver-network-index-zone'));
				networkIndexChart.setOption(networkIndexLineOption);
				break;
			}
			case 'txusage-box':
			{
				if(txusageIndexFlag == '0')
				{
					txusageIndexFlag = '1';
			    	networkIndexLineOption.series[1].data = txusageIndexData;
				}
				else
				{
					txusageIndexFlag = '0';
					networkIndexLineOption.series[1].data = [];
				}
				
				networkIndexChart = echarts.init(document.getElementById('inserver-network-index-zone'));
				networkIndexChart.setOption(networkIndexLineOption);
				break;
			}
		}
		
	}); 

/****************************************************************************************************/	
/**
 * 计算指标时间范围选择
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
							url:inserver_compute_index_action,
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
 * 网络指标时间范围选择
 */
		$('#inserver-network-time-cobbox').combobox({    
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
									url:inserver_network_index_action,
									dataType:'json',
									success:
										function(ret)
										{
											//重置指标列表及标志位
											$(".insnet-drop-down-title").children("input").prop('checked',false);
											$(".insnet-drop-down-title").children("input").val('0');
											rxusageIndexFlag = '1';
											txusageIndexFlag = '1';

											$('#rxusage-box').prop('checked',true);
											$('#rxusage-box').val('1');
											$('#txusage-box').prop('checked',true);
											$('#txusage-box').val('1');
											                                 
											indexXdata = ret.starttimeList;
											rxusageIndexData=ret.rxusageList;
											txusageIndexData=ret.txusageList;
	
									    	networkIndexChart = echarts.init(document.getElementById('inserver-network-index-zone'));
									    	networkIndexLineOption.xAxis.data = ret.starttimeList;
									    	networkIndexLineOption.series[0].data = ret.rxusageList;
									    	networkIndexLineOption.series[1].data = ret.txusageList;
									    	networkIndexChart.setOption(networkIndexLineOption);
										}
								});
				        
					    }
		});  	

//		var diskIOChart = echarts.init(document.getElementById('inserver-disk-io-chart'));
		
//		$.ajax
//		({
//		 	type : 'post',
//			async:true, 
//			data:{neid:neid},
//			url:inserver_disk_io_action,
//			dataType:'json',
//			success:
//				function(ret)
//				{
//					diskIOOption.series[0].data = ret.diskReadRateList;
//					diskIOOption.series[1].data = ret.diskWriteRateList;
//					diskIOOption.yAxis.data = ret.diskNameList;
//					var diskIOChart = echarts.init(document.getElementById('inserver-disk-io-chart'));
//				    diskIOChart.setOption(diskIOOption);
//				}
//		});		

	
})(jQuery);