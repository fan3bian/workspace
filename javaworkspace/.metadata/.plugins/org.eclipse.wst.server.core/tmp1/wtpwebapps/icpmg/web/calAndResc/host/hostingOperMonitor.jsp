<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/icp/include/taglib.jsp" %>
<%
	String contextPath = request.getContextPath();
%>

<script type="text/javascript">
$(document).ready(function(){
	cpu_usage_currtDayAjax("", "");	//首先加载当前一天的数据
	mem_usage_currtDayAjax("","");
	mem_capacity_stat_ajaxData("", "");
});

function setOptionTheme(){
	Highcharts.createElement('link', {
		href: 'http://fonts.googleapis.com/css?family=Dosis:400,600',
		rel: 'stylesheet',
		type: 'text/css'
	}, null, document.getElementsByTagName('head')[0]);

	Highcharts.theme = {
		colors: ["#7cb5ec", "#f7a35c", "#aaeeee","#7798BF",  "#ff0066", "#eeaaee","#55BF3B", "#DF5353", "#7798BF", "#aaeeee", "#90ee7e"],
		chart: {
			backgroundColor: null,
			style: {
				fontFamily: "Dosis, sans-serif"
			}
		},
		title: {
			style: {
				fontSize: '16px',
				fontWeight: 'bold',
				textTransform: 'uppercase'
			}
		},
		tooltip: {
			borderWidth: 0,
			backgroundColor: 'rgba(219,219,216,0.8)',
			shadow: false
		},
		legend: {
			itemStyle: {
				fontWeight: 'bold',
				fontSize: '13px'
			}
		},
		xAxis: {
			gridLineWidth: 1,
			labels: {
				style: {
					fontSize: '12px'
				}
			}
		},
		yAxis: {
			minorTickInterval: 'auto',
			title: {
				style: {
					textTransform: 'uppercase'
				}
			},
			labels: {
				style: {
					fontSize: '12px'
				}
			}
		},
		plotOptions: {
			candlestick: {
				lineColor: '#404048'
			}
		},

		// General
		background2: '#F0F0EA'
	};
	// Apply the theme
	Highcharts.setOptions(Highcharts.theme);
}

//内存容量使用容量统计
function mem_capacity_stat_ajaxData(beginTime, endTime){
	var mem_capacity_data = '';
	var mem_used_data = '';
	//var mem_available_data = '';
	var xAxis_data = '';
	var tickInterval = 0;
	
	$.ajax({
		url: "<%=contextPath%>/opermintor/hostMemCapacityStat.do",
		data : {'neid':$("#hostid").val(), 'kpi':'memtot,memused', 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			if(null != result.kpi_cap && "" != result.kpi_cap){
				mem_capacity_data = "[" + result.kpi_cap + "]";
				mem_used_data = "[" + result.kpi_used + "]";
				//mem_available_data = "[" + result.kpi_available + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					xAxis_data += "'" + xarr[i] + "'" + ",";
				}
				xAxis_data = xAxis_data.substring(0, xAxis_data.length - 1);
				xAxis_data = "[" + xAxis_data + "]";
				//period = result.collperiod;
				period = 5;
				tickInterval = Math.ceil(xarr.length/period);
			}
			mem_capacity_stat_chart(mem_capacity_data, mem_used_data, xAxis_data, tickInterval);
		}
	});
}

function mem_capacity_stat_chart(mem_capacity_data, mem_used_data, xAxis_data, tickInterval){

	var mem_capacity_stat_chart = new Highcharts.Chart({
        chart: {
        	renderTo: 'container_host_mem_capacity_stat',
            type: 'area'
        },
        title: {
            text: '内存容量统计'
        },
        credits:{
            enabled: false      //去除版权信息
        }, 
        xAxis: {
        	categories: eval(xAxis_data),
           	tickInterval: tickInterval,		//步长: 5
           	labels: {			//设置横轴坐标的显示样式  
           		align: "left"
           	}
        },
        yAxis: {
            title: {
                text: null
            },
            labels: {
                formatter: function() {
                    return this.value +'GB';
                }
            }
        },
        tooltip: {
            pointFormat: '{series.name} <b>{point.y:,.2f}</b> GB'
        },
        plotOptions: {
            area: {
                marker: {
                    enabled: false,
                    symbol: 'circle',
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },
        series: [{
            name: 'used',
            data: eval(mem_used_data)
        }, {
            name: 'capacity',
            data: eval(mem_capacity_data)
        }]
    });
}
//cpu使用率请求数据
function cpu_usage_currtDayAjax(beginTime, endTime){
	var cpu_usage_data = '';
	var xAxis_data = '';
	var tickInterval = 0;
	
	$.ajax({
		url: "<%=contextPath%>/opermintor/hostCPUUsage.do",
		data : {'neid':$("#hostid").val(), 'kpi':'cpuusage','beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			if(null != result.kpis && "" != result.kpis){
				cpu_usage_data = "[" + result.kpis + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					xAxis_data += "'" + xarr[i] + "'" + ",";
				}
				xAxis_data = xAxis_data.substring(0, xAxis_data.length - 1);
				xAxis_data = "[" + xAxis_data + "]";
				//period = result.collperiod;
				period = 5;	//默认5分钟
				tickInterval = Math.ceil(xarr.length/period);
			}
			cpu_usage_chart(cpu_usage_data,xAxis_data,tickInterval);
		}
	});
}

