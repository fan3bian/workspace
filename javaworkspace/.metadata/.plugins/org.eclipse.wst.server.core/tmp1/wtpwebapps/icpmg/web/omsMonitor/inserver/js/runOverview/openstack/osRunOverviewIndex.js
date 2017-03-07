(function($){
	
//	var nename = '7b363fee-4045-4371-8318-be59bdfd8520';
	var nename = osinserver_nename ;
	var neid = inserver_neid ;
	//var oname=oname;
	var inserver_disk_mount_action =  context_path + "/os_inserver_runoverview/getDiskMount.do";
	var osinserver_index_action = context_path + "/os_inserver_runoverview/getOSInserverIndexData.do";
	var osinserver_compute_index_action = context_path + "/os_inserver_runoverview/getOSInserverComputeIndexData.do";
	var osinserver_network_index_action = context_path + "/os_inserver_runoverview/getOSInserverNetworkIndexData.do";
	var osinserver_disk_index_action=context_path + "/os_inserver_runoverview/getOSInserverDiskIndexData.do";
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
		        toolbox: 
		        {
		            show : true,
		            feature : 
		            {
		                restore : {show: true},
		                saveAsImage : {show: true}
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
//				            	color:'#666',
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
//				            	color:'#666',
		        		fontWeight:'bold'
	                },
	                axisLabel:{
	    	            textStyle:
	                	{
	    	            	color:'#666',
	    	            	fontWeight:'bold'
	                	},
//			                	formatter : function(name,value,cvalue)
//			                	{
//			                		return name.substring(0,10);
//			                	} 
	                },
		            data: []
		        	
		        },
		        backgroundColor:'white',
		        noDataLoadingOption:
		        {
		        	text:'无磁盘监控数据',
		        	effect:'bar',
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
				},
			error:function(){altre("erroe");}
		});	
/**************************************************************************************************
 * 
 * 指标图标
 */	
	
	var indexXdata=[];
	var memIndexData=[];
	var rxusageIndexData=[];
	var txusageIndexData=[];
	var diskrxusageIndexData=[];
	var disktxusageIndexData=[];
	
	
    var indexChart = echarts.init(document.getElementById('osinserver-index-zone'));	
	
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
    var networkIndexChart = echarts.init(document.getElementById('osinserver-network-index-zone'));
    
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
//    	                magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
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
//        			color:'#666',
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
//        				            	color:'#666',
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
    	
    /**************************************************************************************************
     * 
     * disk指标图标
     */	
        var diskIndexChart = echarts.init(document.getElementById('osinserver-disk-index-zone'));
        
        var diskIndexLineOption = 
        {
    	    	title: 
    	        {
    	            text: '磁盘监控',
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
    	            data:["读速率","写速率"],
    	        },
    	        toolbox: 
    	        {
    	            show : true,
    	            feature : {
    	                mark : {show: true},
//    	                dataView : {show: true, readOnly: false},
//        	                magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
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
//            			color:'#666',
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
//            				            	color:'#666',
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
    		            name: '读速率',
    		            type: 'line',
    		            smooth:true,
    		            itemStyle: {normal: {areaStyle: {type: 'default'}}},
    		            data: []
    	        	},
    	        	{
    	        		name:'写速率',
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
	$('#osinserver-time-cobbox-out').hide('slow');
	$('#osinserver-network-time-cobbox-out').hide('slow');
	$('#osinserver-disk-time-cobbox-out').hide('slow');
	
	
	
	/**
	 * disk指标时间范围选择
	 */
	       
	$('#DiskName').combobox({ 					
		panelHeight:100,				
		url:'../../os_inserver_runoverview/getDiskData.do?nename'+nename+"&neid="+neid,
			    valueField:'name',
				textField:'name',
		width:'100%',
		height:'40px',
		multiple:false,
		   onLoadSuccess: function () { //加载完成后,设置选中第一项
               var data = $(this).combobox("getData");
               if (data.length > 0) {
                   $('#DiskName').combobox('select', data[0].name);
                   $('#inserver_name').val(data[0].name);
               }
           }
		
	}); 
	
	$('#DiskName').combobox({
		onSelect: function(rec){
			$('#inserver_name').val(rec.name);
		    var timefield = $('#osinserver-disk-time-cobbox').combobox('getValue');
			queryDiskReadWrite(nename,rec.name,timefield);
			
		}
	});
	
	function queryDiskReadWrite(nename,oname,timefiled){
		
		$.ajax
		({
			 	type : 'post',
				async:false, 
				data:{nename:nename,oname:oname,timeField:timefiled},
				url:osinserver_disk_index_action,
				dataType:'json',
				success:
					function(ret)
					{

						//重置指标列表及标志位
						$(".osnet-read-title").children("input").prop('checked',false);
						$(".osnet-read-title").children("input").val('0');
						rxusageIndexFlag = '1';
						txusageIndexFlag = '1';

						$('#read-box').prop('checked',true);
						$('#read-box').val('1');
						$('#write-box').prop('checked',true);
						$('#write-box').val('1');
						                                 
						indexXdata = ret.starttimeList;
						diskrxusageIndexData=ret.rxUsageList;
						disktxusageIndexData=ret.txUsageList;

						diskIndexChart = echarts.init(document.getElementById('osinserver-disk-index-zone'));
						diskIndexLineOption.xAxis.data = ret.starttimeList;
						diskIndexLineOption.series[0].data = ret.rxUsageList;
						diskIndexLineOption.series[1].data = ret.txUsageList;
						diskIndexChart.setOption(diskIndexLineOption);
					}
			});
		
	}
	
	
	
	//初始化磁盘
	var oname=$('#inserver_name').val();
	
	queryDiskReadWrite(nename,oname,'1');
	
		$.ajax
		({
		 	type : 'post',
			async:true, 
			data:{nename:nename,timeField:1},
			url:osinserver_index_action,
			dataType:'json',
			success:
				function(ret)
				{
					//加载完成,显示
					$('#osinserver-index-list-zone .index-menu .index-list .index-dropdown ').show('slow');
					$('#osinserver-time-cobbox-out').show('slow');
				
					$('#osinserver-network-index-list-zone .index-menu .index-list .index-dropdown ').show('slow');
					$('#osinserver-network-time-cobbox-out').show('slow');
					
					$('#osinserver-disk-index-list-zone .index-menu .index-list .index-dropdown ').show('slow');
					$('#osinserver-disk-time-cobbox-out').show('slow');
					indexXdata = ret.starttimeList;
					cpuIndexData=ret.cpuList;
					memIndexData=ret.memList;
					rxusageIndexData=ret.rxUsageList;
					txusageIndexData=ret.txUsageList;
					
					//初始化计算指标图表
					$('#cpu-box').prop('checked',true);
					$('#cpu-box').val('1');
					indexChart = echarts.init(document.getElementById('osinserver-index-zone'));
					indexLineOption.xAxis.data = ret.starttimeList;
					indexLineOption.series[0].data = ret.cpuList;
			    	indexChart.setOption(indexLineOption);
			    	
			    	//初始化网络指标图表
					$('#rxusage-box').prop('checked',true);
					$('#rxusage-box').val('1');
					$('#txusage-box').prop('checked',true);
					$('#txusage-box').val('1');
			    	networkIndexChart = echarts.init(document.getElementById('osinserver-network-index-zone'));
			    	networkIndexLineOption.xAxis.data = ret.starttimeList;
			    	networkIndexLineOption.series[0].data = ret.rxUsageList;
			    	networkIndexLineOption.series[1].data = ret.txUsageList;
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

				indexChart = echarts.init(document.getElementById('osinserver-index-zone'));
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
				
				indexChart = echarts.init(document.getElementById('osinserver-index-zone'));
				indexChart.setOption(indexLineOption);
				break;
			}
		}
		
	});
	
	//网络指标选择组件
	$(".osnet-drop-down-title").click(function(){
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
				
				networkIndexChart = echarts.init(document.getElementById('osinserver-network-index-zone'));
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
				
				networkIndexChart = echarts.init(document.getElementById('osinserver-network-index-zone'));
				networkIndexChart.setOption(networkIndexLineOption);
				break;
			}
		}
		
	}); 
	
	
	//disk指标选择组件
	$(".osnet-read-title").click(function(){
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
			case 'read-box':
			{
				if(rxusageIndexFlag == '0')
				{
					rxusageIndexFlag = '1';
					diskIndexLineOption.series[0].data = diskrxusageIndexData;
				}
				else
				{
					rxusageIndexFlag = '0';
					diskIndexLineOption.series[0].data = [];
				}
				
				diskIndexChart = echarts.init(document.getElementById('osinserver-disk-index-zone'));
				diskIndexChart.setOption(diskIndexLineOption);
				break;
			}
			case 'write-box':
			{
				if(txusageIndexFlag == '0')
				{
					txusageIndexFlag = '1';
					diskIndexLineOption.series[1].data = disktxusageIndexData;
				}
				else
				{
					txusageIndexFlag = '0';
					diskIndexLineOption.series[1].data = [];
				}
				
				diskIndexChart = echarts.init(document.getElementById('osinserver-disk-index-zone'));
				diskIndexChart.setOption(diskIndexLineOption);
				break;
			}
		}
		
	}); 
	
