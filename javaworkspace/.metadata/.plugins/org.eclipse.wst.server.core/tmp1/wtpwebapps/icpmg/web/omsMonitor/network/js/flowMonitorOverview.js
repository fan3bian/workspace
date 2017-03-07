	var date = [];//时间
	var data = [];//流入的数据
	var data2 = [];//流出的数据
$(function () {
	$('#flowmonitorservices').hide();//不显示最后一个后端服务
	addEcharts();//数据为空，为了出框架样式
});
function queryData(){
	$('#flowmonitor_searchform').form({    
	    url:context_path+"/networkfolw/queryData.do",
	    success:function(rets){
	    	var ret  = JSON.parse(rets);
	    	date = ret.date;
	    	data = ret.bin;
	    	data2 = ret.bout;
	    	addEcharts();
	    }    
	});    
	$('#flowmonitor_searchform').submit();  
}

function resetForm(){
	$('#flowmonitor_searchform').form('reset');
	 $('#flowmonitorspan').html('端口');
	 $('#flowmonitorservices').hide();
}
function addEcharts(){
	//初始化Echart
	 var flowMonitorChart = echarts.init(document.getElementById('folw_monitor_chart'));

	var flowMonitorOption = {
			title: {
		        x: 'center',
		        text: '流量监控图',
		    },
	    tooltip: {
	        trigger: 'axis',
	    },
	    toolbox: {
	        feature: {
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    legend: 
        {
            x:'right',
            y:'50px',
            orient:'vertical',
            textStyle: 
            {
            	color:'#666',
                fontWeight:'bold'
            },
            data:['流入','流出'],
        },
        dataZoom: [{
	        type: 'inside',
	        start: 0,
	        end: 100
	    }, {
	        start: 0,
	        end: 10,
	        handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
	        handleSize: '80%',
	        handleStyle: {
	            color: '#fff',
	            shadowBlur: 3,
	            shadowColor: 'rgba(0, 0, 0, 0.6)',
	            shadowOffsetX: 2,
	            shadowOffsetY: 2
	        }
	    }],
	    xAxis: {
	        type: 'category',
	        axisLine: {
	        	show: true,
	        	},
	        	axisTick: {
	        		show:true
	        	},
	        	splitArea: {
	        		show:true
	        	},
	        boundaryGap: false,
	        data: date
	    },
	    yAxis: {
	        type: 'value',
	        boundaryGap: [0, '100%']
	    },
	    noDataLoadingOption:
        {
        	text:'无展示数据',
        	effect:'ring',
        	textStyle:
        	{
        		fontSize:'20',
        		fontWeight:'bold'
        	}
        },
	    series: [
	        {
	            name:'流入',
	            type:'line',
	            smooth:true,
	            symbol: 'none',
	            sampling: 'average',
	            itemStyle: {
	                normal: {
	                    color: 'rgb(255, 70, 131)'
	                }
	            },
	            areaStyle: {
	                normal: {
	                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	                        offset: 0,
	                        color: 'rgb(255, 158, 68)'
	                    }, {
	                        offset: 1,
	                        color: 'rgb(255, 70, 131)'
	                    }])
	                }
	            },
	            data: data
	        },{
	            name:'流出',
	            type:'line',
	            smooth:true,
	            symbol: 'none',
	            sampling: 'average',
	            itemStyle: {
	                normal: {
	                    color: 'rgb(25, 170, 13)'
	                }
	            },
	            areaStyle: {
	                normal: {
	                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	                        offset: 0,
	                        color: 'rgb(255, 158, 68)'
	                    }, {
	                        offset: 1,
	                        color: 'rgb(25, 170, 13)'
	                    }])
	                }
	            },
	            data: data2
	        }
	    ]
	};
	flowMonitorChart.setOption(flowMonitorOption);
}