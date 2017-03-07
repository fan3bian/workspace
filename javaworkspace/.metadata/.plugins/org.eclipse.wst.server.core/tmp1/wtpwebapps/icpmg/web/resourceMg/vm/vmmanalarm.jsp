<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<div>
	&nbsp;&nbsp;开始时间：<input class="easyui-datetimebox" editable="fasle" name="starttime" id="starttime" style="width:150px;height:30px;border:false"/>
	&nbsp;&nbsp;结束时间：<input class="easyui-datetimebox"  editable="fasle" name="endtime" id="endtime" style="width:150px;height:30px;border:false"/>
	&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchAndLoad()">查询</a>
</div>
<div id="cpu_chart" style="float:left;display:inline;width:550px;"></div>
<div id="mem_chart" style="float:left;display:inline;width:550px;"></div>
<!-- <div id="disk_chart" style="float:left;display:inline;width:550px;"></div> -->
<!-- <div style="clear:both;"></div> -->
<!-- <div id="rxtx_chart" style="float:left;display:inline;width:550px;"></div>  -->
<div style="clear:both;"></div>
<!-- <div id="diskusage_chart" style="float:left;display:inline;width:550px;"></div> -->
<%
	String contextPath = request.getContextPath();
%>
<script type="text/javascript">	
var cpu_chart;
var cpu_dataTmp = '';
var cpu_xdata = '';
var cpu_chinaname = 'CPU负荷';
var cpu_tickInterval = 0;

var disk_chart;
var disk_xdata = '';
var disk_tickInterval = 0;
var diskrd_dataTmp = '';
var diskrd_chinaname = '硬盘读字节数';
var diskwr_dataTmp = '';
var diskwr_chinaname = '硬盘写字节数';

var rxtx_chart;
var rxtx_xdata = '';
var rxtx_tickInterval = 0;
var rx_dataTmp = '';
var rx_chinaname = '接收字节数';
var tx_dataTmp = '';
var tx_chinaname = '发送字节数';

var mem_chart;
var mem_dataTmp = '';
var mem_xdata = '';
var mem_chinaname = '内存利用率';
var mem_tickInterval = 0;

var diskusage_chart;
var diskusage_dataTmp = '';
var diskusage_xdata = '';
var diskusage_chinaname = '磁盘利用率';
var diskusage_tickInterval = 0;

