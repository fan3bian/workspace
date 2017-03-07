(function($){
//	var nename = '7b363fee-4045-4371-8318-be59bdfd8520';
	var nename = osinserver_nename ;
	
	var inserver_disk_io_action = context_path + "/inserver_runoverview/getInserverDiskData.do";
	
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
//				    color:'#666',
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
	            data: ['磁盘1','磁盘2','磁盘3','磁盘4','磁盘5','磁盘6']
	        	
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
	        calculable : true,
	        series: 
	        [
		        {
		            name:'读取',
		            type:'bar',
		            data:[18203, 23489, 29034, 104970, 131744, 63023]
		        },
		        {
		            name:'写入',
		            type:'bar',
		            data:[19325, 23438, 31000, 121594, 134141, 68180]
		        }
	        ]
	    };
	var diskIOChart = echarts.init(document.getElementById('osinserver-disk-io-chart'));
	diskIOChart.setOption(diskIOOption);	
	
	
})(jQuery);