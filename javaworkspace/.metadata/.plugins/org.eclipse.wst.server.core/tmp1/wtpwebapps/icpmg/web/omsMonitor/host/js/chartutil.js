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
    	