$(document).ready(function() {
	cpuAjax("",""); //首先加载当前一天的数据
	//diskAjax("","");
	rxtxAjax("","");
	memAjax("","");
	//diskusageAjax("","");
	cpu_query(cpu_dataTmp, cpu_xdata, cpu_chinaname, cpu_tickInterval);
	/* disk_query(diskrd_dataTmp, disk_xdata, diskrd_chinaname, disk_tickInterval, diskwr_dataTmp, diskwr_chinaname);
	rxtx_query(rx_dataTmp, rxtx_xdata, rx_chinaname, rxtx_tickInterval, tx_dataTmp, tx_chinaname); */
	mem_query(mem_dataTmp, mem_xdata, mem_chinaname, mem_tickInterval);
// 	diskusage_query(diskusage_dataTmp, diskusage_xdata, diskusage_chinaname, diskusage_tickInterval);
}); 
//CPU负荷指标
function cpu_query(dataTmp,xdata,chinaname,tickInterval){
	cpu_chart = new Highcharts.Chart({
					chart: {
					    renderTo: 'cpu_chart',
					    type: 'line',//设置图表样式，可以为line,spline, scatter, splinearea bar,pie,area,column  
					    marginTop:28,
					    marginLeft: 100,
			            marginBottom: 80
					},
					title: {
					    text: 'cpu负荷(%)'
					},
					credits:{//右下角的文本  
			            enabled: false
			        }, 
			        xAxis: {
			            categories: eval(xdata),
			            tickInterval: tickInterval,//步长
			            labels: {//设置横轴坐标的显示样式  
			              	align: 'left'
			            }
			        },
			        yAxis: {
			            minPadding: 0.2,
			            maxPadding: 0.2,
			            title:''
			        },
			        series: [{//以下为纵轴数据  
			            name: chinaname, 
			            data: eval(dataTmp)
			        }] 
			    }); 
}
//硬盘读写字节数指标
/* function disk_query(dataTmp1,xdata,chinaname1,tickInterval,dataTmp2,chinaname2){
	disk_chart = new Highcharts.Chart({
					chart: {
					    renderTo: 'disk_chart',
					    type: 'line',//设置图表样式，可以为line,spline, scatter, splinearea bar,pie,area,column  
					    marginTop:28,
					    marginLeft: 100,
			            marginBottom: 80
					},
					title: {
					    text: ''
					},
					credits:{//右下角的文本  
			            enabled: false
			        }, 
			        xAxis: {
			            categories: eval(xdata),
			            tickInterval: tickInterval,//步长
			            labels: {//设置横轴坐标的显示样式  
			              	align: 'left'
			            }
			        },
			        yAxis: {
			            minPadding: 0.2,
			            maxPadding: 0.2,
			            title:''
			        },
			        series: [{//以下为纵轴数据  
			            name: chinaname1, 
			            data: eval(dataTmp1)
			        },{
			        	name: chinaname2, 
			            data: eval(dataTmp2)
			        }] 
			    }); 
} */
//接收、发送字节数指标
/* function rxtx_query(dataTmp1,xdata,chinaname1,tickInterval,dataTmp2,chinaname2){
	rxtx_chart = new Highcharts.Chart({
					chart: {
					    renderTo: 'rxtx_chart',
					    type: 'line',//设置图表样式，可以为line,spline, scatter, splinearea bar,pie,area,column  
					    marginTop:28,
					    marginLeft: 100,
			            marginBottom: 80
					},
					title: {
					    text: ''
					},
					credits:{//右下角的文本  
			            enabled: false
			        }, 
			        xAxis: {
			            categories: eval(xdata),
			            tickInterval: tickInterval,//步长
			            labels: {//设置横轴坐标的显示样式  
			              	align: 'left'
			            }
			        },
			        yAxis: {
			            minPadding: 0.2,
			            maxPadding: 0.2,
			            title:''
			        },
			        series: [{//以下为纵轴数据  
			            name: chinaname1, 
			            data: eval(dataTmp1)
			        },{
			        	name: chinaname2, 
			            data: eval(dataTmp2)
			        }] 
			    }); 
} */
//内存利用率指标
function mem_query(dataTmp,xdata,chinaname,tickInterval){
	mem_chart = new Highcharts.Chart({
					chart: {
					    renderTo: 'mem_chart',
					    type: 'line',//设置图表样式，可以为line,spline, scatter, splinearea bar,pie,area,column  
					    marginTop:28,
					    marginLeft: 100,
			            marginBottom: 80
					},
					title: {
					    text: '内存负荷(%)'
					},
					credits:{//右下角的文本  
			            enabled: false
			        }, 
			        xAxis: {
			            categories: eval(xdata),
			            tickInterval: tickInterval,//步长
			            labels: {//设置横轴坐标的显示样式  
			              	align: 'left'
			            }
			        },
			        yAxis: {
			            minPadding: 0.2,
			            maxPadding: 0.2,
			            title:''
			        },
			        series: [{//以下为纵轴数据  
			            name: chinaname, 
			            data: eval(dataTmp)
			        }] 
			    }); 
}
//磁盘利用率指标
function diskusage_query(dataTmp,xdata,chinaname,tickInterval){
	diskusage_chart = new Highcharts.Chart({
					chart: {
					    renderTo: 'diskusage_chart',
					    type: 'line',//设置图表样式，可以为line,spline, scatter, splinearea bar,pie,area,column  
					    marginTop:28,
					    marginLeft: 100,
			            marginBottom: 80
					},
					title: {
					    text: ''
					},
					credits:{//右下角的文本  
			            enabled: false
			        }, 
			        xAxis: {
			            categories: eval(xdata),
			            tickInterval: tickInterval,//步长
			            labels: {//设置横轴坐标的显示样式  
			              	align: 'left'
			            }
			        },
			        yAxis: {
			            minPadding: 0.2,
			            maxPadding: 0.2,
			            title:''
			        },
			        series: [{//以下为纵轴数据  
			            name: chinaname, 
			            data: eval(dataTmp)
			        }] 
			    }); 
}


