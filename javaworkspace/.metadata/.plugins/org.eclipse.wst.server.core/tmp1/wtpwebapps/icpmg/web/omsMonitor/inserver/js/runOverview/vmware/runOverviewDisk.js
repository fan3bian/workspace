(function($){
	var neid = inserver_neid ;
	var inserver_disk_action = context_path + "/inserver_runoverview/getInserverDiskData.do";
	var inserver_disk_mount_action = context_path + "/inserver_runoverview/getInserverDiskSize.do";
	var inserver_disk_io_action = context_path + "/inserver_runoverview/getInserverDiskIO.do";
	
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
	            data: diskDetailXdata
	        	
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'无监控数据',
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
						$('#inserver-single-device-zone').prop('title','hideDiskDetail');
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
//			            	color:'#666',
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
//			            	color:'#666',
	        		fontWeight:'bold'
                },
                axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	},
//		                	formatter : function(name,value,cvalue)
//		                	{
//		                		return name.substring(0,10);
//		                	} 
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
			}
	});
/****************************************************************************************************/
/**
 * 虚拟机磁盘IO图表
 */	
	
	var diskIOOption = 
    {
	        title: 
	        {
	            text: '磁盘IO速率',
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
	            data:['读取','写入'],
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
	        	name:'速率/KBps',
	        	type:'value',
	        	nameTextStyle:
	        	{
//			            	color:'#666',
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
//			            	color:'#666',
	        		fontWeight:'bold'
                },
                axisLabel:{
    	            textStyle:
                	{
    	            	color:'#666',
    	            	fontWeight:'bold'
                	},
//		                	formatter : function(name,value,cvalue)
//		                	{
//		                		return name.substring(0,10);
//		                	} 
                },
	            data: ['磁盘1','磁盘2','磁盘3','磁盘4','磁盘5','磁盘6']
	        	
	        },
	        backgroundColor:'white',
	        noDataLoadingOption:
	        {
	        	text:'无磁盘IO监控数据',
	        	effect:'bar',
	        	textStyle:
	        	{
	        		fontSize:'15',
	        		fontWeight:'bold'
	        	}
	        },
	        calculable : true,
	        series: 
	        [
		        {
		            name:'读取',
		            type:'bar',
		            data:[]
//		            data:[18203, 23489, 29034, 104970, 131744, 63023]
		        },
		        {
		            name:'写入',
		            type:'bar',
		            data:[]
//		            data:[19325, 23438, 31000, 121594, 134141, 68180]
		        }
	        ]
	    };

	
})(jQuery);