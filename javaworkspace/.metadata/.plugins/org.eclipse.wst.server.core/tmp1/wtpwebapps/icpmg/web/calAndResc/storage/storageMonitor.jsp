<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/icp/include/taglib.jsp" %>
<%
	String contextPath = request.getContextPath();
%>

<script type="text/javascript">
$(document).ready(function(){

	storage_usage_currtDayAjax("","");
	
});


function storage_usage_currtDayAjax(beginTime, endTime){
	var storage_usage_data = '';
	var xAxis_data = '';
	var tickInterval = 0;
	load();
	$.ajax({
		url: "<%=contextPath%>/stOpermintor/storageUsage.do",
		data : {'storagename':$("#storagename").val(),  'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		
		success: function(result) {
			storage_usage_data = "[" + result.usedPercentList + "]";
			
			var xarr = eval(result.times);
			for (var i = 0; i < xarr.length; i++) {
				xAxis_data += "'" + xarr[i] + "'" + ",";
			}
			xAxis_data = xAxis_data.substring(0, xAxis_data.length - 1);
			xAxis_data = "[" + xAxis_data + "]";
			period = result.collperiod;
			tickInterval = Math.ceil(xarr.length/period);
			
			zhibei_data = "[" + result.provisionedList + "]";
			zhibei_chart(zhibei_data,xAxis_data,tickInterval);
			
			used_data = "[" + result.usedList + "]";
			//used_chart(used_data,xAxis_data,tickInterval);

			storage_usage_chart(storage_usage_data,xAxis_data,tickInterval);
			
			
			storage_capacity_data = "[" + result.capacityList + "]";
			storage_used_data = "[" + result.usedList + "]";
			storage_available_data = "[" + result.availableList + "]";
			
			storage_capacity_stat_chart(storage_capacity_data, storage_used_data, storage_available_data, xAxis_data, tickInterval);
			
			disLoad();
			
			
		}
	});
}

function zhibei_chart(zhibei_data, xAxis_data, tickInterval){
	var cpu_usage_chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container_zhibei_usage',
		    type: 'area'
		},
		title: {
            text: '置备空间(GB):',
            x: -450
        },
        credits:{
            enabled: false		//去除版权信息
        }, 
        xAxis: {
           	categories: eval(xAxis_data),//['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
           	tickInterval: tickInterval,		//步长: 5
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
            }],
            labels:{
           		formatter: function() { 

              		 return  Highcharts.numberFormat(this.value,2) + 'GB';

              		}
            }
        },
        tooltip: {
           	valueSuffix: 'GB',
           	pointFormat:'{series.name} <b> {point.y:,.2f}</b> GB'
        },
        plotOptions: {
            area: {
               /*  pointStart: 1940, */
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
        legend: {
            layout: 'horizontal',
            align: 'center',
            enabled: true,
            verticalAlign: 'bottom',
            borderWidth: 0
        },
        series: [{
            name: '置备空间',
            data: eval(zhibei_data),//[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
        }]
	});
	
}

function storage_usage_chart(storage_usage_data, xAxis_data, tickInterval){
	var storage_usage_chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container_storage_usage',
		    type: 'line'
		},
		title: {
            text: '存储使用率(%):',
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
            }],
            labels:{
           		formatter: function() { 

              		 return  Highcharts.numberFormat(this.value,2) + '%';

              		}
            }
        },
        tooltip: {
           	valueSuffix: '%',
           	pointFormat:'{series.name} <b> {point.y:,.2f}</b> %'
        },
        legend: {
            layout: 'horizontal',
            align: 'center',
            enabled: true,
            verticalAlign: 'bottom',
            borderWidth: 0
        },
        series: [{
            name: '存储使用率',
            data: eval(storage_usage_data)
        }]
	});
}


function storage_capacity_stat_chart(storage_capacity_data, storage_used_data, storage_available_data, xAxis_data, tickInterval){

	var storage_capacity_stat_chart = new Highcharts.Chart({
	//$('#container_storage_capacity_stat').highcharts({
        chart: {
        	renderTo: 'container_storage_capacity_stat',
            type: 'area'
        },
        title: {
            text: '存储容量统计'
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
            /* labels: {
                formatter: function() {
                    return this.value;  // clean, unformatted number for year
                }
            } */
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
            pointFormat: '{series.name} <b>{point.y:,.0f}</b> GB'
        },
        plotOptions: {
            area: {
               /*  pointStart: 1940, */
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
        series: [
        {
            name: 'capacity',
            data: eval(storage_capacity_data)
        }, {
            name: 'available',
            data: eval(storage_available_data)
        },{
            name: 'used',
            data: eval(storage_used_data)
        }
        ]
    });
}


function storage_used_chart(storage_used_data, xAxis_data, tickInterval){
	var storage_usage_chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container_storage_used',
		    type: 'line'
		},
		title: {
            text: '历史增长情况(GB):',
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
            name: '存储使用率',
            data: eval(storage_usage_data)
        }]
	});
}

function used_chart(used_data, xAxis_data, tickInterval){
	var cpu_usage_chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container_storage_used',
		    type: 'line'
		},
		title: {
            text: '已用空间(GB):',
            x: -450
        },
        credits:{
            enabled: false		//去除版权信息
        }, 
        xAxis: {
           	categories: eval(xAxis_data),//['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
           	tickInterval: tickInterval,		//步长: 5
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
           	valueSuffix: 'GB'
        },
        legend: {
            layout: 'horizontal',
            align: 'center',
            enabled: true,
            verticalAlign: 'bottom',
            borderWidth: 0
        },
        series: [{
            name: '已用空间',
            data: eval(used_data),//[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
        }]
	});
	
}



//确定按钮函数
function kpi_usage_ok(){
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
		storage_usage_currtDayAjax(beginTime, endTime);
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

function load() {  
     $("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", height: $(window).height() ,"z-index": 999}).appendTo($("#loadDiv"));  
     $("<div class=\"datagrid-mask-msg\"></div>").html("正在加载，请稍候。。。").appendTo($("#loadDiv")).css({ display: "block","z-index": 999, left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });  
 }  
 
  function disLoad() {  
     $(".datagrid-mask").remove();  
     $(".datagrid-mask-msg").remove();  
 }
   
</script>
<div>
开始时间：<input class="easyui-datetimebox" editable="fasle" name="starttime" id="starttime" style="width:150px;height:28px;border:false"/>&nbsp;&nbsp;
结束时间：<input class="easyui-datetimebox"  editable="fasle" name="endtime" id="endtime" style="width:150px;height:28px;border:false"/>&nbsp;&nbsp;
<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="kpi_usage_ok()">确定</a>
</div>
<div id="loadDiv" style="z-index: 999">
</div>


<div id="tt" class="easyui-tabs" data-options="tabWidth:112,border:false" style="width:100%;">
	<input type="hidden" id="storagename" value="${storagename}"/>
	<div id="tt_zhibei" title="置备空间" data-options="fit:true" style="padding:10px;overflow:auto;">
		<div id="container_zhibei_usage" style="min-width:80%;height:400px"></div>
	</div>
	<div id="tt_useinfo" title="使用情况" data-options="fit:true" style="padding:10px;overflow:auto;">
		<div id="container_storage_usage" style="min-width:80%;height:400px;"></div>
		<div id="container_storage_capacity_stat" style="min-width:80%;height:400px;"></div>
	</div>
	<!--
	<div id="tt_usedQX" title="增长情况" data-options="fit:true" style="padding:10px;overflow:auto;">
		<div id="container_storage_used" style="min-width:80%;height:400px"></div>
	</div>
	-->
</div>