/****************************************************************************************************/	
/**
 * 时间范围选择
 */
		$('#osinserver-time-cobbox').combobox({    
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
							data:{nename:nename,timeField:row.type},
							url:osinserver_compute_index_action,
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
	
									indexChart = echarts.init(document.getElementById('osinserver-index-zone'));
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
		$('#osinserver-network-time-cobbox').combobox({    
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
									data:{nename:nename,timeField:row.type},
									url:osinserver_network_index_action,
									dataType:'json',
									success:
										function(ret)
										{
											//重置指标列表及标志位
											$(".osnet-drop-down-title").children("input").prop('checked',false);
											$(".osnet-drop-down-title").children("input").val('0');
											rxusageIndexFlag = '1';
											txusageIndexFlag = '1';

											$('#rxusage-box').prop('checked',true);
											$('#rxusage-box').val('1');
											$('#txusage-box').prop('checked',true);
											$('#txusage-box').val('1');
											                                 
											indexXdata = ret.starttimeList;
											rxusageIndexData=ret.rxUsageList;
											txusageIndexData=ret.txUsageList;
	
									    	networkIndexChart = echarts.init(document.getElementById('osinserver-network-index-zone'));
									    	networkIndexLineOption.xAxis.data = ret.starttimeList;
									    	networkIndexLineOption.series[0].data = ret.rxUsageList;
									    	networkIndexLineOption.series[1].data = ret.txUsageList;
									    	networkIndexChart.setOption(networkIndexLineOption);
										}
								});
				        
					    }
		});  	

		/****************************************************************************************************/	

		
				$('#osinserver-disk-time-cobbox').combobox({    
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
						    	var oname=$('#inserver_name').val();
						    	queryDiskReadWrite(nename,oname,row.type);
						        
							    }
				});  
				
				
				

		
		
	
})(jQuery);