//查询硬盘读写字节数指标后画出折线
function rxtxAjax(beginTime, endTime){
	rx_dataTmp = '';
	tx_dataTmp = '';
	rxtx_xdata = '';
	
	$.ajax({
		url : "<%=contextPath%>/jsonvm/vmalarmindex.do",
		data : {'neid':$("#tabs_vmid").val(), 'kpi':'rxbytes', 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {			
			rx_chinaname = '接收字节数';			
			if(null != result.kpis && "" != result.kpis){
				rx_dataTmp = "[" + result.kpis + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					rxtx_xdata += "'" + xarr[i] + "'" + ",";
				}
				rxtx_xdata = rxtx_xdata.substring(0, rxtx_xdata.length - 1);
				rxtx_xdata = "[" + rxtx_xdata + "]";
				rxtx_tickInterval = Math.ceil(xarr.length/5);
			}else{
				rx_chinaname += " 接收字节数暂无数据！";
			}
			
			
			$.ajax({
				url : "<%=contextPath%>/jsonvm/vmalarmindex.do",
				data : {'neid':$("#tabs_vmid").val(), 'kpi':'txbytes', 'beginTime':beginTime, 'endTime':endTime},
				type : "post",
				dataType: "json",
				cache : false,
				success: function(result) {
					tx_chinaname = '发送字节数';
					if(null != result.kpis && "" != result.kpis){
						tx_dataTmp = "[" + result.kpis + "]";
					}else{
						tx_chinaname += " 发送字节数暂无数据！";
					}
					
					rxtx_query(rx_dataTmp, rxtx_xdata, rx_chinaname, rxtx_tickInterval, tx_dataTmp, tx_chinaname);
				}
			});
		}
	});
	
}
//查询硬盘读写字节数指标后画出折线
function diskAjax(beginTime, endTime){
	diskrd_dataTmp = '';
	diskwr_dataTmp = '';
	disk_xdata = '';
	
	$.ajax({
		url : "<%=contextPath%>/jsonvm/vmalarmindex.do",
		data : {'neid':$("#tabs_vmid").val(), 'kpi':'diskrdbytes', 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			diskrd_chinaname = '硬盘读字节数';
			if(null != result.kpis && "" != result.kpis){
				diskrd_dataTmp = "[" + result.kpis + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					disk_xdata += "'" + xarr[i] + "'" + ",";
				}
				disk_xdata = disk_xdata.substring(0, disk_xdata.length - 1);
				disk_xdata = "[" + disk_xdata + "]";
				disk_tickInterval = Math.ceil(xarr.length/5);
			}else{
				diskrd_chinaname += " 硬盘读字节数暂无数据！";
			}
			
			$.ajax({
				url : "<%=contextPath%>/jsonvm/vmalarmindex.do",
				data : {'neid':$("#tabs_vmid").val(), 'kpi':'diskwrbytes', 'beginTime':beginTime, 'endTime':endTime},
				type : "post",
				dataType: "json",
				cache : false,
				success: function(result) {
					diskwr_chinaname = '硬盘写字节数';
					if(null != result.kpis && "" != result.kpis){
						diskwr_dataTmp = "[" + result.kpis + "]";
					}else{
						diskwr_chinaname += " 硬盘写字节数暂无数据！";
					}
					
					disk_query(diskrd_dataTmp, disk_xdata, diskrd_chinaname, disk_tickInterval, diskwr_dataTmp, diskwr_chinaname);
				}
			});
		}
	});
	
}
//查询CPU负荷指标后画出折线
function cpuAjax(beginTime, endTime){
	cpu_dataTmp = '';
	cpu_xdata = '';
	
	$.ajax({
		url : "<%=contextPath%>/jsonvm/vmalarmindex.do",
		data : {'neid':$("#tabs_vmid").val(), 'kpi':'cpuload', 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			cpu_chinaname = 'CPU负荷';
			if(null != result.kpis && "" != result.kpis){
				cpu_dataTmp = "[" + result.kpis + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					cpu_xdata += "'" + xarr[i] + "'" + ",";
				}
				cpu_xdata = cpu_xdata.substring(0, cpu_xdata.length - 1);
				cpu_xdata = "[" + cpu_xdata + "]";
				cpu_tickInterval = Math.ceil(xarr.length/5);
			}else{
				cpu_chinaname += " CPU负荷暂无数据！";
			}
			
            cpu_query(cpu_dataTmp, cpu_xdata, cpu_chinaname, cpu_tickInterval); 
		}
	});
}
//查询内存利用率指标后画出折线
function memAjax(beginTime, endTime){
	mem_dataTmp = '';
	mem_xdata = '';
	
	$.ajax({
		url : "<%=contextPath%>/jsonvm/vmalarmindex.do",
		data : {'neid':$("#tabs_vmid").val(), 'kpi':'memusage', 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			mem_chinaname = '内存利用率';
			if(null != result.kpis && "" != result.kpis){
				mem_dataTmp = "[" + result.kpis + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					mem_xdata += "'" + xarr[i] + "'" + ",";
				}
				mem_xdata = mem_xdata.substring(0, cpu_xdata.length - 1);
				mem_xdata = "[" + mem_xdata + "]";
				mem_tickInterval = Math.ceil(xarr.length/5);
			}else{
				mem_chinaname += " 内存利用率暂无数据！";
			}
			
            mem_query(mem_dataTmp, mem_xdata, mem_chinaname, mem_tickInterval); 
		}
	});
}
//查询磁盘利用率指标后画出折线
function diskusageAjax(beginTime, endTime){
	diskusage_dataTmp = '';
	diskusage_xdata = '';
	
	$.ajax({
		url : "<%=contextPath%>/jsonvm/vmalarmindex.do",
		data : {'neid':$("#tabs_vmid").val(), 'kpi':'diskusage', 'beginTime':beginTime, 'endTime':endTime},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			diskusage_chinaname = '磁盘利用率';
			if(null != result.kpis && "" != result.kpis){
				diskusage_dataTmp = "[" + result.kpis + "]";
				
				var xarr = eval(result.times);
				for (var i = 0; i < xarr.length; i++) {
					diskusage_xdata += "'" + xarr[i] + "'" + ",";
				}
				diskusage_xdata = diskusage_xdata.substring(0, diskusage_xdata.length - 1);
				diskusage_xdata = "[" + diskusage_xdata + "]";
				diskusage_tickInterval = Math.ceil(xarr.length/5);
			}else{
				diskusage_chinaname += " 磁盘利用率暂无数据！";
			}
			
            diskusage_query(diskusage_dataTmp, diskusage_xdata, diskusage_chinaname, diskusage_tickInterval); 
		}
	});
}
function searchAndLoad(){
	var beginTime = $('#starttime').datebox('getValue');;
	var endTime = $('#endtime').datebox('getValue');;
	var msg = compareTime(beginTime, endTime);
	if(msg != ""){
		$.messager.alert('提示', msg, 'info');
	}
	
	
	//调用CPU负荷指标数据
	cpuAjax(beginTime, endTime);
	//调用硬盘读、写字节数指标数据
	diskAjax(beginTime, endTime);
	//调用接收、发送字节数指标数据
	rxtxAjax(beginTime, endTime);
	//调用内存利用率指标数据
	memAjax(beginTime, endTime);
	//调用磁盘利用率指标数据
// 	diskusageAjax(beginTime, endTime);
}
//判断时间选择条件
function compareTime(startDate, endDate) { 
	if(null == startDate || '' == startDate || null == endDate || '' == endDate){
		return "查询条件均为必选";  
	}
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
	} else if(allStartDate.getTime() - allEndDate.getTime() > 7*24*60*60){
		return "时间范围不能超过一周";
	}else{
		return "";
	}   
}
</script>
</body>
