<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<style type="text/css">
.continnerWrapper{width:100%;margin:5px auto;overflow:hidden;padding:10px 10px 10px 10px;}

.FieldInput2 {
	width:35%;
	height:25px;
    background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
    text-align: left;
    word-wrap: break-word;
    padding-top:0px !important;
    padding-bottom:0px !important;
    border:#BCD2EE 1px solid !important;  
}
.FieldLabel2 {
	width:20%;
	height:25px;
    background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
    text-align: left;
    word-wrap: break-word;
    padding-top:0px !important;
    padding-bottom:0px !important;
    padding-right:10px !important;
    border:#BCD2EE 1px solid !important;  
}
</style>
	
<script type="text/javascript">
$(document).ready(function() {
	loadDataGrid();
	loadHLWPoolData();
});
function loadDataGrid(){
	$('#hostlist_datagrid').datagrid({
		rownumbers:false,
		checkOnSelect:true,
		selectOnCheck:true,
		singleSelect:true,
		border:false,
		striped:true,
		sortName:'ip',
		sortOrder:'asc',
		nowarp:false,
		method:'post',
		loadMsg:'数据装载中......',
		fitColumns:true,
		idField:'serverid',
	    url:'${pageContext.request.contextPath}/rescpool/getHLWHosts.do?poolid_=0000000007', 
	    onLoadSuccess:function(data){
	    	$('#totl').val(data.total);
	    	$('#totl').html(data.total);
	    }  
	});
}

function curStatFormatter (value,row,index){
	if (value =="Running"){
		return '运行中';
	} else if(value =="Stopped") {
		return '已停止';
	} else if(value =="Starting"){
		return '正在启用';
	} else if(value =="Stopping"){
		return '正在停止';
	}else{
		return value;
	}
}

function hlwpool_total_cpu_chart(total_data,used_data){
 	$('#hlw_total_cpu').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'CPU使用概况', 
            x: -400
        },
        credits:{
            enabled: false		//去除版权信息
        }, 
        xAxis: {
            categories: ['CPU'], 
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'MHz',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ' MHz'
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 50,
            floating: true,
            borderWidth: 0,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        series: [{
            name: 'CPU总量',
            data: eval(total_data)	
        },{
            name: 'CPU已使用',
            data: eval(used_data)		
        }]
    }); 
}

function hlwpool_total_mem_chart(total_data,used_data){
	
 	$('#hlw_total_mem').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: '内存使用概况', 
            x: -400
        },
        credits:{
            enabled: false		//去除版权信息
        }, 
        xAxis: {
            categories: ['Mem'],
            offset: 0, 
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'MB',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ' MB'
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 50,
            floating: true,
            borderWidth: 0,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        series: [{
            name: '内存总量',
            data: eval(total_data)	
        },{
            name: '内存已使用',
            data: eval(used_data)
        }]
    });  
}

function kpi_dataAjax(){
	var total_data = '';
	var used_data = '';
	
	$.ajax({
		url: "${pageContext.request.contextPath}/opermintor/hlwPoolCPUData.do",
		data : {'poolid':'0000000007', 'cpu_total_kpi':'HOST_CPU_TOTAL', 'cpu_used_kpi':'HOST_CPU_USAGE',
			'mem_total_kpi':'HOST_TOTAL_MEMORY', 'mem_used_kpi':'HOST_MEMORY_USAGE'},
		type : "post",
		dataType: "json",
		cache : false,
		success: function(result) {
			if(null != result.cpuTotal && "" != result.cpuTotal){
				total_data = "[" + result.cpuTotal + "]";
			}
			if(null != result.cpuUsed && "" != result.cpuUsed){
				used_data = "[" + result.cpuUsed + "]";
			} 
			hlwpool_total_cpu_chart(total_data,used_data);
			hlwpool_total_mem_chart("[" + result.memTotal + "]","[" + result.memUsed + "]");
		}
	}); 
}

//政务外网资源池
function loadHLWPoolData(){
	kpi_dataAjax();
}
</script>

<div class="continnerWrapper">
	<div style="margin-left:20px;margin-top:5px;">
		<span style="font: bold 20px tahoma, arial, helvetica, sans-serif;">资源概览</span>
	</div>
	<div style="margin-left:20px;margin-top:5px; padding:5px;">
		<span style="font: bold 14px tahoma, arial, helvetica, sans-serif;">政务外网资源池主机数量：</span>
		<label id="totl" style="font: bold 20px tahoma, arial, helvetica, sans-serif;"></label>&nbsp;&nbsp;台
		<!-- <a onclick="showOrHide();" style="text-decoration:underline;">
		</a> -->
	</div>
	
	<div id="aa" class="easyui-accordion" style="width:90%;margin-left:20px;margin-top:5px;">   
	    <div title="主机详细信息" data-options="collapsible:true,selected:false" style="padding:2px;">   
	        <table style="width:100%;" id="hostlist_datagrid">
				<thead>
					<tr>
						<th data-options="field:'serverid',hidden:true"></th>
						<th data-options="field:'servername',width:100,hidden:false">宿主机名称</th>
						<th data-options="field:'description',width:120,align:'center',sortable:true">主机描述</th>
						<th data-options="field:'datacenter',width:80,align:'center'">数据中心</th>
						<th data-options="field:'platformid',width:80,align:'center'">平台</th>
						<th data-options="field:'ip',width:80,align:'center',sortable:true">IP</th>
						<th data-options="field:'cluster',width:80,align:'center'">集群</th>
						<th data-options="field:'cpuappnum',width:80,align:'center'">CPU总量(GHz)</th>
						<th data-options="field:'cpunum',width:80,align:'center'">CPU核心数(C)</th>
						<th data-options="field:'memnum',width:80,align:'center'">内存总量(GB)</th>
						<th data-options="field:'osname',width:80,align:'center'">操作系统</th>
						<th data-options="field:'poolname',width:120,align:'center',hidden:false">资源池</th>
						<th data-options="field:'poolid',width:120,align:'center',hidden:true">资源池ID</th>
						<th data-options="field:'curstatus',width:80,align:'center',formatter:curStatFormatter">运行状态</th>
						<!-- <th data-options="field:'ops',width:100,align:'center',formatter:opsFormater">操作</th> -->
					</tr>
				</thead>
			</table>
	    </div>   
	</div>
</div>

<!--整个政务外网资源池的监控 -->
<div style="padding:10px;overflow:auto;width:90%;margin-left:20px;">
	<div id="hlw_total_cpu" style="min-width:400px;height:400px;padding:10px;overflow:auto;"></div>
</div>
<div style="padding:10px;overflow:auto;width:90%;margin-left:20px;">
	<div id="hlw_total_mem" style="min-width:400px;height:400px;padding:10px;overflow:auto;"></div>
</div>

</body>
</html>