function cpu_usage_chart(cpu_usage_data, xAxis_data, tickInterval){
	var cpu_usage_chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container_host_cpu_usage',
		    type: 'line'
		},
		title: {
            text: 'CPU使用率(%):',
            x: -450
        },
        credits:{
            enabled: false		//去除版权信息
        }, 
        xAxis: {
           	categories: eval(xAxis_data),
           	tickInterval: tickInterval,		//默认步长: 5
           	labels: {			//设置横轴坐标的显示样式  
           		align: "left"
           	}
       	},
       	yAxis: {
			title: {
       			text: null
   			},
            minPadding: 0.2,
           	maxPadding: 0.2,
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
           	valueSuffix: '%'
        },
        legend: {
            layout: 'horizontal',
            align: 'center',
            enabled: true,
            verticalAlign: 'bottom',
            borderWidth: 0
        },
        series: [{
            name: 'CPU使用率',
            data: eval(cpu_usage_data),
        }]
	});
	
}

function mem_usage_currtDayAjax(beginTime, endTime){
	var mem_usage_data = '';
	var xAxis_data = '';
	var tickInterval = 0;
	
	$.ajax({
		url: "<%=contextPath%>/opermintor/hostMemUsage.do",
		data : {'neid':$("#hostid").val(), 'kpi':'memusage', 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			if(null != result.kpis && "" != result.kpis){
				mem_usage_data = "[" + result.kpis + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					xAxis_data += "'" + xarr[i] + "'" + ",";
				}
				xAxis_data = xAxis_data.substring(0, xAxis_data.length - 1);
				xAxis_data = "[" + xAxis_data + "]";
				//period = result.collperiod;
				period = 5;
				tickInterval = Math.ceil(xarr.length/period);
			}
			mem_usage_chart(mem_usage_data,xAxis_data,tickInterval);
		}
	});
}

function mem_usage_chart(mem_usage_data, xAxis_data, tickInterval){
	var mem_usage_chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container_host_mem_usage',
		    type: 'line',
		},
		title: {
            text: '内存使用率(%):',
            x: -450
        },
        credits:{
            enabled: false		//去除版权信息
        }, 
        xAxis: {
           	categories: eval(xAxis_data),
           	tickInterval: tickInterval,		//步长: 5
           	labels: {						//设置横轴坐标的显示样式  
           		align: "left"
           	}
       	},
       	yAxis: {
			title: {
       			text: null
   			},
            minPadding: 0.2,
           	maxPadding: 0.2,
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
           	valueSuffix: '%'
        },
        legend: {
            layout: 'horizontal',
            align: 'center',
            enabled: true,
            verticalAlign: 'bottom',
            borderWidth: 0
        },
        series: [{
            name: '内存使用率',
            data: eval(mem_usage_data)
        }]
	});
}

//确定按钮函数
function host_kpi_usage_ok(){
	var beginTime = $('#starttime').datebox('getValue');
	var endTime = $('#endtime').datebox('getValue');
	
	if(beginTime == '' || beginTime == null){
		$.messager.alert('提示', "开始时间不能为空!", 'info');
	}else{
		var msg = compareTime(beginTime, endTime);
		if(msg != ""){
			$.messager.alert('提示', msg, 'info');
			return;
		}
		cpu_usage_currtDayAjax(beginTime, endTime);
		mem_usage_currtDayAjax(beginTime, endTime);
		mem_capacity_stat_ajaxData(beginTime, endTime);
	}
}
//判断时间选择条件
function compareTime(startDate, endDate) { 
	if(null != endDate || '' != endDate){
    	var startDateTemp = startDate.split(" ");   
    	var endDateTemp = endDate.split(" ");   
    	
    	var arrStartDate = startDateTemp[0].split("-");   
    	var arrEndDate = endDateTemp[0].split("-");   
  
    	var arrStartTime = startDateTemp[1].split(":");   
   		var arrEndTime = endDateTemp[1].split(":");   
	  
		var allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2], arrStartTime[0], arrStartTime[1], arrStartTime[2]);   
		var allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2], arrEndTime[0], arrEndTime[1], arrEndTime[2]);   
	                   
		if (allStartDate.getTime() >= allEndDate.getTime()) {   
	        return "开始时间不能大于结束时间";   
		}else{
			return "";
		}
	}
}
</script>

<div>
	开始时间：<input class="easyui-datetimebox" editable="fasle" name="starttime" id="starttime" style="width:150px;height:28px;border:false"/>&nbsp;&nbsp;
	结束时间：<input class="easyui-datetimebox"  editable="fasle" name="endtime" id="endtime" style="width:150px;height:28px;border:false"/>&nbsp;&nbsp;
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="host_kpi_usage_ok()">确定</a>
</div>
<div id="tt" class="easyui-tabs" data-options="tabWidth:112,border:false" style="width:100%;">
	<input type="hidden" id="hostid" value="${neid}"/>
	<div id="tt_host_cpu" title="CPU" data-options="fit:true" style="padding:10px;overflow:auto;">
		<div id="container_host_cpu_usage" style="min-width:100%;height:400px"></div>
	</div>
	<div id="tt_host_mem" title="内存" data-options="fit:true" style="padding:10px;overflow:auto;">
		<div id="container_host_mem_usage" style="min-width:80%;height:400px"></div>
		<div id="container_host_mem_capacity_stat" style="min-width:80%;height:400px"></div>
	</div>
</div>